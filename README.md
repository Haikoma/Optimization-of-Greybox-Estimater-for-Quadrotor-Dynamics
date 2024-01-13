# Optimization-of-Greybox-Estimater-for-Quadrotor-Dynamics

# Overview
This repository contains a MATLAB implementation of a system identification and estimation project. The goal of this project is to estimate the parameters of a dynamic system using grey-box modeling and optimize the excitation signal to reduce parametric uncertainty. The model used is a linearized and decoupled at low speed, the derivation of which is not covered in this work. Feel free to use any model and adjusting the requirements/inputs.

# Tools Used
MATLAB, Greybox Estimation, Signal processing, Signal Optimization, Fmincon

# Project Structure
The project is organized into two main tasks:

Grey Box Estimation: In this task, the parameters of a dynamic system are estimated using grey-box modeling. The identified system is then compared with the actual system.

Optimization of Excitation Signal: The excitation signal is optimized for three different classes (Linear Sine Sweep, Logarithmic Sine Sweep, and Quadratic Sine Sweep) to reduce parametric uncertainty. The quality of the optimized models is evaluated.

# Files
QUADROTOR_GREYBOX_MODEL_ESTIMATION.mlx: MATLAB script containing the implementation of both works. This script loads data, performs grey-box estimation, conducts uncertainty analysis, optimizes excitation signals, and evaluates the quality of the optimized models.

model2.m: MATLAB function defining the dynamic system model.

Optimization1.m, Optimization2.m, Optimization3.m: MATLAB functions defining the objective functions for optimizing the excitation signals for the three classes using Fmincon().
These functions require a simulink or other with the excitation signal as the input and the outputs of your model.

# Requirements
MATLAB R20XX or later.

# Usage
Open and run the estimation_script.m file in MATLAB.

The results of the estimation and optimization tasks are visualized in the generated plots. Detailed parameter values, uncertainties, and comparisons with the actual system are provided within the MATLAB script.
