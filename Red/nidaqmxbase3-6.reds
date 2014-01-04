Red/System [
	Title:		"National Instrument NI-DAQmx Base"
	Author:		"Francois Jouen"
	Rights:		"Copyright (c) 2013 Francois Jouen. All rights reserved."
	License: 	"BSD-3 - https:;github.com/dockimbel/Red/blob/master/BSD-3-License.txt"
]


; This version is for 3.6 NI-DAQmx Base library, but can also be used with previous lib versions from 3.0
; Runs under Mac OSX, Linux and Windows
; pefectly running for USB DAQ devices ! see http://www.ni.com for details about supported devices.


; define os and lib path 
#switch OS [
		Windows		[#define libni "/c/windows/system32/nidaqmxbase.dll"] ; to be tested
        MacOSX		[#define libni "/Library/Frameworks/nidaqmxbase.framework/nidaqmxbase"]
        Linux       []; to be documented by a Linux User
		#default	[#define libni "/Library/Frameworks/nidaqmxbase.framework/nidaqmxbase"]
]



;******************************************************************************
;*** NI-DAQmx Attributes ******************************************************
;******************************************************************************

;********** Calibration Info Attributes **********
#define DAQmx_SelfCal_Supported                                          1860h ; Indicates whether the device supports self calibration.
#define DAQmx_SelfCal_LastTemp                                           1864h ; Indicates in degrees Celsius the temperature of the device at the time of the last self calibration. Compare this temperature to the current onboard temperature to determine if you should perform another calibration.
#define DAQmx_ExtCal_RecommendedInterval                                 1868h ; Indicates in months the National Instruments recommended interval between each external calibration of the device.
#define DAQmx_ExtCal_LastTemp                                            1867h ; Indicates in degrees Celsius the temperature of the device at the time of the last external calibration. Compare this temperature to the current onboard temperature to determine if you should perform another calibration.
#define DAQmx_Cal_UserDefinedInfo                                        1861h ; Specifies a string that contains arbitrary, user-defined information. This number of characters in this string can be no more than Max Size.
#define DAQmx_Cal_UserDefinedInfo_MaxSize                                191Ch ; Indicates the maximum length in characters of Information.

;********** Channel Attributes **********
#define DAQmx_ChanType                                                   187Fh ; Indicates the type of the virtual channel.
#define DAQmx_PhysicalChanName                                           18F5h ; Indicates the name of the physical channel upon which this virtual channel is based.
#define DAQmx_ChanDescr                                                  1926h ; Specifies a user-defined description for the channel.
#define DAQmx_AI_Max                                                     17DDh ; Specifies the maximum value you expect to measure. This value is in the units you specify with a units property. When you query this property, it returns the coerced maximum value that the device can measure with the current settings.
#define DAQmx_AI_Min                                                     17DEh ; Specifies the minimum value you expect to measure. This value is in the units you specify with a units property.  When you query this property, it returns the coerced minimum value that the device can measure with the current settings.
#define DAQmx_AI_CustomScaleName                                         17E0h ; Specifies the name of a custom scale for the channel.
#define DAQmx_AI_MeasType                                                0695h ; Indicates the measurement to take with the analog input channel and in some cases, such as for temperature measurements, the sensor to use.
#define DAQmx_AI_Voltage_Units                                           1094h ; Specifies the units to use to return voltage measurements from the channel.
#define DAQmx_AI_Temp_Units                                              1033h ; Specifies the units to use to return temperature measurements from the channel.
#define DAQmx_AI_Thrmcpl_Type                                            1050h ; Specifies the type of thermocouple connected to the channel. Thermocouple types differ in composition and measurement range.
#define DAQmx_AI_Thrmcpl_CJCSrc                                          1035h ; Indicates the source of cold-junction compensation.
#define DAQmx_AI_Thrmcpl_CJCVal                                          1036h ; Specifies the temperature of the cold junction if CJC Source is DAQmx_Val_ConstVal. Specify this value in the units of the measurement.
#define DAQmx_AI_Thrmcpl_CJCChan                                         1034h ; Indicates the channel that acquires the temperature of the cold junction if CJC Source is DAQmx_Val_Chan. If the channel does not use a custom scale, NI-DAQmx uses the correct units. If the channel uses a custom scale, the pre-scaled units of the channel must be degrees Celsius.
#define DAQmx_AI_RTD_Type                                                1032h ; Specifies the type of RTD connected to the channel.
#define DAQmx_AI_RTD_R0                                                  1030h ; Specifies in ohms the sensor resistance at 0 deg C. The Callendar-Van Dusen equation requires this value. Refer to the sensor documentation to determine this value.
#define DAQmx_AI_RTD_A                                                   1010h ; Specifies the 'A' constant of the Callendar-Van Dusen equation. NI-DAQmx requires this value when you use a custom RTD.
#define DAQmx_AI_RTD_B                                                   1011h ; Specifies the 'B' constant of the Callendar-Van Dusen equation. NI-DAQmx requires this value when you use a custom RTD.
#define DAQmx_AI_RTD_C                                                   1013h ; Specifies the 'C' constant of the Callendar-Van Dusen equation. NI-DAQmx requires this value when you use a custom RTD.
#define DAQmx_AI_Thrmstr_A                                               18C9h ; Specifies the 'A' constant of the Steinhart-Hart thermistor equation.
#define DAQmx_AI_Thrmstr_B                                               18CBh ; Specifies the 'B' constant of the Steinhart-Hart thermistor equation.
#define DAQmx_AI_Thrmstr_C                                               18CAh ; Specifies the 'C' constant of the Steinhart-Hart thermistor equation.
#define DAQmx_AI_Thrmstr_R1                                              1061h ; Specifies in ohms the value of the reference resistor if you use voltage excitation. NI-DAQmx ignores this value for current excitation.
#define DAQmx_AI_ForceReadFromChan                                       18F8h ; Specifies whether to read from the channel if it is a cold-junction compensation channel. By default, an NI-DAQmx Read function does not return data from cold-junction compensation channels.  Setting this property to TRUE forces read operations to return the cold-junction compensation channel data with the other channels in the task.
#define DAQmx_AI_Current_Units                                           0701h ; Specifies the units to use to return current measurements from the channel.
#define DAQmx_AI_Strain_Units                                            0981h ; Specifies the units to use to return strain measurements from the channel.
#define DAQmx_AI_StrainGage_GageFactor                                   0994h ; Specifies the sensitivity of the strain gage.  Gage factor relates the change in electrical resistance to the change in strain. Refer to the sensor documentation for this value.
#define DAQmx_AI_StrainGage_PoissonRatio                                 0998h ; Specifies the ratio of lateral strain to axial strain in the material you are measuring.
#define DAQmx_AI_StrainGage_Cfg                                          0982h ; Specifies the bridge configuration of the strain gages.
#define DAQmx_AI_Resistance_Units                                        0955h ; Specifies the units to use to return resistance measurements.
#define DAQmx_AI_Freq_Units                                              0806h ; Specifies the units to use to return frequency measurements from the channel.
#define DAQmx_AI_Freq_ThreshVoltage                                      0815h ; Specifies the voltage level at which to recognize waveform repetitions. You should select a voltage level that occurs only once within the entire period of a waveform. You also can select a voltage that occurs only once while the voltage rises or falls.
#define DAQmx_AI_Freq_Hyst                                               0814h ; Specifies in volts a window below Threshold Level. The input voltage must pass below Threshold Level minus this value before NI-DAQmx recognizes a waveform repetition at Threshold Level. Hysteresis can improve the measurement accuracy when the signal contains noise or jitter.
#define DAQmx_AI_LVDT_Units                                              0910h ; Specifies the units to use to return linear position measurements from the channel.
#define DAQmx_AI_LVDT_Sensitivity                                        0939h ; Specifies the sensitivity of the LVDT. This value is in the units you specify with Sensitivity Units. Refer to the sensor documentation to determine this value.
#define DAQmx_AI_LVDT_SensitivityUnits                                   219Ah ; Specifies the units of Sensitivity.
#define DAQmx_AI_RVDT_Units                                              0877h ; Specifies the units to use to return angular position measurements from the channel.
#define DAQmx_AI_RVDT_Sensitivity                                        0903h ; Specifies the sensitivity of the RVDT. This value is in the units you specify with Sensitivity Units. Refer to the sensor documentation to determine this value.
#define DAQmx_AI_RVDT_SensitivityUnits                                   219Bh ; Specifies the units of Sensitivity.
#define DAQmx_AI_Accel_Units                                             0673h ; Specifies the units to use to return acceleration measurements from the channel.
#define DAQmx_AI_Accel_Sensitivity                                       0692h ; Specifies the sensitivity of the accelerometer. This value is in the units you specify with Sensitivity Units. Refer to the sensor documentation to determine this value.
#define DAQmx_AI_Accel_SensitivityUnits                                  219Ch ; Specifies the units of Sensitivity.
#define DAQmx_AI_Coupling                                                0064h ; Specifies the coupling for the channel.
#define DAQmx_AI_Impedance                                               0062h ; Specifies the input impedance of the channel.
#define DAQmx_AI_TermCfg                                                 1097h ; Specifies the terminal configuration for the channel.
#define DAQmx_AI_ResistanceCfg                                           1881h ; Specifies the resistance configuration for the channel. NI-DAQmx uses this value for any resistance-based measurements, including temperature measurement using a thermistor or RTD.
#define DAQmx_AI_LeadWireResistance                                      17EEh ; Specifies in ohms the resistance of the wires that lead to the sensor.
#define DAQmx_AI_Bridge_Cfg                                              0087h ; Specifies the type of Wheatstone bridge that the sensor is.
#define DAQmx_AI_Bridge_NomResistance                                    17ECh ; Specifies in ohms the resistance across each arm of the bridge in an unloaded position.
#define DAQmx_AI_Bridge_InitialVoltage                                   17EDh ; Specifies in volts the output voltage of the bridge in the unloaded condition. NI-DAQmx subtracts this value from any measurements before applying scaling equations.
#define DAQmx_AI_Bridge_ShuntCal_Enable                                  0094h ; Specifies whether to enable a shunt calibration switch. Use Shunt Cal Select to select the switch(es) to enable.
#define DAQmx_AI_Bridge_ShuntCal_Select                                  21D5h ; Specifies which shunt calibration switch(es) to enable.  Use Shunt Cal Enable to enable the switch(es) you specify with this property.
#define DAQmx_AI_Bridge_ShuntCal_GainAdjust                              193Fh ; Specifies the result of a shunt calibration. NI-DAQmx multiplies data read from the channel by the value of this property. This value should be close to 1.0.
#define DAQmx_AI_Bridge_Balance_CoarsePot                                17F1h ; Specifies by how much to compensate for offset in the signal. This value can be between 0 and 127.
#define DAQmx_AI_Bridge_Balance_FinePot                                  18F4h ; Specifies by how much to compensate for offset in the signal. This value can be between 0 and 4095.
#define DAQmx_AI_CurrentShunt_Loc                                        17F2h ; Specifies the shunt resistor location for current measurements.
#define DAQmx_AI_CurrentShunt_Resistance                                 17F3h ; Specifies in ohms the external shunt resistance for current measurements.
#define DAQmx_AI_Excit_Src                                               17F4h ; Specifies the source of excitation.
#define DAQmx_AI_Excit_Val                                               17F5h ; Specifies the amount of excitation that the sensor requires. If Voltage or Current is  DAQmx_Val_Voltage, this value is in volts. If Voltage or Current is  DAQmx_Val_Current, this value is in amperes.
#define DAQmx_AI_Excit_UseForScaling                                     17FCh ; Specifies if NI-DAQmx divides the measurement by the excitation. You should typically set this property to TRUE for ratiometric transducers. If you set this property to TRUE, set Maximum Value and Minimum Value to reflect the scaling.
#define DAQmx_AI_Excit_UseMultiplexed                                    2180h ; Specifies if the SCXI-1122 multiplexes the excitation to the upper half of the channels as it advances through the scan list.
#define DAQmx_AI_Excit_ActualVal                                         1883h ; Specifies the actual amount of excitation supplied by an internal excitation source.  If you read an internal excitation source more precisely with an external device, set this property to the value you read.  NI-DAQmx ignores this value for external excitation.
#define DAQmx_AI_Excit_DCorAC                                            17FBh ; Specifies if the excitation supply is DC or AC.
#define DAQmx_AI_Excit_VoltageOrCurrent                                  17F6h ; Specifies if the channel uses current or voltage excitation.
#define DAQmx_AI_ACExcit_Freq                                            0101h ; Specifies the AC excitation frequency in Hertz.
#define DAQmx_AI_ACExcit_SyncEnable                                      0102h ; Specifies whether to synchronize the AC excitation source of the channel to that of another channel. Synchronize the excitation sources of multiple channels to use multichannel sensors. Set this property to FALSE for the master channel and to TRUE for the slave channels.
#define DAQmx_AI_ACExcit_WireMode                                        18CDh ; Specifies the number of leads on the LVDT or RVDT. Some sensors require you to tie leads together to create a four- or five- wire sensor. Refer to the sensor documentation for more information.
#define DAQmx_AI_Atten                                                   1801h ; Specifies the amount of attenuation to use.
#define DAQmx_AI_Lowpass_Enable                                          1802h ; Specifies whether to enable the lowpass filter of the channel.
#define DAQmx_AI_Lowpass_CutoffFreq                                      1803h ; Specifies the frequency in Hertz that corresponds to the -3dB cutoff of the filter.
#define DAQmx_AI_Lowpass_SwitchCap_ClkSrc                                1884h ; Specifies the source of the filter clock. If you need a higher resolution for the filter, you can supply an external clock to increase the resolution. Refer to the SCXI-1141/1142/1143 User Manual for more information.
#define DAQmx_AI_Lowpass_SwitchCap_ExtClkFreq                            1885h ; Specifies the frequency of the external clock when you set Clock Source to DAQmx_Val_External.  NI-DAQmx uses this frequency to set the pre- and post- filters on the SCXI-1141, SCXI-1142, and SCXI-1143. On those devices, NI-DAQmx determines the filter cutoff by using the equation f/(100*n), where f is the external frequency, and n is the external clock divisor. Refer to the SCXI-1141/1142/1143 User Manual for more...
#define DAQmx_AI_Lowpass_SwitchCap_ExtClkDiv                             1886h ; Specifies the divisor for the external clock when you set Clock Source to DAQmx_Val_External. On the SCXI-1141, SCXI-1142, and SCXI-1143, NI-DAQmx determines the filter cutoff by using the equation f/(100*n), where f is the external frequency, and n is the external clock divisor. Refer to the SCXI-1141/1142/1143 User Manual for more information.
#define DAQmx_AI_Lowpass_SwitchCap_OutClkDiv                             1887h ; Specifies the divisor for the output clock.  NI-DAQmx uses the cutoff frequency to determine the output clock frequency. Refer to the SCXI-1141/1142/1143 User Manual for more information.
#define DAQmx_AI_ResolutionUnits                                         1764h ; Indicates the units of Resolution Value.
#define DAQmx_AI_Resolution                                              1765h ; Indicates the resolution of the analog-to-digital converter of the channel. This value is in the units you specify with Resolution Units.
#define DAQmx_AI_Dither_Enable                                           0068h ; Specifies whether to enable dithering.  Dithering adds Gaussian noise to the input signal. You can use dithering to achieve higher resolution measurements by over sampling the input signal and averaging the results.
#define DAQmx_AI_Rng_High                                                1815h ; Specifies the upper limit of the input range of the device. This value is in the native units of the device. On E Series devices, for example, the native units is volts.
#define DAQmx_AI_Rng_Low                                                 1816h ; Specifies the lower limit of the input range of the device. This value is in the native units of the device. On E Series devices, for example, the native units is volts.
#define DAQmx_AI_Gain                                                    1818h ; Specifies a gain factor to apply to the channel.
#define DAQmx_AI_SampAndHold_Enable                                      181Ah ; Specifies whether to enable the sample and hold circuitry of the device. When you disable sample and hold circuitry, a small voltage offset might be introduced into the signal.  You can eliminate this offset by using Auto Zero Mode to perform an auto zero on the channel.
#define DAQmx_AI_AutoZeroMode                                            1760h ; Specifies when to measure ground. NI-DAQmx subtracts the measured ground voltage from every sample.
#define DAQmx_AI_DataXferMech                                            1821h ; Specifies the data transfer mode for the device.
#define DAQmx_AI_DataXferReqCond                                         188Bh ; Specifies under what condition to transfer data from the onboard memory of the device to the buffer.
#define DAQmx_AI_MemMapEnable                                            188Ch ; Specifies for NI-DAQmx to map hardware registers to the memory space of the customer process, if possible. Mapping to the memory space of the customer process increases performance. However, memory mapping can adversely affect the operation of the device and possibly result in a system crash if software in the process unintentionally accesses the mapped registers.
#define DAQmx_AI_DevScalingCoeff                                         1930h ; Indicates the coefficients of a polynomial equation that NI-DAQmx uses to scale values from the native format of the device to volts. Each element of the array corresponds to a term of the equation. For example, if index two of the array is 4, the third term of the equation is 4x^2. Scaling coefficients do not account for any custom scales or sensors contained by the channel.
#define DAQmx_AO_Max                                                     1186h ; Specifies the maximum value you expect to generate. The value is in the units you specify with a units property. If you try to write a value larger than the maximum value, NI-DAQmx generates an error. NI-DAQmx might coerce this value to a smaller value if other task settings restrict the device from generating the desired maximum.
#define DAQmx_AO_Min                                                     1187h ; Specifies the minimum value you expect to generate. The value is in the units you specify with a units property. If you try to write a value smaller than the minimum value, NI-DAQmx generates an error. NI-DAQmx might coerce this value to a larger value if other task settings restrict the device from generating the desired minimum.
#define DAQmx_AO_CustomScaleName                                         1188h ; Specifies the name of a custom scale for the channel.
#define DAQmx_AO_OutputType                                              1108h ; Indicates whether the channel generates voltage or current.
#define DAQmx_AO_Voltage_Units                                           1184h ; Specifies in what units to generate voltage on the channel. Write data to the channel in the units you select.
#define DAQmx_AO_Current_Units                                           1109h ; Specifies in what units to generate current on the channel. Write data to the channel is in the units you select.
#define DAQmx_AO_OutputImpedance                                         1490h ; Specifies in ohms the impedance of the analog output stage of the device.
#define DAQmx_AO_LoadImpedance                                           0121h ; Specifies in ohms the load impedance connected to the analog output channel.
#define DAQmx_AO_ResolutionUnits                                         182Bh ; Specifies the units of Resolution Value.
#define DAQmx_AO_Resolution                                              182Ch ; Indicates the resolution of the digital-to-analog converter of the channel. This value is in the units you specify with Resolution Units.
#define DAQmx_AO_DAC_Rng_High                                            182Eh ; Specifies the upper limit of the output range of the device. This value is in the native units of the device. On E Series devices, for example, the native units is volts.
#define DAQmx_AO_DAC_Rng_Low                                             182Dh ; Specifies the lower limit of the output range of the device. This value is in the native units of the device. On E Series devices, for example, the native units is volts.
#define DAQmx_AO_DAC_Ref_ConnToGnd                                       0130h ; Specifies whether to ground the internal DAC reference. Grounding the internal DAC reference has the effect of grounding all analog output channels and stopping waveform generation across all analog output channels regardless of whether the channels belong to the current task. You can ground the internal DAC reference only when Source is DAQmx_Val_Internal and Allow Connecting DAC Reference to Ground at Runtime is...
#define DAQmx_AO_DAC_Ref_AllowConnToGnd                                  1830h ; Specifies whether to allow grounding the internal DAC reference at run time. You must set this property to TRUE and set Source to DAQmx_Val_Internal before you can set Connect DAC Reference to Ground to TRUE.
#define DAQmx_AO_DAC_Ref_Src                                             0132h ; Specifies the source of the DAC reference voltage.  The value of this voltage source determines the full-scale value of the DAC.
#define DAQmx_AO_DAC_Ref_Val                                             1832h ; Specifies in volts the value of the DAC reference voltage. This voltage determines the full-scale range of the DAC. Smaller reference voltages result in smaller ranges, but increased resolution.
#define DAQmx_AO_ReglitchEnable                                          0133h ; Specifies whether to enable reglitching.  The output of a DAC normally glitches whenever the DAC is updated with a new value. The amount of glitching differs from code to code and is generally largest at major code transitions.  Reglitching generates uniform glitch energy at each code transition and provides for more uniform glitches.  Uniform glitch energy makes it easier to filter out the noise introduced from g...
#define DAQmx_AO_UseOnlyOnBrdMem                                         183Ah ; Specifies whether to write samples directly to the onboard memory of the device, bypassing the memory buffer. Generally, you cannot update onboard memory after you start the task. Onboard memory includes data FIFOs.
#define DAQmx_AO_DataXferMech                                            0134h ; Specifies the data transfer mode for the device.
#define DAQmx_AO_DataXferReqCond                                         183Ch ; Specifies under what condition to transfer data from the buffer to the onboard memory of the device.
#define DAQmx_AO_MemMapEnable                                            188Fh ; Specifies if NI-DAQmx maps hardware registers to the memory space of the customer process, if possible. Mapping to the memory space of the customer process increases performance. However, memory mapping can adversely affect the operation of the device and possibly result in a system crash if software in the process unintentionally accesses the mapped registers.
#define DAQmx_AO_DevScalingCoeff                                         1931h ; Indicates the coefficients of a linear equation that NI-DAQmx uses to scale values from a voltage to the native format of the device.  Each element of the array corresponds to a term of the equation. For example, if index two of the array is 4, the third term of the equation is 4x^2.  Scaling coefficients do not account for any custom scales that may be applied to the channel.
#define DAQmx_DI_InvertLines                                             0793h ; Specifies whether to invert the lines in the channel. If you set this property to TRUE, the lines are at high logic when off and at low logic when on.
#define DAQmx_DI_NumLines                                                2178h ; Indicates the number of digital lines in the channel.
#define DAQmx_DI_DigFltr_Enable                                          21D6h ; Specifies whether to enable the digital filter for the line(s) or port(s). You can enable the filter on a line-by-line basis. You do not have to enable the filter for all lines in a channel.
#define DAQmx_DI_DigFltr_MinPulseWidth                                   21D7h ; Specifies in seconds the minimum pulse width the filter recognizes as a valid high or low state transition.
#define DAQmx_DO_InvertLines                                             1133h ; Specifies whether to invert the lines in the channel. If you set this property to TRUE, the lines are at high logic when off and at low logic when on.
#define DAQmx_DO_NumLines                                                2179h ; Indicates the number of digital lines in the channel.
#define DAQmx_DO_Tristate                                                18F3h ; Specifies whether to stop driving the channel and set it to a Hi-Z state.
#define DAQmx_CI_Max                                                     189Ch ; Specifies the maximum value you expect to measure. This value is in the units you specify with a units property. When you query this property, it returns the coerced maximum value that the hardware can measure with the current settings.
#define DAQmx_CI_Min                                                     189Dh ; Specifies the minimum value you expect to measure. This value is in the units you specify with a units property. When you query this property, it returns the coerced minimum value that the hardware can measure with the current settings.
#define DAQmx_CI_CustomScaleName                                         189Eh ; Specifies the name of a custom scale for the channel.
#define DAQmx_CI_MeasType                                                18A0h ; Indicates the measurement to take with the channel.
#define DAQmx_CI_Freq_Units                                              18A1h ; Specifies the units to use to return frequency measurements.
#define DAQmx_CI_Freq_Term                                               18A2h ; Specifies the input terminal of the signal to measure.
#define DAQmx_CI_Freq_StartingEdge                                       0799h ; Specifies between which edges to measure the frequency of the signal.
#define DAQmx_CI_Freq_MeasMeth                                           0144h ; Specifies the method to use to measure the frequency of the signal.
#define DAQmx_CI_Freq_MeasTime                                           0145h ; Specifies in seconds the length of time to measure the frequency of the signal if Method is DAQmx_Val_HighFreq2Ctr. Measurement accuracy increases with increased measurement time and with increased signal frequency. If you measure a high-frequency signal for too long, however, the count register could roll over, which results in an incorrect measurement.
#define DAQmx_CI_Freq_Div                                                0147h ; Specifies the value by which to divide the input signal if  Method is DAQmx_Val_LargeRng2Ctr. The larger the divisor, the more accurate the measurement. However, too large a value could cause the count register to roll over, which results in an incorrect measurement.
#define DAQmx_CI_Period_Units                                            18A3h ; Specifies the unit to use to return period measurements.
#define DAQmx_CI_Period_Term                                             18A4h ; Specifies the input terminal of the signal to measure.
#define DAQmx_CI_Period_StartingEdge                                     0852h ; Specifies between which edges to measure the period of the signal.
#define DAQmx_CI_Period_MeasMeth                                         192Ch ; Specifies the method to use to measure the period of the signal.
#define DAQmx_CI_Period_MeasTime                                         192Dh ; Specifies in seconds the length of time to measure the period of the signal if Method is DAQmx_Val_HighFreq2Ctr. Measurement accuracy increases with increased measurement time and with increased signal frequency. If you measure a high-frequency signal for too long, however, the count register could roll over, which results in an incorrect measurement.
#define DAQmx_CI_Period_Div                                              192Eh ; Specifies the value by which to divide the input signal if Method is DAQmx_Val_LargeRng2Ctr. The larger the divisor, the more accurate the measurement. However, too large a value could cause the count register to roll over, which results in an incorrect measurement.
#define DAQmx_CI_CountEdges_Term                                         18C7h ; Specifies the input terminal of the signal to measure.
#define DAQmx_CI_CountEdges_Dir                                          0696h ; Specifies whether to increment or decrement the counter on each edge.
#define DAQmx_CI_CountEdges_DirTerm                                      21E1h ; Specifies the source terminal of the digital signal that controls the count direction if Direction is DAQmx_Val_ExtControlled.
#define DAQmx_CI_CountEdges_InitialCnt                                   0698h ; Specifies the starting value from which to count.
#define DAQmx_CI_CountEdges_ActiveEdge                                   0697h ; Specifies on which edges to increment or decrement the counter.
#define DAQmx_CI_AngEncoder_Units                                        18A6h ; Specifies the units to use to return angular position measurements from the channel.
#define DAQmx_CI_AngEncoder_PulsesPerRev                                 0875h ; Specifies the number of pulses the encoder generates per revolution. This value is the number of pulses on either signal A or signal B, not the total number of pulses on both signal A and signal B.
#define DAQmx_CI_AngEncoder_InitialAngle                                 0881h ; Specifies the starting angle of the encoder. This value is in the units you specify with Units.
#define DAQmx_CI_LinEncoder_Units                                        18A9h ; Specifies the units to use to return linear encoder measurements from the channel.
#define DAQmx_CI_LinEncoder_DistPerPulse                                 0911h ; Specifies the distance to measure for each pulse the encoder generates on signal A or signal B. This value is in the units you specify with Units.
#define DAQmx_CI_LinEncoder_InitialPos                                   0915h ; Specifies the position of the encoder when the measurement begins. This value is in the units you specify with Units.
#define DAQmx_CI_Encoder_DecodingType                                    21E6h ; Specifies how to count and interpret the pulses the encoder generates on signal A and signal B. DAQmx_Val_X1, DAQmx_Val_X2, and DAQmx_Val_X4 are valid for quadrature encoders only. DAQmx_Val_TwoPulseCounting is valid for two-pulse encoders only.
#define DAQmx_CI_Encoder_AInputTerm                                      219Dh ; Specifies the terminal to which signal A is connected.
#define DAQmx_CI_Encoder_BInputTerm                                      219Eh ; Specifies the terminal to which signal B is connected.
#define DAQmx_CI_Encoder_ZInputTerm                                      219Fh ; Specifies the terminal to which signal Z is connected.
#define DAQmx_CI_Encoder_ZIndexEnable                                    0890h ; Specifies whether to use Z indexing for the channel.
#define DAQmx_CI_Encoder_ZIndexVal                                       0888h ; Specifies the value to which to reset the measurement when signal Z is high and signal A and signal B are at the states you specify with Z Index Phase. Specify this value in the units of the measurement.
#define DAQmx_CI_Encoder_ZIndexPhase                                     0889h ; Specifies the states at which signal A and signal B must be while signal Z is high for NI-DAQmx to reset the measurement. If signal Z is never high while signal A and signal B are high, for example, you must choose a phase other than DAQmx_Val_AHighBHigh.
#define DAQmx_CI_PulseWidth_Units                                        0823h ; Specifies the units to use to return pulse width measurements.
#define DAQmx_CI_PulseWidth_Term                                         18AAh ; Specifies the input terminal of the signal to measure.
#define DAQmx_CI_PulseWidth_StartingEdge                                 0825h ; Specifies on which edge of the input signal to begin each pulse width measurement.
#define DAQmx_CI_TwoEdgeSep_Units                                        18ACh ; Specifies the units to use to return two-edge separation measurements from the channel.
#define DAQmx_CI_TwoEdgeSep_FirstTerm                                    18ADh ; Specifies the source terminal of the digital signal that starts each measurement.
#define DAQmx_CI_TwoEdgeSep_FirstEdge                                    0833h ; Specifies on which edge of the first signal to start each measurement.
#define DAQmx_CI_TwoEdgeSep_SecondTerm                                   18AEh ; Specifies the source terminal of the digital signal that stops each measurement.
#define DAQmx_CI_TwoEdgeSep_SecondEdge                                   0834h ; Specifies on which edge of the second signal to stop each measurement.
#define DAQmx_CI_SemiPeriod_Units                                        18AFh ; Specifies the units to use to return semi-period measurements.
#define DAQmx_CI_SemiPeriod_Term                                         18B0h ; Specifies the input terminal of the signal to measure.
#define DAQmx_CI_CtrTimebaseSrc                                          0143h ; Specifies the terminal of the timebase to use for the counter.
#define DAQmx_CI_CtrTimebaseRate                                         18B2h ; Specifies in Hertz the frequency of the counter timebase. Specifying the rate of a counter timebase allows you to take measurements in terms of time or frequency rather than in ticks of the timebase. If you use an external timebase and do not specify the rate, you can take measurements only in terms of ticks of the timebase.
#define DAQmx_CI_CtrTimebaseActiveEdge                                   0142h ; Specifies whether a timebase cycle is from rising edge to rising edge or from falling edge to falling edge.
#define DAQmx_CI_Count                                                   0148h ; Indicates the current value of the count register.
#define DAQmx_CI_OutputState                                             0149h ; Indicates the current state of the out terminal of the counter.
#define DAQmx_CI_TCReached                                               0150h ; Indicates whether the counter rolled over. When you query this property, NI-DAQmx resets it to FALSE.
#define DAQmx_CI_CtrTimebaseMasterTimebaseDiv                            18B3h ; Specifies the divisor for an external counter timebase. You can divide the counter timebase in order to measure slower signals without causing the count register to roll over.
#define DAQmx_CI_DataXferMech                                            0200h ; Specifies the data transfer mode for the channel.
#define DAQmx_CI_NumPossiblyInvalidSamps                                 193Ch ; Indicates the number of samples that the device might have overwritten before it could transfer them to the buffer.
#define DAQmx_CI_DupCountPrevent                                         21ACh ; Specifies whether to enable duplicate count prevention for the channel.
#define DAQmx_CO_OutputType                                              18B5h ; Indicates how to define pulses generated on the channel.
#define DAQmx_CO_Pulse_IdleState                                         1170h ; Specifies the resting state of the output terminal.
#define DAQmx_CO_Pulse_Term                                              18E1h ; Specifies on which terminal to generate pulses.
#define DAQmx_CO_Pulse_Time_Units                                        18D6h ; Specifies the units in which to define high and low pulse time.
#define DAQmx_CO_Pulse_HighTime                                          18BAh ; Specifies the amount of time that the pulse is at a high voltage. This value is in the units you specify with Units or when you create the channel.
#define DAQmx_CO_Pulse_LowTime                                           18BBh ; Specifies the amount of time that the pulse is at a low voltage. This value is in the units you specify with Units or when you create the channel.
#define DAQmx_CO_Pulse_Time_InitialDelay                                 18BCh ; Specifies in seconds the amount of time to wait before generating the first pulse.
#define DAQmx_CO_Pulse_DutyCyc                                           1176h ; Specifies the duty cycle of the pulses. The duty cycle of a signal is the width of the pulse divided by period. NI-DAQmx uses this ratio and the pulse frequency to determine the width of the pulses and the delay between pulses.
#define DAQmx_CO_Pulse_Freq_Units                                        18D5h ; Specifies the units in which to define pulse frequency.
#define DAQmx_CO_Pulse_Freq                                              1178h ; Specifies the frequency of the pulses to generate. This value is in the units you specify with Units or when you create the channel.
#define DAQmx_CO_Pulse_Freq_InitialDelay                                 0299h ; Specifies in seconds the amount of time to wait before generating the first pulse.
#define DAQmx_CO_Pulse_HighTicks                                         1169h ; Specifies the number of ticks the pulse is high.
#define DAQmx_CO_Pulse_LowTicks                                          1171h ; Specifies the number of ticks the pulse is low.
#define DAQmx_CO_Pulse_Ticks_InitialDelay                                0298h ; Specifies the number of ticks to wait before generating the first pulse.
#define DAQmx_CO_CtrTimebaseSrc                                          0339h ; Specifies the terminal of the timebase to use for the counter. Typically, NI-DAQmx uses one of the internal counter timebases when generating pulses. Use this property to specify an external timebase and produce custom pulse widths that are not possible using the internal timebases.
#define DAQmx_CO_CtrTimebaseRate                                         18C2h ; Specifies in Hertz the frequency of the counter timebase. Specifying the rate of a counter timebase allows you to define output pulses in seconds rather than in ticks of the timebase. If you use an external timebase and do not specify the rate, you can define output pulses only in ticks of the timebase.
#define DAQmx_CO_CtrTimebaseActiveEdge                                   0341h ; Specifies whether a timebase cycle is from rising edge to rising edge or from falling edge to falling edge.
#define DAQmx_CO_Count                                                   0293h ; Indicates the current value of the count register.
#define DAQmx_CO_OutputState                                             0294h ; Indicates the current state of the output terminal of the counter.
#define DAQmx_CO_AutoIncrCnt                                             0295h ; Specifies a number of timebase ticks by which to increment each successive pulse.
#define DAQmx_CO_CtrTimebaseMasterTimebaseDiv                            18C3h ; Specifies the divisor for an external counter timebase. You can divide the counter timebase in order to generate slower signals without causing the count register to roll over.
#define DAQmx_CO_PulseDone                                               190Eh ;Indicates if the task completed pulse generation. Use this value for retriggerable pulse generation when you need to determine if the device generated the current pulse. When you query this property, NI-DAQmx resets it to FALSE.

;********** Export Signal Attributes **********
#define DAQmx_Exported_AIConvClk_OutputTerm                              1687h ; Specifies the terminal to which to route the AI Convert Clock.
#define DAQmx_Exported_AIConvClk_Pulse_Polarity                          1688h ; Indicates the polarity of the exported AI Convert Clock. The polarity is fixed and independent of the active edge of the source of the AI Convert Clock.
#define DAQmx_Exported_20MHzTimebase_OutputTerm                          1657h ; Specifies the terminal to which to route the 20MHz Timebase.
#define DAQmx_Exported_SampClk_OutputBehavior                            186Bh ; Specifies whether the exported Sample Clock issues a pulse at the beginning of a sample or changes to a high state for the duration of the sample.
#define DAQmx_Exported_SampClk_OutputTerm                                1663h ; Specifies the terminal to which to route the Sample Clock.
#define DAQmx_Exported_AdvTrig_OutputTerm                                1645h ; Specifies the terminal to which to route the Advance Trigger.
#define DAQmx_Exported_AdvTrig_Pulse_Polarity                            1646h ; Indicates the polarity of the exported Advance Trigger.
#define DAQmx_Exported_AdvTrig_Pulse_WidthUnits                          1647h ; Specifies the units of Width Value.
#define DAQmx_Exported_AdvTrig_Pulse_Width                               1648h ; Specifies the width of an exported Advance Trigger pulse. Specify this value in the units you specify with Width Units.
#define DAQmx_Exported_RefTrig_OutputTerm                                0590h ; Specifies the terminal to which to route the Reference Trigger.
#define DAQmx_Exported_StartTrig_OutputTerm                              0584h ; Specifies the terminal to which to route the Start Trigger.
#define DAQmx_Exported_AdvCmpltEvent_OutputTerm                          1651h ; Specifies the terminal to which to route the Advance Complete Event.
#define DAQmx_Exported_AdvCmpltEvent_Delay                               1757h ; Specifies the output signal delay in periods of the sample clock.
#define DAQmx_Exported_AdvCmpltEvent_Pulse_Polarity                      1652h ; Specifies the polarity of the exported Advance Complete Event.
#define DAQmx_Exported_AdvCmpltEvent_Pulse_Width                         1654h ; Specifies the width of the exported Advance Complete Event pulse.
#define DAQmx_Exported_AIHoldCmpltEvent_OutputTerm                       18EDh ; Specifies the terminal to which to route the AI Hold Complete Event.
#define DAQmx_Exported_AIHoldCmpltEvent_PulsePolarity                    18EEh ; Specifies the polarity of an exported AI Hold Complete Event pulse.
#define DAQmx_Exported_ChangeDetectEvent_OutputTerm                      2197h ; Specifies the terminal to which to route the Change Detection Event.
#define DAQmx_Exported_CtrOutEvent_OutputTerm                            1717h ; Specifies the terminal to which to route the Counter Output Event.
#define DAQmx_Exported_CtrOutEvent_OutputBehavior                        174Fh ; Specifies whether the exported Counter Output Event pulses or changes from one state to the other when the counter reaches terminal count.
#define DAQmx_Exported_CtrOutEvent_Pulse_Polarity                        1718h ; Specifies the polarity of the pulses at the output terminal of the counter when Output Behavior is DAQmx_Val_Pulse. NI-DAQmx ignores this property if Output Behavior is DAQmx_Val_Toggle.
#define DAQmx_Exported_CtrOutEvent_Toggle_IdleState                      186Ah ; Specifies the initial state of the output terminal of the counter when Output Behavior is DAQmx_Val_Toggle. The terminal enters this state when NI-DAQmx commits the task.
#define DAQmx_Exported_WatchdogExpiredEvent_OutputTerm                   21AAh ; Specifies the terminal  to which to route the Watchdog Timer Expired Event.

;********** Device Attributes **********
#define DAQmx_Dev_ProductType                                            0631h ;Indicates the product name of the device.
#define DAQmx_Dev_SerialNum                                              0632h ; Indicates the serial number of the device. This value is zero if the device does not have a serial number.

;********** Read Attributes **********
#define DAQmx_Read_RelativeTo                                            190Ah ; Specifies the point in the buffer at which to begin a read operation. If you also specify an offset with Offset, the read operation begins at that offset relative to the point you select with this property. The default value is DAQmx_Val_CurrReadPos unless you configure a Reference Trigger for the task. If you configure a Reference Trigger, the default value is DAQmx_Val_FirstPretrigSamp.
#define DAQmx_Read_Offset                                                190Bh ; Specifies an offset in samples per channel at which to begin a read operation. This offset is relative to the location you specify with RelativeTo.
#define DAQmx_Read_ChannelsToRead                                        1823h ; Specifies a subset of channels in the task from which to read.
#define DAQmx_Read_ReadAllAvailSamp                                      1215h ; Specifies whether subsequent read operations read all samples currently available in the buffer or wait for the buffer to become full before reading. NI-DAQmx uses this setting for finite acquisitions and only when the number of samples to read is -1. For continuous acquisitions when the number of samples to read is -1, a read operation always reads all samples currently available in the buffer.
#define DAQmx_Read_AutoStart                                             1826h ; Specifies if an NI-DAQmx Read function automatically starts the task  if you did not start the task explicitly by using DAQmxStartTask(). The default value is TRUE. When  an NI-DAQmx Read function starts a finite acquisition task, it also stops the task after reading the last sample.
#define DAQmx_Read_OverWrite                                             1211h ; Specifies whether to overwrite samples in the buffer that you have not yet read.
#define DAQmx_Read_CurrReadPos                                           1221h ; Indicates in samples per channel the current position in the buffer.
#define DAQmx_Read_AvailSampPerChan                                      1223h ; Indicates the number of samples available to read per channel. This value is the same for all channels in the task.
#define DAQmx_Read_TotalSampPerChanAcquired                              192Ah ; Indicates the total number of samples acquired by each channel. NI-DAQmx returns a single value because this value is the same for all channels.
#define DAQmx_Read_ChangeDetect_HasOverflowed                            2194h ; Indicates if samples were missed because change detection events occurred faster than the device could handle them.
#define DAQmx_Read_RawDataWidth                                          217Ah ; Indicates in bytes the size of a raw sample from the task.
#define DAQmx_Read_NumChans                                              217Bh ; Indicates the number of channels that an NI-DAQmx Read function reads from the task. This value is the number of channels in the task or the number of channels you specify with Channels to Read.
#define DAQmx_Read_DigitalLines_BytesPerChan                             217Ch ; Indicates the number of bytes per channel that NI-DAQmx returns in a sample for line-based reads. If a channel has fewer lines than this number, the extra bytes are FALSE.

;********** Switch Channel Attributes **********
#define DAQmx_SwitchChan_Usage                                           18E4h ; Specifies how you can use the channel. Using this property acts as a safety mechanism to prevent you from connecting two source channels, for example.
#define DAQmx_SwitchChan_MaxACCarryCurrent                               0648h ; Indicates in amperes the maximum AC current that the device can carry.
#define DAQmx_SwitchChan_MaxACSwitchCurrent                              0646h ; Indicates in amperes the maximum AC current that the device can switch. This current is always against an RMS voltage level.
#define DAQmx_SwitchChan_MaxACCarryPwr                                   0642h ; Indicates in watts the maximum AC power that the device can carry.
#define DAQmx_SwitchChan_MaxACSwitchPwr                                  0644h ; Indicates in watts the maximum AC power that the device can switch.
#define DAQmx_SwitchChan_MaxDCCarryCurrent                               0647h ; Indicates in amperes the maximum DC current that the device can carry.
#define DAQmx_SwitchChan_MaxDCSwitchCurrent                              0645h ; Indicates in amperes the maximum DC current that the device can switch. This current is always against a DC voltage level.
#define DAQmx_SwitchChan_MaxDCCarryPwr                                   0643h ; Indicates in watts the maximum DC power that the device can carry.
#define DAQmx_SwitchChan_MaxDCSwitchPwr                                  0649h ; Indicates in watts the maximum DC power that the device can switch.
#define DAQmx_SwitchChan_MaxACVoltage                                    0651h ; Indicates in volts the maximum AC RMS voltage that the device can switch.
#define DAQmx_SwitchChan_MaxDCVoltage                                    0650h ; Indicates in volts the maximum DC voltage that the device can switch.
#define DAQmx_SwitchChan_WireMode                                        18E5h ; Indicates the number of wires that the channel switches.
#define DAQmx_SwitchChan_Bandwidth                                       0640h ; Indicates in Hertz the maximum frequency of a signal that can pass through the switch without significant deterioration.
#define DAQmx_SwitchChan_Impedance                                       0641h ; Indicates in ohms the switch impedance. This value is important in the RF domain and should match the impedance of the sources and loads.

;********** Switch Device Attributes **********
#define DAQmx_SwitchDev_SettlingTime                                     1244h ; Specifies in seconds the amount of time to wait for the switch to settle (or debounce). Refer to device documentation for supported settling times.
#define DAQmx_SwitchDev_AutoConnAnlgBus                                  17DAh ; Specifies if NI-DAQmx routes multiplexed channels to the analog bus backplane. Only the SCXI-1127 and SCXI-1128 support this property.
#define DAQmx_SwitchDev_Settled                                          1243h ; Indicates when Settling Time expires.
#define DAQmx_SwitchDev_RelayList                                        17DCh ; Indicates a comma-delimited list of relay names.
#define DAQmx_SwitchDev_NumRelays                                        18E6h ; Indicates the number of relays on the device. This value matches the number of relay names in Relay List.
#define DAQmx_SwitchDev_SwitchChanList                                   18E7h ; Indicates a comma-delimited list of channel names for the current topology of the device.
#define DAQmx_SwitchDev_NumSwitchChans                                   18E8h ; Indicates the number of switch channels for the current topology of the device. This value matches the number of channel names in Switch Channel List.
#define DAQmx_SwitchDev_NumRows                                          18E9h ; Indicates the number of rows on a device in a matrix switch topology. Indicates the number of multiplexed channels on a device in a mux topology.
#define DAQmx_SwitchDev_NumColumns                                       18EAh ; Indicates the number of columns on a device in a matrix switch topology. This value is always 1 if the device is in a mux topology.
#define DAQmx_SwitchDev_Topology                                         193Dh ; Indicates the current topology of the device. This value is one of the topology options in DAQmxSwitchSetTopologyAndReset().

;********** Switch Scan Attributes **********
#define DAQmx_SwitchScan_BreakMode                                       1247h ; Specifies the break mode between each entry in a scan list.
#define DAQmx_SwitchScan_RepeatMode                                      1248h ; Specifies if the task advances through the scan list multiple times.
#define DAQmx_SwitchScan_WaitingForAdv                                   17D9h ; Indicates if the switch hardware is waiting for an  Advance Trigger. If the hardware is waiting, it completed the previous entry in the scan list.

;********** Scale Attributes **********
#define DAQmx_Scale_Descr                                                1226h ; Specifies a description for the scale.
#define DAQmx_Scale_ScaledUnits                                          191Bh ; Specifies the units to use for scaled values. You can use an arbitrary string.
#define DAQmx_Scale_PreScaledUnits                                       18F7h ; Specifies the units of the values that you want to scale.
#define DAQmx_Scale_Type                                                 1929h ; Indicates the method or equation form that the custom scale uses.
#define DAQmx_Scale_Lin_Slope                                            1227h ; Specifies the slope, m, in the equation y=mx+b.
#define DAQmx_Scale_Lin_YIntercept                                       1228h ; Specifies the y-intercept, b, in the equation y=mx+b.
#define DAQmx_Scale_Map_ScaledMax                                        1229h ; Specifies the largest value in the range of scaled values. NI-DAQmx maps this value to Pre-Scaled Maximum Value. Reads clip samples that are larger than this value. Writes generate errors for samples that are larger than this value.
#define DAQmx_Scale_Map_PreScaledMax                                     1231h ; Specifies the largest value in the range of pre-scaled values. NI-DAQmx maps this value to Scaled Maximum Value.
#define DAQmx_Scale_Map_ScaledMin                                        1230h ; Specifies the smallest value in the range of scaled values. NI-DAQmx maps this value to Pre-Scaled Minimum Value. Reads clip samples that are smaller than this value. Writes generate errors for samples that are smaller than this value.
#define DAQmx_Scale_Map_PreScaledMin                                     1232h ; Specifies the smallest value in the range of pre-scaled values. NI-DAQmx maps this value to Scaled Minimum Value.
#define DAQmx_Scale_Poly_ForwardCoeff                                    1234h ; Specifies an array of coefficients for the polynomial that converts pre-scaled values to scaled values. Each element of the array corresponds to a term of the equation. For example, if index three of the array is 9, the fourth term of the equation is 9x^3.
#define DAQmx_Scale_Poly_ReverseCoeff                                    1235h ; Specifies an array of coefficients for the polynomial that converts scaled values to pre-scaled values. Each element of the array corresponds to a term of the equation. For example, if index three of the array is 9, the fourth term of the equation is 9y^3.
#define DAQmx_Scale_Table_ScaledVals                                     1236h ; Specifies an array of scaled values. These values map directly to the values in Pre-Scaled Values.
#define DAQmx_Scale_Table_PreScaledVals                                  1237h ; Specifies an array of pre-scaled values. These values map directly to the values in Scaled Values.

;********** System Attributes **********
#define DAQmx_Sys_GlobalChans                                            1265h ; Indicates an array that contains the names of all global channels saved on the system.
#define DAQmx_Sys_Scales                                                 1266h ; Indicates an array that contains the names of all custom scales saved on the system.
#define DAQmx_Sys_Tasks                                                  1267h ; Indicates an array that contains the names of all tasks saved on the system.
#define DAQmx_Sys_DevNames                                               193Bh ; Indicates an array that contains the names of all devices installed in the system.
#define DAQmx_Sys_NIDAQMajorVersion                                      1272h ; Indicates the major portion of the installed version of NI-DAQ, such as 7 for version 7.0.
#define DAQmx_Sys_NIDAQMinorVersion                                      1923h ; Indicates the minor portion of the installed version of NI-DAQ, such as 0 for version 7.0.

;********** Task Attributes **********
#define DAQmx_Task_Name                                                  1276h ; Indicates the name of the task.
#define DAQmx_Task_Channels                                              1273h ; Indicates the names of all virtual channels in the task.
#define DAQmx_Task_NumChans                                              2181h ; Indicates the number of virtual channels in the task.
#define DAQmx_Task_Complete                                              1274h ; Indicates whether the task completed execution.

;********** Timing Attributes **********
#define DAQmx_SampQuant_SampMode                                         1300h ; Specifies if a task acquires or generates a finite number of samples or if it continuously acquires or generates samples.
#define DAQmx_SampQuant_SampPerChan                                      1310h ; Specifies the number of samples to acquire or generate for each channel if Sample Mode is finite.
#define DAQmx_SampTimingType                                             1347h ; Specifies the type of sample timing to use for the task.
#define DAQmx_SampClk_Rate                                               1344h ; Specifies the sampling rate in samples per channel per second. If you use an external source for the Sample Clock, set this input to the maximum expected rate of that clock.
#define DAQmx_SampClk_Src                                                1852h ; Specifies the terminal of the signal to use as the Sample Clock.
#define DAQmx_SampClk_ActiveEdge                                         1301h ; Specifies on which edge of a clock pulse sampling takes place. This property is useful primarily when the signal you use as the Sample Clock is not a periodic clock.
#define DAQmx_SampClk_TimebaseDiv                                        18EBh ; Specifies the number of Sample Clock Timebase pulses needed to produce a single Sample Clock pulse.
#define DAQmx_SampClk_Timebase_Rate                                      1303h ; Specifies the rate of the Sample Clock Timebase. When the signal you use as the Sample Clock Timebase is not a clock, NI-DAQmx might require the rate to calculate other timing parameters. If this is the case, setting this property to an approximation is preferable to not setting it at all.
#define DAQmx_SampClk_Timebase_Src                                       1308h ; Specifies the terminal of the signal to use as the Sample Clock Timebase.
#define DAQmx_SampClk_Timebase_ActiveEdge                                18ECh ; Specifies on which edge to recognize a Sample Clock Timebase pulse. This property is useful primarily when the signal you use as the Sample Clock Timebase is not a periodic clock.
#define DAQmx_SampClk_Timebase_MasterTimebaseDiv                         1305h ; Specifies the number of pulses of the Master Timebase needed to produce a single pulse of the Sample Clock Timebase.
#define DAQmx_ChangeDetect_DI_RisingEdgePhysicalChans                    2195h ; Specifies the names of the digital lines or ports on which to detect rising edges. The lines or ports must be used by virtual channels in the task. You also can specify a string that contains a list or range of digital lines or ports.
#define DAQmx_ChangeDetect_DI_FallingEdgePhysicalChans                   2196h ; Specifies the names of the digital lines or ports on which to detect rising edges. The lines or ports must be used by virtual channels in the task. You also can specify a string that contains a list or range of digital lines or ports.
#define DAQmx_OnDemand_SimultaneousAOEnable                              21A0h ; Specifies whether to update all channels in the task simultaneously, rather than updating channels independently when you write a sample to that channel.
#define DAQmx_AIConv_Rate                                                1848h ; Specifies the rate at which to clock the analog-to-digital converter. This clock is specific to the analog input section of an E Series device.
#define DAQmx_AIConv_Src                                                 1502h ; Specifies the terminal of the signal to use as the AI Convert Clock.
#define DAQmx_AIConv_ActiveEdge                                          1853h ; Specifies on which edge of the clock pulse an analog-to-digital conversion takes place.
#define DAQmx_AIConv_TimebaseDiv                                         1335h ; Specifies the number of AI Convert Clock Timebase pulses needed to produce a single AI Convert Clock pulse.
#define DAQmx_AIConv_Timebase_Src                                        1339h ; Specifies the terminal  of the signal to use as the AI Convert Clock Timebase.
#define DAQmx_MasterTimebase_Rate                                        1495h ; Specifies the rate of the Master Timebase.
#define DAQmx_MasterTimebase_Src                                         1343h ; Specifies the terminal of the signal to use as the Master Timebase. On an E Series device, you can choose only between the onboard 20MHz Timebase or the RTSI7 terminal.
#define DAQmx_DelayFromSampClk_DelayUnits                                1304h ; Specifies the units of Delay.
#define DAQmx_DelayFromSampClk_Delay                                     1317h ; Specifies the amount of time to wait after receiving a Sample Clock edge before beginning to acquire the sample. This value is in the units you specify with Delay Units.

;********** Trigger Attributes **********
#define DAQmx_StartTrig_Type                                             1393h ; Specifies the type of trigger to use to start a task.
#define DAQmx_DigEdge_StartTrig_Src                                      1407h ; Specifies the name of a terminal where there is a digital signal to use as the source of the Start Trigger.
#define DAQmx_DigEdge_StartTrig_Edge                                     1404h ; Specifies on which edge of a digital pulse to start acquiring or generating samples.
#define DAQmx_AnlgEdge_StartTrig_Src                                     1398h ; Specifies the name of a virtual channel or terminal where there is an analog signal to use as the source of the Start Trigger.
#define DAQmx_AnlgEdge_StartTrig_Slope                                   1397h ; Specifies on which slope of the trigger signal to start acquiring or generating samples.
#define DAQmx_AnlgEdge_StartTrig_Lvl                                     1396h ; Specifies at what threshold in the units of the measurement or generation to start acquiring or generating samples. Use Slope to specify on which slope to trigger on this threshold.
#define DAQmx_AnlgEdge_StartTrig_Hyst                                    1395h ; Specifies a hysteresis level in the units of the measurement or generation. If Slope is DAQmx_Val_RisingSlope, the trigger does not deassert until the source signal passes below  Level minus the hysteresis. If Slope is DAQmx_Val_FallingSlope, the trigger does not deassert until the source signal passes above Level plus the hysteresis.
#define DAQmx_AnlgWin_StartTrig_Src                                      1400h ; Specifies the name of a virtual channel or terminal where there is an analog signal to use as the source of the Start Trigger.
#define DAQmx_AnlgWin_StartTrig_When                                     1401h ; Specifies whether the task starts acquiring or generating samples when the signal enters or leaves the window you specify with Bottom and Top.
#define DAQmx_AnlgWin_StartTrig_Top                                      1403h ; Specifies the upper limit of the window. Specify this value in the units of the measurement or generation.
#define DAQmx_AnlgWin_StartTrig_Btm                                      1402h ; Specifies the lower limit of the window. Specify this value in the units of the measurement or generation.
#define DAQmx_StartTrig_Delay                                            1856h ; Specifies an amount of time to wait after the Start Trigger is received before acquiring or generating the first sample. This value is in the units you specify with Delay Units.
#define DAQmx_StartTrig_DelayUnits                                       18C8h ; Specifies the units of Delay.
#define DAQmx_StartTrig_Retriggerable                                    190Fh ; Specifies whether to enable retriggerable counter pulse generation. When you set this property to TRUE, the device generates pulses each time it receives a trigger. The device ignores a trigger if it is in the process of generating pulses.
#define DAQmx_RefTrig_Type                                               1419h ; Specifies the type of trigger to use to mark a reference point for the measurement.
#define DAQmx_RefTrig_PretrigSamples                                     1445h ; Specifies the minimum number of pretrigger samples to acquire from each channel before recognizing the reference trigger. Post-trigger samples per channel are equal to Samples Per Channel minus the number of pretrigger samples per channel.
#define DAQmx_DigEdge_RefTrig_Src                                        1434h ; Specifies the name of a terminal where there is a digital signal to use as the source of the Reference Trigger.
#define DAQmx_DigEdge_RefTrig_Edge                                       1430h ; Specifies on what edge of a digital pulse the Reference Trigger occurs.
#define DAQmx_AnlgEdge_RefTrig_Src                                       1424h ; Specifies the name of a virtual channel or terminal where there is an analog signal to use as the source of the Reference Trigger.
#define DAQmx_AnlgEdge_RefTrig_Slope                                     1423h ; Specifies on which slope of the source signal the Reference Trigger occurs.
#define DAQmx_AnlgEdge_RefTrig_Lvl                                       1422h ; Specifies in the units of the measurement the threshold at which the Reference Trigger occurs.  Use Slope to specify on which slope to trigger at this threshold.
#define DAQmx_AnlgEdge_RefTrig_Hyst                                      1421h ; Specifies a hysteresis level in the units of the measurement. If Slope is DAQmx_Val_RisingSlope, the trigger does not deassert until the source signal passes below Level minus the hysteresis. If Slope is DAQmx_Val_FallingSlope, the trigger does not deassert until the source signal passes above Level plus the hysteresis.
#define DAQmx_AnlgWin_RefTrig_Src                                        1426h ; Specifies the name of a virtual channel or terminal where there is an analog signal to use as the source of the Reference Trigger.
#define DAQmx_AnlgWin_RefTrig_When                                       1427h ; Specifies whether the Reference Trigger occurs when the source signal enters the window or when it leaves the window. Use Bottom and Top to specify the window.
#define DAQmx_AnlgWin_RefTrig_Top                                        1429h ; Specifies the upper limit of the window. Specify this value in the units of the measurement.
#define DAQmx_AnlgWin_RefTrig_Btm                                        1428h ; Specifies the lower limit of the window. Specify this value in the units of the measurement.
#define DAQmx_AdvTrig_Type                                               1365h ; Specifies the type of trigger to use to advance to the next entry in a scan list.
#define DAQmx_DigEdge_AdvTrig_Src                                        1362h ; Specifies the name of a terminal where there is a digital signal to use as the source of the Advance Trigger.
#define DAQmx_DigEdge_AdvTrig_Edge                                       1360h ; Specifies on which edge of a digital signal to advance to the next entry in a scan list.
#define DAQmx_PauseTrig_Type                                             1366h ; Specifies the type of trigger to use to pause a task.
#define DAQmx_AnlgLvl_PauseTrig_Src                                      1370h ; Specifies the name of a virtual channel or terminal where there is an analog signal to use as the source of the trigger.
#define DAQmx_AnlgLvl_PauseTrig_When                                     1371h ; Specifies whether the task pauses above or below the threshold you specify with Level.
#define DAQmx_AnlgLvl_PauseTrig_Lvl                                      1369h ; Specifies the threshold at which to pause the task. Specify this value in the units of the measurement or generation. Use Pause When to specify whether the task pauses above or below this threshold.
#define DAQmx_AnlgLvl_PauseTrig_Hyst                                     1368h ; Specifies a hysteresis level in the units of the measurement or generation. If Pause When is DAQmx_Val_AboveLvl, the trigger does not deassert until the source signal passes below Level minus the hysteresis. If Pause When is DAQmx_Val_BelowLvl, the trigger does not deassert until the source signal passes above Level plus the hysteresis.
#define DAQmx_AnlgWin_PauseTrig_Src                                      1373h ; Specifies the name of a virtual channel or terminal where there is an analog signal to use as the source of the trigger.
#define DAQmx_AnlgWin_PauseTrig_When                                     1374h ; Specifies whether the task pauses while the trigger signal is inside or outside the window you specify with Bottom and Top.
#define DAQmx_AnlgWin_PauseTrig_Top                                      1376h ; Specifies the upper limit of the window. Specify this value in the units of the measurement or generation.
#define DAQmx_AnlgWin_PauseTrig_Btm                                      1375h ; Specifies the lower limit of the window. Specify this value in the units of the measurement or generation.
#define DAQmx_DigLvl_PauseTrig_Src                                       1379h ; Specifies the name of a terminal where there is a digital signal to use as the source of the Pause Trigger.
#define DAQmx_DigLvl_PauseTrig_When                                      1380h ; Specifies whether the task pauses while the signal is high or low.
#define DAQmx_ArmStartTrig_Type                                          1414h ; Specifies the type of trigger to use to arm the task for a Start Trigger. If you configure an Arm Start Trigger, the task does not respond to a Start Trigger until the device receives the Arm Start Trigger.
#define DAQmx_DigEdge_ArmStartTrig_Src                                   1417h ; Specifies the name of a terminal where there is a digital signal to use as the source of the Arm Start Trigger.
#define DAQmx_DigEdge_ArmStartTrig_Edge                                  1415h ; Specifies on which edge of a digital signal to arm the task for a Start Trigger.

;********** Watchdog Attributes **********
#define DAQmx_Watchdog_Timeout                                           21A9h ; Specifies in seconds the amount of time until the watchdog timer expires. A value of -1 means the internal timer never expires. Set this input to -1 if you use an Expiration Trigger to expire the watchdog task.
#define DAQmx_WatchdogExpirTrig_Type                                     21A3h ; Specifies the type of trigger to use to expire a watchdog task.
#define DAQmx_DigEdge_WatchdogExpirTrig_Src                              21A4h ; Specifies the name of a terminal where a digital signal exists to use as the source of the Expiration Trigger.
#define DAQmx_DigEdge_WatchdogExpirTrig_Edge                             21A5h ; Specifies on which edge of a digital signal to expire the watchdog task.
#define DAQmx_Watchdog_DO_ExpirState                                     21A7h ; Specifies the state to which to set the digital physical channels when the watchdog task expires.  You cannot modify the expiration state of dedicated digital input physical channels.
#define DAQmx_Watchdog_HasExpired                                        21A8h ; Indicates if the watchdog timer expired. You can read this property only while the task is running.

;********** Write Attributes **********
#define DAQmx_Write_RelativeTo                                           190Ch ; Specifies the point in the buffer at which to write data. If you also specify an offset with Offset, the write operation begins at that offset relative to this point you select with this property.
#define DAQmx_Write_Offset                                               190Dh ; Specifies in samples per channel an offset at which a write operation begins. This offset is relative to the location you specify with Relative To.
#define DAQmx_Write_RegenMode                                            1453h ; Specifies whether to allow NI-DAQmx to generate the same data multiple times.
#define DAQmx_Write_CurrWritePos                                         1458h ; Indicates the number of the next sample for the device to generate. This value is identical for all channels in the task.
#define DAQmx_Write_SpaceAvail                                           1460h ; Indicates in samples per channel the amount of available space in the buffer.
#define DAQmx_Write_TotalSampPerChanGenerated                            192Bh ; Indicates the total number of samples generated by each channel in the task. This value is identical for all channels in the task.
#define DAQmx_Write_RawDataWidth                                         217Dh ; Indicates in bytes the required size of a raw sample to write to the task.
#define DAQmx_Write_NumChans                                             217Eh ; Indicates the number of channels that an NI-DAQmx Write function writes to the task. This value is the number of channels in the task.
#define DAQmx_Write_DigitalLines_BytesPerChan                            217Fh ; Indicates the number of bytes expected per channel in a sample for line-based writes. If a channel has fewer lines than this number, NI-DAQmx ignores the extra bytes.


;******************************************************************************
; *** NI-DAQmx Values **********************************************************
; ******************************************************************************

;******************************************************
;***    Non-Attribute Function Parameter Values     ***
;******************************************************

;*** Values for the Mode parameter of DAQmxTaskControl ***
#define DAQmx_Val_Task_Start                                              0   ; Start
#define DAQmx_Val_Task_Stop                                               1   ; Stop
#define DAQmx_Val_Task_Verify                                             2   ; Verify
#define DAQmx_Val_Task_Commit                                             3   ; Commit
#define DAQmx_Val_Task_Reserve                                            4   ; Reserve
#define DAQmx_Val_Task_Unreserve                                          5   ; Unreserve
#define DAQmx_Val_Task_Abort                                              6   ; Abort

;*** Values for the Action parameter of DAQmxControlWatchdogTask ***
#define DAQmx_Val_ResetTimer                                              0   ; Reset Timer
#define DAQmx_Val_ClearExpiration                                         1   ; Clear Expiration

;*** Values for the Line Grouping parameter of DAQmxCreateDIChan and DAQmxCreateDOChan ***
#define DAQmx_Val_ChanPerLine                                             0   ; One Channel For Each Line
#define DAQmx_Val_ChanForAllLines                                         1   ; One Channel For All Lines

;*** Values for the Fill Mode parameter of DAQmxReadAnalogF64, DAQmxReadBinaryI16, DAQmxReadBinaryU16, DAQmxReadDigitalU8, DAQmxReadDigitalU32, DAQmxReadDigitalLines ***
;*** Values for the Data Layout parameter of DAQmxWriteAnalogF64, DAQmxWriteBinaryI16, DAQmxWriteDigitalU8, DAQmxWriteDigitalU32, DAQmxWriteDigitalLines ***
#define DAQmx_Val_GroupByChannel                                          0   ; Group by Channel
#define DAQmx_Val_GroupByScanNumber                                       1   ; Group by Scan Number

;*** Values for the Signal Modifiers parameter of DAQmxConnectTerms ***/
#define DAQmx_Val_DoNotInvertPolarity                                     0   ; Do not invert polarity
#define DAQmx_Val_InvertPolarity                                          1   ; Invert polarity

;*** Values for the Action paramter of DAQmxCloseExtCal ***
#define DAQmx_Val_Action_Commit                                           0   ; Commit
#define DAQmx_Val_Action_Cancel                                           1   ; Cancel

;*** Values for the Trigger ID parameter of DAQmxSendSoftwareTrigger ***
#define DAQmx_Val_AdvanceTrigger                                          12488 ; Advance Trigger

;*** Value set for the Signal ID parameter of DAQmxExportSignal ***
#define DAQmx_Val_AIConvertClock                                          12484 ; AI Convert Clock
#define DAQmx_Val_20MHzTimebaseClock                                      12486 ; 20MHz Timebase Clock
#define DAQmx_Val_SampleClock                                             12487 ; Sample Clock
#define DAQmx_Val_AdvanceTrigger                                          12488 ; Advance Trigger
#define DAQmx_Val_ReferenceTrigger                                        12490 ; Reference Trigger
#define DAQmx_Val_StartTrigger                                            12491 ; Start Trigger
#define DAQmx_Val_AdvCmpltEvent                                           12492 ; Advance Complete Event
#define DAQmx_Val_AIHoldCmpltEvent                                        12493 ; AI Hold Complete Event
#define DAQmx_Val_CounterOutputEvent                                      12494 ; Counter Output Event
#define DAQmx_Val_ChangeDetectionEvent                                    12511 ; Change Detection Event
#define DAQmx_Val_WDTExpiredEvent                                         12512 ; Watchdog Timer Expired Event

;*** Value set for the ActiveEdge parameter of DAQmxCfgSampClkTiming ***
#define DAQmx_Val_Rising                                                  10280 ; Rising
#define DAQmx_Val_Falling                                                 10171 ; Falling

;*** Value set SwitchPathType ***
;*** Value set for the output Path Status parameter of DAQmxSwitchFindPath ***
#define DAQmx_Val_PathStatus_Available                                    10431 ; Path Available
#define DAQmx_Val_PathStatus_AlreadyExists                                10432 ; Path Already Exists
#define DAQmx_Val_PathStatus_Unsupported                                  10433 ; Path Unsupported
#define DAQmx_Val_PathStatus_ChannelInUse                                 10434 ; Channel In Use
#define DAQmx_Val_PathStatus_SourceChannelConflict                        10435 ; Channel Source Conflict
#define DAQmx_Val_PathStatus_ChannelReservedForRouting                    10436 ; Channel Reserved for Routing

;*** Value set for the Units parameter of DAQmxCreateAIThrmcplChan, DAQmxCreateAIRTDChan, DAQmxCreateAIThrmstrChanIex, DAQmxCreateAIThrmstrChanVex and DAQmxCreateAITempBuiltInSensorChan ***
#define DAQmx_Val_DegC                                                    10143 ; Deg C
#define DAQmx_Val_DegF                                                    10144 ; Deg F
#define DAQmx_Val_Kelvins                                                 10325 ; Kelvins
#define DAQmx_Val_DegR                                                    10145 ; Deg R

;*** Value set for the state parameter of DAQmxSetDigitalPowerUpStates ***
#define DAQmx_Val_High                                                    10192 ; High
#define DAQmx_Val_Low                                                     10214 ; Low
#define DAQmx_Val_Tristate                                                10310 ; Tristate

;*** Value set RelayPos ***
;*** Value set for the state parameter of DAQmxSwitchGetSingleRelayPos and DAQmxSwitchGetMultiRelayPos ***
#define DAQmx_Val_Open                                                    10437 ; Open
#define DAQmx_Val_Closed                                                  10438 ; Closed

;*** Value for the Terminal Config parameter of DAQmxCreateAIVoltageChan, DAQmxCreateAICurrentChan and DAQmxCreateAIVoltageChanWithExcit ***
#define DAQmx_Val_Cfg_Default                                             -1 ; Default

;*** Value for the Timeout parameter of DAQmxWaitUntilTaskDone
#define DAQmx_Val_WaitInfinitely                                          -1.0

;*** Value for the Number of Samples per Channel parameter of DAQmxReadAnalogF64, DAQmxReadBinaryI16, DAQmxReadBinaryU16, DAQmxReadDigitalU8, DAQmxReadDigitalU32,
;    DAQmxReadDigitalLines, DAQmxReadCounterF64, DAQmxReadCounterU32 and DAQmxReadRaw ***
#define DAQmx_Val_Auto                                                     -1

;******************************************************
;***              Attribute Values                  ***
;******************************************************
;*** Values for DAQmx_AI_ACExcit_WireMode ***
;*** Value set ACExcitWireMode ***
#define DAQmx_Val_4Wire                                                       4 ; 4-Wire
#define DAQmx_Val_5Wire                                                       5 ; 5-Wire

;*** Values for DAQmx_AI_MeasType ***
;*** Value set AIMeasurementType ***
#define DAQmx_Val_Voltage                                                 10322 ; Voltage
#define DAQmx_Val_Current                                                 10134 ; Current
#define DAQmx_Val_Voltage_CustomWithExcitation                            10323 ; More:Voltage:Custom with Excitation
#define DAQmx_Val_Freq_Voltage                                            10181 ; Frequency
#define DAQmx_Val_Resistance                                              10278 ; Resistance
#define DAQmx_Val_Temp_TC                                                 10303 ; Temperature:Thermocouple
#define DAQmx_Val_Temp_Thrmstr                                            10302 ; Temperature:Thermistor
#define DAQmx_Val_Temp_RTD                                                10301 ; Temperature:RTD
#define DAQmx_Val_Temp_BuiltInSensor                                      10311 ; Temperature:Built-in Sensor
#define DAQmx_Val_Strain_Gage                                             10300 ; Strain Gage
#define DAQmx_Val_Position_LVDT                                           10352 ; Position:LVDT
#define DAQmx_Val_Position_RVDT                                           10353 ; Position:RVDT
#define DAQmx_Val_Accelerometer                                           10356 ; Accelerometer

;*** Values for DAQmx_AO_OutputType ***
;*** Value set AOOutputChannelType ***
#define DAQmx_Val_Voltage                                                 10322 ; Voltage
#define DAQmx_Val_Current                                                 10134 ; Current

;*** Values for DAQmx_AI_Accel_SensitivityUnits ***
;*** Value set AccelSensitivityUnits1 ***
#define DAQmx_Val_mVoltsPerG                                              12509 ; mVolts/g
#define DAQmx_Val_VoltsPerG                                               12510 ; Volts/g

;*** Values for DAQmx_AI_Accel_Units ***
;*** Value set AccelUnits2 ***
#define DAQmx_Val_AccelUnit_g                                             10186 ; g
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale

;*** Values for DAQmx_SampQuant_SampMode ***
;*** Value set AcquisitionType ***
#define DAQmx_Val_FiniteSamps                                             10178 ; Finite Samples
#define DAQmx_Val_ContSamps                                               10123 ; Continuous Samples

;*** Values for DAQmx_AnlgLvl_PauseTrig_When ***
;*** Value set ActiveLevel ***
#define DAQmx_Val_AboveLvl                                                10093 ; Above Level
#define DAQmx_Val_BelowLvl                                                10107 ; Below Level

;*** Values for DAQmx_AI_RVDT_Units ***
;*** Value set AngleUnits1 ***
#define DAQmx_Val_Degrees                                                 10146 ; Degrees
#define DAQmx_Val_Radians                                                 10273 ; Radians
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale

;*** Values for DAQmx_CI_AngEncoder_Units ***
;*** Value set AngleUnits2 ***
#define DAQmx_Val_Degrees                                                 10146 ; Degrees
#define DAQmx_Val_Radians                                                 10273 ; Radians
#define DAQmx_Val_Ticks                                                   10304 ; Ticks
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale

;*** Values for DAQmx_AI_AutoZeroMode ***
;*** Value set AutoZeroType1 ***
#define DAQmx_Val_None                                                    10230 ; None
#define DAQmx_Val_Once                                                    10244 ; Once

;*** Values for DAQmx_SwitchScan_BreakMode ***
;*** Value set BreakMode ***
#define DAQmx_Val_NoAction                                                10227 ; No Action
#define DAQmx_Val_BreakBeforeMake                                         10110 ; Break Before Make

;*** Values for DAQmx_AI_Bridge_Cfg ***
;*** Value set BridgeConfiguration1 ***
#define DAQmx_Val_FullBridge                                              10182 ; Full Bridge
#define DAQmx_Val_HalfBridge                                              10187 ; Half Bridge
#define DAQmx_Val_QuarterBridge                                           10270 ; Quarter Bridge
#define DAQmx_Val_NoBridge                                                10228 ; No Bridge

;*** Values for DAQmx_CI_MeasType ***
;*** Value set CIMeasurementType ***
#define DAQmx_Val_CountEdges                                              10125 ; Count Edges
#define DAQmx_Val_Freq                                                    10179 ; Frequency
#define DAQmx_Val_Period                                                  10256 ; Period
#define DAQmx_Val_PulseWidth                                              10359 ; Pulse Width
#define DAQmx_Val_SemiPeriod                                              10289 ; Semi Period
#define DAQmx_Val_Position_AngEncoder                                     10360 ; Position:Angular Encoder
#define DAQmx_Val_Position_LinEncoder                                     10361 ; Position:Linear Encoder
#define DAQmx_Val_TwoEdgeSep                                              10267 ; Two Edge Separation

;*** Values for DAQmx_AI_Thrmcpl_CJCSrc ***
;*** Value set CJCSource1 ***
#define DAQmx_Val_BuiltIn                                                 10200 ; Built-In
#define DAQmx_Val_ConstVal                                                10116 ; Constant Value
#define DAQmx_Val_Chan                                                    10113 ; Channel

;*** Values for DAQmx_CO_OutputType ***
;*** Value set COOutputType ***
#define DAQmx_Val_Pulse_Time                                              10269 ; Pulse:Time
#define DAQmx_Val_Pulse_Freq                                              10119 ; Pulse:Frequency
#define DAQmx_Val_Pulse_Ticks                                             10268 ; Pulse:Ticks

;*** Values for DAQmx_ChanType ***
;*** Value set ChannelType ***
#define DAQmx_Val_AI                                                      10100 ; Analog Input
#define DAQmx_Val_AO                                                      10102 ; Analog Output
#define DAQmx_Val_DI                                                      10151 ; Digital Input
#define DAQmx_Val_DO                                                      10153 ; Digital Output
#define DAQmx_Val_CI                                                      10131 ; Counter Input
#define DAQmx_Val_CO                                                      10132 ; Counter Output

;*** Values for DAQmx_CI_CountEdges_Dir ***
;*** Value set CountDirection1 ***
#define DAQmx_Val_CountUp                                                 10128 ; Count Up
#define DAQmx_Val_CountDown                                               10124 ; Count Down
#define DAQmx_Val_ExtControlled                                           10326 ; Externally Controlled

;*** Values for DAQmx_CI_Freq_MeasMeth ***
;*** Values for DAQmx_CI_Period_MeasMeth ***
;*** Value set CounterFrequencyMethod ***
#define DAQmx_Val_LowFreq1Ctr                                             10105 ; Low Frequency with 1 Counter
#define DAQmx_Val_HighFreq2Ctr                                            10157 ; High Frequency with 2 Counters
#define DAQmx_Val_LargeRng2Ctr                                            10205 ; Large Range with 2 Counters

;*** Values for DAQmx_AI_Coupling ***
;*** Value set Coupling1 ***
#define DAQmx_Val_AC                                                      10045 ; AC
#define DAQmx_Val_DC                                                      10050 ; DC
#define DAQmx_Val_GND                                                     10066 ; GND

;*** Values for DAQmx_AI_CurrentShunt_Loc ***
;*** Value set CurrentShuntResistorLocation1 ***
#define DAQmx_Val_Internal                                                10200 ; Internal
#define DAQmx_Val_External                                                10167 ; External

;*** Values for DAQmx_AI_Current_Units ***
;*** Values for DAQmx_AO_Current_Units ***
;*** Value set CurrentUnits1 ***
#define DAQmx_Val_Amps                                                    10342 ; Amps
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale

;*** Values for DAQmx_AI_DataXferMech ***
;*** Values for DAQmx_AO_DataXferMech ***
;*** Values for DAQmx_CI_DataXferMech ***
;*** Value set DataTransferMechanism ***
#define DAQmx_Val_DMA                                                     10054 ; DMA
#define DAQmx_Val_Interrupts                                              10204 ; Interrupts
#define DAQmx_Val_ProgrammedIO                                            10264 ; Programmed I/O

;*** Values for DAQmx_Watchdog_DO_ExpirState ***
;*** Value set DigitalLineState ***
#define DAQmx_Val_High                                                    10192 ; High
#define DAQmx_Val_Low                                                     10214 ; Low
#define DAQmx_Val_Tristate                                                10310 ; Tristate
#define DAQmx_Val_NoChange                                                10160 ; No Change

;*** Values for DAQmx_StartTrig_DelayUnits ***
;*** Value set DigitalWidthUnits1 ***
#define DAQmx_Val_SampClkPeriods                                          10286 ; Sample Clock Periods
#define DAQmx_Val_Seconds                                                 10364 ; Seconds
#define DAQmx_Val_Ticks                                                   10304 ; Ticks

;*** Values for DAQmx_DelayFromSampClk_DelayUnits ***
;*** Value set DigitalWidthUnits2 ***
#define DAQmx_Val_Seconds                                                 10364 ; Seconds
#define DAQmx_Val_Ticks                                                   10304 ; Ticks

;*** Values for DAQmx_Exported_AdvTrig_Pulse_WidthUnits ***
;*** Value set DigitalWidthUnits3 ***
#define DAQmx_Val_Seconds                                                 10364 ; Seconds

;*** Values for DAQmx_CI_Freq_StartingEdge ***
;*** Values for DAQmx_CI_Period_StartingEdge ***
;*** Values for DAQmx_CI_CountEdges_ActiveEdge ***
;*** Values for DAQmx_CI_PulseWidth_StartingEdge ***
;*** Values for DAQmx_CI_TwoEdgeSep_FirstEdge ***
;*** Values for DAQmx_CI_TwoEdgeSep_SecondEdge ***
;*** Values for DAQmx_CI_CtrTimebaseActiveEdge ***
;*** Values for DAQmx_CO_CtrTimebaseActiveEdge ***
;*** Values for DAQmx_SampClk_ActiveEdge ***
;*** Values for DAQmx_SampClk_Timebase_ActiveEdge ***
;*** Values for DAQmx_AIConv_ActiveEdge ***
;*** Values for DAQmx_DigEdge_StartTrig_Edge ***
;*** Values for DAQmx_DigEdge_RefTrig_Edge ***
;*** Values for DAQmx_DigEdge_AdvTrig_Edge ***
;*** Values for DAQmx_DigEdge_ArmStartTrig_Edge ***
;*** Values for DAQmx_DigEdge_WatchdogExpirTrig_Edge ***
;*** Value set Edge1 ***
#define DAQmx_Val_Rising                                                  10280 ; Rising
#define DAQmx_Val_Falling                                                 10171 ; Falling

;*** Values for DAQmx_CI_Encoder_DecodingType ***
;*** Value set EncoderType2 ***
#define DAQmx_Val_X1                                                      10090 ; X1
#define DAQmx_Val_X2                                                      10091 ; X2
#define DAQmx_Val_X4                                                      10092 ; X4
#define DAQmx_Val_TwoPulseCounting                                        10313 ; Two Pulse Counting

;*** Values for DAQmx_CI_Encoder_ZIndexPhase ***
;*** Value set EncoderZIndexPhase1 ***
#define DAQmx_Val_AHighBHigh                                              10040 ; A High B High
#define DAQmx_Val_AHighBLow                                               10041 ; A High B Low
#define DAQmx_Val_ALowBHigh                                               10042 ; A Low B High
#define DAQmx_Val_ALowBLow                                                10043 ; A Low B Low

;*** Values for DAQmx_AI_Excit_DCorAC ***
;*** Value set ExcitationDCorAC ***
#define DAQmx_Val_DC                                                      10050 ; DC
#define DAQmx_Val_AC                                                      10045 ; AC

;*** Values for DAQmx_AI_Excit_Src ***
;*** Value set ExcitationSource ***
#define DAQmx_Val_Internal                                                10200 ; Internal
#define DAQmx_Val_External                                                10167 ; External
#define DAQmx_Val_None                                                    10230 ; None

;*** Values for DAQmx_AI_Excit_VoltageOrCurrent ***
;*** Value set ExcitationVoltageOrCurrent ***
#define DAQmx_Val_Voltage                                                 10322 ; Voltage
#define DAQmx_Val_Current                                                 10134 ; Current

;*** Values for DAQmx_Exported_CtrOutEvent_OutputBehavior ***
;*** Value set ExportActions2 ***
#define DAQmx_Val_Pulse                                                   10265 ; Pulse
#define DAQmx_Val_Toggle                                                  10307 ; Toggle

;*** Values for DAQmx_Exported_SampClk_OutputBehavior ***
;*** Value set ExportActions3 ***
#define DAQmx_Val_Pulse                                                   10265 ; Pulse
#define DAQmx_Val_Lvl                                                     10210 ; Level

;*** Values for DAQmx_AI_Freq_Units ***
;*** Value set FrequencyUnits ***
#define DAQmx_Val_Hz                                                      10373 ; Hz
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale

;*** Values for DAQmx_CO_Pulse_Freq_Units ***
;*** Value set FrequencyUnits2 ***
#define DAQmx_Val_Hz                                                      10373 ; Hz

;*** Values for DAQmx_CI_Freq_Units ***
;*** Value set FrequencyUnits3 ***
#define DAQmx_Val_Hz                                                      10373 ; Hz
#define DAQmx_Val_Ticks                                                   10304 ; Ticks
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale


;*** Values for DAQmx_AI_DataXferReqCond ***
;*** Value set InputDataTransferCondition ***
#define DAQmx_Val_OnBrdMemMoreThanHalfFull                                10237 ; On Board Memory More than Half Full
#define DAQmx_Val_OnBrdMemNotEmpty                                        10241 ; On Board Memory Not Empty

;*** Values for DAQmx_AI_TermCfg ***
;*** Value set InputTermCfg ***
#define DAQmx_Val_RSE                                                     10083 ; RSE
#define DAQmx_Val_NRSE                                                    10078 ; NRSE
#define DAQmx_Val_Diff                                                    10106 ; Differential

;*** Values for DAQmx_AI_LVDT_SensitivityUnits ***
;*** Value set LVDTSensitivityUnits1 ***
#define DAQmx_Val_mVoltsPerVoltPerMillimeter                              12506 ; mVolts/Volt/mMeter
#define DAQmx_Val_mVoltsPerVoltPerMilliInch                               12505 ; mVolts/Volt/0.001 Inch

;*** Values for DAQmx_AI_LVDT_Units ***
;*** Value set LengthUnits2 ***
#define DAQmx_Val_Meters                                                  10219 ; Meters
#define DAQmx_Val_Inches                                                  10379 ; Inches
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale

;*** Values for DAQmx_CI_LinEncoder_Units ***
;*** Value set LengthUnits3 ***
#define DAQmx_Val_Meters                                                  10219 ; Meters
#define DAQmx_Val_Inches                                                  10379 ; Inches
#define DAQmx_Val_Ticks                                                   10304 ; Ticks
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale

;*** Values for DAQmx_CI_OutputState ***
;*** Values for DAQmx_CO_Pulse_IdleState ***
;*** Values for DAQmx_CO_OutputState ***
;*** Values for DAQmx_Exported_CtrOutEvent_Toggle_IdleState ***
;*** Values for DAQmx_DigLvl_PauseTrig_When ***
;*** Value set Level1 ***
#define DAQmx_Val_High                                                    10192 ; High
#define DAQmx_Val_Low                                                     10214 ; Low

;*** Values for DAQmx_AIConv_Timebase_Src ***
;*** Value set MIOAIConvertTbSrc ***
#define DAQmx_Val_SameAsSampTimebase                                      10284 ; Same as Sample Timebase
#define DAQmx_Val_SameAsMasterTimebase                                    10282 ; Same as Master Timebase

;*** Values for DAQmx_AO_DataXferReqCond ***
;*** Value set OutputDataTransferCondition ***
#define DAQmx_Val_OnBrdMemEmpty                                           10235 ; On Board Memory Empty
#define DAQmx_Val_OnBrdMemHalfFullOrLess                                  10239 ; On Board Memory Half Full or Less
#define DAQmx_Val_OnBrdMemNotFull                                         10242 ; On Board Memory Less than Full

;*** Values for DAQmx_Read_OverWrite ***
;*** Value set OverwriteMode1 ***
#define DAQmx_Val_OverwriteUnreadSamps                                    10252 ; Overwrite Unread Samples
#define DAQmx_Val_DoNotOverwriteUnreadSamps                               10159 ; Do Not Overwrite Unread Samples

;*** Values for DAQmx_Exported_AIConvClk_Pulse_Polarity ***
;*** Values for DAQmx_Exported_AdvTrig_Pulse_Polarity ***
;*** Values for DAQmx_Exported_AdvCmpltEvent_Pulse_Polarity ***
;*** Values for DAQmx_Exported_AIHoldCmpltEvent_PulsePolarity ***
;*** Values for DAQmx_Exported_CtrOutEvent_Pulse_Polarity ***
;*** Value set Polarity2 ***
#define DAQmx_Val_ActiveHigh                                              10095 ; Active High
#define DAQmx_Val_ActiveLow                                               10096 ; Active Low

;*** Values for DAQmx_AI_RTD_Type ***
;*** Value set RTDType1 ***
#define DAQmx_Val_Pt3750                                                  12481 ; Pt3750
#define DAQmx_Val_Pt3851                                                  10071 ; Pt3851
#define DAQmx_Val_Pt3911                                                  12482 ; Pt3911
#define DAQmx_Val_Pt3916                                                  10069 ; Pt3916
#define DAQmx_Val_Pt3920                                                  10053 ; Pt3920
#define DAQmx_Val_Pt3928                                                  12483 ; Pt3928
#define DAQmx_Val_Custom                                                  10137 ; Custom

;*** Values for DAQmx_AI_RVDT_SensitivityUnits ***
;*** Value set RVDTSensitivityUnits1 ***
#define DAQmx_Val_mVoltsPerVoltPerDegree                                  12507 ; mVolts/Volt/Degree
#define DAQmx_Val_mVoltsPerVoltPerRadian                                  12508 ; mVolts/Volt/Radian

;*** Values for DAQmx_Read_RelativeTo ***
;*** Value set ReadRelativeTo ***
#define DAQmx_Val_FirstSample                                             10424 ; First Sample
#define DAQmx_Val_CurrReadPos                                             10425 ; Current Read Position
#define DAQmx_Val_RefTrig                                                 10426 ; Reference Trigger
#define DAQmx_Val_FirstPretrigSamp                                        10427 ; First Pretrigger Sample
#define DAQmx_Val_MostRecentSamp                                          10428 ; Most Recent Sample


;*** Values for DAQmx_Write_RegenMode ***
;*** Value set RegenerationMode1 ***
#define DAQmx_Val_AllowRegen                                              10097 ; Allow Regeneration
#define DAQmx_Val_DoNotAllowRegen                                         10158 ; Do Not Allow Regeneration

;*** Values for DAQmx_AI_ResistanceCfg ***
;*** Value set ResistanceConfiguration ***
#define DAQmx_Val_2Wire                                                       2 ; 2-Wire
#define DAQmx_Val_3Wire                                                       3 ; 3-Wire
#define DAQmx_Val_4Wire                                                       4 ; 4-Wire

;*** Values for DAQmx_AI_Resistance_Units ***
;*** Value set ResistanceUnits1 ***
#define DAQmx_Val_Ohms                                                    10384 ; Ohms
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale

;*** Values for DAQmx_AI_ResolutionUnits ***
;*** Values for DAQmx_AO_ResolutionUnits ***
;*** Value set ResolutionType1 ***
#define DAQmx_Val_Bits                                                    10109 ; Bits

;*** Values for DAQmx_SampTimingType ***
;*** Value set SampleTimingType ***
#define DAQmx_Val_SampClk                                                 10388 ; Sample Clock
#define DAQmx_Val_Handshake                                               10389 ; Handshake
#define DAQmx_Val_Implicit                                                10451 ; Implicit
#define DAQmx_Val_OnDemand                                                10390 ; On Demand
#define DAQmx_Val_ChangeDetection                                         12504 ; Change Detection

;*** Values for DAQmx_Scale_Type ***
;*** Value set ScaleType ***
#define DAQmx_Val_Linear                                                  10447 ; Linear
#define DAQmx_Val_MapRanges                                               10448 ; Map Ranges
#define DAQmx_Val_Polynomial                                              10449 ; Polynomial
#define DAQmx_Val_Table                                                   10450 ; Table

;*** Values for DAQmx_AI_Bridge_ShuntCal_Select ***
;*** Value set ShuntCalSelect ***
#define DAQmx_Val_A                                                       12513 ; A
#define DAQmx_Val_B                                                       12514 ; B
#define DAQmx_Val_AandB                                                   12515 ; A and B

;*** Values for DAQmx_AnlgEdge_StartTrig_Slope ***
;*** Values for DAQmx_AnlgEdge_RefTrig_Slope ***
;*** Value set Slope1 ***
#define DAQmx_Val_RisingSlope                                             10280 ; Rising
#define DAQmx_Val_FallingSlope                                            10171 ; Falling

;*** Values for DAQmx_AI_Lowpass_SwitchCap_ClkSrc ***
;*** Values for DAQmx_AO_DAC_Ref_Src ***
;*** Value set SourceSelection ***
#define DAQmx_Val_Internal                                                10200 ; Internal
#define DAQmx_Val_External                                                10167 ; External

;*** Values for DAQmx_AI_StrainGage_Cfg ***
;*** Value set StrainGageBridgeType1 ***
#define DAQmx_Val_FullBridgeI                                             10183 ; Full Bridge I
#define DAQmx_Val_FullBridgeII                                            10184 ; Full Bridge II
#define DAQmx_Val_FullBridgeIII                                           10185 ; Full Bridge III
#define DAQmx_Val_HalfBridgeI                                             10188 ; Half Bridge I
#define DAQmx_Val_HalfBridgeII                                            10189 ; Half Bridge II
#define DAQmx_Val_QuarterBridgeI                                          10271 ; Quarter Bridge I
#define DAQmx_Val_QuarterBridgeII                                         10272 ; Quarter Bridge II

;*** Values for DAQmx_AI_Strain_Units ***
;*** Value set StrainUnits1 ***
#define DAQmx_Val_Strain                                                  10299 ; Strain
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale

;*** Values for DAQmx_SwitchScan_RepeatMode ***
;*** Value set SwitchScanRepeatMode ***
#define DAQmx_Val_Finite                                                  10172 ; Finite
#define DAQmx_Val_Cont                                                    10117 ; Continuous

;*** Values for DAQmx_SwitchChan_Usage ***
;*** Value set SwitchUsageTypes ***
#define DAQmx_Val_Source                                                  10439 ; Source
#define DAQmx_Val_Load                                                    10440 ; Load
#define DAQmx_Val_ReservedForRouting                                      10441 ; Reserved for Routing

;*** Values for DAQmx_AI_Temp_Units ***
;*** Value set TemperatureUnits1 ***
#define DAQmx_Val_DegC                                                    10143 ; Deg C
#define DAQmx_Val_DegF                                                    10144 ; Deg F
#define DAQmx_Val_Kelvins                                                 10325 ; Kelvins
#define DAQmx_Val_DegR                                                    10145 ; Deg R
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale

;*** Values for DAQmx_AI_Thrmcpl_Type ***
;*** Value set ThermocoupleType1 ***
#define DAQmx_Val_J_Type_TC                                               10072 ; J
#define DAQmx_Val_K_Type_TC                                               10073 ; K
#define DAQmx_Val_N_Type_TC                                               10077 ; N
#define DAQmx_Val_R_Type_TC                                               10082 ; R
#define DAQmx_Val_S_Type_TC                                               10085 ; S
#define DAQmx_Val_T_Type_TC                                               10086 ; T
#define DAQmx_Val_B_Type_TC                                               10047 ; B
#define DAQmx_Val_E_Type_TC                                               10055 ; E

;*** Values for DAQmx_CO_Pulse_Time_Units ***
;*** Value set TimeUnits2 ***
#define DAQmx_Val_Seconds                                                 10364 ; Seconds

;*** Values for DAQmx_CI_Period_Units ***
;*** Values for DAQmx_CI_PulseWidth_Units ***
;*** Values for DAQmx_CI_TwoEdgeSep_Units ***
;*** Values for DAQmx_CI_SemiPeriod_Units ***
;*** Value set TimeUnits3 ***
#define DAQmx_Val_Seconds                                                 10364 ; Seconds
#define DAQmx_Val_Ticks                                                   10304 ; Ticks
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale

;*** Values for DAQmx_RefTrig_Type ***
;*** Value set TriggerType1 ***
#define DAQmx_Val_AnlgEdge                                                10099 ; Analog Edge
#define DAQmx_Val_DigEdge                                                 10150 ; Digital Edge
#define DAQmx_Val_AnlgWin                                                 10103 ; Analog Window
#define DAQmx_Val_None                                                    10230 ; None

;*** Values for DAQmx_ArmStartTrig_Type ***
;*** Values for DAQmx_WatchdogExpirTrig_Type ***
;*** Value set TriggerType4 ***
#define DAQmx_Val_DigEdge                                                 10150 ; Digital Edge
#define DAQmx_Val_None                                                    10230 ; None

;*** Values for DAQmx_AdvTrig_Type ***
;*** Value set TriggerType5 ***
#define DAQmx_Val_DigEdge                                                 10150 ; Digital Edge
#define DAQmx_Val_Software                                                10292 ; Software
#define DAQmx_Val_None                                                    10230 ; None

;*** Values for DAQmx_PauseTrig_Type ***
;*** Value set TriggerType6 ***
#define DAQmx_Val_AnlgLvl                                                 10101 ; Analog Level
#define DAQmx_Val_AnlgWin                                                 10103 ; Analog Window
#define DAQmx_Val_DigLvl                                                  10152 ; Digital Level
#define DAQmx_Val_None                                                    10230 ; None

;*** Values for DAQmx_StartTrig_Type ***
;*** Value set TriggerType8 ***
#define DAQmx_Val_AnlgEdge                                                10099 ; Analog Edge
#define DAQmx_Val_DigEdge                                                 10150 ; Digital Edge
#define DAQmx_Val_AnlgWin                                                 10103 ; Analog Window
#define DAQmx_Val_None                                                    10230 ; None

;*** Values for DAQmx_Scale_PreScaledUnits ***
;*** Value set UnitsPreScaled ***
#define DAQmx_Val_Volts                                                   10348 ; Volts
#define DAQmx_Val_Amps                                                    10342 ; Amps
#define DAQmx_Val_DegF                                                    10144 ; Deg F
#define DAQmx_Val_DegC                                                    10143 ; Deg C
#define DAQmx_Val_DegR                                                    10145 ; Deg R
#define DAQmx_Val_Kelvins                                                 10325 ; Kelvins
#define DAQmx_Val_Strain                                                  10299 ; Strain
#define DAQmx_Val_Ohms                                                    10384 ; Ohms
#define DAQmx_Val_Hz                                                      10373 ; Hz
#define DAQmx_Val_Seconds                                                 10364 ; Seconds
#define DAQmx_Val_Meters                                                  10219 ; Meters
#define DAQmx_Val_Inches                                                  10379 ; Inches
#define DAQmx_Val_Degrees                                                 10146 ; Degrees
#define DAQmx_Val_Radians                                                 10273 ; Radians
#define DAQmx_Val_g                                                       10186 ; g

;*** Values for DAQmx_AI_Voltage_Units ***
;*** Value set VoltageUnits1 ***
#define DAQmx_Val_Volts                                                   10348 ; Volts
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale

;*** Values for DAQmx_AO_Voltage_Units ***
;*** Value set VoltageUnits2 ***
#define DAQmx_Val_Volts                                                   10348 ; Volts
#define DAQmx_Val_FromCustomScale                                         10065 ; From Custom Scale

;*** Values for DAQmx_AnlgWin_StartTrig_When ***
;*** Values for DAQmx_AnlgWin_RefTrig_When ***
;*** Value set WindowTriggerCondition1 ***
#define DAQmx_Val_EnteringWin                                             10163 ; Entering Window
#define DAQmx_Val_LeavingWin                                              10208 ; Leaving Window

;*** Values for DAQmx_AnlgWin_PauseTrig_When ***
;*** Value set WindowTriggerCondition2 ***
#define DAQmx_Val_InsideWin                                               10199 ; Inside Window
#define DAQmx_Val_OutsideWin                                              10251 ; Outside Window

;*** Values for DAQmx_Write_RelativeTo ***
;*** Value set WriteRelativeTo ***
#define DAQmx_Val_FirstSample                                             10424 ; First Sample
#define DAQmx_Val_CurrWritePos                                            10430 ; Current Write Position


; Switch Topologies
#define DAQmx_Val_Switch_Topology_1127_1_Wire_64x1_Mux         "1127/1-Wire 64x1 Mux"           ; 1127/1-Wire 64x1 Mux
#define DAQmx_Val_Switch_Topology_1127_2_Wire_32x1_Mux         "1127/2-Wire 32x1 Mux"           ; 1127/2-Wire 32x1 Mux
#define DAQmx_Val_Switch_Topology_1127_2_Wire_4x8_Matrix       "1127/2-Wire 4x8 Matrix"         ; 1127/2-Wire 4x8 Matrix
#define DAQmx_Val_Switch_Topology_1127_4_Wire_16x1_Mux         "1127/4-Wire 16x1 Mux"           ; 1127/4-Wire 16x1 Mux
#define DAQmx_Val_Switch_Topology_1127_Independent             "1127/Independent"               ; 1127/Independent
#define DAQmx_Val_Switch_Topology_1128_1_Wire_64x1_Mux         "1128/1-Wire 64x1 Mux"           ; 1128/1-Wire 64x1 Mux
#define DAQmx_Val_Switch_Topology_1128_2_Wire_32x1_Mux         "1128/2-Wire 32x1 Mux"           ; 1128/2-Wire 32x1 Mux
#define DAQmx_Val_Switch_Topology_1128_2_Wire_4x8_Matrix       "1128/2-Wire 4x8 Matrix"         ; 1128/2-Wire 4x8 Matrix
#define DAQmx_Val_Switch_Topology_1128_4_Wire_16x1_Mux         "1128/4-Wire 16x1 Mux"           ; 1128/4-Wire 16x1 Mux
#define DAQmx_Val_Switch_Topology_1128_Independent             "1128/Independent"               ; 1128/Independent
#define DAQmx_Val_Switch_Topology_1129_2_Wire_16x16_Matrix     "1129/2-Wire 16x16 Matrix"       ; 1129/2-Wire 16x16 Matrix
#define DAQmx_Val_Switch_Topology_1129_2_Wire_8x32_Matrix      "1129/2-Wire 8x32 Matrix"        ; 1129/2-Wire 8x32 Matrix
#define DAQmx_Val_Switch_Topology_1129_2_Wire_4x64_Matrix      "1129/2-Wire 4x64 Matrix"        ; 1129/2-Wire 4x64 Matrix
#define DAQmx_Val_Switch_Topology_1129_2_Wire_Dual_8x16_Matrix "1129/2-Wire Dual 8x16 Matrix"   ; 1129/2-Wire Dual 8x16 Matrix
#define DAQmx_Val_Switch_Topology_1129_2_Wire_Dual_4x32_Matrix "1129/2-Wire Dual 4x32 Matrix"   ; 1129/2-Wire Dual 4x32 Matrix
#define DAQmx_Val_Switch_Topology_1129_2_Wire_Quad_4x16_Matrix "1129/2-Wire Quad 4x16 Matrix"   ; 1129/2-Wire Quad 4x16 Matrix
#define DAQmx_Val_Switch_Topology_1130_1_Wire_256x1_Mux        "1130/1-Wire 256x1 Mux"          ; 1130/1-Wire 256x1 Mux
#define DAQmx_Val_Switch_Topology_1130_2_Wire_128x1_Mux        "1130/2-Wire 128x1 Mux"          ; 1130/2-Wire 128x1 Mux
#define DAQmx_Val_Switch_Topology_1130_4_Wire_64x1_Mux         "1130/4-Wire 64x1 Mux"           ; 1130/4-Wire 64x1 Mux
#define DAQmx_Val_Switch_Topology_1130_1_Wire_4x64_Matrix      "1130/1-Wire 4x64 Matrix"        ; 1130/1-Wire 4x64 Matrix
#define DAQmx_Val_Switch_Topology_1130_1_Wire_8x32_Matrix      "1130/1-Wire 8x32 Matrix"        ; 1130/1-Wire 8x32 Matrix
#define DAQmx_Val_Switch_Topology_1130_2_Wire_4x32_Matrix      "1130/2-Wire 4x32 Matrix"        ; 1130/2-Wire 4x32 Matrix
#define DAQmx_Val_Switch_Topology_1130_Independent             "1130/Independent"               ; 1130/Independent
#define DAQmx_Val_Switch_Topology_1160_16_SPDT                 "1160/16-SPDT"                   ; 1160/16-SPDT
#define DAQmx_Val_Switch_Topology_1161_8_SPDT                  "1161/8-SPDT"                    ; 1161/8-SPDT
#define DAQmx_Val_Switch_Topology_1163R_Octal_4x1_Mux          "1163R/Octal 4x1 Mux"            ; 1163R/Octal 4x1 Mux
#define DAQmx_Val_Switch_Topology_1166_32_SPDT                 "1166/32-SPDT"                   ; 1166/32-SPDT
#define DAQmx_Val_Switch_Topology_1167_Independent             "1167/Independent"               ; 1167/Independent
#define DAQmx_Val_Switch_Topology_1190_Quad_4x1_Mux            "1190/Quad 4x1 Mux"              ; 1190/Quad 4x1 Mux
#define DAQmx_Val_Switch_Topology_1191_Quad_4x1_Mux            "1191/Quad 4x1 Mux"              ; 1191/Quad 4x1 Mux
#define DAQmx_Val_Switch_Topology_1192_8_SPDT                  "1192/8-SPDT"                    ; 1192/8-SPDT
#define DAQmx_Val_Switch_Topology_1193_32x1_Mux                "1193/32x1 Mux"                  ; 1193/32x1 Mux
#define DAQmx_Val_Switch_Topology_1193_Dual_16x1_Mux           "1193/Dual 16x1 Mux"             ; 1193/Dual 16x1 Mux
#define DAQmx_Val_Switch_Topology_1193_Quad_8x1_Mux            "1193/Quad 8x1 Mux"              ; 1193/Quad 8x1 Mux
#define DAQmx_Val_Switch_Topology_1193_16x1_Terminated_Mux     "1193/16x1 Terminated Mux"       ; 1193/16x1 Terminated Mux
#define DAQmx_Val_Switch_Topology_1193_Dual_8x1_Terminated_Mux "1193/Dual 8x1 Terminated Mux"   ; 1193/Dual 8x1 Terminated Mux
#define DAQmx_Val_Switch_Topology_1193_Quad_4x1_Terminated_Mux "1193/Quad 4x1 Terminated Mux"   ; 1193/Quad 4x1 Terminated Mux
#define DAQmx_Val_Switch_Topology_1193_Independent             "1193/Independent"               ; 1193/Independent
#define DAQmx_Val_Switch_Topology_2529_2_Wire_8x16_Matrix      "2529/2-Wire 8x16 Matrix"        ; 2529/2-Wire 8x16 Matrix
#define DAQmx_Val_Switch_Topology_2529_2_Wire_4x32_Matrix      "2529/2-Wire 4x32 Matrix"        ; 2529/2-Wire 4x32 Matrix
#define DAQmx_Val_Switch_Topology_2529_2_Wire_Dual_4x16_Matrix "2529/2-Wire Dual 4x16 Matrix"   ; 2529/2-Wire Dual 4x16 Matrix
#define DAQmx_Val_Switch_Topology_2530_1_Wire_128x1_Mux        "2530/1-Wire 128x1 Mux"          ; 2530/1-Wire 128x1 Mux
#define DAQmx_Val_Switch_Topology_2530_2_Wire_64x1_Mux         "2530/2-Wire 64x1 Mux"           ; 2530/2-Wire 64x1 Mux
#define DAQmx_Val_Switch_Topology_2530_4_Wire_32x1_Mux         "2530/4-Wire 32x1 Mux"           ; 2530/4-Wire 32x1 Mux
#define DAQmx_Val_Switch_Topology_2530_1_Wire_4x32_Matrix      "2530/1-Wire 4x32 Matrix"        ; 2530/1-Wire 4x32 Matrix
#define DAQmx_Val_Switch_Topology_2530_1_Wire_8x16_Matrix      "2530/1-Wire 8x16 Matrix"        ; 2530/1-Wire 8x16 Matrix
#define DAQmx_Val_Switch_Topology_2530_2_Wire_4x16_Matrix      "2530/2-Wire 4x16 Matrix"        ; 2530/2-Wire 4x16 Matrix
#define DAQmx_Val_Switch_Topology_2530_Independent             "2530/Independent"               ; 2530/Independent
#define DAQmx_Val_Switch_Topology_2566_16_SPDT                 "2566/16-SPDT"                   ; 2566/16-SPDT
#define DAQmx_Val_Switch_Topology_2567_Independent             "2567/Independent"               ; 2567/Independent
#define DAQmx_Val_Switch_Topology_2570_40_SPDT                 "2570/40-SPDT"                   ; 2570/40-SPDT
#define DAQmx_Val_Switch_Topology_2593_16x1_Mux                "2593/16x1 Mux"                  ; 2593/16x1 Mux
#define DAQmx_Val_Switch_Topology_2593_Dual_8x1_Mux            "2593/Dual 8x1 Mux"              ; 2593/Dual 8x1 Mux
#define DAQmx_Val_Switch_Topology_2593_8x1_Terminated_Mux      "2593/8x1 Terminated Mux"        ; 2593/8x1 Terminated Mux
#define DAQmx_Val_Switch_Topology_2593_Dual_4x1_Terminated_Mux "2593/Dual 4x1 Terminated Mux"   ; 2593/Dual 4x1 Terminated Mux
#define DAQmx_Val_Switch_Topology_2593_Independent             "2593/Independent"               ; 2593/Independent


;******************************************************************************
;*** NI-DAQmx Error Codes *****************************************************
;******************************************************************************


#define DAQmxSuccess                                                            0

#define DAQMXFAILDED(error)                                                     ((error)!=0)

;Error and Warning Codes
#define DAQmxErrorInvalidInstallation                                          -200683
#define DAQmxErrorRefTrigMasterSessionUnavailable                              -200682
#define DAQmxErrorRouteFailedBecauseWatchdogExpired                            -200681
#define DAQmxErrorDeviceShutDownDueToHighTemp                                  -200680
#define DAQmxErrorNoMemMapWhenHWTimedSinglePoint                               -200679
#define DAQmxErrorWriteFailedBecauseWatchdogExpired                            -200678
#define DAQmxErrorDifftInternalAIInputSrcs                                     -200677
#define DAQmxErrorDifftAIInputSrcInOneChanGroup                                -200676
#define DAQmxErrorInternalAIInputSrcInMultChanGroups                           -200675
#define DAQmxErrorSwitchOpFailedDueToPrevError                                 -200674
#define DAQmxErrorWroteMultiSampsUsingSingleSampWrite                          -200673
#define DAQmxErrorMismatchedInputArraySizes                                    -200672
#define DAQmxErrorCantExceedRelayDriveLimit                                    -200671
#define DAQmxErrorDACRngLowNotEqualToMinusRefVal                               -200670
#define DAQmxErrorCantAllowConnectDACToGnd                                     -200669
#define DAQmxErrorWatchdogTimeoutOutOfRangeAndNotSpecialVal                    -200668
#define DAQmxErrorNoWatchdogOutputOnPortReservedForInput                       -200667
#define DAQmxErrorNoInputOnPortCfgdForWatchdogOutput                           -200666
#define DAQmxErrorWatchdogExpirationStateNotEqualForLinesInPort                -200665
#define DAQmxErrorCannotPerformOpWhenTaskNotReserved                           -200664
#define DAQmxErrorPowerupStateNotSupported                                     -200663
#define DAQmxErrorWatchdogTimerNotSupported                                    -200662
#define DAQmxErrorOpNotSupportedWhenRefClkSrcNone                              -200661
#define DAQmxErrorSampClkRateUnavailable                                       -200660
#define DAQmxErrorPrptyGetSpecdSingleActiveChanFailedDueToDifftVals            -200659
#define DAQmxErrorPrptyGetImpliedActiveChanFailedDueToDifftVals                -200658
#define DAQmxErrorPrptyGetSpecdActiveChanFailedDueToDifftVals                  -200657
#define DAQmxErrorNoRegenWhenUsingBrdMem                                       -200656
#define DAQmxErrorNonbufferedReadMoreThanSampsPerChan                          -200655
#define DAQmxErrorWatchdogExpirationTristateNotSpecdForEntirePort              -200654
#define DAQmxErrorPowerupTristateNotSpecdForEntirePort                         -200653
#define DAQmxErrorPowerupStateNotSpecdForEntirePort                            -200652
#define DAQmxErrorCantSetWatchdogExpirationOnDigInChan                         -200651
#define DAQmxErrorCantSetPowerupStateOnDigInChan                               -200650
#define DAQmxErrorPhysChanNotInTask                                            -200649
#define DAQmxErrorPhysChanDevNotInTask                                         -200648
#define DAQmxErrorDigInputNotSupported                                         -200647
#define DAQmxErrorDigFilterIntervalNotEqualForLines                            -200646
#define DAQmxErrorDigFilterIntervalAlreadyCfgd                                 -200645
#define DAQmxErrorCantResetExpiredWatchdog                                     -200644
#define DAQmxErrorActiveChanTooManyLinesSpecdWhenGettingPrpty                  -200643
#define DAQmxErrorActiveChanNotSpecdWhenGetting1LinePrpty                      -200642
#define DAQmxErrorDigPrptyCannotBeSetPerLine                                   -200641
#define DAQmxErrorSendAdvCmpltAfterWaitForTrigInScanlist                       -200640
#define DAQmxErrorDisconnectionRequiredInScanlist                              -200639
#define DAQmxErrorTwoWaitForTrigsAfterConnectionInScanlist                     -200638
#define DAQmxErrorActionSeparatorRequiredAfterBreakingConnectionInScanlist     -200637
#define DAQmxErrorConnectionInScanlistMustWaitForTrig                          -200636
#define DAQmxErrorActionNotSupportedTaskNotWatchdog                            -200635
#define DAQmxErrorWfmNameSameAsScriptName                                      -200634
#define DAQmxErrorScriptNameSameAsWfmName                                      -200633
#define DAQmxErrorDSFStopClock                                                 -200632
#define DAQmxErrorDSFReadyForStartClock                                        -200631
#define DAQmxErrorWriteOffsetNotMultOfIncr                                     -200630
#define DAQmxErrorDifferentPrptyValsNotSupportedOnDev                          -200629
#define DAQmxErrorRefAndPauseTrigConfigured                                    -200628
#define DAQmxErrorFailedToEnableHighSpeedInputClock                            -200627
#define DAQmxErrorEmptyPhysChanInPowerUpStatesArray                            -200626
#define DAQmxErrorActivePhysChanTooManyLinesSpecdWhenGettingPrpty              -200625
#define DAQmxErrorActivePhysChanNotSpecdWhenGetting1LinePrpty                  -200624
#define DAQmxErrorPXIDevTempCausedShutDown                                     -200623
#define DAQmxErrorInvalidNumSampsToWrite                                       -200622
#define DAQmxErrorOutputFIFOUnderflow2                                         -200621
#define DAQmxErrorRepeatedAIPhysicalChan                                       -200620
#define DAQmxErrorMultScanOpsInOneChassis                                      -200619
#define DAQmxErrorInvalidAIChanOrder                                           -200618
#define DAQmxErrorReversePowerProtectionActivated                              -200617
#define DAQmxErrorInvalidAsynOpHandle                                          -200616
#define DAQmxErrorFailedToEnableHighSpeedOutput                                -200615
#define DAQmxErrorCannotReadPastEndOfRecord                                    -200614
#define DAQmxErrorAcqStoppedToPreventInputBufferOverwriteOneDataXferMech       -200613
#define DAQmxErrorZeroBasedChanIndexInvalid                                    -200612
#define DAQmxErrorNoChansOfGivenTypeInTask                                     -200611
#define DAQmxErrorSampClkSrcInvalidForOutputValidForInput                      -200610
#define DAQmxErrorOutputBufSizeTooSmallToStartGen                              -200609
#define DAQmxErrorInputBufSizeTooSmallToStartAcq                               -200608
#define DAQmxErrorExportTwoSignalsOnSameTerminal                               -200607
#define DAQmxErrorChanIndexInvalid                                             -200606
#define DAQmxErrorRangeSyntaxNumberTooBig                                      -200605
#define DAQmxErrorNULLPtr                                                      -200604
#define DAQmxErrorScaledMinEqualMax                                            -200603
#define DAQmxErrorPreScaledMinEqualMax                                         -200602
#define DAQmxErrorPropertyNotSupportedForScaleType                             -200601
#define DAQmxErrorChannelNameGenerationNumberTooBig                            -200600
#define DAQmxErrorRepeatedNumberInScaledValues                                 -200599
#define DAQmxErrorRepeatedNumberInPreScaledValues                              -200598
#define DAQmxErrorLinesAlreadyReservedForOutput                                -200597
#define DAQmxErrorSwitchOperationChansSpanMultipleDevsInList                   -200596
#define DAQmxErrorInvalidIDInListAtBeginningOfSwitchOperation                  -200595
#define DAQmxErrorMStudioInvalidPolyDirection                                  -200594
#define DAQmxErrorMStudioPropertyGetWhileTaskNotVerified                       -200593
#define DAQmxErrorRangeWithTooManyObjects                                      -200592
#define DAQmxErrorCppDotNetAPINegativeBufferSize                               -200591
#define DAQmxErrorCppCantRemoveInvalidEventHandler                             -200590
#define DAQmxErrorCppCantRemoveEventHandlerTwice                               -200589
#define DAQmxErrorCppCantRemoveOtherObjectsEventHandler                        -200588
#define DAQmxErrorDigLinesReservedOrUnavailable                                -200587
#define DAQmxErrorDSFFailedToResetStream                                       -200586
#define DAQmxErrorDSFReadyForOutputNotAsserted                                 -200585
#define DAQmxErrorSampToWritePerChanNotMultipleOfIncr                          -200584
#define DAQmxErrorAOPropertiesCauseVoltageBelowMin                             -200583
#define DAQmxErrorAOPropertiesCauseVoltageOverMax                              -200582
#define DAQmxErrorPropertyNotSupportedWhenRefClkSrcNone                        -200581
#define DAQmxErrorAIMaxTooSmall                                                -200580
#define DAQmxErrorAIMaxTooLarge                                                -200579
#define DAQmxErrorAIMinTooSmall                                                -200578
#define DAQmxErrorAIMinTooLarge                                                -200577
#define DAQmxErrorBuiltInCJCSrcNotSupported                                    -200576
#define DAQmxErrorTooManyPostTrigSampsPerChan                                  -200575
#define DAQmxErrorTrigLineNotFoundSingleDevRoute                               -200574
#define DAQmxErrorDifferentInternalAIInputSources                              -200573
#define DAQmxErrorDifferentAIInputSrcInOneChanGroup                            -200572
#define DAQmxErrorInternalAIInputSrcInMultipleChanGroups                       -200571
#define DAQmxErrorCAPIChanIndexInvalid                                         -200570
#define DAQmxErrorCollectionDoesNotMatchChanType                               -200569
#define DAQmxErrorOutputCantStartChangedRegenerationMode                       -200568
#define DAQmxErrorOutputCantStartChangedBufferSize                             -200567
#define DAQmxErrorChanSizeTooBigForU32PortWrite                                -200566
#define DAQmxErrorChanSizeTooBigForU8PortWrite                                 -200565
#define DAQmxErrorChanSizeTooBigForU32PortRead                                 -200564
#define DAQmxErrorChanSizeTooBigForU8PortRead                                  -200563
#define DAQmxErrorInvalidDigDataWrite                                          -200562
#define DAQmxErrorInvalidAODataWrite                                           -200561
#define DAQmxErrorWaitUntilDoneDoesNotIndicateDone                             -200560
#define DAQmxErrorMultiChanTypesInTask                                         -200559
#define DAQmxErrorMultiDevsInTask                                              -200558
#define DAQmxErrorCannotSetPropertyWhenTaskRunning                             -200557
#define DAQmxErrorCannotGetPropertyWhenTaskNotCommittedOrRunning               -200556
#define DAQmxErrorLeadingUnderscoreInString                                    -200555
#define DAQmxErrorTrailingSpaceInString                                        -200554
#define DAQmxErrorLeadingSpaceInString                                         -200553
#define DAQmxErrorInvalidCharInString                                          -200552
#define DAQmxErrorDLLBecameUnlocked                                            -200551
#define DAQmxErrorDLLLock                                                      -200550
#define DAQmxErrorSelfCalConstsInvalid                                         -200549
#define DAQmxErrorInvalidTrigCouplingExceptForExtTrigChan                      -200548
#define DAQmxErrorWriteFailsBufferSizeAutoConfigured                           -200547
#define DAQmxErrorExtCalAdjustExtRefVoltageFailed                              -200546
#define DAQmxErrorSelfCalFailedExtNoiseOrRefVoltageOutOfCal                    -200545
#define DAQmxErrorExtCalTemperatureNotDAQmx                                    -200544
#define DAQmxErrorExtCalDateTimeNotDAQmx                                       -200543
#define DAQmxErrorSelfCalTemperatureNotDAQmx                                   -200542
#define DAQmxErrorSelfCalDateTimeNotDAQmx                                      -200541
#define DAQmxErrorDACRefValNotSet                                              -200540
#define DAQmxErrorAnalogMultiSampWriteNotSupported                             -200539
#define DAQmxErrorInvalidActionInControlTask                                   -200538
#define DAQmxErrorPolyCoeffsInconsistent                                       -200537
#define DAQmxErrorSensorValTooLow                                              -200536
#define DAQmxErrorSensorValTooHigh                                             -200535
#define DAQmxErrorWaveformNameTooLong                                          -200534
#define DAQmxErrorIdentifierTooLongInScript                                    -200533
#define DAQmxErrorUnexpectedIDFollowingSwitchChanName                          -200532
#define DAQmxErrorRelayNameNotSpecifiedInList                                  -200531
#define DAQmxErrorUnexpectedIDFollowingRelayNameInList                         -200530
#define DAQmxErrorUnexpectedIDFollowingSwitchOpInList                          -200529
#define DAQmxErrorInvalidLineGrouping                                          -200528
#define DAQmxErrorCtrMinMax                                                    -200527
#define DAQmxErrorWriteChanTypeMismatch                                        -200526
#define DAQmxErrorReadChanTypeMismatch                                         -200525
#define DAQmxErrorWriteNumChansMismatch                                        -200524
#define DAQmxErrorOneChanReadForMultiChanTask                                  -200523
#define DAQmxErrorCannotSelfCalDuringExtCal                                    -200522
#define DAQmxErrorMeasCalAdjustOscillatorPhaseDAC                              -200521
#define DAQmxErrorInvalidCalConstCalADCAdjustment                              -200520
#define DAQmxErrorInvalidCalConstOscillatorFreqDACValue                        -200519
#define DAQmxErrorInvalidCalConstOscillatorPhaseDACValue                       -200518
#define DAQmxErrorInvalidCalConstOffsetDACValue                                -200517
#define DAQmxErrorInvalidCalConstGainDACValue                                  -200516
#define DAQmxErrorInvalidNumCalADCReadsToAverage                               -200515
#define DAQmxErrorInvalidCfgCalAdjustDirectPathOutputImpedance                 -200514
#define DAQmxErrorInvalidCfgCalAdjustMainPathOutputImpedance                   -200513
#define DAQmxErrorInvalidCfgCalAdjustMainPathPostAmpGainAndOffset              -200512
#define DAQmxErrorInvalidCfgCalAdjustMainPathPreAmpGain                        -200511
#define DAQmxErrorInvalidCfgCalAdjustMainPreAmpOffset                          -200510
#define DAQmxErrorMeasCalAdjustCalADC                                          -200509
#define DAQmxErrorMeasCalAdjustOscillatorFrequency                             -200508
#define DAQmxErrorMeasCalAdjustDirectPathOutputImpedance                       -200507
#define DAQmxErrorMeasCalAdjustMainPathOutputImpedance                         -200506
#define DAQmxErrorMeasCalAdjustDirectPathGain                                  -200505
#define DAQmxErrorMeasCalAdjustMainPathPostAmpGainAndOffset                    -200504
#define DAQmxErrorMeasCalAdjustMainPathPreAmpGain                              -200503
#define DAQmxErrorMeasCalAdjustMainPathPreAmpOffset                            -200502
#define DAQmxErrorInvalidDateTimeInEEPROM                                      -200501
#define DAQmxErrorUnableToLocateErrorResources                                 -200500
#define DAQmxErrorDotNetAPINotUnsigned32BitNumber                              -200499
#define DAQmxErrorInvalidRangeOfObjectsSyntaxInString                          -200498
#define DAQmxErrorAttemptToEnableLineNotPreviouslyDisabled                     -200497
#define DAQmxErrorInvalidCharInPattern                                         -200496
#define DAQmxErrorIntermediateBufferFull                                       -200495
#define DAQmxErrorLoadTaskFailsBecauseNoTimingOnDev                            -200494
#define DAQmxErrorCAPIReservedParamNotNULLNorEmpty                             -200493
#define DAQmxErrorCAPIReservedParamNotNULL                                     -200492
#define DAQmxErrorCAPIReservedParamNotZero                                     -200491
#define DAQmxErrorSampleValueOutOfRange                                        -200490
#define DAQmxErrorChanAlreadyInTask                                            -200489
#define DAQmxErrorVirtualChanDoesNotExist                                      -200488
#define DAQmxErrorChanNotInTask                                                -200486
#define DAQmxErrorTaskNotInDataNeighborhood                                    -200485
#define DAQmxErrorCantSaveTaskWithoutReplace                                   -200484
#define DAQmxErrorCantSaveChanWithoutReplace                                   -200483
#define DAQmxErrorDevNotInTask                                                 -200482
#define DAQmxErrorDevAlreadyInTask                                             -200481
#define DAQmxErrorCanNotPerformOpWhileTaskRunning                              -200479
#define DAQmxErrorCanNotPerformOpWhenNoChansInTask                             -200478
#define DAQmxErrorCanNotPerformOpWhenNoDevInTask                               -200477
#define DAQmxErrorCannotPerformOpWhenTaskNotRunning                            -200475
#define DAQmxErrorOperationTimedOut                                            -200474
#define DAQmxErrorCannotReadWhenAutoStartFalseAndTaskNotRunningOrCommitted     -200473
#define DAQmxErrorCannotWriteWhenAutoStartFalseAndTaskNotRunningOrCommitted    -200472
#define DAQmxErrorTaskVersionNew                                               -200470
#define DAQmxErrorChanVersionNew                                               -200469
#define DAQmxErrorEmptyString                                                  -200467
#define DAQmxErrorChannelSizeTooBigForPortReadType                             -200466
#define DAQmxErrorChannelSizeTooBigForPortWriteType                            -200465
#define DAQmxErrorExpectedNumberOfChannelsVerificationFailed                   -200464
#define DAQmxErrorNumLinesMismatchInReadOrWrite                                -200463
#define DAQmxErrorOutputBufferEmpty                                            -200462
#define DAQmxErrorInvalidChanName                                              -200461
#define DAQmxErrorReadNoInputChansInTask                                       -200460
#define DAQmxErrorWriteNoOutputChansInTask                                     -200459
#define DAQmxErrorPropertyNotSupportedNotInputTask                             -200457
#define DAQmxErrorPropertyNotSupportedNotOutputTask                            -200456
#define DAQmxErrorGetPropertyNotInputBufferedTask                              -200455
#define DAQmxErrorGetPropertyNotOutputBufferedTask                             -200454
#define DAQmxErrorInvalidTimeoutVal                                            -200453
#define DAQmxErrorAttributeNotSupportedInTaskContext                           -200452
#define DAQmxErrorAttributeNotQueryableUnlessTaskIsCommitted                   -200451
#define DAQmxErrorAttributeNotSettableWhenTaskIsRunning                        -200450
#define DAQmxErrorDACRngLowNotMinusRefValNorZero                               -200449
#define DAQmxErrorDACRngHighNotEqualRefVal                                     -200448
#define DAQmxErrorUnitsNotFromCustomScale                                      -200447
#define DAQmxErrorInvalidVoltageReadingDuringExtCal                            -200446
#define DAQmxErrorCalFunctionNotSupported                                      -200445
#define DAQmxErrorInvalidPhysicalChanForCal                                    -200444
#define DAQmxErrorExtCalNotComplete                                            -200443
#define DAQmxErrorCantSyncToExtStimulusFreqDuringCal                           -200442
#define DAQmxErrorUnableToDetectExtStimulusFreqDuringCal                       -200441
#define DAQmxErrorInvalidCloseAction                                           -200440
#define DAQmxErrorExtCalFunctionOutsideExtCalSession                           -200439
#define DAQmxErrorInvalidCalArea                                               -200438
#define DAQmxErrorExtCalConstsInvalid                                          -200437
#define DAQmxErrorStartTrigDelayWithExtSampClk                                 -200436
#define DAQmxErrorDelayFromSampClkWithExtConv                                  -200435
#define DAQmxErrorFewerThan2PreScaledVals                                      -200434
#define DAQmxErrorFewerThan2ScaledValues                                       -200433
#define DAQmxErrorPhysChanOutputType                                           -200432
#define DAQmxErrorPhysChanMeasType                                             -200431
#define DAQmxErrorInvalidPhysChanType                                          -200430
#define DAQmxErrorLabVIEWEmptyTaskOrChans                                      -200429
#define DAQmxErrorLabVIEWInvalidTaskOrChans                                    -200428
#define DAQmxErrorInvalidRefClkRate                                            -200427
#define DAQmxErrorInvalidExtTrigImpedance                                      -200426
#define DAQmxErrorHystTrigLevelAIMax                                           -200425
#define DAQmxErrorLineNumIncompatibleWithVideoSignalFormat                     -200424
#define DAQmxErrorTrigWindowAIMinAIMaxCombo                                    -200423
#define DAQmxErrorTrigAIMinAIMax                                               -200422
#define DAQmxErrorHystTrigLevelAIMin                                           -200421
#define DAQmxErrorInvalidSampRateConsiderRIS                                   -200420
#define DAQmxErrorInvalidReadPosDuringRIS                                      -200419
#define DAQmxErrorImmedTrigDuringRISMode                                       -200418
#define DAQmxErrorTDCNotEnabledDuringRISMode                                   -200417
#define DAQmxErrorMultiRecWithRIS                                              -200416
#define DAQmxErrorInvalidRefClkSrc                                             -200415
#define DAQmxErrorInvalidSampClkSrc                                            -200414
#define DAQmxErrorInsufficientOnBoardMemForNumRecsAndSamps                     -200413
#define DAQmxErrorInvalidAIAttenuation                                         -200412
#define DAQmxErrorACCouplingNotAllowedWith50OhmImpedance                       -200411
#define DAQmxErrorInvalidRecordNum                                             -200410
#define DAQmxErrorZeroSlopeLinearScale                                         -200409
#define DAQmxErrorZeroReversePolyScaleCoeffs                                   -200408
#define DAQmxErrorZeroForwardPolyScaleCoeffs                                   -200407
#define DAQmxErrorNoReversePolyScaleCoeffs                                     -200406
#define DAQmxErrorNoForwardPolyScaleCoeffs                                     -200405
#define DAQmxErrorNoPolyScaleCoeffs                                            -200404
#define DAQmxErrorReversePolyOrderLessThanNumPtsToCompute                      -200403
#define DAQmxErrorReversePolyOrderNotPositive                                  -200402
#define DAQmxErrorNumPtsToComputeNotPositive                                   -200401
#define DAQmxErrorWaveformLengthNotMultipleOfIncr                              -200400
#define DAQmxErrorCAPINoExtendedErrorInfoAvailable                             -200399
#define DAQmxErrorCVIFunctionNotFoundInDAQmxDLL                                -200398
#define DAQmxErrorCVIFailedToLoadDAQmxDLL                                      -200397
#define DAQmxErrorNoCommonTrigLineForImmedRoute                                -200396
#define DAQmxErrorNoCommonTrigLineForTaskRoute                                 -200395
#define DAQmxErrorF64PrptyValNotUnsignedInt                                    -200394
#define DAQmxErrorRegisterNotWritable                                          -200393
#define DAQmxErrorInvalidOutputVoltageAtSampClkRate                            -200392
#define DAQmxErrorStrobePhaseShiftDCMBecameUnlocked                            -200391
#define DAQmxErrorDrivePhaseShiftDCMBecameUnlocked                             -200390
#define DAQmxErrorClkOutPhaseShiftDCMBecameUnlocked                            -200389
#define DAQmxErrorOutputBoardClkDCMBecameUnlocked                              -200388
#define DAQmxErrorInputBoardClkDCMBecameUnlocked                               -200387
#define DAQmxErrorInternalClkDCMBecameUnlocked                                 -200386
#define DAQmxErrorDCMLock                                                      -200385
#define DAQmxErrorDataLineReservedForDynamicOutput                             -200384
#define DAQmxErrorInvalidRefClkSrcGivenSampClkSrc                              -200383
#define DAQmxErrorNoPatternMatcherAvailable                                    -200382
#define DAQmxErrorInvalidDelaySampRateBelowPhaseShiftDCMThresh                 -200381
#define DAQmxErrorStrainGageCalibration                                        -200380
#define DAQmxErrorInvalidExtClockFreqAndDivCombo                               -200379
#define DAQmxErrorCustomScaleDoesNotExist                                      -200378
#define DAQmxErrorOnlyFrontEndChanOpsDuringScan                                -200377
#define DAQmxErrorInvalidOptionForDigitalPortChannel                           -200376
#define DAQmxErrorUnsupportedSignalTypeExportSignal                            -200375
#define DAQmxErrorInvalidSignalTypeExportSignal                                -200374
#define DAQmxErrorUnsupportedTrigTypeSendsSWTrig                               -200373
#define DAQmxErrorInvalidTrigTypeSendsSWTrig                                   -200372
#define DAQmxErrorRepeatedPhysicalChan                                         -200371
#define DAQmxErrorResourcesInUseForRouteInTask                                 -200370
#define DAQmxErrorResourcesInUseForRoute                                       -200369
#define DAQmxErrorRouteNotSupportedByHW                                        -200368
#define DAQmxErrorResourcesInUseForExportSignalPolarity                        -200367
#define DAQmxErrorResourcesInUseForInversionInTask                             -200366
#define DAQmxErrorResourcesInUseForInversion                                   -200365
#define DAQmxErrorExportSignalPolarityNotSupportedByHW                         -200364
#define DAQmxErrorInversionNotSupportedByHW                                    -200363
#define DAQmxErrorOverloadedChansExistNotRead                                  -200362
#define DAQmxErrorInputFIFOOverflow2                                           -200361
#define DAQmxErrorCJCChanNotSpecd                                              -200360
#define DAQmxErrorCtrExportSignalNotPossible                                   -200359
#define DAQmxErrorRefTrigWhenContinuous                                        -200358
#define DAQmxErrorIncompatibleSensorOutputAndDeviceInputRanges                 -200357
#define DAQmxErrorCustomScaleNameUsed                                          -200356
#define DAQmxErrorPropertyValNotSupportedByHW                                  -200355
#define DAQmxErrorPropertyValNotValidTermName                                  -200354
#define DAQmxErrorResourcesInUseForProperty                                    -200353
#define DAQmxErrorCJCChanAlreadyUsed                                           -200352
#define DAQmxErrorForwardPolynomialCoefNotSpecd                                -200351
#define DAQmxErrorTableScaleNumPreScaledAndScaledValsNotEqual                  -200350
#define DAQmxErrorTableScalePreScaledValsNotSpecd                              -200349
#define DAQmxErrorTableScaleScaledValsNotSpecd                                 -200348
#define DAQmxErrorIntermediateBufferSizeNotMultipleOfIncr                      -200347
#define DAQmxErrorEventPulseWidthOutOfRange                                    -200346
#define DAQmxErrorEventDelayOutOfRange                                         -200345
#define DAQmxErrorSampPerChanNotMultipleOfIncr                                 -200344
#define DAQmxErrorCannotCalculateNumSampsTaskNotStarted                        -200343
#define DAQmxErrorScriptNotInMem                                               -200342
#define DAQmxErrorOnboardMemTooSmall                                           -200341
#define DAQmxErrorReadAllAvailableDataWithoutBuffer                            -200340
#define DAQmxErrorPulseActiveAtStart                                           -200339
#define DAQmxErrorCalTempNotSupported                                          -200338
#define DAQmxErrorDelayFromSampClkTooLong                                      -200337
#define DAQmxErrorDelayFromSampClkTooShort                                     -200336
#define DAQmxErrorAIConvRateTooHigh                                            -200335
#define DAQmxErrorDelayFromStartTrigTooLong                                    -200334
#define DAQmxErrorDelayFromStartTrigTooShort                                   -200333
#define DAQmxErrorSampRateTooHigh                                              -200332
#define DAQmxErrorSampRateTooLow                                               -200331
#define DAQmxErrorPFI0UsedForAnalogAndDigitalSrc                               -200330
#define DAQmxErrorPrimingCfgFIFO                                               -200329
#define DAQmxErrorCannotOpenTopologyCfgFile                                    -200328
#define DAQmxErrorInvalidDTInsideWfmDataType                                   -200327
#define DAQmxErrorRouteSrcAndDestSame                                          -200326
#define DAQmxErrorReversePolynomialCoefNotSpecd                                -200325
#define DAQmxErrorDevAbsentOrUnavailable                                       -200324
#define DAQmxErrorNoAdvTrigForMultiDevScan                                     -200323
#define DAQmxErrorInterruptsInsufficientDataXferMech                           -200322
#define DAQmxErrorInvalidAttentuationBasedOnMinMax                             -200321
#define DAQmxErrorCabledModuleCannotRouteSSH                                   -200320
#define DAQmxErrorCabledModuleCannotRouteConvClk                               -200319
#define DAQmxErrorInvalidExcitValForScaling                                    -200318
#define DAQmxErrorNoDevMemForScript                                            -200317
#define DAQmxErrorScriptDataUnderflow                                          -200316
#define DAQmxErrorNoDevMemForWaveform                                          -200315
#define DAQmxErrorStreamDCMBecameUnlocked                                      -200314
#define DAQmxErrorStreamDCMLock                                                -200313
#define DAQmxErrorWaveformNotInMem                                             -200312
#define DAQmxErrorWaveformWriteOutOfBounds                                     -200311
#define DAQmxErrorWaveformPreviouslyAllocated                                  -200310
#define DAQmxErrorSampClkTbMasterTbDivNotAppropriateForSampTbSrc               -200309
#define DAQmxErrorSampTbRateSampTbSrcMismatch                                  -200308
#define DAQmxErrorMasterTbRateMasterTbSrcMismatch                              -200307
#define DAQmxErrorSampsPerChanTooBig                                           -200306
#define DAQmxErrorFinitePulseTrainNotPossible                                  -200305
#define DAQmxErrorExtMasterTimebaseRateNotSpecified                            -200304
#define DAQmxErrorExtSampClkSrcNotSpecified                                    -200303
#define DAQmxErrorInputSignalSlowerThanMeasTime                                -200302
#define DAQmxErrorCannotUpdatePulseGenProperty                                 -200301
#define DAQmxErrorInvalidTimingType                                            -200300
#define DAQmxErrorPropertyUnavailWhenUsingOnboardMemory                        -200297
#define DAQmxErrorCannotWriteAfterStartWithOnboardMemory                       -200295
#define DAQmxErrorNotEnoughSampsWrittenForInitialXferRqstCondition             -200294
#define DAQmxErrorNoMoreSpace                                                  -200293
#define DAQmxErrorSamplesCanNotYetBeWritten                                    -200292
#define DAQmxErrorGenStoppedToPreventIntermediateBufferRegenOfOldSamples       -200291
#define DAQmxErrorGenStoppedToPreventRegenOfOldSamples                         -200290
#define DAQmxErrorSamplesNoLongerWriteable                                     -200289
#define DAQmxErrorSamplesWillNeverBeGenerated                                  -200288
#define DAQmxErrorNegativeWriteSampleNumber                                    -200287
#define DAQmxErrorNoAcqStarted                                                 -200286
#define DAQmxErrorSamplesNotYetAvailable                                       -200284
#define DAQmxErrorAcqStoppedToPreventIntermediateBufferOverflow                -200283
#define DAQmxErrorNoRefTrigConfigured                                          -200282
#define DAQmxErrorCannotReadRelativeToRefTrigUntilDone                         -200281
#define DAQmxErrorSamplesNoLongerAvailable                                     -200279
#define DAQmxErrorSamplesWillNeverBeAvailable                                  -200278
#define DAQmxErrorNegativeReadSampleNumber                                     -200277
#define DAQmxErrorExternalSampClkAndRefClkThruSameTerm                         -200276
#define DAQmxErrorExtSampClkRateTooLowForClkIn                                 -200275
#define DAQmxErrorExtSampClkRateTooHighForBackplane                            -200274
#define DAQmxErrorSampClkRateAndDivCombo                                       -200273
#define DAQmxErrorSampClkRateTooLowForDivDown                                  -200272
#define DAQmxErrorProductOfAOMinAndGainTooSmall                                -200271
#define DAQmxErrorInterpolationRateNotPossible                                 -200270
#define DAQmxErrorOffsetTooLarge                                               -200269
#define DAQmxErrorOffsetTooSmall                                               -200268
#define DAQmxErrorProductOfAOMaxAndGainTooLarge                                -200267
#define DAQmxErrorMinAndMaxNotSymmetric                                        -200266
#define DAQmxErrorInvalidAnalogTrigSrc                                         -200265
#define DAQmxErrorTooManyChansForAnalogRefTrig                                 -200264
#define DAQmxErrorTooManyChansForAnalogPauseTrig                               -200263
#define DAQmxErrorTrigWhenOnDemandSampTiming                                   -200262
#define DAQmxErrorInconsistentAnalogTrigSettings                               -200261
#define DAQmxErrorMemMapDataXferModeSampTimingCombo                            -200260
#define DAQmxErrorInvalidJumperedAttr                                          -200259
#define DAQmxErrorInvalidGainBasedOnMinMax                                     -200258
#define DAQmxErrorInconsistentExcit                                            -200257
#define DAQmxErrorTopologyNotSupportedByCfgTermBlock                           -200256
#define DAQmxErrorBuiltInTempSensorNotSupported                                -200255
#define DAQmxErrorInvalidTerm                                                  -200254
#define DAQmxErrorCannotTristateTerm                                           -200253
#define DAQmxErrorCannotTristateBusyTerm                                       -200252
#define DAQmxErrorNoDMAChansAvailable                                          -200251
#define DAQmxErrorInvalidWaveformLengthWithinLoopInScript                      -200250
#define DAQmxErrorInvalidSubsetLengthWithinLoopInScript                        -200249
#define DAQmxErrorMarkerPosInvalidForLoopInScript                              -200248
#define DAQmxErrorIntegerExpectedInScript                                      -200247
#define DAQmxErrorPLLBecameUnlocked                                            -200246
#define DAQmxErrorPLLLock                                                      -200245
#define DAQmxErrorDDCClkOutDCMBecameUnlocked                                   -200244
#define DAQmxErrorDDCClkOutDCMLock                                             -200243
#define DAQmxErrorClkDoublerDCMBecameUnlocked                                  -200242
#define DAQmxErrorClkDoublerDCMLock                                            -200241
#define DAQmxErrorSampClkDCMBecameUnlocked                                     -200240
#define DAQmxErrorSampClkDCMLock                                               -200239
#define DAQmxErrorSampClkTimebaseDCMBecameUnlocked                             -200238
#define DAQmxErrorSampClkTimebaseDCMLock                                       -200237
#define DAQmxErrorAttrCannotBeReset                                            -200236
#define DAQmxErrorExplanationNotFound                                          -200235
#define DAQmxErrorWriteBufferTooSmall                                          -200234
#define DAQmxErrorSpecifiedAttrNotValid                                        -200233
#define DAQmxErrorAttrCannotBeRead                                             -200232
#define DAQmxErrorAttrCannotBeSet                                              -200231
#define DAQmxErrorNULLPtrForC_Api                                              -200230
#define DAQmxErrorReadBufferTooSmall                                           -200229
#define DAQmxErrorBufferTooSmallForString                                      -200228
#define DAQmxErrorNoAvailTrigLinesOnDevice                                     -200227
#define DAQmxErrorTrigBusLineNotAvail                                          -200226
#define DAQmxErrorCouldNotReserveRequestedTrigLine                             -200225
#define DAQmxErrorTrigLineNotFound                                             -200224
#define DAQmxErrorSCXI1126ThreshHystCombination                                -200223
#define DAQmxErrorAcqStoppedToPreventInputBufferOverwrite                      -200222
#define DAQmxErrorTimeoutExceeded                                              -200221
#define DAQmxErrorInvalidDeviceID                                              -200220
#define DAQmxErrorInvalidAOChanOrder                                           -200219
#define DAQmxErrorSampleTimingTypeAndDataXferMode                              -200218
#define DAQmxErrorBufferWithOnDemandSampTiming                                 -200217
#define DAQmxErrorBufferAndDataXferMode                                        -200216
#define DAQmxErrorMemMapAndBuffer                                              -200215
#define DAQmxErrorNoAnalogTrigHW                                               -200214
#define DAQmxErrorTooManyPretrigPlusMinPostTrigSamps                           -200213
#define DAQmxErrorInconsistentUnitsSpecified                                   -200212
#define DAQmxErrorMultipleRelaysForSingleRelayOp                               -200211
#define DAQmxErrorMultipleDevIDsPerChassisSpecifiedInList                      -200210
#define DAQmxErrorDuplicateDevIDInList                                         -200209
#define DAQmxErrorInvalidRangeStatementCharInList                              -200208
#define DAQmxErrorInvalidDeviceIDInList                                        -200207
#define DAQmxErrorTriggerPolarityConflict                                      -200206
#define DAQmxErrorCannotScanWithCurrentTopology                                -200205
#define DAQmxErrorUnexpectedIdentifierInFullySpecifiedPathInList               -200204
#define DAQmxErrorSwitchCannotDriveMultipleTrigLines                           -200203
#define DAQmxErrorInvalidRelayName                                             -200202
#define DAQmxErrorSwitchScanlistTooBig                                         -200201
#define DAQmxErrorSwitchChanInUse                                              -200200
#define DAQmxErrorSwitchNotResetBeforeScan                                     -200199
#define DAQmxErrorInvalidTopology                                              -200198
#define DAQmxErrorAttrNotSupported                                             -200197
#define DAQmxErrorUnexpectedEndOfActionsInList                                 -200196
#define DAQmxErrorPowerBudgetExceeded                                          -200195
#define DAQmxErrorHWUnexpectedlyPoweredOffAndOn                                -200194
#define DAQmxErrorSwitchOperationNotSupported                                  -200193
#define DAQmxErrorOnlyContinuousScanSupported                                  -200192
#define DAQmxErrorSwitchDifferentTopologyWhenScanning                          -200191
#define DAQmxErrorDisconnectPathNotSameAsExistingPath                          -200190
#define DAQmxErrorConnectionNotPermittedOnChanReservedForRouting               -200189
#define DAQmxErrorCannotConnectSrcChans                                        -200188
#define DAQmxErrorCannotConnectChannelToItself                                 -200187
#define DAQmxErrorChannelNotReservedForRouting                                 -200186
#define DAQmxErrorCannotConnectChansDirectly                                   -200185
#define DAQmxErrorChansAlreadyConnected                                        -200184
#define DAQmxErrorChanDuplicatedInPath                                         -200183
#define DAQmxErrorNoPathToDisconnect                                           -200182
#define DAQmxErrorInvalidSwitchChan                                            -200181
#define DAQmxErrorNoPathAvailableBetween2SwitchChans                           -200180
#define DAQmxErrorExplicitConnectionExists                                     -200179
#define DAQmxErrorSwitchDifferentSettlingTimeWhenScanning                      -200178
#define DAQmxErrorOperationOnlyPermittedWhileScanning                          -200177
#define DAQmxErrorOperationNotPermittedWhileScanning                           -200176
#define DAQmxErrorHardwareNotResponding                                        -200175
#define DAQmxErrorInvalidSampAndMasterTimebaseRateCombo                        -200173
#define DAQmxErrorNonZeroBufferSizeInProgIOXfer                                -200172
#define DAQmxErrorVirtualChanNameUsed                                          -200171
#define DAQmxErrorPhysicalChanDoesNotExist                                     -200170
#define DAQmxErrorMemMapOnlyForProgIOXfer                                      -200169
#define DAQmxErrorTooManyChans                                                 -200168
#define DAQmxErrorCannotHaveCJTempWithOtherChans                               -200167
#define DAQmxErrorOutputBufferUnderwrite                                       -200166
#define DAQmxErrorSensorInvalidCompletionResistance                            -200163
#define DAQmxErrorVoltageExcitIncompatibleWith2WireCfg                         -200162
#define DAQmxErrorIntExcitSrcNotAvailable                                      -200161
#define DAQmxErrorCannotCreateChannelAfterTaskVerified                         -200160
#define DAQmxErrorLinesReservedForSCXIControl                                  -200159
#define DAQmxErrorCouldNotReserveLinesForSCXIControl                           -200158
#define DAQmxErrorCalibrationFailed                                            -200157
#define DAQmxErrorReferenceFrequencyInvalid                                    -200156
#define DAQmxErrorReferenceResistanceInvalid                                   -200155
#define DAQmxErrorReferenceCurrentInvalid                                      -200154
#define DAQmxErrorReferenceVoltageInvalid                                      -200153
#define DAQmxErrorEEPROMDataInvalid                                            -200152
#define DAQmxErrorCabledModuleNotCapableOfRoutingAI                            -200151
#define DAQmxErrorChannelNotAvailableInParallelMode                            -200150
#define DAQmxErrorExternalTimebaseRateNotKnownForDelay                         -200149
#define DAQmxErrorFREQOUTCannotProduceDesiredFrequency                         -200148
#define DAQmxErrorMultipleCounterInputTask                                     -200147
#define DAQmxErrorCounterStartPauseTriggerConflict                             -200146
#define DAQmxErrorCounterInputPauseTriggerAndSampleClockInvalid                -200145
#define DAQmxErrorCounterOutputPauseTriggerInvalid                             -200144
#define DAQmxErrorCounterTimebaseRateNotSpecified                              -200143
#define DAQmxErrorCounterTimebaseRateNotFound                                  -200142
#define DAQmxErrorCounterOverflow                                              -200141
#define DAQmxErrorCounterNoTimebaseEdgesBetweenGates                           -200140
#define DAQmxErrorCounterMaxMinRangeFreq                                       -200139
#define DAQmxErrorCounterMaxMinRangeTime                                       -200138
#define DAQmxErrorSuitableTimebaseNotFoundTimeCombo                            -200137
#define DAQmxErrorSuitableTimebaseNotFoundFrequencyCombo                       -200136
#define DAQmxErrorInternalTimebaseSourceDivisorCombo                           -200135
#define DAQmxErrorInternalTimebaseSourceRateCombo                              -200134
#define DAQmxErrorInternalTimebaseRateDivisorSourceCombo                       -200133
#define DAQmxErrorExternalTimebaseRateNotknownForRate                          -200132
#define DAQmxErrorAnalogTrigChanNotFirstInScanList                             -200131
#define DAQmxErrorNoDivisorForExternalSignal                                   -200130
#define DAQmxErrorAttributeInconsistentAcrossRepeatedPhysicalChannels          -200128
#define DAQmxErrorCannotHandshakeWithPort0                                     -200127
#define DAQmxErrorControlLineConflictOnPortC                                   -200126
#define DAQmxErrorLines4To7ConfiguredForOutput                                 -200125
#define DAQmxErrorLines4To7ConfiguredForInput                                  -200124
#define DAQmxErrorLines0To3ConfiguredForOutput                                 -200123
#define DAQmxErrorLines0To3ConfiguredForInput                                  -200122
#define DAQmxErrorPortConfiguredForOutput                                      -200121
#define DAQmxErrorPortConfiguredForInput                                       -200120
#define DAQmxErrorPortConfiguredForStaticDigitalOps                            -200119
#define DAQmxErrorPortReservedForHandshaking                                   -200118
#define DAQmxErrorPortDoesNotSupportHandshakingDataIO                          -200117
#define DAQmxErrorCannotTristate8255OutputLines                                -200116
#define DAQmxErrorTemperatureOutOfRangeForCalibration                          -200113
#define DAQmxErrorCalibrationHandleInvalid                                     -200112
#define DAQmxErrorPasswordRequired                                             -200111
#define DAQmxErrorIncorrectPassword                                            -200110
#define DAQmxErrorPasswordTooLong                                              -200109
#define DAQmxErrorCalibrationSessionAlreadyOpen                                -200108
#define DAQmxErrorSCXIModuleIncorrect                                          -200107
#define DAQmxErrorAttributeInconsistentAcrossChannelsOnDevice                  -200106
#define DAQmxErrorSCXI1122ResistanceChanNotSupportedForCfg                     -200105
#define DAQmxErrorBracketPairingMismatchInList                                 -200104
#define DAQmxErrorInconsistentNumSamplesToWrite                                -200103
#define DAQmxErrorIncorrectDigitalPattern                                      -200102
#define DAQmxErrorIncorrectNumChannelsToWrite                                  -200101
#define DAQmxErrorIncorrectReadFunction                                        -200100
#define DAQmxErrorPhysicalChannelNotSpecified                                  -200099
#define DAQmxErrorMoreThanOneTerminal                                          -200098
#define DAQmxErrorMoreThanOneActiveChannelSpecified                            -200097
#define DAQmxErrorInvalidNumberSamplesToRead                                   -200096
#define DAQmxErrorAnalogWaveformExpected                                       -200095
#define DAQmxErrorDigitalWaveformExpected                                      -200094
#define DAQmxErrorActiveChannelNotSpecified                                    -200093
#define DAQmxErrorFunctionNotSupportedForDeviceTasks                           -200092
#define DAQmxErrorFunctionNotInLibrary                                         -200091
#define DAQmxErrorLibraryNotPresent                                            -200090
#define DAQmxErrorDuplicateTask                                                -200089
#define DAQmxErrorInvalidTask                                                  -200088
#define DAQmxErrorInvalidChannel                                               -200087
#define DAQmxErrorInvalidSyntaxForPhysicalChannelRange                         -200086
#define DAQmxErrorMinNotLessThanMax                                            -200082
#define DAQmxErrorSampleRateNumChansConvertPeriodCombo                         -200081
#define DAQmxErrorAODuringCounter1DMAConflict                                  -200079
#define DAQmxErrorAIDuringCounter0DMAConflict                                  -200078
#define DAQmxErrorInvalidAttributeValue                                        -200077
#define DAQmxErrorSuppliedCurrentDataOutsideSpecifiedRange                     -200076
#define DAQmxErrorSuppliedVoltageDataOutsideSpecifiedRange                     -200075
#define DAQmxErrorCannotStoreCalConst                                          -200074
#define DAQmxErrorSCXIModuleNotFound                                           -200073
#define DAQmxErrorDuplicatePhysicalChansNotSupported                           -200072
#define DAQmxErrorTooManyPhysicalChansInList                                   -200071
#define DAQmxErrorInvalidAdvanceEventTriggerType                               -200070
#define DAQmxErrorDeviceIsNotAValidSwitch                                      -200069
#define DAQmxErrorDeviceDoesNotSupportScanning                                 -200068
#define DAQmxErrorScanListCannotBeTimed                                        -200067
#define DAQmxErrorConnectOperatorInvalidAtPointInList                          -200066
#define DAQmxErrorUnexpectedSwitchActionInList                                 -200065
#define DAQmxErrorUnexpectedSeparatorInList                                    -200064
#define DAQmxErrorExpectedTerminatorInList                                     -200063
#define DAQmxErrorExpectedConnectOperatorInList                                -200062
#define DAQmxErrorExpectedSeparatorInList                                      -200061
#define DAQmxErrorFullySpecifiedPathInListContainsRange                        -200060
#define DAQmxErrorConnectionSeparatorAtEndOfList                               -200059
#define DAQmxErrorIdentifierInListTooLong                                      -200058
#define DAQmxErrorDuplicateDeviceIDInListWhenSettling                          -200057
#define DAQmxErrorChannelNameNotSpecifiedInList                                -200056
#define DAQmxErrorDeviceIDNotSpecifiedInList                                   -200055
#define DAQmxErrorSemicolonDoesNotFollowRangeInList                            -200054
#define DAQmxErrorSwitchActionInListSpansMultipleDevices                       -200053
#define DAQmxErrorRangeWithoutAConnectActionInList                             -200052
#define DAQmxErrorInvalidIdentifierFollowingSeparatorInList                    -200051
#define DAQmxErrorInvalidChannelNameInList                                     -200050
#define DAQmxErrorInvalidNumberInRepeatStatementInList                         -200049
#define DAQmxErrorInvalidTriggerLineInList                                     -200048
#define DAQmxErrorInvalidIdentifierInListFollowingDeviceID                     -200047
#define DAQmxErrorInvalidIdentifierInListAtEndOfSwitchAction                   -200046
#define DAQmxErrorDeviceRemoved                                                -200045
#define DAQmxErrorRoutingPathNotAvailable                                      -200044
#define DAQmxErrorRoutingHardwareBusy                                          -200043
#define DAQmxErrorRequestedSignalInversionForRoutingNotPossible                -200042
#define DAQmxErrorInvalidRoutingDestinationTerminalName                        -200041
#define DAQmxErrorInvalidRoutingSourceTerminalName                             -200040
#define DAQmxErrorRoutingNotSupportedForDevice                                 -200039
#define DAQmxErrorWaitIsLastInstructionOfLoopInScript                          -200038
#define DAQmxErrorClearIsLastInstructionOfLoopInScript                         -200037
#define DAQmxErrorInvalidLoopIterationsInScript                                -200036
#define DAQmxErrorRepeatLoopNestingTooDeepInScript                             -200035
#define DAQmxErrorMarkerPositionOutsideSubsetInScript                          -200034
#define DAQmxErrorSubsetStartOffsetNotAlignedInScript                          -200033
#define DAQmxErrorInvalidSubsetLengthInScript                                  -200032
#define DAQmxErrorMarkerPositionNotAlignedInScript                             -200031
#define DAQmxErrorSubsetOutsideWaveformInScript                                -200030
#define DAQmxErrorMarkerOutsideWaveformInScript                                -200029
#define DAQmxErrorWaveformInScriptNotInMem                                     -200028
#define DAQmxErrorKeywordExpectedInScript                                      -200027
#define DAQmxErrorBufferNameExpectedInScript                                   -200026
#define DAQmxErrorProcedureNameExpectedInScript                                -200025
#define DAQmxErrorScriptHasInvalidIdentifier                                   -200024
#define DAQmxErrorScriptHasInvalidCharacter                                    -200023
#define DAQmxErrorResourceAlreadyReserved                                      -200022
#define DAQmxErrorSelfTestFailed                                               -200020
#define DAQmxErrorADCOverrun                                                   -200019
#define DAQmxErrorDACUnderflow                                                 -200018
#define DAQmxErrorInputFIFOUnderflow                                           -200017
#define DAQmxErrorOutputFIFOUnderflow                                          -200016
#define DAQmxErrorSCXISerialCommunication                                      -200015
#define DAQmxErrorDigitalTerminalSpecifiedMoreThanOnce                         -200014
#define DAQmxErrorDigitalOutputNotSupported                                    -200012
#define DAQmxErrorInconsistentChannelDirections                                -200011
#define DAQmxErrorInputFIFOOverflow                                            -200010
#define DAQmxErrorTimeStampOverwritten                                         -200009
#define DAQmxErrorStopTriggerHasNotOccurred                                    -200008
#define DAQmxErrorRecordNotAvailable                                           -200007
#define DAQmxErrorRecordOverwritten                                            -200006
#define DAQmxErrorDataNotAvailable                                             -200005
#define DAQmxErrorDataOverwrittenInDeviceMemory                                -200004
#define DAQmxErrorDuplicatedChannel                                            -200003
#define DAQmxWarningTimestampCounterRolledOver                                  200003
#define DAQmxWarningInputTerminationOverloaded                                  200004
#define DAQmxWarningADCOverloaded                                               200005
#define DAQmxWarningPLLUnlocked                                                 200007
#define DAQmxWarningCounter0DMADuringAIConflict                                 200008
#define DAQmxWarningCounter1DMADuringAOConflict                                 200009
#define DAQmxWarningStoppedBeforeDone                                           200010
#define DAQmxWarningRateViolatesSettlingTime                                    200011
#define DAQmxWarningRateViolatesMaxADCRate                                      200012
#define DAQmxWarningUserDefInfoStringTooLong                                    200013
#define DAQmxWarningTooManyInterruptsPerSecond                                  200014
#define DAQmxWarningPotentialGlitchDuringWrite                                  200015
#define DAQmxWarningDevNotSelfCalibratedWithDAQmx                               200016
#define DAQmxWarningAISampRateTooLow                                            200017
#define DAQmxWarningAIConvRateTooLow                                            200018
#define DAQmxWarningReadOffsetCoercion                                          200019
#define DAQmxWarningPretrigCoercion                                             200020
#define DAQmxWarningSampValCoercedToMax                                         200021
#define DAQmxWarningSampValCoercedToMin                                         200022
#define DAQmxWarningPropertyVersionNew                                          200024
#define DAQmxWarningUserDefinedInfoTooLong                                      200025
#define DAQmxWarningCAPIStringTruncatedToFitBuffer                              200026
#define DAQmxWarningSampClkRateTooLow                                           200027
#define DAQmxWarningPossiblyInvalidCTRSampsInFiniteDMAAcq                       200028
#define DAQmxWarningRISAcqCompletedSomeBinsNotFilled                            200029
#define DAQmxWarningPXIDevTempExceedsMaxOpTemp                                  200030
#define DAQmxWarningOutputGainTooLowForRFFreq                                   200031
#define DAQmxWarningOutputGainTooHighForRFFreq                                  200032
#define DAQmxWarningMultipleWritesBetweenSampClks                               200033
#define DAQmxWarningDeviceMayShutDownDueToHighTemp                              200034
#define DAQmxWarningReadNotCompleteBeforeSampClk                                209800
#define DAQmxWarningWriteNotCompleteBeforeSampClk                               209801



;******************************************************************************
; *** NI-DAQBasemx Function Declarations ***************************************
;******************************************************************************/

;******************************************************/
;***         Task Configuration/Control             ***/
;******************************************************/

;for use with red/system


#import [
	libni cdecl [
        DAQmxBaseLoadTask: "DAQmxBaseLoadTask"[
            ;Loads an existing named task created by you with the NI-DAQmx Base Task Configuration Utility. 
            ;If you use this function to load a task, you must use DAQmxBaseClearTask to destroy it.
            taskName                    [c-string!]
            PtrTaskHandle		[pointer![integer!]]; pointer
            return:                     [integer!]
        ]
        DAQmxBaseCreateTask: "DAQmxBaseCreateTask" [
            {Creates a task. If you use this function to create a task, you must use DAQmxBaseClearTask to destroy it.}
            taskName                    [c-string!]
            PtrTaskHandle		[pointer![integer!]]; pointer
            return:                     [integer!]
        ]
        DAQmxBaseStartTask: "DAQmxBaseStartTask" [
            {Transitions the task from the committed state to the running state, which begins measurement or generation. 
            Using this function is required for all NI-DAQmx Base applications. 
            This function is not required if you are using a DAQmxBase Write function with autoStart set to TRUE.}
            TaskHandle                  [integer!]
            return:                     [integer!]
        ]
        DAQmxBaseStopTask: "DAQmxBaseStopTask" [
            {Stops the task and returns it to the state it was in before you called DAQmxBaseStartTask 
            or called an DAQmxBase Write function with autoStart set to TRUE. 
            Using this function is required for all NI-DAQmx Base applications.}
            TaskHandle                  [integer!]
            return:                     [integer!]
        ]
        DAQmxBaseClearTask: "DAQmxBaseClearTask" [
            {Clears the task. Make sure the task has been stopped by calling DAQmxBaseStopTask.}
            TaskHandle                  [integer!]
            return:                     [integer!]
        ]
        DAQmxBaseIsTaskDone: "DAQmxBaseIsTaskDone" [
            {Queries whether the task completed execution. 
            Use this function to ensure that the specified operation is complete before you stop the task.}
            TaskHandle                  [integer!]
            isTaskDone                  [pointer! [integer!]]
            return:                     [integer!]
        ]   

        ;******************************************************
        ;***        Channel Configuration/Creation          ***
        ;******************************************************
        
        DAQmxBaseCreateAIVoltageChan: "DAQmxBaseCreateAIVoltageChan" [
            {Creates channel(s) for voltage measurement and adds the channel(s) to the task you specify with taskHandle.}
            TaskHandle                  [integer!]
            physicalChannel             [c-string!]
            nameToAssignToChannel       [c-string!]; not used/ use empty string
            terminalConfig              [integer!]
            minVal                      [float!]
            maxVal                      [float!]
            units                       [integer!]
            customScaleName             [c-string!] ;not used/ use empty string use none by setting CustomScaleName address to 0
            return:                     [integer!]
        ]
        DAQmxBaseCreateAIThrmcplChan: "DAQmxBaseCreateAIThrmcplChan" [
	{This function is only valid for a NI USB-9211 device. 
            Creates channel(s) that use a thermocouple to measure temperature and adds the channel(s) 
            to the task you specify with taskHandle.}
            TaskHandle                  [integer!]
            physicalChannel             [c-string!]
            nameToAssignToChannel       [c-string!]; not used/ use empty string
            minVal                      [float!]
            maxVal                      [float!]
            units                       [integer!]
            thermocoupleType            [integer!]
            cjcSource                   [integer!]
            cjVal                       [float!]
            cjcChannel                  [c-string!]
            return:                     [integer!]
        ]   
        DAQmxBaseCreateAOVoltageChan: "DAQmxBaseCreateAOVoltageChan" [
            {Creates channel(s) to generate voltage and adds the channel(s) to the task you specify with taskHandle.}
            TaskHandle                  [integer!]
            physicalChannel             [c-string!]
            nameToAssignToChannel       [c-string!]; not used/ use empty string
            minVal                      [float!]
            maxVal                      [float!]
            units                       [integer!]
            customScaleName             [c-string!] ;not used/ use empty string
            return:                     [integer!]
        ]
        DAQmxBaseCreateDIChan: "DAQmxBaseCreateDIChan" [
            {Creates channel(s) to measure digital signals and adds the channel(s) to the task you specify with taskHandle. 
            For some devices (such as E Series), NI-DAQmx Base supports grouping the digital lines of a port as single channel, 
            not multiple channels.}
            TaskHandle                  [integer!]
            lines                       [c-string!]
            nameToAssignToLines         [c-string!]; not used/ use empty string
            lineGrouping                [integer!]	
            return:                     [integer!]
        ]
        DAQmxBaseCreateDOChan: "DAQmxBaseCreateDOChan" [
            {Creates channel(s) to generate digital signals and adds the channel(s) to the task you specify with taskHandle. 
            For some devices (such as E Series), NI-DAQmx Base supports grouping the digital lines of a port as a single channel, 
            not multiple channels.}
            TaskHandle                  [integer!]
            lines                       [c-string!]
            nameToAssignToLines         [c-string!]; not used/ use empty string
            lineGrouping                [integer!]	
            return:                     [integer!]
        ]
        DAQmxBaseCreateCIPeriodChan: "DAQmxBaseCreateCIPeriodChan" [
            {Creates a channel to measure the period of a digital signal and adds the channel to the task you specify with taskHandle. 
            You can create only one counter input channel at a time with this function because a task can include only one counter input channel. 
            To read from multiple counters simultaneously, use a separate task for each counter. 
            Connect the input signal to the default input terminal of the counter.}
            TaskHandle                  [integer!]
            counter                     [c-string!] ;The name of the counter to use to create virtual channels such as Dev1/ctr0.
            nameToAssignToLines         [c-string!]; not used/ use empty string
            minVal                      [float!]
            maxVal                      [float!]
            units                       [integer!]	
            edge                        [integer!]
            measMethod                  [integer!]
            measTime                    [float!] ;  always pass 0 for this parameter.
            divisor                     [integer!] ; always pass 1 for this parameter.
            customScaleName             [c-string!] ;not used/ use none by setting CustomScaleName address to 0
            return:                     [integer!]
        ]
        DAQmxBaseCreateCICountEdgesChan: "DAQmxBaseCreateCICountEdgesChan" [
            {Creates a channel to count the number of rising or falling edges of a digital signal and adds the channel to the task you specify with taskHandle. 
            You can create only one counter input channel at a time with this function because a task can include only one counter input channel. 
            To read from multiple counters simultaneously, use a separate task for each counter. 
            Connect the input signal to the default input terminal of the counter.}
            TaskHandle                  [integer!]
            counter                     [c-string!] ;The name of the counter to use to create virtual channels such as Dev1/ctr0.
            nameToAssignToLines         [c-string!]; not used/ use empty string
            edge                        [integer!]
            initialCount                [integer!]
            countDirection              [integer!]	
            return:                     [integer!]
        ]
        DAQmxBaseCreateCIPulseWidthChan: "DAQmxBaseCreateCIPulseWidthChan" [
            {Creates a channel to measure the width of a digital pulse and adds the channel to the task you specify with taskHandle. 
            startingEdge determines whether to measure a high pulse or low pulse. 
            You can create only one counter input channel at a time with this function because a task can include only one counter input channel. 
            To read from multiple counters simultaneously, use a separate task for each counter. 
            Connect the input signal to the default input terminal of the counter.}
            TaskHandle                  [integer!]
            counter                     [c-string!] ;The name of the counter to use to create virtual channels such as Dev1/ctr0.
            nameToAssignToLines         [c-string!]; not used/ use empty string
            minVal                      [float!]
            maxVal                      [float!]
            units                       [integer!]	
            startingEdge                [integer!]
            customScaleName             [c-string!] ;not used/ use none by setting CustomScaleName address to 0
            return:                     [integer!]
        ]
        DAQmxBaseCreateCILinEncoderChan: "DAQmxBaseCreateCILinEncoderChan" [
            {Creates a channel that uses a linear encoder to measure linear position. 
            You can create only one counter input channel at a time with this function because a task can include only one counter input channel. T
            o read from multiple counters simultaneously, use a separate task for each counter. 
            Connect the input signals to the default input terminals of the counter unless you select different input terminals.}
            TaskHandle                  [integer!]
            counter                     [c-string!] ;The name of the counter to use to create virtual channels such as Dev1/ctr0.
            nameToAssignToLines         [c-string!]; not used/ use empty string
            decodingType                [integer!]
            ZidxEnable                  [integer!]
            ZidxVal                     [float!]
            ZidxPhase                   [integer!]
            Units                       [integer!]
            distPerPulse                [float!]
            initialPos                  [float!]
            customScaleName             [c-string!] ;not used/ use none by setting CustomScaleName address to 0
            return:                     [integer!]
        ]
        DAQmxBaseCreateCIAngEncoderChan: "DAQmxBaseCreateCIAngEncoderChan" [
            {Creates a channel that uses an angular encoder to measure angular position. 
            You can create only one counter input channel at a time with this function because a task can include only one counter input channel. 
            To read from multiple counters simultaneously, use a separate task for each counter. 
            Connect the input signals to the default input terminals of the counter unless you select different input terminals.}
            TaskHandle                  [integer!]
            counter                     [c-string!] ;The name of the counter to use to create virtual channels such as Dev1/ctr0.
            nameToAssignToLines         [c-string!]; not used/ use empty string
            decodingType                [integer!]
            ZidxEnable                  [integer!]
            ZidxVal                     [float!]
            ZidxPhase                   [integer!]
            units                       [integer!]
            pulsesPerRev                [integer!]
            initialAngle                [float!]
            customScaleName             [c-string!] ;not used/ use none by setting CustomScaleName address to 0
            return:                     [integer!]
        ]
        DAQmxBaseCreateCOPulseChanFreq: "DAQmxBaseCreateCOPulseChanFreq" [
            {Creates a channel to generate digital pulses defined by freq and dutyCycle and adds the channel to the task you specify with taskHandle. 
            The pulses appear on the default output terminal of the counter.
            You can create only one counter output channel at a time with this function because a task can include only one counter output channel. 
            To use multiple counters simultaneously, use a separate task for each counter.}
            TaskHandle                  [integer!]
            counter                     [c-string!] ;The name of the counter to use to create virtual channels such as Dev1/ctr0.
            nameToAssignToLines         [c-string!]; not used/ use empty string
            units                       [integer!]
            idleState                   [integer!]
            initialDelay                [float!]
            freq                        [float!]
            dutyCycle                   [float!]
            return:                     [float!]
        ]
        DAQmxBaseGetChanAttribute: "DAQmxBaseGetChanAttribute" [
            { undocumented: to be tested for value parameter}
            TaskHandle                  [integer!]
            channel                     [c-string!]
            attribute                   [integer!]
            value                       [pointer! [byte!]] ;*void just a pointer
            return:                     [integer!]
        ]
        DAQmxBaseSetChanAttribute: "DAQmxBaseSetChanAttribute" [
 			{ undocumented}
            TaskHandle                  [integer!]
            channel                     [c-string!]
            attribute                   [integer!]
            value                       [integer!]
            return:                     [integer!]
        ]
        
        ;******************************************************
        ;***                    Timing                      ***
        ;******************************************************
        
        ;(Analog/Counter Timing)
        DAQmxBaseCfgSampClkTiming: "DAQmxBaseCfgSampClkTiming" [
            {Sets the source of the Sample Clock, the rate of the Sample Clock, and the number of samples to acquire or generate.}
            TaskHandle              [integer!]
            source                  [c-string!]
            rate                    [float!]
            activeEdge              [integer!]
            sampleMode              [integer!]
            sampsPerChan            [integer!]
            return:                 [integer!]
        ]
        
        ;(Digital Timing)
        DAQmxBaseCfgImplicitTiming: "DAQmxBaseCfgImplicitTiming"  [
            {Sets only the number of samples to acquire or generate without specifying timing. 
            Typically, you should use this function when the task does not require sample timing, 
            such as tasks that use counters for buffered frequency measurement, buffered period measurement, or pulse train generation.}
            TaskHandle              [integer!]
            sampleMode              [integer!]
            sampsPerChan            [integer!]
            return:                 [integer!]
        ]
        ;******************************************************
        ;***                  Triggering                    ***
        ;******************************************************
        DAQmxBaseDisableStartTrig: "DAQmxBaseDisableStartTrig" [
            {Configures the task to start acquiring or generating samples immediately upon starting the task.}
            TaskHandle              [integer!]
            return:                 [integer!]
        ]
        DAQmxBaseCfgDigEdgeStartTrig: "DAQmxBaseCfgDigEdgeStartTrig" [
            {Configures the task to start acquiring or generating samples on a rising or falling edge of a digital signal.}
            TaskHandle              [integer!]
            triggerSource           [c-string!]
            triggerEdge             [integer!]
            return:                 [integer!]
        ]
        DAQmxBaseCfgAnlgEdgeStartTrig:"DAQmxBaseCfgAnlgEdgeStartTrig" [
            {Configures the task to start acquiring samples when an analog signal crosses the level you specify.}
            TaskHandle              [integer!]
            triggerSource           [c-string!]
            triggerSlope            [integer!]
            triggerLevel            [float!]
            return:                 [integer!]
        ]  
        DAQmxBaseDisableRefTrig: "DAQmxBaseDisableRefTrig" [
            {Disables reference triggering for the measurement or generation.}
            TaskHandle              [integer!]
            return:                 [integer!]
        ]
        DAQmxBaseCfgDigEdgeRefTrig: "DAQmxBaseCfgDigEdgeRefTrig" [
            {Configures the task to stop the acquisition when the device acquires all pretrigger samples, 
            detects a rising or falling edge of a digital signal, and acquires all posttrigger samples.}
            TaskHandle              [integer!]
            triggerSource           [c-string!]
            triggerEdge             [integer!] 
            pretriggerSamples       [integer!]
            return:                 [integer!]
        ]
        DAQmxBaseCfgAnlgEdgeRefTrig: "DAQmxBaseCfgAnlgEdgeRefTrig" [
            {Configures the task to stop the acquisition when the device acquires all pretrigger samples, 
            an analog signal reaches the level you specify, and the device acquires all post-trigger samples.}
            TaskHandle              [integer!]
            triggerSource           [c-string!]
            triggerSlope            [integer!]
            triggerLevel            [float!]
            pretriggerSamples       [integer!]
            return:                 [integer!]
        ]
        ;******************************************************
        ;***                 Read Data                      ***
        ;******************************************************
        
       
        DAQmxBaseReadAnalogF64: "DAQmxBaseReadAnalogF64" [
            {Reads multiple floating-point samples from a task that contains one or more analog input channels.}
            TaskHandle              [integer!]
            numSampsPerChan         [integer!] 
            timeout                 [float!] 
            fillMode                [integer!]
            readArray               [pointer! [float!]] ; a pointer to an array of floats representing the sampled values by channel
            arraySizeInSamps        [integer!]
            sampsPerChanRead        [pointer! [integer!]] ; pointer
            reserved                [pointer! [integer!]]; Reserved for future use. Pass NULL to this parameter
            return:                 [integer!]
        ]
        DAQmxBaseReadBinaryI16:"DAQmxBaseReadBinaryI16" [
            {Reads multiple unscaled, signed 16-bit integer samples from a task that contains one or more analog input channels.}
            TaskHandle              [integer!]  
            numSampsPerChan         [integer!]
            timeout                 [float!]
            fillMode                [integer!] 
            readArray               [pointer! [integer!]] ;pointer to array
            arraySizeInSamps        [integer!]
            sampsPerChanRead        [pointer! [integer!]]; pointer 
            reserved                [pointer![integer!]]; Reserved for future use. Pass NULL to this parameter
            return:                 [integer!]
        ]
        DAQmxBaseReadBinaryI32: "DAQmxBaseReadBinaryI32" [
            {Reads multiple unscaled, signed 32-bit integer samples from a task that contains one or more analog input channels.}
            TaskHandle              [integer!] 
            numSampsPerChan         [integer!]
            timeout                 [float!]
            fillMode                [integer!] 
            readArray               [pointer![integer!]] ; pointer
            arraySizeInSamps        [integer!]
            sampsPerChanRead        [pointer![integer!]]; pointer ?
            reserved                [pointer![integer!]]; Reserved for future use. Pass NULL to this parameter
            return:                 [integer!]
        ]
        DAQmxBaseReadDigitalU8: "DAQmxBaseReadDigitalU8" [     
            {Reads multiple 8-bit integer samples from a task that one or more multiple digital input channels. 
            Use this function for devices with up to 8 lines per port. The data is returned in unsigned byte format.}
            TaskHandle              [integer!]
            numSampsPerChan         [integer!]
            timeout                 [float!]
            fillMode                [integer!] 
            readArray               [pointer![integer!]]; pointer to val array
            arraySizeInSamps        [integer!]
            sampsPerChanRead        [pointer![integer!]]; pointer ?
            reserved                [pointer![integer!]]; Reserved for future use. Pass NULL to this parameter
            return:                 [integer!]
        ]
        DAQmxBaseReadDigitalU32: "DAQmxBaseReadDigitalU32" [
            {Reads multiple 32-bit integer samples from a task that contains one or more digital input channels. 
            Use this return type for devices with up to 32 lines per port. The data is returned in unsigned integer format.}
            TaskHandle              [integer!]
            numSampsPerChan         [integer!]
            timeout                 [float!]
            fillMode                [integer!] 
            readArray               [pointer![integer!]] ;pointer to val array
            arraySizeInSamps        [integer!]
            sampsPerChanRead        [pointer![integer!]]; pointer ?
            reserved                [pointer![integer!]]; Reserved for future use. Pass NULL to this parameter
            return:                 [integer!]
        ]
        DAQmxBaseReadDigitalScalarU32: "DAQmxBaseReadDigitalScalarU32" [
            {Reads a single 32-bit integer sample from a task that contains a single digital input channel. 
            Use this return type for devices with up to 32 lines per port. 
            The data is returned in unsigned integer format.}
            TaskHandle              [integer!]
            timeout                 [float!] 
            value                   [integer!] ; pointer to value
            reserved                [pointer! [integer!]]; Reserved for future use. Pass NULL to this parameter
            return:                 [integer!]
        ]
        DAQmxBaseReadCounterF64: "DAQmxBaseReadCounterF64" [
            {Reads multiple floating-point samples from a counter task. 
            Use this function when counter samples are scaled to a floating-point value, such as for frequency and period measurements.}
            TaskHandle              [integer!]
            numSampsPerChan         [integer!]
            timeout                 [float!]
            readArray               [pointer! [integer!]]; pointer to val
            arraySizeInSamps        [integer!]
            sampsPerChanRead        [pointer! [integer!]]; pointer
            reserved                [pointer! [integer!]]; pointer Reserved for future use. Pass NULL to this parameter
            return:                 [integer!]
        ]
        DAQmxBaseReadCounterU32: "DAQmxBaseReadCounterU32" [
            {Reads multiple 32-bit integer samples from a counter task. 
            Use this function when counter samples are returned unscaled, such as for edge counting.}
            TaskHandle              [integer!]
            numSampsPerChan         [integer!]
            timeout                 [float!]
            readArray               [pointer! [integer!]]; pointer
            arraySizeInSamps        [integer!]
            sampsPerChanRead        [pointer! [integer!]]; pointer
            reserved                [pointer! [integer!]]; pointer Reserved for future use. Pass NULL to this parameter
            return:                 [integer!]
        ]
        DAQmxBaseReadCounterScalarF64: "DAQmxBaseReadCounterScalarF64" [
            {Reads a single floating-point sample from a counter task. 
            Use this function when the counter sample is scaled to a floating-point value, such as for frequency and period measurement.}
            TaskHandle [integer!]
            timeout                 [float!] 
            value                   [float!] ; use a pointer to a decimal value 
	    reserved                [pointer! [integer!]] ;
            return:                 [integer!]
        ]
        DAQmxBaseReadCounterScalarU32: "DAQmxBaseReadCounterScalarU32" [
            {Reads a 32-bit integer sample from a counter task. 
            Use this function when the counter sample is returned unscaled, such as for edge counting.}
            TaskHandle              [integer!]
            timeout                 [float!] 
            value                   [integer!]; pointer to a single 32-bit value 
	    reserved                [pointer! [integer!]] ;
            return:                 [integer!]
        ]
        
        ;******************************************************
        ;***                 Write Data                     ***
        ;******************************************************
        
        DAQmxBaseWriteAnalogF64: "DAQmxBaseWriteAnalogF64" [
            {Writes multiple floating-point samples to a task that contains one or more analog output channels.}
            TaskHandle              [integer!]
            numSampsPerChan         [integer!]
            autoStart               [integer!]; 0: false
            timeout                 [float!] 
            dataLayout              [integer!]
            writeArray              [pointer! [integer!]] ;pointer The array of 64-bit samples to write to the task
            sampsPerChanWritten     [pointer! [integer!]] ; pointer
            reserved                [pointer! [integer!]]; null
            return:                 [integer!]
        ]
        
        DAQmxBaseWriteDigitalU8: "DAQmxBaseWriteDigitalU8" [
            {Writes multiple eight-bit unsigned integer samples to a task that contains one or more digital output channels. 
            Use this format for devices with up to 8 lines per port.
            Note: Buffered writes require a minimum buffer size of two samples.}
            TTaskHandle             [integer!] 
            numSampsPerChan         [integer!]
            autoStart               [integer!]
            timeout                 [float!] 
            dataLayout              [integer!]
            writeArray              [pointer! [integer!]] ; pointer The array of 8-bit integer samples to write to the task.
            sampsPerChanWritten     [pointer! [integer!]] ; pointer
            reserved                [pointer! [integer!]]; null
            return:                 [integer!]
        ]
        DAQmxBaseWriteDigitalU32: "DAQmxBaseWriteDigitalU32" [
            {Writes multiple 32-bit unsigned integer samples to a task that contains one or more digital output channels. 
            Use this format for devices with up to 32 lines per port.
            Note: Buffered writes require a minimum buffer size of 2 samples.}
            TaskHandle              [integer!]
            numSampsPerChan         [integer!]
            autoStart               [integer!]
            timeout                 [float!] 
            dataLayout              [integer!]
            writeArray[pointer!     [integer!]] ; pointer The array of 32-bit integer samples to write to the task.
            sampsPerChanWritten     [pointer! [integer!]] ; pointer
            reserved                [pointer! [integer!]]; null
            return:                 [integer!]
        ]
        DAQmxBaseWriteDigitalScalarU32: "DAQmxBaseWriteDigitalScalarU32" [
            {Writes a single 32-bit unsigned integer sample to a task that contains a single digital output channel. 
            Use this format for devices with up to 32 lines per port. Useful for static digital tasks only.}
            TaskHandle              [integer!]
            autoStart               [integer!]
            timeout                 [float!] 
            value                   [integer!] ; A 32-bit integer sample to write to the task
            reserved                [pointer! [integer!]]; null
            return:                 [integer!]
        ]
        DAQmxBaseGetWriteAttribute: "DAQmxBaseGetWriteAttribute" [
            {Undocumented; must be tested for void}
            TaskHandle              [integer!]
            attribute               [integer!]
            value                   [pointer! [byte!]] ; void pointer
            return:                 [integer!]
        ]
        
        DAQmxBaseSetWriteAttribute: "DAQmxBaseSetWriteAttribute" [
            {Undocumented}
            TaskHandle              [integer!]
            attribute               [integer!]
            value                   [integer!] ;int
            return:                 [integer!]
        ]
        
        ;******************************************************
        ;***               Events & Signals                 ***
        ;******************************************************

        DAQmxBaseExportSignal: "DAQmxBaseExportSignal"  [
            {Routes a control signal to the specified terminal. 
            The output terminal can reside on the device that generates the control signal or on a different device. 
            Use this function to share clocks and triggers between multiple tasks and devices. 
            The routes created by this function are task-based routes.}
            TaskHandle              [integer!]
            signalID                [integer!]
            outputTerminal          [c-string!]
            return:                 [integer!]
        ]
        
        ;******************************************************
        ;***              Scale Configurations              ***
        ;******************************************************
        ;not in the base version

        ;******************************************************
        ;***             Buffer Configurations              ***
        ;******************************************************

        DAQmxBaseCfgInputBuffer: "DAQmxBaseCfgInputBuffer" [
            {Overrides the automatic input buffer allocation that NI-DAQmx Base performs.}
            TaskHandle              [integer!]
            numSampsPerChan         [integer!]
            return:                 [integer!]
        ]
        ;******************************************************
        ;***                Switch Functions                ***
        ;******************************************************
        ; see  Switch Topologies
        ;******************************************************
        ;***                Signal Routing                  ***
        ;******************************************************
        ;not in the base version


        ;******************************************************
        ;***                Device Control                  ***
        ;******************************************************
        DAQmxBaseResetDevice: "DAQmxBaseResetDevice" [
            {Immediately aborts all tasks associated with a device and returns the device to an initialized state. 
            Aborting a task stops and releases any resources the task reserved.}
            deviceName              [c-string!]
            return:                 [integer!]
        ]
        ;******************************************************
        ;***              Watchdog Timer                    ***
        ;******************************************************
        ;not in the base version 

        ;******************************************************
        ;***                Calibration                     ***
        ;******************************************************
        ;not in the base version 

        ;******************************************************
        ;***              System Configuration              ***
        ;******************************************************

        ;not in the base version

        ;******************************************************/
        ;***                 Error Handling                 ***/
        ;******************************************************/
        
        ; this function  must be improved in order to use wit Red/System
         
        DAQmxBaseGetExtendedErrorInfo: "DAQmxBaseGetExtendedErrorInfo" [
            {Returns dynamic, specific error information. 
            This function is valid only for the last function that failed; additional NI-DAQmxBase calls may invalidate this information.}
            errorString         [c-string!]
            bufferSize          [integer!]
            return:             [integer!]
        ]
        
        ;******************************************************************************
        ; *** NI-DAQmxBase Specific Attribute Get/Set/Reset Function Declarations *****
        ;******************************************************************************

        DAQmxBaseGetDevSerialNum: "DAQmxBaseGetDevSerialNum" [
            device		[c-string!]
            *data		[pointer![integer!]]; pointer
            return:             [integer!]
        ] 
     ]
] ; end of import 

