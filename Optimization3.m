function Cov = Optimization3(f0, f1, duration)
freq1=f0;
freq2=f1;
Xu=-0.1068;
Xq=0.1192;
Mu=-5.9755;
Mq=-2.6478;
Xd=-10.1647;
Md=450.71;
A=[Xu, Xq, -9.81; Mu, Mq, 0; 0, 1, 0];
B=[Xd; Md; 0];
C=[1, 0, 0; 0, 1, 0; 0, 0, 1; Xu, Xq, 0]; 
D=[0; 0; 0; Xd];
% Noise
noise.Enabler = 1;
noise.pos_stand_dev = noise.Enabler * 0.0011;                            	%[m]
noise.vel_stand_dev = noise.Enabler * 0.01;                               %[m/s]
noise.attitude_stand_dev = noise.Enabler * deg2rad(0.0076);                 %[rad]
noise.ang_rate_stand_dev = noise.Enabler * deg2rad(0.01);                   %[rad/s]
% Delays
delay.position_filter = 1;
delay.attitude_filter = 1;
delay.mixer = 1;
% Load controller parameters
parameters_controller    
% Signal generation
Fs=250; Ts=1/Fs;
total_samples = duration * Fs;
t = (0:total_samples-1) / Fs;
k = (f1 - f0)/duration^2;
quad_sweep = 0.1*sin(f0 *t + k*t.^3);
ExcitationM(:,2) =quad_sweep;
SetPoint=[0,0];
% Values selected
simulation_time=t(end)-t(1);
% Greyest
options = simset('SrcWorkspace','current');
outSim = sim('Simulator_Single_Axis',[],options);
Mtot=outSim.Mtot; ax=outSim.ax; q=outSim.q;
data = iddata([q,ax],Mtot,Ts);
DATA_freq=fft(data);

odefun = @model2;
Xu =-0.10;
Xq = 0.11;
Xd = -10.1647;
Mu = -5.9;
Mq = -2.6;
Md = 450;
%Xu=0;Xq=0;Mu=0;Mq=0;Xd=0;Md=0;
parameters = {'Xu',Xu;'Xq',Xq;'Xd',Xd;'Mu',Mu;'Mq',Mq;'Md',Md};
fcn_type = 'c';
sys = idgrey(odefun,parameters,fcn_type);
sysest = greyest(DATA_freq,sys);
Params=['Xu';'Xq';'Xd';'Mu';'Mq';'Md'];
[Values,Standard_Dev] = getpvec(sysest);
RealValues = [-0.1068 0.1192 -10.1647 -5.9755 -2.6478 450.71]';
for i=1:length(RealValues)
    if abs(RealValues(i))>abs(Values(i))
       perc(i)=abs((Values(i)/RealValues(i)));
    elseif abs(RealValues(i))<abs(Values(i))
       perc(i)=abs((RealValues(i)/Values(i)));
    end
end
tol=0.95;
if sum(perc)/6>tol
    Cov = Standard_Dev;
else 
    Cov = ones(6,1);
end
disp(sum(Cov.^2))
disp(perc)
disp(table(Params,Values,Standard_Dev))
end