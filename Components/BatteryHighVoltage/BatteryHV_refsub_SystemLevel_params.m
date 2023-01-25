%% Model parameters for high voltage battery component
% For the system-level battery.
%
% If you edit this file, make sure to run this to update variables
% before running harness model for simulation.

% Copyright 2022-2023 The MathWorks, Inc.

%% Bus

defineBus_HighVoltage

%% Battery specifications

batteryHV.nominalVoltage_V = 350;

batteryHV.internalResistance_Ohm = 0.01;

batteryHV.nominalCapacity_kWh = 4;

% Open Circuit Voltage. 3.5 V to 3.7 V assuming Lithium-ion
batteryHV.voltagePerCell_V = 3.7;

batteryHV.nominalCharge_Ahr = ...
  BatteryHV_getAmpereHourRating( ...
    Voltage_V = batteryHV.nominalVoltage_V, ...
    Capacity_kWh = batteryHV.nominalCapacity_kWh, ...
    StateOfCharge_pct = 100 );

% Voltage is 90 % of the nominal when SOC is 50 %.
batteryHV.measuredVoltage_V = batteryHV.nominalVoltage_V * 0.9;
batteryHV.measuredCharge_Ahr = batteryHV.nominalCharge_Ahr * 0.5;

% More thermal model parameters
% These parameters are used when thermal model is enabled
% in the Battery block from Simscape Electrical.
batteryHV.measurementTemperature_K = 273.15 + 25;
batteryHV.secondMeasurementTemperature_K = 273.15 + 0;
batteryHV.secondNominalVoltage_V = batteryHV.nominalVoltage_V * 0.95;
batteryHV.secondInternalResistance_Ohm = batteryHV.internalResistance_Ohm * 2;
batteryHV.secondMeasuredVoltage_V = batteryHV.nominalVoltage_V * 0.9;

%% Ambient

% batteryHV.thermalMass_kJ_per_K = 0.1;
batteryHV.RadiationArea_m2 = 1;
batteryHV.RadiationCoeff_W_per_K4m2 = 5e-10;

ambient.temp_K = 273.15 + 20;
ambient.mass_t = 10000;
ambient.SpecificHeat_J_per_Kkg = 1000;

%% Initial conditions

initial.hvBattery_SOC_pct = 70;

initial.hvBattery_Charge_Ahr = ...
  BatteryHV_getAmpereHourRating( ...
    Voltage_V = batteryHV.nominalVoltage_V, ...
    Capacity_kWh = batteryHV.nominalCapacity_kWh, ...
    StateOfCharge_pct = initial.hvBattery_SOC_pct );

initial.hvBattery_Temperature_K = ambient.temp_K;

initial.ambientTemp_K = ambient.temp_K;