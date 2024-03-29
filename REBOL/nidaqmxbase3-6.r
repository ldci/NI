#! /usr/bin/rebol -qs
REBOL [
title: "National Instruments Rebol Wrapper"
date: 11-Feb-2013
file: %nidaqmax.r
version: "3.6"
author: "Francois Jouen (ldci)"
Purpose: {A wrapper allowing to use National Instrument DAQmx base (3.6) library with Rebol}
Comment: {Mainly tested on MacOSX. The wrapper should work on Linux and Windows}
email: Francois.Jouen@ephe.sorbonne.fr
library: [
        level: 'advanced 
        platform: 'all 
        type: 'tool 
        domain: [] 
        tested-under: view 2.7.6 on [Mac OSX] 
        support: none 
        license: "BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt"
 		see-also: none
    ]
]



; we need some Rebol functions

Get-Os: func [
		"Return Operating System we are using " ] 
[ 
	switch system/version/4 [
		3 [os: "Windows" ]
		2 [os: "MacOSX" ]
		4 [os: "Linux" ]
		5 [os: "BeOS" ]
		7 [os: "NetBSD"]
		9 [os: "OpenBSD"]
		10 [os: "SunSolaris"]
	]
	return os
]

loaded-lib: false



tmp: Get-Os


switch/default  tmp [
	"MacOSX" [lib-file:  to-local-file "/Library/Frameworks/nidaqmxbase.framework/nidaqmxbase"]
	"Windows" [lib-file:  to-local-file "/c/windows/system32/nidaqmxbase.dll"]
	"Linux" []; ; please, document library path
	]
	[Alert "Sorry! This operating system is not yet supported!" Quit]

; loading the library according to the OS
if error? try [libni: load/library to-file lib-file loaded-lib: true][
		   alert join "Error in loading " lib-file
		   quit
]
; OK we can work now
if loaded-lib [recycle/off ; no automatic memory managment by Rebol
]

freeLib: does [
	if loaded-lib [free libni recycle/on]

]

; all parameters are in integer format: 
;better than issue type for rebol memory  as stressed out by Guest2

;******************************************************************************
;*** NI-DAQmx Attributes ******************************************************
;******************************************************************************

;********** Calibration Info Attributes **********

DAQmx_SelfCal_Supported: 				6240 ; Indicates whether the device supports self calibration. 
DAQmx_SelfCal_LastTemp: 				6244 ; Indicates in degrees Celsius the temperature of the device at the time of the last self calibration. Compare this temperature to the current onboard temperature to determine if you should perform another calibration. 
DAQmx_ExtCal_RecommendedInterval: 		6248 ; Indicates in months the National Instruments recommended interval between each external calibration of the device. 
DAQmx_ExtCal_LastTemp: 					6247 ; Indicates in degrees Celsius the temperature of the device at the time of the last external calibration. Compare this temperature to the current onboard temperature to determine if you should perform another calibration. 
DAQmx_Cal_UserDefinedInfo: 				6241 ; Specifies a string that contains arbitrary, user-defined information. This number of characters in this string can be no more than Max Size. 
DAQmx_Cal_UserDefinedInfo_MaxSize: 		6428 ; Indicates the maximum length in characters of Information. 

;********** Channel Attributes **********

DAQmx_ChanType: 						6271 ; Indicates the type of the virtual channel. 
DAQmx_PhysicalChanName: 				6389 ; Indicates the name of the physical channel upon which this virtual channel is based. 
DAQmx_ChanDescr: 						6438 ; Specifies a user-defined description for the channel. 
DAQmx_AI_Max: 							6109 ; Specifies the maximum value you expect to measure. This value is in the units you specify with a units property. When you query this property, it returns the coerced maximum value that the device can measure with the current settings. 
DAQmx_AI_Min: 							6110 ; Specifies the minimum value you expect to measure. This value is in the units you specify with a units property. When you query this property, it returns the coerced minimum value that the device can measure with the current settings. 
DAQmx_AI_CustomScaleName: 				6112 ; Specifies the name of a custom scale for the channel. 
DAQmx_AI_MeasType: 						1685 ; Indicates the measurement to take with the analog input channel and in some cases, such as for temperature measurements, the sensor to use. 
DAQmx_AI_Voltage_Units: 				4244 ; Specifies the units to use to return voltage measurements from the channel. 
DAQmx_AI_Temp_Units: 					4147 ; Specifies the units to use to return temperature measurements from the channel. 
DAQmx_AI_Thrmcpl_Type: 					4176 ; Specifies the type of thermocouple connected to the channel. Thermocouple types differ in composition and measurement range. 
DAQmx_AI_Thrmcpl_CJCSrc: 				4149 ; Indicates the source of cold-junction compensation. 
DAQmx_AI_Thrmcpl_CJCVal: 				4150 ; Specifies the temperature of the cold junction if CJC Source isDAQmx_Val_ConstVal. Specify this value in the units of the measurement. 
DAQmx_AI_Thrmcpl_CJCChan: 				4148 ; Indicates the channel that acquires the temperature of the cold junction if CJC Source isDAQmx_Val_Chan. If the channel does not use a custom scale, NI-DAQmx uses the correct units. If the channel uses a custom scale, the pre-scaled units of the channel must be degrees Celsius. 
DAQmx_AI_RTD_Type: 						4146 ; Specifies the type of RTD connected to the channel. 
DAQmx_AI_RTD_R0: 						4144 ; Specifies in ohms the sensor resistance at 0 deg C. The Callendar-Van Dusen equation requires this value. Refer to the sensor documentation to determine this value. 
DAQmx_AI_RTD_A: 						4112 ; Specifies the 'A' constant of the Callendar-Van Dusen equation. NI-DAQmx requires this value when you use a custom RTD. 
DAQmx_AI_RTD_B: 						4113 ; Specifies the 'B' constant of the Callendar-Van Dusen equation. NI-DAQmx requires this value when you use a custom RTD. 
DAQmx_AI_RTD_C: 						4115 ; Specifies the 'C' constant of the Callendar-Van Dusen equation. NI-DAQmx requires this value when you use a custom RTD. 
DAQmx_AI_Thrmstr_A: 					6345 ; Specifies the 'A' constant of the Steinhart-Hart thermistor equation. 
DAQmx_AI_Thrmstr_B: 					6347 ; Specifies the 'B' constant of the Steinhart-Hart thermistor equation. 
DAQmx_AI_Thrmstr_C: 					6346 ; Specifies the 'C' constant of the Steinhart-Hart thermistor equation. 
DAQmx_AI_Thrmstr_R1: 					4193 ; Specifies in ohms the value of the reference resistor if you use voltage excitation. NI-DAQmx ignores this value for current excitation. 
DAQmx_AI_ForceReadFromChan: 			6392 ; Specifies whether to read from the channel if it is a cold-junction compensation channel. By default, an NI-DAQmx Read function does not return data from cold-junction compensation channels. Setting this property to TRUE forces read operations to return the cold-junction compensation channel data with the other channels in the task. 
DAQmx_AI_Current_Units: 				1793 ; Specifies the units to use to return current measurements from the channel. 
DAQmx_AI_Strain_Units: 					2433 ; Specifies the units to use to return strain measurements from the channel. 
DAQmx_AI_StrainGage_GageFactor: 		2452 ; Specifies the sensitivity of the strain gage. Gage factor relates the change in electrical resistance to the change in strain. Refer to the sensor documentation for this value. 
DAQmx_AI_StrainGage_PoissonRatio: 		2456 ; Specifies the ratio of lateral strain to axial strain in the material you are measuring. 
DAQmx_AI_StrainGage_Cfg: 				2434 ; Specifies the bridge configuration of the strain gages. 
DAQmx_AI_Resistance_Units: 				2389 ; Specifies the units to use to return resistance measurements. 
DAQmx_AI_Freq_Units: 					2054 ; Specifies the units to use to return frequency measurements from the channel. 
DAQmx_AI_Freq_ThreshVoltage: 			2069 ; Specifies the voltage level at which to recognize waveform repetitions. You should select a voltage level that occurs only once within the entire period of a waveform. You also can select a voltage that occurs only once while the voltage rises or falls. 
DAQmx_AI_Freq_Hyst: 					2068 ; Specifies in volts a window below Threshold Level. The input voltage must pass below Threshold Level minus this value before NI-DAQmx recognizes a waveform repetition at Threshold Level. Hysteresis can improve the measurement accuracy when the signal contains noise or jitter. 
DAQmx_AI_LVDT_Units: 					2320 ; Specifies the units to use to return linear position measurements from the channel. 
DAQmx_AI_LVDT_Sensitivity: 				2361 ; Specifies the sensitivity of the LVDT. This value is in the units you specify with Sensitivity Units. Refer to the sensor documentation to determine this value. 
DAQmx_AI_LVDT_SensitivityUnits: 		8602 ; Specifies the units of Sensitivity. 
DAQmx_AI_RVDT_Units: 					2167 ; Specifies the units to use to return angular position measurements from the channel. 
DAQmx_AI_RVDT_Sensitivity: 				2307 ; Specifies the sensitivity of the RVDT. This value is in the units you specify with Sensitivity Units. Refer to the sensor documentation to determine this value. 
DAQmx_AI_RVDT_SensitivityUnits: 		8603 ; Specifies the units of Sensitivity. 
DAQmx_AI_Accel_Units: 					1651 ; Specifies the units to use to return acceleration measurements from the channel. 
DAQmx_AI_Accel_Sensitivity: 			1682 ; Specifies the sensitivity of the accelerometer. This value is in the units you specify with Sensitivity Units. Refer to the sensor documentation to determine this value. 
DAQmx_AI_Accel_SensitivityUnits: 		8604 ; Specifies the units of Sensitivity. 
DAQmx_AI_Coupling: 						100 ; Specifies the coupling for the channel. 
DAQmx_AI_Impedance: 					98 ; Specifies the input impedance of the channel. 
DAQmx_AI_TermCfg: 						4247 ; Specifies the terminal configuration for the channel. 
DAQmx_AI_ResistanceCfg: 				6273 ; Specifies the resistance configuration for the channel. NI-DAQmx uses this value for any resistance-based measurements, including temperature measurement using a thermistor or RTD. 
DAQmx_AI_LeadWireResistance: 			6126 ; Specifies in ohms the resistance of the wires that lead to the sensor. 
DAQmx_AI_Bridge_Cfg: 					135 ; Specifies the type of Wheatstone bridge that the sensor is. 
DAQmx_AI_Bridge_NomResistance: 			6124 ; Specifies in ohms the resistance across each arm of the bridge in an unloaded position. 
DAQmx_AI_Bridge_InitialVoltage: 		6125 ; Specifies in volts the output voltage of the bridge in the unloaded condition. NI-DAQmx subtracts this value from any measurements before applying scaling equations. 
DAQmx_AI_Bridge_ShuntCal_Enable: 		148 ; Specifies whether to enable a shunt calibration switch. Use Shunt Cal Select to select the switch(es) to enable. 
DAQmx_AI_Bridge_ShuntCal_Select: 		8661 ; Specifies which shunt calibration switch(es) to enable. Use Shunt Cal Enable to enable the switch(es) you specify with this property. 
DAQmx_AI_Bridge_ShuntCal_GainAdjust: 	6463 ; Specifies the result of a shunt calibration. NI-DAQmx multiplies data read from the channel by the value of this property. This value should be close to 1.0. 
DAQmx_AI_Bridge_Balance_CoarsePot: 		6129 ; Specifies by how much to compensate for off in the signal. This value can be between 0 and 127. 
DAQmx_AI_Bridge_Balance_FinePot: 		6388 ; Specifies by how much to compensate for off in the signal. This value can be between 0 and 4095. 
DAQmx_AI_CurrentShunt_Loc: 				6130 ; Specifies the shunt resistor location for current measurements. 
DAQmx_AI_CurrentShunt_Resistance: 		6131 ; Specifies in ohms the external shunt resistance for current measurements. 
DAQmx_AI_Excit_Src: 					6132 ; Specifies the source of excitation. 
DAQmx_AI_Excit_Val: 					6133 ; Specifies the amount of excitation that the sensor requires. If Voltage or Current is DAQmx_Val_Voltage, this value is in volts. If Voltage or Current is DAQmx_Val_Current, this value is in amperes. 
DAQmx_AI_Excit_UseForScaling: 			6140 ; Specifies if NI-DAQmx divides the measurement by the excitation. You should typically this property to TRUE for ratiometric transducers. If you this property to TRUE, Maximum Value and Minimum Value to reflect the scaling. 
DAQmx_AI_Excit_UseMultiplexed: 			8576 ; Specifies if the SCXI-1122 multiplexes the excitation to the upper half of the channels as it advances through the scan list. 
DAQmx_AI_Excit_ActualVal: 				6275 ; Specifies the actual amount of excitation supplied by an internal excitation source. If you read an internal excitation source more precisely with an external device, this property to the value you read. NI-DAQmx ignores this value for external excitation. 
DAQmx_AI_Excit_DCorAC: 					6139 ; Specifies if the excitation supply is DC or AC. 
DAQmx_AI_Excit_VoltageOrCurrent: 		6134 ; Specifies if the channel uses current or voltage excitation. 
DAQmx_AI_ACExcit_Freq: 					257 ; Specifies the AC excitation frequency in Hertz. 
DAQmx_AI_ACExcit_SyncEnable: 			258 ; Specifies whether to synchronize the AC excitation source of the channel to that of another channel. Synchronize the excitation sources of multiple channels to use multichannel sensors. this property to FALSE for the master channel and to TRUE for the slave channels. 
DAQmx_AI_ACExcit_WireMode: 				6349 ; Specifies the number of leads on the LVDT or RVDT. Some sensors require you to tie leads together to create a four- or five- wire sensor. Refer to the sensor documentation for more information. 
DAQmx_AI_Atten: 						6145 ; Specifies the amount of attenuation to use. 
DAQmx_AI_Lowpass_Enable: 				6146 ; Specifies whether to enable the lowpass filter of the channel. 
DAQmx_AI_Lowpass_CutoffFreq: 			6147 ; Specifies the frequency in Hertz that corresponds to the -3dB cutoff of the filter. 
DAQmx_AI_Lowpass_SwitchCap_ClkSrc: 		6276 ; Specifies the source of the filter clock. If you need a higher resolution for the filter, you can supply an external clock to increase the resolution. Refer to the SCXI-1141/1142/1143 User Manual for more information. 
DAQmx_AI_Lowpass_SwitchCap_ExtClkFreq: 	6277 ; Specifies the frequency of the external clock when you Clock Source toDAQmx_Val_External. NI-DAQmx uses this frequency to the pre- and post- filters on the SCXI-1141, SCXI-1142, and SCXI-1143. On those devices, NI-DAQmx determines the filter cutoff by using the equation f/(100*n), where f is the external frequency, and n is the external clock divisor. Refer to the SCXI-1141/1142/1143 User Manual for more... 
DAQmx_AI_Lowpass_SwitchCap_ExtClkDiv: 	6278 ; Specifies the divisor for the external clock when you Clock Source toDAQmx_Val_External. On the SCXI-1141, SCXI-1142, and SCXI-1143, NI-DAQmx determines the filter cutoff by using the equation f/(100*n), where f is the external frequency, and n is the external clock divisor. Refer to the SCXI-1141/1142/1143 User Manual for more information. 
DAQmx_AI_Lowpass_SwitchCap_OutClkDiv: 	6279 ; Specifies the divisor for the output clock. NI-DAQmx uses the cutoff frequency to determine the output clock frequency. Refer to the SCXI-1141/1142/1143 User Manual for more information. 
DAQmx_AI_ResolutionUnits: 				5988 ; Indicates the units of Resolution Value. 
DAQmx_AI_Resolution: 					5989 ; Indicates the resolution of the analog-to-digital converter of the channel. This value is in the units you specify with Resolution Units. 
DAQmx_AI_Dither_Enable: 				104 ; Specifies whether to enable dithering. Dithering adds Gaussian noise to the input signal. You can use dithering to achieve higher resolution measurements by over sampling the input signal and averaging the results. 
DAQmx_AI_Rng_High: 						6165 ; Specifies the upper limit of the input range of the device. This value is in the native units of the device. On E Series devices, for example, the native units is volts. 
DAQmx_AI_Rng_Low: 						6166 ; Specifies the lower limit of the input range of the device. This value is in the native units of the device. On E Series devices, for example, the native units is volts. 
DAQmx_AI_Gain: 							6168 ; Specifies a gain factor to apply to the channel. 
DAQmx_AI_SampAndHold_Enable: 			6170 ; Specifies whether to enable the sample and hold circuitry of the device. When you disable sample and hold circuitry, a small voltage off might be introduced into the signal. You can eliminate this off by using Auto Zero Mode to perform an auto zero on the channel. 
DAQmx_AI_AutoZeroMode: 					5984 ; Specifies when to measure ground. NI-DAQmx subtracts the measured ground voltage from every sample. 
DAQmx_AI_DataXferMech: 					6177 ; Specifies the data transfer mode for the device. 
DAQmx_AI_DataXferReqCond: 				6283 ; Specifies under what condition to transfer data from the onboard memory of the device to the buffer. 
DAQmx_AI_MemMapEnable: 					6284 ; Specifies for NI-DAQmx to map hardware registers to the memory space of the customer process, if possible. Mapping to the memory space of the customer process increases performance. However, memory mapping can adversely affect the operation of the device and possibly result in a system crash if software in the process unintentionally accesses the mapped registers. 
DAQmx_AI_DevScalingCoeff: 				6448 ; Indicates the coefficients of a polynomial equation that NI-DAQmx uses to scale values from the native format of the device to volts. Each element of the array corresponds to a term of the equation. For example, if index two of the array is 4, the third term of the equation is 4x^2. Scaling coefficients do not account for any custom scales or sensors contained by the channel. 
DAQmx_AO_Max: 							4486 ; Specifies the maximum value you expect to generate. The value is in the units you specify with a units property. If you try to write a value larger than the maximum value, NI-DAQmx generates an error. NI-DAQmx might coerce this value to a smaller value if other task settings restrict the device from generating the desired maximum. 
DAQmx_AO_Min: 							4487 ; Specifies the minimum value you expect to generate. The value is in the units you specify with a units property. If you try to write a value smaller than the minimum value, NI-DAQmx generates an error. NI-DAQmx might coerce this value to a larger value if other task settings restrict the device from generating the desired minimum. 
DAQmx_AO_CustomScaleName: 				4488 ; Specifies the name of a custom scale for the channel. 
DAQmx_AO_OutputType: 					4360 ; Indicates whether the channel generates voltage or current. 
DAQmx_AO_Voltage_Units: 				4484 ; Specifies in what units to generate voltage on the channel. Write data to the channel in the units you select. 
DAQmx_AO_Current_Units: 				4361 ; Specifies in what units to generate current on the channel. Write data to the channel is in the units you select. 
DAQmx_AO_OutputImpedance: 				5264 ; Specifies in ohms the impedance of the analog output stage of the device. 
DAQmx_AO_LoadImpedance: 				289 ; Specifies in ohms the load impedance connected to the analog output channel. 
DAQmx_AO_ResolutionUnits: 				6187 ; Specifies the units of Resolution Value. 
DAQmx_AO_Resolution: 					6188 ; Indicates the resolution of the digital-to-analog converter of the channel. This value is in the units you specify with Resolution Units. 
DAQmx_AO_DAC_Rng_High: 					6190 ; Specifies the upper limit of the output range of the device. This value is in the native units of the device. On E Series devices, for example, the native units is volts. 
DAQmx_AO_DAC_Rng_Low: 					6189 ; Specifies the lower limit of the output range of the device. This value is in the native units of the device. On E Series devices, for example, the native units is volts. 
DAQmx_AO_DAC_Ref_ConnToGnd: 			304 ; Specifies whether to ground the internal DAC reference. Grounding the internal DAC reference has the effect of grounding all analog output channels and stopping waveform generation across all analog output channels regardless of whether the channels belong to the current task. You can ground the internal DAC reference only when Source isDAQmx_Val_Internal and Allow Connecting DAC Reference to Ground at Runtime is... 
DAQmx_AO_DAC_Ref_AllowConnToGnd: 		6192 ; Specifies whether to allow grounding the internal DAC reference at run time. You must this property to TRUE and Source toDAQmx_Val_Internal before you can Connect DAC Reference to Ground to TRUE. 
DAQmx_AO_DAC_Ref_Src: 					306 ; Specifies the source of the DAC reference voltage. The value of this voltage source determines the full-scale value of the DAC. 
DAQmx_AO_DAC_Ref_Val: 					6194 ; Specifies in volts the value of the DAC reference voltage. This voltage determines the full-scale range of the DAC. Smaller reference voltages result in smaller ranges, but increased resolution. 
DAQmx_AO_ReglitchEnable: 				307 ; Specifies whether to enable reglitching. The output of a DAC normally glitches whenever the DAC is updated with a new value. The amount of glitching differs from code to code and is generally largest at major code transitions. Reglitching generates uniform glitch energy at each code transition and provides for more uniform glitches. Uniform glitch energy makes it easier to filter out the noise introduced from g... 
DAQmx_AO_UseOnlyOnBrdMem: 				6202 ; Specifies whether to write samples directly to the onboard memory of the device, bypassing the memory buffer. Generally, you cannot update onboard memory after you start the task. Onboard memory includes data FIFOs. 
DAQmx_AO_DataXferMech: 					308 ; Specifies the data transfer mode for the device. 
DAQmx_AO_DataXferReqCond: 				6204 ; Specifies under what condition to transfer data from the buffer to the onboard memory of the device. 
DAQmx_AO_MemMapEnable: 					6287 ; Specifies if NI-DAQmx maps hardware registers to the memory space of the customer process, if possible. Mapping to the memory space of the customer process increases performance. However, memory mapping can adversely affect the operation of the device and possibly result in a system crash if software in the process unintentionally accesses the mapped registers. 
DAQmx_AO_DevScalingCoeff: 				6449 ; Indicates the coefficients of a linear equation that NI-DAQmx uses to scale values from a voltage to the native format of the device. Each element of the array corresponds to a term of the equation. For example, if index two of the array is 4, the third term of the equation is 4x^2. Scaling coefficients do not account for any custom scales that may be applied to the channel. 
DAQmx_DI_InvertLines: 					1939 ; Specifies whether to invert the lines in the channel. If you this property to TRUE, the lines are at high logic when off and at low logic when on. 
DAQmx_DI_NumLines: 						8568 ; Indicates the number of digital lines in the channel. 
DAQmx_DI_DigFltr_Enable: 				8662 ; Specifies whether to enable the digital filter for the line(s) or port(s). You can enable the filter on a line-by-line basis. You do not have to enable the filter for all lines in a channel. 
DAQmx_DI_DigFltr_MinPulseWidth: 		8663 ; Specifies in seconds the minimum pulse width the filter recognizes as a valid high or low state transition. 
DAQmx_DO_InvertLines: 					4403 ; Specifies whether to invert the lines in the channel. If you this property to TRUE, the lines are at high logic when off and at low logic when on. 
DAQmx_DO_NumLines: 						8569 ; Indicates the number of digital lines in the channel. 
DAQmx_DO_Tristate: 						6387 ; Specifies whether to stop driving the channel and it to a Hi-Z state. 
DAQmx_CI_Max: 							6300 ; Specifies the maximum value you expect to measure. This value is in the units you specify with a units property. When you query this property, it returns the coerced maximum value that the hardware can measure with the current settings. 
DAQmx_CI_Min: 							6301 ; Specifies the minimum value you expect to measure. This value is in the units you specify with a units property. When you query this property, it returns the coerced minimum value that the hardware can measure with the current settings. 
DAQmx_CI_CustomScaleName: 				6302 ; Specifies the name of a custom scale for the channel. 
DAQmx_CI_MeasType: 						6304 ; Indicates the measurement to take with the channel. 
DAQmx_CI_Freq_Units: 					6305 ; Specifies the units to use to return frequency measurements. 
DAQmx_CI_Freq_Term: 					6306 ; Specifies the input terminal of the signal to measure. 
DAQmx_CI_Freq_StartingEdge: 			1945 ; Specifies between which edges to measure the frequency of the signal. 
DAQmx_CI_Freq_MeasMeth: 				324 ; Specifies the method to use to measure the frequency of the signal. 
DAQmx_CI_Freq_MeasTime: 				325 ; Specifies in seconds the length of time to measure the frequency of the signal if Method isDAQmx_Val_HighFreq2Ctr. Measurement accuracy increases with increased measurement time and with increased signal frequency. If you measure a high-frequency signal for too long, however, the count register could roll over, which results in an incorrect measurement. 
DAQmx_CI_Freq_Div: 						327 ; Specifies the value by which to divide the input signal if Method isDAQmx_Val_LargeRng2Ctr. The larger the divisor, the more accurate the measurement. However, too large a value could cause the count register to roll over, which results in an incorrect measurement. 
DAQmx_CI_Period_Units: 					6307 ; Specifies the unit to use to return period measurements. 
DAQmx_CI_Period_Term: 					6308 ; Specifies the input terminal of the signal to measure. 
DAQmx_CI_Period_StartingEdge: 			2130 ; Specifies between which edges to measure the period of the signal. 
DAQmx_CI_Period_MeasMeth: 				6444 ; Specifies the method to use to measure the period of the signal. 
DAQmx_CI_Period_MeasTime: 				6445 ; Specifies in seconds the length of time to measure the period of the signal if Method isDAQmx_Val_HighFreq2Ctr. Measurement accuracy increases with increased measurement time and with increased signal frequency. If you measure a high-frequency signal for too long, however, the count register could roll over, which results in an incorrect measurement. 
DAQmx_CI_Period_Div: 					6446 ; Specifies the value by which to divide the input signal if Method isDAQmx_Val_LargeRng2Ctr. The larger the divisor, the more accurate the measurement. However, too large a value could cause the count register to roll over, which results in an incorrect measurement. 
DAQmx_CI_CountEdges_Term: 				6343 ; Specifies the input terminal of the signal to measure. 
DAQmx_CI_CountEdges_Dir: 				1686 ; Specifies whether to increment or decrement the counter on each edge. 
DAQmx_CI_CountEdges_DirTerm: 			8673 ; Specifies the source terminal of the digital signal that controls the count direction if Direction isDAQmx_Val_ExtControlled. 
DAQmx_CI_CountEdges_InitialCnt: 		1688 ; Specifies the starting value from which to count. 
DAQmx_CI_CountEdges_ActiveEdge: 		1687 ; Specifies on which edges to increment or decrement the counter. 
DAQmx_CI_AngEncoder_Units: 				6310 ; Specifies the units to use to return angular position measurements from the channel. 
DAQmx_CI_AngEncoder_PulsesPerRev: 		2165 ; Specifies the number of pulses the encoder generates per revolution. This value is the number of pulses on either signal A or signal B, not the total number of pulses on both signal A and signal B. 
DAQmx_CI_AngEncoder_InitialAngle: 		2177 ; Specifies the starting angle of the encoder. This value is in the units you specify with Units. 
DAQmx_CI_LinEncoder_Units: 				6313 ; Specifies the units to use to return linear encoder measurements from the channel. 
DAQmx_CI_LinEncoder_DistPerPulse: 		2321 ; Specifies the distance to measure for each pulse the encoder generates on signal A or signal B. This value is in the units you specify with Units. 
DAQmx_CI_LinEncoder_InitialPos: 		2325 ; Specifies the position of the encoder when the measurement begins. This value is in the units you specify with Units. 
DAQmx_CI_Encoder_DecodingType: 			8678 ; Specifies how to count and interpret the pulses the encoder generates on signal A and signal B.DAQmx_Val_X1,DAQmx_Val_X2, andDAQmx_Val_X4 are valid for quadrature encoders only.DAQmx_Val_TwoPulseCounting is valid for two-pulse encoders only. 
DAQmx_CI_Encoder_AInputTerm: 			8605 ; Specifies the terminal to which signal A is connected. 
DAQmx_CI_Encoder_BInputTerm: 			8606 ; Specifies the terminal to which signal B is connected. 
DAQmx_CI_Encoder_ZInputTerm: 			8607 ; Specifies the terminal to which signal Z is connected. 
DAQmx_CI_Encoder_ZIndexEnable: 			2192 ; Specifies whether to use Z indexing for the channel. 
DAQmx_CI_Encoder_ZIndexVal: 			2184 ; Specifies the value to which to re the measurement when signal Z is high and signal A and signal B are at the states you specify with Z Index Phase. Specify this value in the units of the measurement. 
DAQmx_CI_Encoder_ZIndexPhase: 			2185 ; Specifies the states at which signal A and signal B must be while signal Z is high for NI-DAQmx to re the measurement. If signal Z is never high while signal A and signal B are high, for example, you must choose a phase other thanDAQmx_Val_AHighBHigh. 
DAQmx_CI_PulseWidth_Units: 				2083 ; Specifies the units to use to return pulse width measurements. 
DAQmx_CI_PulseWidth_Term: 				6314 ; Specifies the input terminal of the signal to measure. 
DAQmx_CI_PulseWidth_StartingEdge: 		2085 ; Specifies on which edge of the input signal to begin each pulse width measurement. 
DAQmx_CI_TwoEdgeSep_Units: 				6316 ; Specifies the units to use to return two-edge separation measurements from the channel. 
DAQmx_CI_TwoEdgeSep_FirstTerm: 			6317 ; Specifies the source terminal of the digital signal that starts each measurement. 
DAQmx_CI_TwoEdgeSep_FirstEdge: 			2099 ; Specifies on which edge of the first signal to start each measurement. 
DAQmx_CI_TwoEdgeSep_SecondTerm: 		6318 ; Specifies the source terminal of the digital signal that stops each measurement. 
DAQmx_CI_TwoEdgeSep_SecondEdge: 		2100 ; Specifies on which edge of the second signal to stop each measurement. 
DAQmx_CI_SemiPeriod_Units: 				6319 ; Specifies the units to use to return semi-period measurements. 
DAQmx_CI_SemiPeriod_Term: 				6320 ; Specifies the input terminal of the signal to measure. 
DAQmx_CI_CtrTimebaseSrc: 				323 ; Specifies the terminal of the timebase to use for the counter. 
DAQmx_CI_CtrTimebaseRate: 				6322 ; Specifies in Hertz the frequency of the counter timebase. Specifying the rate of a counter timebase allows you to take measurements in terms of time or frequency rather than in ticks of the timebase. If you use an external timebase and do not specify the rate, you can take measurements only in terms of ticks of the timebase. 
DAQmx_CI_CtrTimebaseActiveEdge: 		322 ; Specifies whether a timebase cycle is from rising edge to rising edge or from falling edge to falling edge. 
DAQmx_CI_Count: 						328 ; Indicates the current value of the count register. 
DAQmx_CI_OutputState: 					329 ; Indicates the current state of the out terminal of the counter. 
DAQmx_CI_TCReached: 					336 ; Indicates whether the counter rolled over. When you query this property, NI-DAQmx resets it to FALSE. 
DAQmx_CI_CtrTimebaseMasterTimebaseDiv: 	6323 ; Specifies the divisor for an external counter timebase. You can divide the counter timebase in order to measure slower signals without causing the count register to roll over. 
DAQmx_CI_DataXferMech: 					512 ; Specifies the data transfer mode for the channel. 
DAQmx_CI_NumPossiblyInvalidSamps: 		6460 ; Indicates the number of samples that the device might have overwritten before it could transfer them to the buffer. 
DAQmx_CI_DupCountPrevent: 				8620 ; Specifies whether to enable duplicate count prevention for the channel. 
DAQmx_CO_OutputType: 					6325 ; Indicates how to define pulses generated on the channel. 
DAQmx_CO_Pulse_IdleState: 				4464 ; Specifies the resting state of the output terminal. 
DAQmx_CO_Pulse_Term: 					6369 ; Specifies on which terminal to generate pulses. 
DAQmx_CO_Pulse_Time_Units: 				6358 ; Specifies the units in which to define high and low pulse time. 
DAQmx_CO_Pulse_HighTime: 				6330 ; Specifies the amount of time that the pulse is at a high voltage. This value is in the units you specify with Units or when you create the channel. 
DAQmx_CO_Pulse_LowTime: 				6331 ; Specifies the amount of time that the pulse is at a low voltage. This value is in the units you specify with Units or when you create the channel. 
DAQmx_CO_Pulse_Time_InitialDelay: 		6332 ; Specifies in seconds the amount of time to wait before generating the first pulse. 
DAQmx_CO_Pulse_DutyCyc: 				4470 ; Specifies the duty cycle of the pulses. The duty cycle of a signal is the width of the pulse divided by period. NI-DAQmx uses this ratio and the pulse frequency to determine the width of the pulses and the delay between pulses. 
DAQmx_CO_Pulse_Freq_Units: 				6357 ; Specifies the units in which to define pulse frequency. 
DAQmx_CO_Pulse_Freq: 					4472 ; Specifies the frequency of the pulses to generate. This value is in the units you specify with Units or when you create the channel. 
DAQmx_CO_Pulse_Freq_InitialDelay: 		665 ; Specifies in seconds the amount of time to wait before generating the first pulse. 
DAQmx_CO_Pulse_HighTicks: 				4457 ; Specifies the number of ticks the pulse is high. 
DAQmx_CO_Pulse_LowTicks: 				4465 ; Specifies the number of ticks the pulse is low. 
DAQmx_CO_Pulse_Ticks_InitialDelay: 		664 ; Specifies the number of ticks to wait before generating the first pulse. 
DAQmx_CO_CtrTimebaseSrc: 				825 ; Specifies the terminal of the timebase to use for the counter. Typically, NI-DAQmx uses one of the internal counter timebases when generating pulses. Use this property to specify an external timebase and produce custom pulse widths that are not possible using the internal timebases. 
DAQmx_CO_CtrTimebaseRate: 				6338 ; Specifies in Hertz the frequency of the counter timebase. Specifying the rate of a counter timebase allows you to define output pulses in seconds rather than in ticks of the timebase. If you use an external timebase and do not specify the rate, you can define output pulses only in ticks of the timebase. 
DAQmx_CO_CtrTimebaseActiveEdge: 		833 ; Specifies whether a timebase cycle is from rising edge to rising edge or from falling edge to falling edge. 
DAQmx_CO_Count: 						659 ; Indicates the current value of the count register. 
DAQmx_CO_OutputState: 					660 ; Indicates the current state of the output terminal of the counter. 
DAQmx_CO_AutoIncrCnt: 					661 ; Specifies a number of timebase ticks by which to increment each successive pulse. 
DAQmx_CO_CtrTimebaseMasterTimebaseDiv: 	6339 ; Specifies the divisor for an external counter timebase. You can divide the counter timebase in order to generate slower signals without causing the count register to roll over. 
DAQmx_CO_PulseDone: 					6414 ; Indicates if the task completed pulse generation. Use this value for retriggerable pulse generation when you need to determine if the device generated the current pulse. When you query this property, NI-DAQmx resets it to FALSE. 

;********** Export Signal Attributes **********

DAQmx_Exported_AIConvClk_OutputTerm: 			5767 ; Specifies the terminal to which to route the AI Convert Clock. 
DAQmx_Exported_AIConvClk_Pulse_Polarity: 		5768 ; Indicates the polarity of the exported AI Convert Clock. The polarity is fixed and independent of the active edge of the source of the AI Convert Clock. 
DAQmx_Exported_20MHzTimebase_OutputTerm: 		5719 ; Specifies the terminal to which to route the 20MHz Timebase. 
DAQmx_Exported_SampClk_OutputBehavior: 			6251 ; Specifies whether the exported Sample Clock issues a pulse at the beginning of a sample or changes to a high state for the duration of the sample. 
DAQmx_Exported_SampClk_OutputTerm: 				5731 ; Specifies the terminal to which to route the Sample Clock. 
DAQmx_Exported_AdvTrig_OutputTerm: 				5701 ; Specifies the terminal to which to route the Advance Trigger. 
DAQmx_Exported_AdvTrig_Pulse_Polarity: 			5702 ; Indicates the polarity of the exported Advance Trigger. 
DAQmx_Exported_AdvTrig_Pulse_WidthUnits: 		5703 ; Specifies the units of Width Value. 
DAQmx_Exported_AdvTrig_Pulse_Width: 			5704 ; Specifies the width of an exported Advance Trigger pulse. Specify this value in the units you specify with Width Units. 
DAQmx_Exported_RefTrig_OutputTerm: 				1424 ; Specifies the terminal to which to route the Reference Trigger. 
DAQmx_Exported_StartTrig_OutputTerm: 			1412 ; Specifies the terminal to which to route the Start Trigger. 
DAQmx_Exported_AdvCmpltEvent_OutputTerm: 		5713 ; Specifies the terminal to which to route the Advance Complete Event. 
DAQmx_Exported_AdvCmpltEvent_Delay: 			5975 ; Specifies the output signal delay in periods of the sample clock. 
DAQmx_Exported_AdvCmpltEvent_Pulse_Polarity: 	5714 ; Specifies the polarity of the exported Advance Complete Event. 
DAQmx_Exported_AdvCmpltEvent_Pulse_Width: 		5716 ; Specifies the width of the exported Advance Complete Event pulse. 
DAQmx_Exported_AIHoldCmpltEvent_OutputTerm: 	6381 ; Specifies the terminal to which to route the AI Hold Complete Event. 
DAQmx_Exported_AIHoldCmpltEvent_PulsePolarity: 	6382 ; Specifies the polarity of an exported AI Hold Complete Event pulse. 
DAQmx_Exported_ChangeDetectEvent_OutputTerm: 	8599 ; Specifies the terminal to which to route the Change Detection Event. 
DAQmx_Exported_CtrOutEvent_OutputTerm: 			5911 ; Specifies the terminal to which to route the Counter Output Event. 
DAQmx_Exported_CtrOutEvent_OutputBehavior: 		5967 ; Specifies whether the exported Counter Output Event pulses or changes from one state to the other when the counter reaches terminal count. 
DAQmx_Exported_CtrOutEvent_Pulse_Polarity: 		5912 ; Specifies the polarity of the pulses at the output terminal of the counter when Output Behavior isDAQmx_Val_Pulse. NI-DAQmx ignores this property if Output Behavior isDAQmx_Val_Toggle. 
DAQmx_Exported_CtrOutEvent_Toggle_IdleState: 	6250 ; Specifies the initial state of the output terminal of the counter when Output Behavior isDAQmx_Val_Toggle. The terminal enters this state when NI-DAQmx commits the task. 
DAQmx_Exported_WatchdogExpiredEvent_OutputTerm: 8618 ; Specifies the terminal to which to route the Watchdog Timer Expired Event. 

;********** Device Attributes **********
DAQmx_Dev_ProductType: 							1585 ; Indicates the product name of the device. 
DAQmx_Dev_SerialNum: 							1586 ; Indicates the serial number of the device. This value is zero if the device does not have a serial number. 

;********** Read Attributes **********

DAQmx_Read_RelativeTo: 							6410 ; Specifies the point in the buffer at which to begin a read operation. If you also specify an off with Offset, the read operation begins at that off relative to the point you select with this property. The default value isDAQmx_Val_CurrReadPos unless you configure a Reference Trigger for the task. If you configure a Reference Trigger, the default value isDAQmx_Val_FirstPretrigSamp. 
DAQmx_Read_Offset: 								6411 ; Specifies an off in samples per channel at which to begin a read operation. This off is relative to the location you specify with RelativeTo. 
DAQmx_Read_ChannelsToRead: 						6179 ; Specifies a sub of channels in the task from which to read. 
DAQmx_Read_ReadAllAvailSamp: 					4629 ; Specifies whether subsequent read operations read all samples currently available in the buffer or wait for the buffer to become full before reading. NI-DAQmx uses this setting for finite acquisitions and only when the number of samples to read is -1. For continuous acquisitions when the number of samples to read is -1, a read operation always reads all samples currently available in the buffer. 
DAQmx_Read_AutoStart: 							6182 ; Specifies if an NI-DAQmx Read function automatically starts the task if you did not start the task explicitly by usingDAQmxStartTask(). The default value is TRUE. When an NI-DAQmx Read function starts a finite acquisition task, it also stops the task after reading the last sample. 
DAQmx_Read_OverWrite: 							4625 ; Specifies whether to overwrite samples in the buffer that you have not yet read. 
DAQmx_Read_CurrReadPos: 						4641 ; Indicates in samples per channel the current position in the buffer. 
DAQmx_Read_AvailSampPerChan: 					4643 ; Indicates the number of samples available to read per channel. This value is the same for all channels in the task. 
DAQmx_Read_TotalSampPerChanAcquired: 			6442 ; Indicates the total number of samples acquired by each channel. NI-DAQmx returns a single value because this value is the same for all channels. 
DAQmx_Read_ChangeDetect_HasOverflowed: 			8596 ; Indicates if samples were missed because change detection events occurred faster than the device could handle them. 
DAQmx_Read_RawDataWidth: 						8570 ; Indicates in bytes the size of a raw sample from the task. 
DAQmx_Read_NumChans: 							8571 ; Indicates the number of channels that an NI-DAQmx Read function reads from the task. This value is the number of channels in the task or the number of channels you specify with Channels to Read. 
DAQmx_Read_DigitalLines_BytesPerChan: 			8572 ; Indicates the number of bytes per channel that NI-DAQmx returns in a sample for line-based reads. If a channel has fewer lines than this number, the extra bytes are FALSE. 

;********** Switch Channel Attributes **********

DAQmx_SwitchChan_Usage: 						6372 ; Specifies how you can use the channel. Using this property acts as a safety mechanism to prevent you from connecting two source channels, for example. 
DAQmx_SwitchChan_MaxACCarryCurrent: 			1608 ; Indicates in amperes the maximum AC current that the device can carry. 
DAQmx_SwitchChan_MaxACSwitchCurrent: 			1606 ; Indicates in amperes the maximum AC current that the device can switch. This current is always against an RMS voltage level. 
DAQmx_SwitchChan_MaxACCarryPwr: 				1602 ; Indicates in watts the maximum AC power that the device can carry. 
DAQmx_SwitchChan_MaxACSwitchPwr: 				1604 ; Indicates in watts the maximum AC power that the device can switch. 
DAQmx_SwitchChan_MaxDCCarryCurrent: 			1607 ; Indicates in amperes the maximum DC current that the device can carry. 
DAQmx_SwitchChan_MaxDCSwitchCurrent: 			1605 ; Indicates in amperes the maximum DC current that the device can switch. This current is always against a DC voltage level. 
DAQmx_SwitchChan_MaxDCCarryPwr: 				1603 ; Indicates in watts the maximum DC power that the device can carry. 
DAQmx_SwitchChan_MaxDCSwitchPwr: 				1609 ; Indicates in watts the maximum DC power that the device can switch. 
DAQmx_SwitchChan_MaxACVoltage: 					1617 ; Indicates in volts the maximum AC RMS voltage that the device can switch. 
DAQmx_SwitchChan_MaxDCVoltage: 					1616 ; Indicates in volts the maximum DC voltage that the device can switch. 
DAQmx_SwitchChan_WireMode: 						6373 ; Indicates the number of wires that the channel switches. 
DAQmx_SwitchChan_Bandwidth: 					1600 ; Indicates in Hertz the maximum frequency of a signal that can pass through the switch without significant deterioration. 
DAQmx_SwitchChan_Impedance: 					1601 ; Indicates in ohms the switch impedance. This value is important in the RF domain and should match the impedance of the sources and loads. 

;********** Switch Device Attributes **********

DAQmx_SwitchDev_SettlingTime: 					4676 ; Specifies in seconds the amount of time to wait for the switch to settle (or debounce). Refer to device documentation for supported settling times. 
DAQmx_SwitchDev_AutoConnAnlgBus: 				6106 ; Specifies if NI-DAQmx routes multiplexed channels to the analog bus backplane. Only the SCXI-1127 and SCXI-1128 support this property. 
DAQmx_SwitchDev_Settled: 						4675 ; Indicates when Settling Time expires. 
DAQmx_SwitchDev_RelayList: 						6108 ; Indicates a comma-delimited list of relay names. 
DAQmx_SwitchDev_NumRelays: 						6374 ; Indicates the number of relays on the device. This value matches the number of relay names in Relay List. 
DAQmx_SwitchDev_SwitchChanList: 				6375 ; Indicates a comma-delimited list of channel names for the current topology of the device. 
DAQmx_SwitchDev_NumSwitchChans:					6376 ; Indicates the number of switch channels for the current topology of the device. This value matches the number of channel names in Switch Channel List. 
DAQmx_SwitchDev_NumRows: 						6377 ; Indicates the number of rows on a device in a matrix switch topology. Indicates the number of multiplexed channels on a device in a mux topology. 
DAQmx_SwitchDev_NumColumns: 					6378 ; Indicates the number of columns on a device in a matrix switch topology. This value is always 1 if the device is in a mux topology. 
DAQmx_SwitchDev_Topology: 						6461 ; Indicates the current topology of the device. This value is one of the topology options inDAQmxSwitchSetTopologyAndReset(). 

;********** Switch Scan Attributes **********

DAQmx_SwitchScan_BreakMode: 					4679 ; Specifies the break mode between each entry in a scan list. 
DAQmx_SwitchScan_RepeatMode: 					4680 ; Specifies if the task advances through the scan list multiple times. 
DAQmx_SwitchScan_WaitingForAdv: 				6105 ; Indicates if the switch hardware is waiting for an Advance Trigger. If the hardware is waiting, it completed the previous entry in the scan list. 

;********** Scale Attributes **********

DAQmx_Scale_Descr: 								4646 ; Specifies a description for the scale. 
DAQmx_Scale_ScaledUnits: 						6427 ; Specifies the units to use for scaled values. You can use an arbitrary string. 
DAQmx_Scale_PreScaledUnits: 					6391 ; Specifies the units of the values that you want to scale. 
DAQmx_Scale_Type: 								6441 ; Indicates the method or equation form that the custom scale uses. 
DAQmx_Scale_Lin_Slope: 							4647 ; Specifies the slope, m, in the equation y=mx+b. 
DAQmx_Scale_Lin_YIntercept: 					4648 ; Specifies the y-intercept, b, in the equation y=mx+b. 
DAQmx_Scale_Map_ScaledMax: 						4649 ; Specifies the largest value in the range of scaled values. NI-DAQmx maps this value to Pre-Scaled Maximum Value. Reads clip samples that are larger than this value. Writes generate errors for samples that are larger than this value. 
DAQmx_Scale_Map_PreScaledMax: 					4657 ; Specifies the largest value in the range of pre-scaled values. NI-DAQmx maps this value to Scaled Maximum Value. 
DAQmx_Scale_Map_ScaledMin: 						4656 ; Specifies the smallest value in the range of scaled values. NI-DAQmx maps this value to Pre-Scaled Minimum Value. Reads clip samples that are smaller than this value. Writes generate errors for samples that are smaller than this value. 
DAQmx_Scale_Map_PreScaledMin: 					4658 ; Specifies the smallest value in the range of pre-scaled values. NI-DAQmx maps this value to Scaled Minimum Value. 
DAQmx_Scale_Poly_ForwardCoeff: 					4660 ; Specifies an array of coefficients for the polynomial that converts pre-scaled values to scaled values. Each element of the array corresponds to a term of the equation. For example, if index three of the array is 9, the fourth term of the equation is 9x^3. 
DAQmx_Scale_Poly_ReverseCoeff: 					4661 ; Specifies an array of coefficients for the polynomial that converts scaled values to pre-scaled values. Each element of the array corresponds to a term of the equation. For example, if index three of the array is 9, the fourth term of the equation is 9y^3. 
DAQmx_Scale_Table_ScaledVals: 					4662 ; Specifies an array of scaled values. These values map directly to the values in Pre-Scaled Values. 
DAQmx_Scale_Table_PreScaledVals: 				4663 ; Specifies an array of pre-scaled values. These values map directly to the values in Scaled Values. 

;********** System Attributes **********

DAQmx_Sys_GlobalChans: 							4709 ; Indicates an array that contains the names of all global channels saved on the system. 
DAQmx_Sys_Scales: 								4710 ; Indicates an array that contains the names of all custom scales saved on the system. 
DAQmx_Sys_Tasks: 								4711 ; Indicates an array that contains the names of all tasks saved on the system. 
DAQmx_Sys_DevNames: 							6459 ; Indicates an array that contains the names of all devices installed in the system. 
DAQmx_Sys_NIDAQMajorVersion: 					4722 ; Indicates the major portion of the installed version of NI-DAQ, such as 7 for version 7.0. 
DAQmx_Sys_NIDAQMinorVersion: 					6435 ; Indicates the minor portion of the installed version of NI-DAQ, such as 0 for version 7.0. 

;********** Task Attributes **********

DAQmx_Task_Name: 								4726 ; Indicates the name of the task. 
DAQmx_Task_Channels: 							4723 ; Indicates the names of all virtual channels in the task. 
DAQmx_Task_NumChans: 							8577 ; Indicates the number of virtual channels in the task. 
DAQmx_Task_Complete: 							4724 ; Indicates whether the task completed execution. 

;********** Timing Attributes **********

DAQmx_SampQuant_SampMode: 						4864 ; Specifies if a task acquires or generates a finite number of samples or if it continuously acquires or generates samples. 
DAQmx_SampQuant_SampPerChan: 					4880 ; Specifies the number of samples to acquire or generate for each channel if Sample Mode is finite. 
DAQmx_SampTimingType: 							4935 ; Specifies the type of sample timing to use for the task. 
DAQmx_SampClk_Rate: 							4932 ; Specifies the sampling rate in samples per channel per second. If you use an external source for the Sample Clock, this input to the maximum expected rate of that clock. 
DAQmx_SampClk_Src: 								6226 ; Specifies the terminal of the signal to use as the Sample Clock. 
DAQmx_SampClk_ActiveEdge: 						4865 ; Specifies on which edge of a clock pulse sampling takes place. This property is useful primarily when the signal you use as the Sample Clock is not a periodic clock. 
DAQmx_SampClk_TimebaseDiv: 						6379 ; Specifies the number of Sample Clock Timebase pulses needed to produce a single Sample Clock pulse. 
DAQmx_SampClk_Timebase_Rate: 					4867 ; Specifies the rate of the Sample Clock Timebase. When the signal you use as the Sample Clock Timebase is not a clock, NI-DAQmx might require the rate to calculate other timing parameters. If this is the case, setting this property to an approximation is preferable to not setting it at all. 
DAQmx_SampClk_Timebase_Src: 					4872 ; Specifies the terminal of the signal to use as the Sample Clock Timebase. 
DAQmx_SampClk_Timebase_ActiveEdge: 				6380 ; Specifies on which edge to recognize a Sample Clock Timebase pulse. This property is useful primarily when the signal you use as the Sample Clock Timebase is not a periodic clock. 
DAQmx_SampClk_Timebase_MasterTimebaseDiv: 		4869 ; Specifies the number of pulses of the Master Timebase needed to produce a single pulse of the Sample Clock Timebase. 
DAQmx_ChangeDetect_DI_RisingEdgePhysicalChans: 	8597 ; Specifies the names of the digital lines or ports on which to detect rising edges. The lines or ports must be used by virtual channels in the task. You also can specify a string that contains a list or range of digital lines or ports. 
DAQmx_ChangeDetect_DI_FallingEdgePhysicalChans: 8598 ; Specifies the names of the digital lines or ports on which to detect rising edges. The lines or ports must be used by virtual channels in the task. You also can specify a string that contains a list or range of digital lines or ports. 
DAQmx_OnDemand_SimultaneousAOEnable: 			8608 ; Specifies whether to update all channels in the task simultaneously, rather than updating channels independently when you write a sample to that channel. 
DAQmx_AIConv_Rate: 								6216 ; Specifies the rate at which to clock the analog-to-digital converter. This clock is specific to the analog input section of an E Series device. 
DAQmx_AIConv_Src: 								5378 ; Specifies the terminal of the signal to use as the AI Convert Clock. 
DAQmx_AIConv_ActiveEdge: 						6227 ; Specifies on which edge of the clock pulse an analog-to-digital conversion takes place. 
DAQmx_AIConv_TimebaseDiv: 						4917 ; Specifies the number of AI Convert Clock Timebase pulses needed to produce a single AI Convert Clock pulse. 
DAQmx_AIConv_Timebase_Src: 						4921 ; Specifies the terminal of the signal to use as the AI Convert Clock Timebase. 
DAQmx_MasterTimebase_Rate: 						5269 ; Specifies the rate of the Master Timebase. 
DAQmx_MasterTimebase_Src: 						4931 ; Specifies the terminal of the signal to use as the Master Timebase. On an E Series device, you can choose only between the onboard 20MHz Timebase or the RTSI7 terminal. 
DAQmx_DelayFromSampClk_DelayUnits: 				4868 ; Specifies the units of Delay. 
DAQmx_DelayFromSampClk_Delay: 					4887 ; Specifies the amount of time to wait after receiving a Sample Clock edge before beginning to acquire the sample. This value is in the units you specify with Delay Units. 

;********** Trigger Attributes **********

DAQmx_StartTrig_Type: 							5011 ; Specifies the type of trigger to use to start a task. 
DAQmx_DigEdge_StartTrig_Src: 					5127 ; Specifies the name of a terminal where there is a digital signal to use as the source of the Start Trigger. 
DAQmx_DigEdge_StartTrig_Edge: 					5124 ; Specifies on which edge of a digital pulse to start acquiring or generating samples. 
DAQmx_AnlgEdge_StartTrig_Src: 					5016 ; Specifies the name of a virtual channel or terminal where there is an analog signal to use as the source of the Start Trigger. 
DAQmx_AnlgEdge_StartTrig_Slope: 				5015 ; Specifies on which slope of the trigger signal to start acquiring or generating samples. 
DAQmx_AnlgEdge_StartTrig_Lvl: 					5014 ; Specifies at what threshold in the units of the measurement or generation to start acquiring or generating samples. Use Slope to specify on which slope to trigger on this threshold. 
DAQmx_AnlgEdge_StartTrig_Hyst: 					5013 ; Specifies a hysteresis level in the units of the measurement or generation. If Slope isDAQmx_Val_RisingSlope, the trigger does not deassert until the source signal passes below Level minus the hysteresis. If Slope isDAQmx_Val_FallingSlope, the trigger does not deassert until the source signal passes above Level plus the hysteresis. 
DAQmx_AnlgWin_StartTrig_Src: 					5120 ; Specifies the name of a virtual channel or terminal where there is an analog signal to use as the source of the Start Trigger. 
DAQmx_AnlgWin_StartTrig_When: 					5121 ; Specifies whether the task starts acquiring or generating samples when the signal enters or leaves the window you specify with Bottom and Top. 
DAQmx_AnlgWin_StartTrig_Top: 					5123 ; Specifies the upper limit of the window. Specify this value in the units of the measurement or generation. 
DAQmx_AnlgWin_StartTrig_Btm: 					5122 ; Specifies the lower limit of the window. Specify this value in the units of the measurement or generation. 
DAQmx_StartTrig_Delay: 							6230 ; Specifies an amount of time to wait after the Start Trigger is received before acquiring or generating the first sample. This value is in the units you specify with Delay Units. 
DAQmx_StartTrig_DelayUnits: 					6344 ; Specifies the units of Delay. 
DAQmx_StartTrig_Retriggerable: 					6415 ; Specifies whether to enable retriggerable counter pulse generation. When you this property to TRUE, the device generates pulses each time it receives a trigger. The device ignores a trigger if it is in the process of generating pulses. 
DAQmx_RefTrig_Type: 							5145 ; Specifies the type of trigger to use to mark a reference point for the measurement. 
DAQmx_RefTrig_PretrigSamples: 					5189 ; Specifies the minimum number of pretrigger samples to acquire from each channel before recognizing the reference trigger. Post-trigger samples per channel are equal to Samples Per Channel minus the number of pretrigger samples per channel. 
DAQmx_DigEdge_RefTrig_Src: 						5172 ; Specifies the name of a terminal where there is a digital signal to use as the source of the Reference Trigger. 
DAQmx_DigEdge_RefTrig_Edge: 					5168 ; Specifies on what edge of a digital pulse the Reference Trigger occurs. 
DAQmx_AnlgEdge_RefTrig_Src: 					5156 ; Specifies the name of a virtual channel or terminal where there is an analog signal to use as the source of the Reference Trigger. 
DAQmx_AnlgEdge_RefTrig_Slope: 					5155 ; Specifies on which slope of the source signal the Reference Trigger occurs. 
DAQmx_AnlgEdge_RefTrig_Lvl: 					5154 ; Specifies in the units of the measurement the threshold at which the Reference Trigger occurs. Use Slope to specify on which slope to trigger at this threshold. 
DAQmx_AnlgEdge_RefTrig_Hyst: 					5153 ; Specifies a hysteresis level in the units of the measurement. If Slope isDAQmx_Val_RisingSlope, the trigger does not deassert until the source signal passes below Level minus the hysteresis. If Slope isDAQmx_Val_FallingSlope, the trigger does not deassert until the source signal passes above Level plus the hysteresis. 
DAQmx_AnlgWin_RefTrig_Src: 						5158 ; Specifies the name of a virtual channel or terminal where there is an analog signal to use as the source of the Reference Trigger. 
DAQmx_AnlgWin_RefTrig_When: 					5159 ; Specifies whether the Reference Trigger occurs when the source signal enters the window or when it leaves the window. Use Bottom and Top to specify the window. 
DAQmx_AnlgWin_RefTrig_Top: 						5161 ; Specifies the upper limit of the window. Specify this value in the units of the measurement. 
DAQmx_AnlgWin_RefTrig_Btm: 						5160 ; Specifies the lower limit of the window. Specify this value in the units of the measurement. 
DAQmx_AdvTrig_Type: 							4965 ; Specifies the type of trigger to use to advance to the next entry in a scan list. 
DAQmx_DigEdge_AdvTrig_Src: 						4962 ; Specifies the name of a terminal where there is a digital signal to use as the source of the Advance Trigger. 
DAQmx_DigEdge_AdvTrig_Edge: 					4960 ; Specifies on which edge of a digital signal to advance to the next entry in a scan list. 
DAQmx_PauseTrig_Type: 							4966 ; Specifies the type of trigger to use to pause a task. 
DAQmx_AnlgLvl_PauseTrig_Src: 					4976 ; Specifies the name of a virtual channel or terminal where there is an analog signal to use as the source of the trigger. 
DAQmx_AnlgLvl_PauseTrig_When: 					4977 ; Specifies whether the task pauses above or below the threshold you specify with Level. 
DAQmx_AnlgLvl_PauseTrig_Lvl: 					4969 ; Specifies the threshold at which to pause the task. Specify this value in the units of the measurement or generation. Use Pause When to specify whether the task pauses above or below this threshold. 
DAQmx_AnlgLvl_PauseTrig_Hyst: 					4968 ; Specifies a hysteresis level in the units of the measurement or generation. If Pause When isDAQmx_Val_AboveLvl, the trigger does not deassert until the source signal passes below Level minus the hysteresis. If Pause When isDAQmx_Val_BelowLvl, the trigger does not deassert until the source signal passes above Level plus the hysteresis. 
DAQmx_AnlgWin_PauseTrig_Src: 					4979 ; Specifies the name of a virtual channel or terminal where there is an analog signal to use as the source of the trigger. 
DAQmx_AnlgWin_PauseTrig_When: 					4980 ; Specifies whether the task pauses while the trigger signal is inside or outside the window you specify with Bottom and Top. 
DAQmx_AnlgWin_PauseTrig_Top: 					4982 ; Specifies the upper limit of the window. Specify this value in the units of the measurement or generation. 
DAQmx_AnlgWin_PauseTrig_Btm: 					4981 ; Specifies the lower limit of the window. Specify this value in the units of the measurement or generation. 
DAQmx_DigLvl_PauseTrig_Src: 					4985 ; Specifies the name of a terminal where there is a digital signal to use as the source of the Pause Trigger. 
DAQmx_DigLvl_PauseTrig_When: 					4992 ; Specifies whether the task pauses while the signal is high or low. 
DAQmx_ArmStartTrig_Type: 						5140 ; Specifies the type of trigger to use to arm the task for a Start Trigger. If you configure an Arm Start Trigger, the task does not respond to a Start Trigger until the device receives the Arm Start Trigger. 
DAQmx_DigEdge_ArmStartTrig_Src: 				5143 ; Specifies the name of a terminal where there is a digital signal to use as the source of the Arm Start Trigger. 
DAQmx_DigEdge_ArmStartTrig_Edge: 				5141 ; Specifies on which edge of a digital signal to arm the task for a Start Trigger. 

;********** Watchdog Attributes **********

DAQmx_Watchdog_Timeout: 						8617 ; Specifies in seconds the amount of time until the watchdog timer expires. A value of -1 means the internal timer never expires. this input to -1 if you use an Expiration Trigger to expire the watchdog task. 
DAQmx_WatchdogExpirTrig_Type: 					8611 ; Specifies the type of trigger to use to expire a watchdog task. 
DAQmx_DigEdge_WatchdogExpirTrig_Src: 			8612 ; Specifies the name of a terminal where a digital signal exists to use as the source of the Expiration Trigger. 
DAQmx_DigEdge_WatchdogExpirTrig_Edge: 			8613 ; Specifies on which edge of a digital signal to expire the watchdog task. 
DAQmx_Watchdog_DO_ExpirState: 					8615 ; Specifies the state to which to the digital physical channels when the watchdog task expires. You cannot modify the expiration state of dedicated digital input physical channels. 
DAQmx_Watchdog_HasExpired: 						8616 ; Indicates if the watchdog timer expired. You can read this property only while the task is running. 

;********** Write Attributes **********

DAQmx_Write_RelativeTo: 						6412 ; Specifies the point in the buffer at which to write data. If you also specify an off with Offset, the write operation begins at that off relative to this point you select with this property. 
DAQmx_Write_Offset: 							6413 ; Specifies in samples per channel an off at which a write operation begins. This off is relative to the location you specify with Relative To. 
DAQmx_Write_RegenMode: 							5203 ; Specifies whether to allow NI-DAQmx to generate the same data multiple times. 
DAQmx_Write_CurrWritePos: 						5208 ; Indicates the number of the next sample for the device to generate. This value is identical for all channels in the task. 
DAQmx_Write_SpaceAvail: 						5216 ; Indicates in samples per channel the amount of available space in the buffer. 
DAQmx_Write_TotalSampPerChanGenerated: 			6443 ; Indicates the total number of samples generated by each channel in the task. This value is identical for all channels in the task. 
DAQmx_Write_RawDataWidth: 						8573 ; Indicates in bytes the required size of a raw sample to write to the task. 
DAQmx_Write_NumChans: 							8574 ; Indicates the number of channels that an NI-DAQmx Write function writes to the task. This value is the number of channels in the task. 
DAQmx_Write_DigitalLines_BytesPerChan: 			8575 ; Indicates the number of bytes expected per channel in a sample for line-based writes. If a channel has fewer lines than this number, NI-DAQmx ignores the extra bytes. 


;******************************************************************************
;*** NI-DAQmx Values **********************************************************
;******************************************************************************

;******************************************************
;***    Non-Attribute Function Parameter Values     ***
;******************************************************

;*** Values for the Mode parameter ofDAQmxTaskControl ***
DAQmx_Val_Task_Start: 							0 ; Start
DAQmx_Val_Task_Stop: 							1 ; Stop
DAQmx_Val_Task_Verify: 							2 ; Verify
DAQmx_Val_Task_Commit: 							3 ; Commit
DAQmx_Val_Task_Reserve: 						4 ; Reserve
DAQmx_Val_Task_Unreserve: 						5 ; Unreserve
DAQmx_Val_Task_Abort: 							6 ; Abort

;*** Values for the Action parameter ofDAQmxControlWatchdogTask ***
DAQmx_Val_ResetTimer: 							0 ; Re Timer
DAQmx_Val_ClearExpiration: 						1 ; Clear Expiration

;*** Values for the Line Grouping parameter ofDAQmxCreateDIChan andDAQmxCreateDOChan ***
DAQmx_Val_ChanPerLine: 							0 ; One Channel For Each Line
DAQmx_Val_ChanForAllLines: 						1 ; One Channel For All Lines

;*** Values for the Fill Mode parameter ofDAQmxReadAnalogF64,DAQmxReadBinaryI16,DAQmxReadBinaryU16,DAQmxReadDigitalU8,DAQmxReadDigitalU32,DAQmxReadDigitalLines ***
;*** Values for the Data Layout parameter ofDAQmxWriteAnalogF64,DAQmxWriteBinaryI16,DAQmxWriteDigitalU8,DAQmxWriteDigitalU32,DAQmxWriteDigitalLines ***
DAQmx_Val_GroupByChannel: 						0 ; Group by Channel
DAQmx_Val_GroupByScanNumber: 					1 ; Group by Scan Number

;*** Values for the Signal Modifiers parameter ofDAQmxConnectTerms ***/
DAQmx_Val_DoNotInvertPolarity: 					0 ; Do not invert polarity
DAQmx_Val_InvertPolarity: 						1 ; Invert polarity

;*** Values for the Action paramter ofDAQmxCloseExtCal ***
DAQmx_Val_Action_Commit: 						0 ; Commit
DAQmx_Val_Action_Cancel: 						1 ; Cancel

;*** Values for the Trigger ID parameter ofDAQmxSendSoftwareTrigger ***
DAQmx_Val_AdvanceTrigger: 						12488 ; Advance Trigger

;*** Value  for the Signal ID parameter ofDAQmxExportSignal ***
DAQmx_Val_AIConvertClock: 						12484 ; AI Convert Clock
DAQmx_Val_20MHzTimebaseClock: 					12486 ; 20MHz Timebase Clock
DAQmx_Val_SampleClock: 							12487 ; Sample Clock
DAQmx_Val_AdvanceTrigger: 						12488 ; Advance Trigger
DAQmx_Val_ReferenceTrigger: 					12490 ; Reference Trigger
DAQmx_Val_StartTrigger: 						12491 ; Start Trigger
DAQmx_Val_AdvCmpltEvent: 						12492 ; Advance Complete Event
DAQmx_Val_AIHoldCmpltEvent: 					12493 ; AI Hold Complete Event
DAQmx_Val_CounterOutputEvent: 					12494 ; Counter Output Event
DAQmx_Val_ChangeDetectionEvent: 				12511 ; Change Detection Event
DAQmx_Val_WDTExpiredEvent: 						12512 ; Watchdog Timer Expired Event

;*** Value  for the ActiveEdge parameter ofDAQmxCfgSampClkTiming ***
DAQmx_Val_Rising: 								10280 ; Rising
DAQmx_Val_Falling: 								10171 ; Falling

;*** Value  SwitchPathType ***
;*** Value  for the output Path Status parameter ofDAQmxSwitchFindPath ***
DAQmx_Val_PathStatus_Available: 				10431 ; Path Available
DAQmx_Val_PathStatus_AlreadyExists: 			10432 ; Path Already Exists
DAQmx_Val_PathStatus_Unsupported: 				10433 ; Path Unsupported
DAQmx_Val_PathStatus_ChannelInUse: 				10434 ; Channel In Use
DAQmx_Val_PathStatus_SourceChannelConflict: 	10435 ; Channel Source Conflict
DAQmx_Val_PathStatus_ChannelReservedForRouting: 10436 ; Channel Reserved for Routing

;*** Value  for the Units parameter ofDAQmxCreateAIThrmcplChan,DAQmxCreateAIRTDChan,DAQmxCreateAIThrmstrChanIex,DAQmxCreateAIThrmstrChanVex andDAQmxCreateAITempBuiltInSensorChan ***
DAQmx_Val_DegC: 								10143 ; Deg C
DAQmx_Val_DegF: 								10144 ; Deg F
DAQmx_Val_Kelvins: 								10325 ; Kelvins
DAQmx_Val_DegR: 								10145 ; Deg R

;*** Value  for the state parameter ofDAQmxSetDigitalPowerUpStates ***
DAQmx_Val_High: 								10192 ; High
DAQmx_Val_Low: 									10214 ; Low
DAQmx_Val_Tristate: 							10310 ; Tristate

;*** Value  RelayPos ***
;*** Value  for the state parameter ofDAQmxSwitchGetSingleRelayPos andDAQmxSwitchGetMultiRelayPos ***
DAQmx_Val_Open: 								10437 ; Open
DAQmx_Val_Closed: 								10438 ; Closed

;*** Value for the Terminal Config parameter ofDAQmxCreateAIVoltageChan,DAQmxCreateAICurrentChan andDAQmxCreateAIVoltageChanWithExcit ***
DAQmx_Val_Cfg_Default: 							-1 ; Default

;*** Value for the Timeout parameter ofDAQmxWaitUntilTaskDone
DAQmx_Val_WaitInfinitely: 						-1.0

;*** Value for the Number of Samples per Channel parameter ofDAQmxReadAnalogF64,DAQmxReadBinaryI16,DAQmxReadBinaryU16,DAQmxReadDigitalU8,DAQmxReadDigitalU32,
;   DAQmxReadDigitalLines,DAQmxReadCounterF64,DAQmxReadCounterU32 andDAQmxReadRaw ***
DAQmx_Val_Auto: 								-1

;******************************************************
;***: Attribute Values: ***/
;* *****************************************************

;*** Values forDAQmx_AI_ACExcit_WireMode ***
;*** Value  ACExcitWireMode ***
DAQmx_Val_4Wire: 								4 ; 4-Wire
DAQmx_Val_5Wire: 								5 ; 5-Wire

;*** Values forDAQmx_AI_MeasType ***
;*** Value  AIMeasurementType ***
DAQmx_Val_Voltage: 								10322 ; Voltage
DAQmx_Val_Current: 								10134 ; Current
DAQmx_Val_Voltage_CustomWithExcitation: 		10323 ; More:Voltage:Custom with Excitation
DAQmx_Val_Freq_Voltage: 						10181 ; Frequency
DAQmx_Val_Resistance: 							10278 ; Resistance
DAQmx_Val_Temp_TC: 								10303 ; Temperature:Thermocouple
DAQmx_Val_Temp_Thrmstr: 						10302 ; Temperature:Thermistor
DAQmx_Val_Temp_RTD: 							10301 ; Temperature:RTD
DAQmx_Val_Temp_BuiltInSensor: 					10311 ; Temperature:Built-in Sensor
DAQmx_Val_Strain_Gage: 							10300 ; Strain Gage
DAQmx_Val_Position_LVDT: 						10352 ; Position:LVDT
DAQmx_Val_Position_RVDT: 						10353 ; Position:RVDT
DAQmx_Val_Accelerometer: 						10356 ; Accelerometer

;*** Values forDAQmx_AO_OutputType ***
;*** Value  AOOutputChannelType ***
DAQmx_Val_Voltage: 								10322 ; Voltage
DAQmx_Val_Current: 								10134 ; Current

;*** Values forDAQmx_AI_Accel_SensitivityUnits ***
;*** Value  AccelSensitivityUnits1 ***
DAQmx_Val_mVoltsPerG: 							12509 ; mVolts/g
DAQmx_Val_VoltsPerG: 							12510 ; Volts/g

;*** Values forDAQmx_AI_Accel_Units ***
;*** Value  AccelUnits2 ***
DAQmx_Val_AccelUnit_g: 							10186 ; g
DAQmx_Val_FromCustomScale: 						10065 ; From Custom Scale

;*** Values forDAQmx_SampQuant_SampMode ***
;*** Value  AcquisitionType ***
DAQmx_Val_FiniteSamps: 							10178 ; Finite Samples
DAQmx_Val_ContSamps: 							10123 ; Continuous Samples

;*** Values forDAQmx_AnlgLvl_PauseTrig_When ***
;*** Value  ActiveLevel ***
DAQmx_Val_AboveLvl: 							10093 ; Above Level
DAQmx_Val_BelowLvl: 							10107 ; Below Level

;*** Values forDAQmx_AI_RVDT_Units ***
;*** Value  AngleUnits1 ***
DAQmx_Val_Degrees: 								10146 ; Degrees
DAQmx_Val_Radians: 								10273 ; Radians
DAQmx_Val_FromCustomScale: 						10065 ; From Custom Scale

;*** Values forDAQmx_CI_AngEncoder_Units ***
;*** Value  AngleUnits2 ***
DAQmx_Val_Degrees: 								10146 ; Degrees
DAQmx_Val_Radians: 								10273 ; Radians
DAQmx_Val_Ticks: 								10304 ; Ticks
DAQmx_Val_FromCustomScale: 						10065 ; From Custom Scale

;*** Values forDAQmx_AI_AutoZeroMode ***
;*** Value  AutoZeroType1 ***
DAQmx_Val_None: 								10230 ; None
DAQmx_Val_Once: 								10244 ; Once

;*** Values forDAQmx_SwitchScan_BreakMode ***
;*** Value  BreakMode ***
DAQmx_Val_NoAction: 							10227 ; No Action
DAQmx_Val_BreakBeforeMake: 						10110 ; Break Before Make

;*** Values forDAQmx_AI_Bridge_Cfg ***
;*** Value  BridgeConfiguration1 ***
DAQmx_Val_FullBridge: 							10182 ; Full Bridge
DAQmx_Val_HalfBridge: 							10187 ; Half Bridge
DAQmx_Val_QuarterBridge: 						10270 ; Quarter Bridge
DAQmx_Val_NoBridge: 							10228 ; No Bridge

;*** Values forDAQmx_CI_MeasType ***
;*** Value  CIMeasurementType ***
DAQmx_Val_CountEdges: 							10125 ; Count Edges
DAQmx_Val_Freq: 								10179 ; Frequency
DAQmx_Val_Period: 								10256 ; Period
DAQmx_Val_PulseWidth: 							10359 ; Pulse Width
DAQmx_Val_SemiPeriod: 							10289 ; Semi Period
DAQmx_Val_Position_AngEncoder: 					10360 ; Position:Angular Encoder
DAQmx_Val_Position_LinEncoder: 					10361 ; Position:Linear Encoder
DAQmx_Val_TwoEdgeSep: 							10267 ; Two Edge Separation

;*** Values forDAQmx_AI_Thrmcpl_CJCSrc ***
;*** Value  CJCSource1 ***
DAQmx_Val_BuiltIn: 								10200 ; Built-In
DAQmx_Val_ConstVal:	 							10116 ; Constant Value
DAQmx_Val_Chan: 								10113 ; Channel

;*** Values forDAQmx_CO_OutputType ***
;*** Value  COOutputType ***
DAQmx_Val_Pulse_Time: 							10269 ; Pulse:Time
DAQmx_Val_Pulse_Freq: 							10119 ; Pulse:Frequency
DAQmx_Val_Pulse_Ticks: 							10268 ; Pulse:Ticks

;*** Values forDAQmx_ChanType ***
;*** Value  ChannelType ***
DAQmx_Val_AI: 									10100 ; Analog Input
DAQmx_Val_AO: 									10102 ; Analog Output
DAQmx_Val_DI: 									10151 ; Digital Input
DAQmx_Val_DO: 									10153 ; Digital Output
DAQmx_Val_CI: 									10131 ; Counter Input
DAQmx_Val_CO: 									10132 ; Counter Output

;*** Values forDAQmx_CI_CountEdges_Dir ***
;*** Value  CountDirection1 ***
DAQmx_Val_CountUp: 								10128 ; Count Up
DAQmx_Val_CountDown: 							10124 ; Count Down
DAQmx_Val_ExtControlled: 						10326 ; Externally Controlled

;*** Values forDAQmx_CI_Freq_MeasMeth ***
;*** Values forDAQmx_CI_Period_MeasMeth ***
;*** Value  CounterFrequencyMethod ***
DAQmx_Val_LowFreq1Ctr: 							10105 ; Low Frequency with 1 Counter
DAQmx_Val_HighFreq2Ctr: 						10157 ; High Frequency with 2 Counters
DAQmx_Val_LargeRng2Ctr: 						10205 ; Large Range with 2 Counters

;*** Values forDAQmx_AI_Coupling ***
;*** Value  Coupling1 ***
DAQmx_Val_AC: 									10045 ; AC
DAQmx_Val_DC: 									10050 ; DC
DAQmx_Val_GND: 									10066 ; GND

;*** Values forDAQmx_AI_CurrentShunt_Loc ***
;*** Value  CurrentShuntResistorLocation1 ***
DAQmx_Val_Internal: 							10200 ; Internal
DAQmx_Val_External: 							10167 ; External

;*** Values forDAQmx_AI_Current_Units ***
;*** Values forDAQmx_AO_Current_Units ***
;*** Value  CurrentUnits1 ***
DAQmx_Val_Amps: 								10342 ; Amps
DAQmx_Val_FromCustomScale: 						10065 ; From Custom Scale

;*** Values forDAQmx_AI_DataXferMech ***
;*** Values forDAQmx_AO_DataXferMech ***
;*** Values forDAQmx_CI_DataXferMech ***
;*** Value  DataTransferMechanism ***
DAQmx_Val_DMA: 									10054 ; DMA
DAQmx_Val_Interrupts: 							10204 ; Interrupts
DAQmx_Val_ProgrammedIO: 						10264 ; Programmed I/O

;*** Values forDAQmx_Watchdog_DO_ExpirState ***
;*** Value  DigitalLineState ***
DAQmx_Val_High: 								10192 ; High
DAQmx_Val_Low: 									10214 ; Low
DAQmx_Val_Tristate: 							10310 ; Tristate
DAQmx_Val_NoChange: 							10160 ; No Change

;*** Values forDAQmx_StartTrig_DelayUnits ***
;*** Value  DigitalWidthUnits1 ***
DAQmx_Val_SampClkPeriods: 						10286 ; Sample Clock Periods
DAQmx_Val_Seconds: 								10364 ; Seconds
DAQmx_Val_Ticks: 								10304 ; Ticks

;*** Values forDAQmx_DelayFromSampClk_DelayUnits ***
;*** Value  DigitalWidthUnits2 ***
DAQmx_Val_Seconds: 								10364 ; Seconds
DAQmx_Val_Ticks: 								10304 ; Ticks

;*** Values forDAQmx_Exported_AdvTrig_Pulse_WidthUnits ***
;*** Value  DigitalWidthUnits3 ***
DAQmx_Val_Seconds: 								10364 ; Seconds

;*** Values forDAQmx_CI_Freq_StartingEdge ***
;*** Values forDAQmx_CI_Period_StartingEdge ***
;*** Values forDAQmx_CI_CountEdges_ActiveEdge ***
;*** Values forDAQmx_CI_PulseWidth_StartingEdge ***
;*** Values forDAQmx_CI_TwoEdgeSep_FirstEdge ***
;*** Values forDAQmx_CI_TwoEdgeSep_SecondEdge ***
;*** Values forDAQmx_CI_CtrTimebaseActiveEdge ***
;*** Values forDAQmx_CO_CtrTimebaseActiveEdge ***
;*** Values forDAQmx_SampClk_ActiveEdge ***
;*** Values forDAQmx_SampClk_Timebase_ActiveEdge ***
;*** Values forDAQmx_AIConv_ActiveEdge ***
;*** Values forDAQmx_DigEdge_StartTrig_Edge ***
;*** Values forDAQmx_DigEdge_RefTrig_Edge ***
;*** Values forDAQmx_DigEdge_AdvTrig_Edge ***
;*** Values forDAQmx_DigEdge_ArmStartTrig_Edge ***
;*** Values forDAQmx_DigEdge_WatchdogExpirTrig_Edge ***
;*** Value  Edge1 ***

DAQmx_Val_Rising:                       	10280 ; Rising
DAQmx_Val_Falling:                       	10171 ; Falling

;*** Values forDAQmx_CI_Encoder_DecodingType ***
;*** Value  EncoderType2 ***
DAQmx_Val_X1:                       		10090 ; X1
DAQmx_Val_X2:                       		10091 ; X2
DAQmx_Val_X4:                       		10092 ; X4
DAQmx_Val_TwoPulseCounting:                 10313 ; Two Pulse Counting

;*** Values forDAQmx_CI_Encoder_ZIndexPhase ***
;*** Value  EncoderZIndexPhase1 ***
DAQmx_Val_AHighBHigh:                        10040 ; A High B High
DAQmx_Val_AHighBLow:                         10041 ; A High B Low
DAQmx_Val_ALowBHigh:                         10042 ; A Low B High
DAQmx_Val_ALowBLow:                          10043 ; A Low B Low

;*** Values forDAQmx_AI_Excit_DCorAC ***
;*** Value  ExcitationDCorAC ***
DAQmx_Val_DC:                        		10050 ; DC
DAQmx_Val_AC:                        		10045 ; AC

;*** Values forDAQmx_AI_Excit_Src ***
;*** Value  ExcitationSource ***
DAQmx_Val_Internal:                         10200 ; Internal
DAQmx_Val_External:                         10167 ; External
DAQmx_Val_None:                          	10230 ; None

;*** Values forDAQmx_AI_Excit_VoltageOrCurrent ***
;*** Value  ExcitationVoltageOrCurrent ***
DAQmx_Val_Voltage:                          10322 ; Voltage
DAQmx_Val_Current:                          10134 ; Current

;*** Values forDAQmx_Exported_CtrOutEvent_OutputBehavior ***
;*** Value  ExportActions2 ***
DAQmx_Val_Pulse:                          	10265 ; Pulse
DAQmx_Val_Toggle:                          	10307 ; Toggle

;*** Values forDAQmx_Exported_SampClk_OutputBehavior ***
;*** Value  ExportActions3 ***
DAQmx_Val_Pulse:                          	10265 ; Pulse
DAQmx_Val_Lvl:                          	10210 ; Level

;*** Values forDAQmx_AI_Freq_Units ***
;*** Value  FrequencyUnits ***
DAQmx_Val_Hz:                          		10373 ; Hz
DAQmx_Val_FromCustomScale:                  10065 ; From Custom Scale

;*** Values forDAQmx_CO_Pulse_Freq_Units ***
;*** Value  FrequencyUnits2 ***
DAQmx_Val_Hz: 								10373 ; Hz

;*** Values forDAQmx_CI_Freq_Units ***
;*** Value  FrequencyUnits3 ***
DAQmx_Val_Hz: 								10373 ; Hz
DAQmx_Val_Ticks: 							10304 ; Ticks
DAQmx_Val_FromCustomScale: 					10065 ; From Custom Scale


;*** Values forDAQmx_AI_DataXferReqCond ***
;*** Value  InputDataTransferCondition ***
DAQmx_Val_OnBrdMemMoreThanHalfFull: 		10237 ; On Board Memory More than Half Full
DAQmx_Val_OnBrdMemNotEmpty: 				10241 ; On Board Memory Not Empty

;*** Values forDAQmx_AI_TermCfg ***
;*** Value  InputTermCfg ***
DAQmx_Val_RSE: 								10083 ; RSE
DAQmx_Val_NRSE: 							10078 ; NRSE
DAQmx_Val_Diff: 							10106 ; Differential

;*** Values forDAQmx_AI_LVDT_SensitivityUnits ***
;*** Value  LVDTSensitivityUnits1 ***
DAQmx_Val_mVoltsPerVoltPerMillimeter: 		12506 ; mVolts/Volt/mMeter
DAQmx_Val_mVoltsPerVoltPerMilliInch: 		12505 ; mVolts/Volt/0.001 Inch

;*** Values forDAQmx_AI_LVDT_Units ***
;*** Value  LengthUnits2 ***
DAQmx_Val_Meters: 							10219 ; Meters
DAQmx_Val_Inches: 							10379 ; Inches
DAQmx_Val_FromCustomScale: 					10065 ; From Custom Scale

;*** Values forDAQmx_CI_LinEncoder_Units ***
;*** Value  LengthUnits3 ***
DAQmx_Val_Meters: 							10219 ; Meters
DAQmx_Val_Inches: 							10379 ; Inches
DAQmx_Val_Ticks: 							10304 ; Ticks
DAQmx_Val_FromCustomScale: 					10065 ; From Custom Scale

;*** Values forDAQmx_CI_OutputState ***
;*** Values forDAQmx_CO_Pulse_IdleState ***
;*** Values forDAQmx_CO_OutputState ***
;*** Values forDAQmx_Exported_CtrOutEvent_Toggle_IdleState ***
;*** Values forDAQmx_DigLvl_PauseTrig_When ***
;*** Value  Level1 ***
DAQmx_Val_High: 							10192 ; High
DAQmx_Val_Low: 								10214 ; Low

;*** Values forDAQmx_AIConv_Timebase_Src ***
;*** Value  MIOAIConvertTbSrc ***
DAQmx_Val_SameAsSampTimebase: 				10284 ; Same as Sample Timebase
DAQmx_Val_SameAsMasterTimebase: 			10282 ; Same as Master Timebase

;*** Values forDAQmx_AO_DataXferReqCond ***
;*** Value  OutputDataTransferCondition ***
DAQmx_Val_OnBrdMemEmpty: 					10235 ; On Board Memory Empty
DAQmx_Val_OnBrdMemHalfFullOrLess: 			10239 ; On Board Memory Half Full or Less
DAQmx_Val_OnBrdMemNotFull: 					10242 ; On Board Memory Less than Full

;*** Values forDAQmx_Read_OverWrite ***
;*** Value  OverwriteMode1 ***
DAQmx_Val_OverwriteUnreadSamps: 			10252 ; Overwrite Unread Samples
DAQmx_Val_DoNotOverwriteUnreadSamps: 		10159 ; Do Not Overwrite Unread Samples

;*** Values forDAQmx_Exported_AIConvClk_Pulse_Polarity ***
;*** Values forDAQmx_Exported_AdvTrig_Pulse_Polarity ***
;*** Values forDAQmx_Exported_AdvCmpltEvent_Pulse_Polarity ***
;*** Values forDAQmx_Exported_AIHoldCmpltEvent_PulsePolarity ***
;*** Values forDAQmx_Exported_CtrOutEvent_Pulse_Polarity ***
;*** Value  Polarity2 ***
DAQmx_Val_ActiveHigh: 						10095 ; Active High
DAQmx_Val_ActiveLow: 						10096 ; Active Low

;*** Values forDAQmx_AI_RTD_Type ***
;*** Value  RTDType1 ***
DAQmx_Val_Pt3750:							12481 ; Pt3750
DAQmx_Val_Pt3851: 							10071 ; Pt3851
DAQmx_Val_Pt3911: 							12482 ; Pt3911
DAQmx_Val_Pt3916: 							10069 ; Pt3916
DAQmx_Val_Pt3920: 							10053 ; Pt3920
DAQmx_Val_Pt3928: 							12483 ; Pt3928
DAQmx_Val_Custom: 							10137 ; Custom

;*** Values forDAQmx_AI_RVDT_SensitivityUnits ***
;*** Value  RVDTSensitivityUnits1 ***
DAQmx_Val_mVoltsPerVoltPerDegree: 			12507 ; mVolts/Volt/Degree
DAQmx_Val_mVoltsPerVoltPerRadian: 			12508 ; mVolts/Volt/Radian

;*** Values forDAQmx_Read_RelativeTo ***
;*** Value  ReadRelativeTo ***
DAQmx_Val_FirstSample: 						10424 ; First Sample
DAQmx_Val_CurrReadPos: 						10425 ; Current Read Position
DAQmx_Val_RefTrig: 							10426 ; Reference Trigger
DAQmx_Val_FirstPretrigSamp: 				10427 ; First Pretrigger Sample
DAQmx_Val_MostRecentSamp: 					10428 ; Most Recent Sample


;*** Values forDAQmx_Write_RegenMode ***
;*** Value  RegenerationMode1 ***
DAQmx_Val_AllowRegen: 						10097 ; Allow Regeneration
DAQmx_Val_DoNotAllowRegen: 					10158 ; Do Not Allow Regeneration

;*** Values forDAQmx_AI_ResistanceCfg ***
;*** Value  ResistanceConfiguration ***
DAQmx_Val_2Wire: 							2 ; 2-Wire
DAQmx_Val_3Wire: 							3 ; 3-Wire
DAQmx_Val_4Wire: 							4 ; 4-Wire

;*** Values forDAQmx_AI_Resistance_Units ***
;*** Value  ResistanceUnits1 ***
DAQmx_Val_Ohms: 							10384 ; Ohms
DAQmx_Val_FromCustomScale: 					10065 ; From Custom Scale

;*** Values forDAQmx_AI_ResolutionUnits ***
;*** Values forDAQmx_AO_ResolutionUnits ***
;*** Value  ResolutionType1 ***
DAQmx_Val_Bits: 							10109 ; Bits

;*** Values forDAQmx_SampTimingType ***
;*** Value  SampleTimingType ***
DAQmx_Val_SampClk: 							10388 ; Sample Clock
DAQmx_Val_Handshake: 						10389 ; Handshake
DAQmx_Val_Implicit: 						10451 ; Implicit
DAQmx_Val_OnDemand: 						10390 ; On Demand
DAQmx_Val_ChangeDetection: 					12504 ; Change Detection

;*** Values forDAQmx_Scale_Type ***
;*** Value  ScaleType ***
DAQmx_Val_Linear: 							10447 ; Linear
DAQmx_Val_MapRanges: 						10448 ; Map Ranges
DAQmx_Val_Polynomial: 						10449 ; Polynomial
DAQmx_Val_Table: 							10450 ; Table

;*** Values forDAQmx_AI_Bridge_ShuntCal_Select ***
;*** Value  ShuntCalSelect ***
DAQmx_Val_A: 								12513 ; A
DAQmx_Val_B: 								12514 ; B
DAQmx_Val_AandB: 							12515 ; A and B

;*** Values forDAQmx_AnlgEdge_StartTrig_Slope ***
;*** Values forDAQmx_AnlgEdge_RefTrig_Slope ***
;*** Value  Slope1 ***
DAQmx_Val_RisingSlope: 						10280 ; Rising
DAQmx_Val_FallingSlope: 					10171 ; Falling

;*** Values forDAQmx_AI_Lowpass_SwitchCap_ClkSrc ***
;*** Values forDAQmx_AO_DAC_Ref_Src ***
;*** Value  SourceSelection ***
DAQmx_Val_Internal: 						10200 ; Internal
DAQmx_Val_External: 						10167 ; External

;*** Values forDAQmx_AI_StrainGage_Cfg ***
;*** Value  StrainGageBridgeType1 ***
DAQmx_Val_FullBridgeI: 						10183 ; Full Bridge I
DAQmx_Val_FullBridgeII: 					10184 ; Full Bridge II
DAQmx_Val_FullBridgeIII: 					10185 ; Full Bridge III
DAQmx_Val_HalfBridgeI: 						10188 ; Half Bridge I
DAQmx_Val_HalfBridgeII: 					10189 ; Half Bridge II
DAQmx_Val_QuarterBridgeI: 					10271 ; Quarter Bridge I
DAQmx_Val_QuarterBridgeII: 					10272 ; Quarter Bridge II

;*** Values forDAQmx_AI_Strain_Units ***
;*** Value  StrainUnits1 ***
DAQmx_Val_Strain: 							10299 ; Strain
DAQmx_Val_FromCustomScale: 					10065 ; From Custom Scale

;*** Values forDAQmx_SwitchScan_RepeatMode ***
;*** Value  SwitchScanRepeatMode ***
DAQmx_Val_Finite: 							10172 ; Finite
DAQmx_Val_Cont: 							10117 ; Continuous

;*** Values forDAQmx_SwitchChan_Usage ***
;*** Value  SwitchUsageTypes ***
DAQmx_Val_Source: 							10439 ; Source
DAQmx_Val_Load: 							10440 ; Load
DAQmx_Val_ReservedForRouting: 				10441 ; Reserved for Routing

;*** Values forDAQmx_AI_Temp_Units ***
;*** Value  TemperatureUnits1 ***
DAQmx_Val_DegC: 							10143 ; Deg C
DAQmx_Val_DegF: 							10144 ; Deg F
DAQmx_Val_Kelvins: 							10325 ; Kelvins
DAQmx_Val_DegR: 							10145 ; Deg R
DAQmx_Val_FromCustomScale: 					10065 ; From Custom Scale

;*** Values forDAQmx_AI_Thrmcpl_Type ***
;*** Value  ThermocoupleType1 ***
DAQmx_Val_J_Type_TC: 						10072 ; J
DAQmx_Val_K_Type_TC: 						10073 ; K
DAQmx_Val_N_Type_TC: 						10077 ; N
DAQmx_Val_R_Type_TC: 						10082 ; R
DAQmx_Val_S_Type_TC: 						10085 ; S
DAQmx_Val_T_Type_TC: 						10086 ; T
DAQmx_Val_B_Type_TC: 						10047 ; B
DAQmx_Val_E_Type_TC: 						10055 ; E

;*** Values forDAQmx_CO_Pulse_Time_Units ***
;*** Value  TimeUnits2 ***
DAQmx_Val_Seconds: 							10364 ; Seconds

;*** Values forDAQmx_CI_Period_Units ***
;*** Values forDAQmx_CI_PulseWidth_Units ***
;*** Values forDAQmx_CI_TwoEdgeSep_Units ***
;*** Values forDAQmx_CI_SemiPeriod_Units ***
;*** Value  TimeUnits3 ***
DAQmx_Val_Seconds: 							10364 ; Seconds
DAQmx_Val_Ticks: 							10304 ; Ticks
DAQmx_Val_FromCustomScale: 					10065 ; From Custom Scale

;*** Values forDAQmx_RefTrig_Type ***
;*** Value  TriggerType1 ***
DAQmx_Val_AnlgEdge: 						10099 ; Analog Edge
DAQmx_Val_DigEdge: 							10150 ; Digital Edge
DAQmx_Val_AnlgWin: 							10103 ; Analog Window
DAQmx_Val_None: 							10230 ; None

;*** Values forDAQmx_ArmStartTrig_Type ***
;*** Values forDAQmx_WatchdogExpirTrig_Type ***
;*** Value  TriggerType4 ***
DAQmx_Val_DigEdge: 							10150 ; Digital Edge
DAQmx_Val_None: 							10230 ; None

;*** Values forDAQmx_AdvTrig_Type ***
;*** Value  TriggerType5 ***
DAQmx_Val_DigEdge: 							10150 ; Digital Edge
DAQmx_Val_Software: 						10292 ; Software
DAQmx_Val_None: 							10230 ; None

;*** Values forDAQmx_PauseTrig_Type ***
;*** Value  TriggerType6 ***
DAQmx_Val_AnlgLvl: 							10101 ; Analog Level
DAQmx_Val_AnlgWin: 							10103 ; Analog Window
DAQmx_Val_DigLvl: 							10152 ; Digital Level
DAQmx_Val_None: 							10230 ; None

;*** Values forDAQmx_StartTrig_Type ***
;*** Value  TriggerType8 ***
DAQmx_Val_AnlgEdge: 						10099 ; Analog Edge
DAQmx_Val_DigEdge: 							10150 ; Digital Edge
DAQmx_Val_AnlgWin: 							10103 ; Analog Window
DAQmx_Val_None: 							10230 ; None

;*** Values forDAQmx_Scale_PreScaledUnits ***
;*** Value  UnitsPreScaled ***
DAQmx_Val_Volts: 							10348 ; Volts
DAQmx_Val_Amps: 							10342 ; Amps
DAQmx_Val_DegF: 							10144 ; Deg F
DAQmx_Val_DegC: 							10143 ; Deg C
DAQmx_Val_DegR: 							10145 ; Deg R
DAQmx_Val_Kelvins: 							10325 ; Kelvins
DAQmx_Val_Strain: 							10299 ; Strain
DAQmx_Val_Ohms: 							10384 ; Ohms
DAQmx_Val_Hz: 								10373 ; Hz
DAQmx_Val_Seconds: 							10364 ; Seconds
DAQmx_Val_Meters: 							10219 ; Meters
DAQmx_Val_Inches: 							10379 ; Inches
DAQmx_Val_Degrees: 							10146 ; Degrees
DAQmx_Val_Radians: 							10273 ; Radians
DAQmx_Val_g: 								10186 ; g

;*** Values forDAQmx_AI_Voltage_Units ***
;*** Value  VoltageUnits1 ***
DAQmx_Val_Volts: 							10348 ; Volts
DAQmx_Val_FromCustomScale: 					10065 ; From Custom Scale

;*** Values forDAQmx_AO_Voltage_Units ***
;*** Value  VoltageUnits2 ***
DAQmx_Val_Volts: 							10348 ; Volts
DAQmx_Val_FromCustomScale: 					10065 ; From Custom Scale

;*** Values forDAQmx_AnlgWin_StartTrig_When ***
;*** Values forDAQmx_AnlgWin_RefTrig_When ***
;*** Value  WindowTriggerCondition1 ***
DAQmx_Val_EnteringWin: 						10163 ; Entering Window
DAQmx_Val_LeavingWin: 						10208 ; Leaving Window

;*** Values forDAQmx_AnlgWin_PauseTrig_When ***
;*** Value  WindowTriggerCondition2 ***
DAQmx_Val_InsideWin: 						10199 ; Inside Window
DAQmx_Val_OutsideWin: 						10251 ; Outside Window

;*** Values forDAQmx_Write_RelativeTo ***
;*** Value  WriteRelativeTo ***
DAQmx_Val_FirstSample: 						10424 ; First Sample
DAQmx_Val_CurrWritePos: 					10430 ; Current Write Position


; Switch Topologies
DAQmx_Val_Switch_Topology_1127_1_Wire_64x1_Mux: 				"1127/1-Wire 64x1 Mux"          ;1127/1-Wire 64x1 Mux
DAQmx_Val_Switch_Topology_1127_2_Wire_32x1_Mux: 				"1127/2-Wire 32x1 Mux"          ;1127/2-Wire 32x1 Mux
DAQmx_Val_Switch_Topology_1127_2_Wire_4x8_Matrix: 				"1127/2-Wire 4x8 Matrix"      	;1127/2-Wire 4x8 Matrix
DAQmx_Val_Switch_Topology_1127_4_Wire_16x1_Mux: 				"1127/4-Wire 16x1 Mux"          ;1127/4-Wire 16x1 Mux
DAQmx_Val_Switch_Topology_1127_Independent: 					"1127/Independent"              ;1127/Independent
DAQmx_Val_Switch_Topology_1128_1_Wire_64x1_Mux: 				"1128/1-Wire 64x1 Mux"          ;1128/1-Wire 64x1 Mux
DAQmx_Val_Switch_Topology_1128_2_Wire_32x1_Mux: 				"1128/2-Wire 32x1 Mux"          ;1128/2-Wire 32x1 Mux
DAQmx_Val_Switch_Topology_1128_2_Wire_4x8_Matrix: 				"1128/2-Wire 4x8 Matrix"      	;1128/2-Wire 4x8 Matrix
DAQmx_Val_Switch_Topology_1128_4_Wire_16x1_Mux:		 			"1128/4-Wire 16x1 Mux"          ;1128/4-Wire 16x1 Mux
DAQmx_Val_Switch_Topology_1128_Independent: 					"1128/Independent"              ;1128/Independent
DAQmx_Val_Switch_Topology_1129_2_Wire_16x16_Matrix: 			"1129/2-Wire 16x16 Matrix"  	;1129/2-Wire 16x16 Matrix
DAQmx_Val_Switch_Topology_1129_2_Wire_8x32_Matrix: 				"1129/2-Wire 8x32 Matrix"    	;1129/2-Wire 8x32 Matrix
DAQmx_Val_Switch_Topology_1129_2_Wire_4x64_Matrix: 				"1129/2-Wire 4x64 Matrix"    	;1129/2-Wire 4x64 Matrix
DAQmx_Val_Switch_Topology_1129_2_Wire_Dual_8x16_Matrix: 		"1129/2-Wire Dual 8x16 Matrix"  ;1129/2-Wire Dual 8x16 Matrix
DAQmx_Val_Switch_Topology_1129_2_Wire_Dual_4x32_Matrix: 		"1129/2-Wire Dual 4x32 Matrix"  ;1129/2-Wire Dual 4x32 Matrix
DAQmx_Val_Switch_Topology_1129_2_Wire_Quad_4x16_Matrix: 		"1129/2-Wire Quad 4x16 Matrix"  ;1129/2-Wire Quad 4x16 Matrix
DAQmx_Val_Switch_Topology_1130_1_Wire_256x1_Mux: 				"1130/1-Wire 256x1 Mux"         ;1130/1-Wire 256x1 Mux
DAQmx_Val_Switch_Topology_1130_2_Wire_128x1_Mux: 				"1130/2-Wire 128x1 Mux"         ;1130/2-Wire 128x1 Mux
DAQmx_Val_Switch_Topology_1130_4_Wire_64x1_Mux: 				"1130/4-Wire 64x1 Mux"          ;1130/4-Wire 64x1 Mux
DAQmx_Val_Switch_Topology_1130_1_Wire_4x64_Matrix: 				"1130/1-Wire 4x64 Matrix"       ;1130/1-Wire 4x64 Matrix
DAQmx_Val_Switch_Topology_1130_1_Wire_8x32_Matrix: 				"1130/1-Wire 8x32 Matrix"       ;1130/1-Wire 8x32 Matrix
DAQmx_Val_Switch_Topology_1130_2_Wire_4x32_Matrix: 				"1130/2-Wire 4x32 Matrix"       ;1130/2-Wire 4x32 Matrix
DAQmx_Val_Switch_Topology_1130_Independent: 					"1130/Independent"              ;1130/Independent
DAQmx_Val_Switch_Topology_1160_16_SPDT: 						"1160/16-SPDT"					;1160/16-SPDT
DAQmx_Val_Switch_Topology_1161_8_SPDT: 							"1161/8-SPDT"                  	;1161/8-SPDT
DAQmx_Val_Switch_Topology_1163R_Octal_4x1_Mux: 					"1163R/Octal 4x1 Mux"           ;1163R/Octal 4x1 Mux
DAQmx_Val_Switch_Topology_1166_32_SPDT:							"1166/32-SPDT"                  ;1166/32-SPDT
DAQmx_Val_Switch_Topology_1167_Independent: 					"1167/Independent"              ;1167/Independent
DAQmx_Val_Switch_Topology_1190_Quad_4x1_Mux: 					"1190/Quad 4x1 Mux"             ;1190/Quad 4x1 Mux
DAQmx_Val_Switch_Topology_1191_Quad_4x1_Mux: 					"1191/Quad 4x1 Mux"             ;1191/Quad 4x1 Mux
DAQmx_Val_Switch_Topology_1192_8_SPDT:  						"1192/8-SPDT"                   ;1192/8-SPDT
DAQmx_Val_Switch_Topology_1193_32x1_Mux: 						"1193/32x1 Mux"                 ;1193/32x1 Mux
DAQmx_Val_Switch_Topology_1193_Dual_16x1_Mux: 					"1193/Dual 16x1 Mux"           	;1193/Dual 16x1 Mux
DAQmx_Val_Switch_Topology_1193_Quad_8x1_Mux: 					"1193/Quad 8x1 Mux"             ;1193/Quad 8x1 Mux
DAQmx_Val_Switch_Topology_1193_16x1_Terminated_Mux: 			"1193/16x1 Terminated Mux"      ;1193/16x1 Terminated Mux
DAQmx_Val_Switch_Topology_1193_Dual_8x1_Terminated_Mux: 		"1193/Dual 8x1 Terminated Mux"  ;1193/Dual 8x1 Terminated Mux
DAQmx_Val_Switch_Topology_1193_Quad_4x1_Terminated_Mux: 		"1193/Quad 4x1 Terminated Mux"  ;1193/Quad 4x1 Terminated Mux
DAQmx_Val_Switch_Topology_1193_Independent: 					"1193/Independent"              ;1193/Independent
DAQmx_Val_Switch_Topology_2529_2_Wire_8x16_Matrix: 				"2529/2-Wire 8x16 Matrix"       ;2529/2-Wire 8x16 Matrix
DAQmx_Val_Switch_Topology_2529_2_Wire_4x32_Matrix: 				"2529/2-Wire 4x32 Matrix"       ;2529/2-Wire 4x32 Matrix
DAQmx_Val_Switch_Topology_2529_2_Wire_Dual_4x16_Matrix: 		"2529/2-Wire Dual 4x16 Matrix"  ;2529/2-Wire Dual 4x16 Matrix
DAQmx_Val_Switch_Topology_2530_1_Wire_128x1_Mux: 				"2530/1-Wire 128x1 Mux"         ;2530/1-Wire 128x1 Mux
DAQmx_Val_Switch_Topology_2530_2_Wire_64x1_Mux: 				"2530/2-Wire 64x1 Mux"          ;2530/2-Wire 64x1 Mux
DAQmx_Val_Switch_Topology_2530_4_Wire_32x1_Mux:					"2530/4-Wire 32x1 Mux"          ;2530/4-Wire 32x1 Mux
DAQmx_Val_Switch_Topology_2530_1_Wire_4x32_Matrix: 				"2530/1-Wire 4x32 Matrix"       ;2530/1-Wire 4x32 Matrix
DAQmx_Val_Switch_Topology_2530_1_Wire_8x16_Matrix: 				"2530/1-Wire 8x16 Matrix"       ;2530/1-Wire 8x16 Matrix
DAQmx_Val_Switch_Topology_2530_2_Wire_4x16_Matrix: 				"2530/2-Wire 4x16 Matrix"       ;2530/2-Wire 4x16 Matrix
DAQmx_Val_Switch_Topology_2530_Independent:	 					"2530/Independent"              ;2530/Independent
DAQmx_Val_Switch_Topology_2566_16_SPDT: 						"2566/16-SPDT"                  ;2566/16-SPDT
DAQmx_Val_Switch_Topology_2567_Independent: 					"2567/Independent"              ;2567/Independent
DAQmx_Val_Switch_Topology_2570_40_SPDT: 						"2570/40-SPDT"                  ;2570/40-SPDT
DAQmx_Val_Switch_Topology_2593_16x1_Mux: 						"2593/16x1 Mux"                 ;2593/16x1 Mux
DAQmx_Val_Switch_Topology_2593_Dual_8x1_Mux: 					"2593/Dual 8x1 Mux"             ;2593/Dual 8x1 Mux
DAQmx_Val_Switch_Topology_2593_8x1_Terminated_Mux: 				"2593/8x1 Terminated Mux"       ;2593/8x1 Terminated Mux
DAQmx_Val_Switch_Topology_2593_Dual_4x1_Terminated_Mux: 		"2593/Dual 4x1 Terminated Mux"  ;2593/Dual 4x1 Terminated Mux
DAQmx_Val_Switch_Topology_2593_Independent: 					"2593/Independent"              ;2593/Independent


;Error (negative value) and Warning (positive value) Codes 
 DAQmxSuccess:                                                            0
 ;DAQMXFAILDED(error)                                                     ((error)!=0)
 DAQmxErrorInvalidInstallation:                                          (-200683)
 DAQmxErrorRefTrigMasterSessionUnavailable:                              (-200682)
 DAQmxErrorRouteFailedBecauseWatchdogExpired:                            (-200681)
 DAQmxErrorDeviceShutDownDueToHighTemp:                                  (-200680)
 DAQmxErrorNoMemMapWhenHWTimedSinglePoint:                               (-200679)
 DAQmxErrorWriteFailedBecauseWatchdogExpired:                            (-200678)
 DAQmxErrorDifftInternalAIInputSrcs:                                     (-200677)
 DAQmxErrorDifftAIInputSrcInOneChanGroup:                                (-200676)
 DAQmxErrorInternalAIInputSrcInMultChanGroups:                           (-200675)
 DAQmxErrorSwitchOpFailedDueToPrevError:                                 (-200674)
 DAQmxErrorWroteMultiSampsUsingSingleSampWrite:                          (-200673)
 DAQmxErrorMismatchedInputArraySizes:                                    (-200672)
 DAQmxErrorCantExceedRelayDriveLimit:                                    (-200671)
 DAQmxErrorDACRngLowNotEqualToMinusRefVal:                               (-200670)
 DAQmxErrorCantAllowConnectDACToGnd:                                     (-200669)
 DAQmxErrorWatchdogTimeoutOutOfRangeAndNotSpecialVal:                    (-200668)
 DAQmxErrorNoWatchdogOutputOnPortReservedForInput:                       (-200667)
 DAQmxErrorNoInputOnPortCfgdForWatchdogOutput:                           (-200666)
 DAQmxErrorWatchdogExpirationStateNotEqualForLinesInPort:                (-200665)
 DAQmxErrorCannotPerformOpWhenTaskNotReserved:                           (-200664)
 DAQmxErrorPowerupStateNotSupported:                                     (-200663)
 DAQmxErrorWatchdogTimerNotSupported:                                    (-200662)
 DAQmxErrorOpNotSupportedWhenRefClkSrcNone:                              (-200661)
 DAQmxErrorSampClkRateUnavailable:                                       (-200660)
 DAQmxErrorPrptyGetSpecdSingleActiveChanFailedDueToDifftVals:            (-200659)
 DAQmxErrorPrptyGetImpliedActiveChanFailedDueToDifftVals:                (-200658)
 DAQmxErrorPrptyGetSpecdActiveChanFailedDueToDifftVals:                  (-200657)
 DAQmxErrorNoRegenWhenUsingBrdMem:                                       (-200656)
 DAQmxErrorNonbufferedReadMoreThanSampsPerChan:                          (-200655)
 DAQmxErrorWatchdogExpirationTristateNotSpecdForEntirePort:              (-200654)
 DAQmxErrorPowerupTristateNotSpecdForEntirePort:                         (-200653)
 DAQmxErrorPowerupStateNotSpecdForEntirePort:                            (-200652)
 DAQmxErrorCantSetWatchdogExpirationOnDigInChan:                         (-200651)
 DAQmxErrorCantSetPowerupStateOnDigInChan:                               (-200650)
 DAQmxErrorPhysChanNotInTask:                                            (-200649)
 DAQmxErrorPhysChanDevNotInTask:                                         (-200648)
 DAQmxErrorDigInputNotSupported:                                         (-200647)
 DAQmxErrorDigFilterIntervalNotEqualForLines:                            (-200646)
 DAQmxErrorDigFilterIntervalAlreadyCfgd:                                 (-200645)
 DAQmxErrorCantResetExpiredWatchdog:                                     (-200644)
 DAQmxErrorActiveChanTooManyLinesSpecdWhenGettingPrpty:                  (-200643)
 DAQmxErrorActiveChanNotSpecdWhenGetting1LinePrpty:                      (-200642)
 DAQmxErrorDigPrptyCannotBeSetPerLine:                                   (-200641)
 DAQmxErrorSendAdvCmpltAfterWaitForTrigInScanlist:                       (-200640)
 DAQmxErrorDisconnectionRequiredInScanlist:                              (-200639)
 DAQmxErrorTwoWaitForTrigsAfterConnectionInScanlist:                     (-200638)
 DAQmxErrorActionSeparatorRequiredAfterBreakingConnectionInScanlist:     (-200637)
 DAQmxErrorConnectionInScanlistMustWaitForTrig:                          (-200636)
 DAQmxErrorActionNotSupportedTaskNotWatchdog:                            (-200635)
 DAQmxErrorWfmNameSameAsScriptName:                                      (-200634)
 DAQmxErrorScriptNameSameAsWfmName:                                      (-200633)
 DAQmxErrorDSFStopClock:                                                 (-200632)
 DAQmxErrorDSFReadyForStartClock:                                        (-200631)
 DAQmxErrorWriteOffsetNotMultOfIncr:                                     (-200630)
 DAQmxErrorDifferentPrptyValsNotSupportedOnDev:                          (-200629)
 DAQmxErrorRefAndPauseTrigConfigured:                                    (-200628)
 DAQmxErrorFailedToEnableHighSpeedInputClock:                            (-200627)
 DAQmxErrorEmptyPhysChanInPowerUpStatesArray:                            (-200626)
 DAQmxErrorActivePhysChanTooManyLinesSpecdWhenGettingPrpty:              (-200625)
 DAQmxErrorActivePhysChanNotSpecdWhenGetting1LinePrpty:                  (-200624)
 DAQmxErrorPXIDevTempCausedShutDown:                                     (-200623)
 DAQmxErrorInvalidNumSampsToWrite:                                       (-200622)
 DAQmxErrorOutputFIFOUnderflowv:                                         (-200621)
 DAQmxErrorRepeatedAIPhysicalChan:                                       (-200620)
 DAQmxErrorMultScanOpsInOneChassis:                                      (-200619)
 DAQmxErrorInvalidAIChanOrder:                                           (-200618)
 DAQmxErrorReversePowerProtectionActivated:                              (-200617)
 DAQmxErrorInvalidAsynOpHandle:                                          (-200616)
 DAQmxErrorFailedToEnableHighSpeedOutput:                                (-200615)
 DAQmxErrorCannotReadPastEndOfRecord:                                    (-200614)
 DAQmxErrorAcqStoppedToPreventInputBufferOverwriteOneDataXferMech:       (-200613)
 DAQmxErrorZeroBasedChanIndexInvalid:                                    (-200612)
 DAQmxErrorNoChansOfGivenTypeInTask:                                     (-200611)
 DAQmxErrorSampClkSrcInvalidForOutputValidForInput:                      (-200610)
 DAQmxErrorOutputBufSizeTooSmallToStartGen:                              (-200609)
 DAQmxErrorInputBufSizeTooSmallToStartAcq:                               (-200608)
 DAQmxErrorExportTwoSignalsOnSameTerminal:                               (-200607)
 DAQmxErrorChanIndexInvalid:                                             (-200606)
 DAQmxErrorRangeSyntaxNumberTooBig:                                      (-200605)
 DAQmxErrorNULLPtr:                                                      (-200604)
 DAQmxErrorScaledMinEqualMax:                                            (-200603)
 DAQmxErrorPreScaledMinEqualMax:                                         (-200602)
 DAQmxErrorPropertyNotSupportedForScaleType:                             (-200601)
 DAQmxErrorChannelNameGenerationNumberTooBig:                            (-200600)
 DAQmxErrorRepeatedNumberInScaledValues:                                 (-200599)
 DAQmxErrorRepeatedNumberInPreScaledValues:                              (-200598)
 DAQmxErrorLinesAlreadyReservedForOutput:                                (-200597)
 DAQmxErrorSwitchOperationChansSpanMultipleDevsInList:                   (-200596)
 DAQmxErrorInvalidIDInListAtBeginningOfSwitchOperation:                  (-200595)
 DAQmxErrorMStudioInvalidPolyDirection:                                  (-200594)
 DAQmxErrorMStudioPropertyGetWhileTaskNotVerified:                       (-200593)
 DAQmxErrorRangeWithTooManyObjects:                                      (-200592)
 DAQmxErrorCppDotNetAPINegativeBufferSize:                               (-200591)
 DAQmxErrorCppCantRemoveInvalidEventHandler:                             (-200590)
 DAQmxErrorCppCantRemoveEventHandlerTwice:                               (-200589)
 DAQmxErrorCppCantRemoveOtherObjectsEventHandler:                        (-200588)
 DAQmxErrorDigLinesReservedOrUnavailable:                                (-200587)
 DAQmxErrorDSFFailedToResetStream:                                       (-200586)
 DAQmxErrorDSFReadyForOutputNotAsserted:                                 (-200585)
 DAQmxErrorSampToWritePerChanNotMultipleOfIncr:                          (-200584)
 DAQmxErrorAOPropertiesCauseVoltageBelowMin:                             (-200583)
 DAQmxErrorAOPropertiesCauseVoltageOverMax:                              (-200582)
 DAQmxErrorPropertyNotSupportedWhenRefClkSrcNone:                        (-200581)
 DAQmxErrorAIMaxTooSmall:                                                (-200580)
 DAQmxErrorAIMaxTooLarge:                                                (-200579)
 DAQmxErrorAIMinTooSmall:                                                (-200578)
 DAQmxErrorAIMinTooLarge:                                                (-200577)
 DAQmxErrorBuiltInCJCSrcNotSupported:                                    (-200576)
 DAQmxErrorTooManyPostTrigSampsPerChan:                                  (-200575)
 DAQmxErrorTrigLineNotFoundSingleDevRoute:                               (-200574)
 DAQmxErrorDifferentInternalAIInputSources:                              (-200573)
 DAQmxErrorDifferentAIInputSrcInOneChanGroup:                            (-200572)
 DAQmxErrorInternalAIInputSrcInMultipleChanGroups:                       (-200571)
 DAQmxErrorCAPIChanIndexInvalid:                                         (-200570)
 DAQmxErrorCollectionDoesNotMatchChanType:                               (-200569)
 DAQmxErrorOutputCantStartChangedRegenerationMode:                       (-200568)
 DAQmxErrorOutputCantStartChangedBufferSize:                             (-200567)
 DAQmxErrorChanSizeTooBigForU32PortWrite:                                (-200566)
 DAQmxErrorChanSizeTooBigForU8PortWrite:                                 (-200565)
 DAQmxErrorChanSizeTooBigForU32PortRead:                                 (-200564)
 DAQmxErrorChanSizeTooBigForU8PortRead:                                  (-200563)
 DAQmxErrorInvalidDigDataWrite:                                          (-200562)
 DAQmxErrorInvalidAODataWrite:                                           (-200561)
 DAQmxErrorWaitUntilDoneDoesNotIndicateDone:                             (-200560)
 DAQmxErrorMultiChanTypesInTask:                                         (-200559)
 DAQmxErrorMultiDevsInTask:                                              (-200558)
 DAQmxErrorCannotSetPropertyWhenTaskRunning:                             (-200557)
 DAQmxErrorCannotGetPropertyWhenTaskNotCommittedOrRunning:               (-200556)
 DAQmxErrorLeadingUnderscoreInString:                                    (-200555)
 DAQmxErrorTrailingSpaceInString:                                        (-200554)
 DAQmxErrorLeadingSpaceInString:                                         (-200553)
 DAQmxErrorInvalidCharInString:                                          (-200552)
 DAQmxErrorDLLBecameUnlocked:                                            (-200551)
 DAQmxErrorDLLLock:                                                      (-200550)
 DAQmxErrorSelfCalConstsInvalid:                                         (-200549)
 DAQmxErrorInvalidTrigCouplingExceptForExtTrigChan:                      (-200548)
 DAQmxErrorWriteFailsBufferSizeAutoConfigured:                           (-200547)
 DAQmxErrorExtCalAdjustExtRefVoltageFailed:                              (-200546)
 DAQmxErrorSelfCalFailedExtNoiseOrRefVoltageOutOfCal:                    (-200545)
 DAQmxErrorExtCalTemperatureNotDAQmx:                                    (-200544)
 DAQmxErrorExtCalDateTimeNotDAQmx:                                       (-200543)
 DAQmxErrorSelfCalTemperatureNotDAQmx:                                   (-200542)
 DAQmxErrorSelfCalDateTimeNotDAQmx:                                      (-200541)
 DAQmxErrorDACRefValNotSet:                                              (-200540)
 DAQmxErrorAnalogMultiSampWriteNotSupported:                             (-200539)
 DAQmxErrorInvalidActionInControlTask:                                   (-200538)
 DAQmxErrorPolyCoeffsInconsistent:                                       (-200537)
 DAQmxErrorSensorValTooLow:                                              (-200536)
 DAQmxErrorSensorValTooHigh:                                             (-200535)
 DAQmxErrorWaveformNameTooLong:                                          (-200534)
 DAQmxErrorIdentifierTooLongInScript:                                    (-200533)
 DAQmxErrorUnexpectedIDFollowingSwitchChanName:                          (-200532)
 DAQmxErrorRelayNameNotSpecifiedInList:                                  (-200531)
 DAQmxErrorUnexpectedIDFollowingRelayNameInList:                         (-200530)
 DAQmxErrorUnexpectedIDFollowingSwitchOpInList:                          (-200529)
 DAQmxErrorInvalidLineGrouping:                                          (-200528)
 DAQmxErrorCtrMinMax:                                                    (-200527)
 DAQmxErrorWriteChanTypeMismatch:                                        (-200526)
 DAQmxErrorReadChanTypeMismatch:                                         (-200525)
 DAQmxErrorWriteNumChansMismatch:                                        (-200524)
 DAQmxErrorOneChanReadForMultiChanTask:                                  (-200523)
 DAQmxErrorCannotSelfCalDuringExtCal:                                    (-200522)
 DAQmxErrorMeasCalAdjustOscillatorPhaseDAC:                              (-200521)
 DAQmxErrorInvalidCalConstCalADCAdjustment:                              (-200520)
 DAQmxErrorInvalidCalConstOscillatorFreqDACValue:                        (-200519)
 DAQmxErrorInvalidCalConstOscillatorPhaseDACValue:                       (-200518)
 DAQmxErrorInvalidCalConstOffsetDACValue:                                (-200517)
 DAQmxErrorInvalidCalConstGainDACValue:                                  (-200516)
 DAQmxErrorInvalidNumCalADCReadsToAverage:                               (-200515)
 DAQmxErrorInvalidCfgCalAdjustDirectPathOutputImpedance:                 (-200514)
 DAQmxErrorInvalidCfgCalAdjustMainPathOutputImpedance:                   (-200513)
 DAQmxErrorInvalidCfgCalAdjustMainPathPostAmpGainAndOffset:              (-200512)
 DAQmxErrorInvalidCfgCalAdjustMainPathPreAmpGain:                        (-200511)
 DAQmxErrorInvalidCfgCalAdjustMainPreAmpOffset:                          (-200510)
 DAQmxErrorMeasCalAdjustCalADC:                                          (-200509)
 DAQmxErrorMeasCalAdjustOscillatorFrequency:                             (-200508)
 DAQmxErrorMeasCalAdjustDirectPathOutputImpedance:                       (-200507)
 DAQmxErrorMeasCalAdjustMainPathOutputImpedance:                         (-200506)
 DAQmxErrorMeasCalAdjustDirectPathGain:                                  (-200505)
 DAQmxErrorMeasCalAdjustMainPathPostAmpGainAndOffset:                    (-200504)
 DAQmxErrorMeasCalAdjustMainPathPreAmpGain:                              (-200503)
 DAQmxErrorMeasCalAdjustMainPathPreAmpOffset:                            (-200502)
 DAQmxErrorInvalidDateTimeInEEPROm:                                      (-200501)
 DAQmxErrorUnableToLocateErrorResources:                                 (-200500)
 DAQmxErrorDotNetAPINotUnsigned32BitNumber:                              (-200499)
 DAQmxErrorInvalidRangeOfObjectsSyntaxInString:                          (-200498)
 DAQmxErrorAttemptToEnableLineNotPreviouslyDisabled:                     (-200497)
 DAQmxErrorInvalidCharInPattern:                                         (-200496)
 DAQmxErrorIntermediateBufferFull:                                       (-200495)
 DAQmxErrorLoadTaskFailsBecauseNoTimingOnDev:                            (-200494)
 DAQmxErrorCAPIReservedParamNotNULLNorEmpty:                             (-200493)
 DAQmxErrorCAPIReservedParamNotNULl:                                     (-200492)
 DAQmxErrorCAPIReservedParamNotZero:                                     (-200491)
 DAQmxErrorSampleValueOutOfRange:                                        (-200490)
 DAQmxErrorChanAlreadyInTask:                                            (-200489)
 DAQmxErrorVirtualChanDoesNotExist:                                      (-200488)
 DAQmxErrorChanNotInTask:                                                (-200486)
 DAQmxErrorTaskNotInDataNeighborhood:                                    (-200485)
 DAQmxErrorCantSaveTaskWithoutReplace:                                   (-200484)
 DAQmxErrorCantSaveChanWithoutReplace:                                   (-200483)
 DAQmxErrorDevNotInTask:                                                 (-200482)
 DAQmxErrorDevAlreadyInTask:                                             (-200481)
 DAQmxErrorCanNotPerformOpWhileTaskRunning:                              (-200479)
 DAQmxErrorCanNotPerformOpWhenNoChansInTask:                             (-200478)
 DAQmxErrorCanNotPerformOpWhenNoDevInTask:                               (-200477)
 DAQmxErrorCannotPerformOpWhenTaskNotRunning:                            (-200475)
 DAQmxErrorOperationTimedOut:                                            (-200474)
 DAQmxErrorCannotReadWhenAutoStartFalseAndTaskNotRunningOrCommitted:     (-200473)
 DAQmxErrorCannotWriteWhenAutoStartFalseAndTaskNotRunningOrCommitted:    (-200472)
 DAQmxErrorTaskVersionNew:                                               (-200470)
 DAQmxErrorChanVersionNew:                                               (-200469)
 DAQmxErrorEmptyString:                                                  (-200467)
 DAQmxErrorChannelSizeTooBigForPortReadType:                             (-200466)
 DAQmxErrorChannelSizeTooBigForPortWriteType:                            (-200465)
 DAQmxErrorExpectedNumberOfChannelsVerificationFailed:                   (-200464)
 DAQmxErrorNumLinesMismatchInReadOrWrite:                                (-200463)
 DAQmxErrorOutputBufferEmpty:                                            (-200462)
 DAQmxErrorInvalidChanName:                                              (-200461)
 DAQmxErrorReadNoInputChansInTask:                                       (-200460)
 DAQmxErrorWriteNoOutputChansInTask:                                     (-200459)
 DAQmxErrorPropertyNotSupportedNotInputTask:                             (-200457)
 DAQmxErrorPropertyNotSupportedNotOutputTask:                            (-200456)
 DAQmxErrorGetPropertyNotInputBufferedTask:                              (-200455)
 DAQmxErrorGetPropertyNotOutputBufferedTask:                             (-200454)
 DAQmxErrorInvalidTimeoutVal:                                            (-200453)
 DAQmxErrorAttributeNotSupportedInTaskContext:                           (-200452)
 DAQmxErrorAttributeNotQueryableUnlessTaskIsCommitted:                   (-200451)
 DAQmxErrorAttributeNotSettableWhenTaskIsRunning:                        (-200450)
 DAQmxErrorDACRngLowNotMinusRefValNorZero:                               (-200449)
 DAQmxErrorDACRngHighNotEqualRefVal:                                     (-200448)
 DAQmxErrorUnitsNotFromCustomScale:                                      (-200447)
 DAQmxErrorInvalidVoltageReadingDuringExtCal:                            (-200446)
 DAQmxErrorCalFunctionNotSupported:                                      (-200445)
 DAQmxErrorInvalidPhysicalChanForCal:                                    (-200444)
 DAQmxErrorExtCalNotComplete:                                            (-200443)
 DAQmxErrorCantSyncToExtStimulusFreqDuringCal:                           (-200442)
 DAQmxErrorUnableToDetectExtStimulusFreqDuringCal:                       (-200441)
 DAQmxErrorInvalidCloseAction:                                           (-200440)
 DAQmxErrorExtCalFunctionOutsideExtCalSession:                           (-200439)
 DAQmxErrorInvalidCalArea:                                               (-200438)
 DAQmxErrorExtCalConstsInvalid:                                          (-200437)
 DAQmxErrorStartTrigDelayWithExtSampClk:                                 (-200436)
 DAQmxErrorDelayFromSampClkWithExtConv:                                  (-200435)
 DAQmxErrorFewerThan2PreScaledVals:                                      (-200434)
 DAQmxErrorFewerThan2ScaledValues:                                       (-200433)
 DAQmxErrorPhysChanOutputType:                                           (-200432)
 DAQmxErrorPhysChanMeasType:                                             (-200431)
 DAQmxErrorInvalidPhysChanType:                                          (-200430)
 DAQmxErrorLabVIEWEmptyTaskOrChans:                                      (-200429)
 DAQmxErrorLabVIEWInvalidTaskOrChans:                                    (-200428)
 DAQmxErrorInvalidRefClkRate:                                            (-200427)
 DAQmxErrorInvalidExtTrigImpedance:                                      (-200426)
 DAQmxErrorHystTrigLevelAIMax:                                           (-200425)
 DAQmxErrorLineNumIncompatibleWithVideoSignalFormat:                     (-200424)
 DAQmxErrorTrigWindowAIMinAIMaxCombo:                                    (-200423)
 DAQmxErrorTrigAIMinAIMax:                                               (-200422)
 DAQmxErrorHystTrigLevelAIMin:                                           (-200421)
 DAQmxErrorInvalidSampRateConsiderRIs:                                   (-200420)
 DAQmxErrorInvalidReadPosDuringRIs:                                      (-200419)
 DAQmxErrorImmedTrigDuringRISMode:                                       (-200418)
 DAQmxErrorTDCNotEnabledDuringRISMode:                                   (-200417)
 DAQmxErrorMultiRecWithRIs:                                              (-200416)
 DAQmxErrorInvalidRefClkSrC:                                             (-200415)
 DAQmxErrorInvalidSampClkSrC:                                            (-200414)
 DAQmxErrorInsufficientOnBoardMemForNumRecsAndSamps:                     (-200413)
 DAQmxErrorInvalidAIAttenuation:                                         (-200412)
 DAQmxErrorACCouplingNotAllowedWith50OhmImpedance:                       (-200411)
 DAQmxErrorInvalidRecordNum:                                             (-200410)
 DAQmxErrorZeroSlopeLinearScale:                                         (-200409)
 DAQmxErrorZeroReversePolyScaleCoeffs:                                   (-200408)
 DAQmxErrorZeroForwardPolyScaleCoeffs:                                   (-200407)
 DAQmxErrorNoReversePolyScaleCoeffs:                                     (-200406)
 DAQmxErrorNoForwardPolyScaleCoeffs:                                     (-200405)
 DAQmxErrorNoPolyScaleCoeffs:                                            (-200404)
 DAQmxErrorReversePolyOrderLessThanNumPtsToCompute:                      (-200403)
 DAQmxErrorReversePolyOrderNotPositive:                                  (-200402)
 DAQmxErrorNumPtsToComputeNotPositive:                                   (-200401)
 DAQmxErrorWaveformLengthNotMultipleOfIncr:                              (-200400)
 DAQmxErrorCAPINoExtendedErrorInfoAvailable:                             (-200399)
 DAQmxErrorCVIFunctionNotFoundInDAQmxDLl:                                (-200398)
 DAQmxErrorCVIFailedToLoadDAQmxDLl:                                      (-200397)
 DAQmxErrorNoCommonTrigLineForImmedRoute:                                (-200396)
 DAQmxErrorNoCommonTrigLineForTaskRoute:                                 (-200395)
 DAQmxErrorF64PrptyValNotUnsignedInt:                                    (-200394)
 DAQmxErrorRegisterNotWritable:                                          (-200393)
 DAQmxErrorInvalidOutputVoltageAtSampClkRate:                            (-200392)
 DAQmxErrorStrobePhaseShiftDCMBecameUnlocked:                            (-200391)
 DAQmxErrorDrivePhaseShiftDCMBecameUnlocked:                             (-200390)
 DAQmxErrorClkOutPhaseShiftDCMBecameUnlocked:                            (-200389)
 DAQmxErrorOutputBoardClkDCMBecameUnlocked:                              (-200388)
 DAQmxErrorInputBoardClkDCMBecameUnlocked:                               (-200387)
 DAQmxErrorInternalClkDCMBecameUnlocked:                                 (-200386)
 DAQmxErrorDCMLock:                                                      (-200385)
 DAQmxErrorDataLineReservedForDynamicOutput:                             (-200384)
 DAQmxErrorInvalidRefClkSrcGivenSampClkSrC:                              (-200383)
 DAQmxErrorNoPatternMatcherAvailable:                                    (-200382)
 DAQmxErrorInvalidDelaySampRateBelowPhaseShiftDCMThresh:                 (-200381)
 DAQmxErrorStrainGageCalibration:                                        (-200380)
 DAQmxErrorInvalidExtClockFreqAndDivCombo:                               (-200379)
 DAQmxErrorCustomScaleDoesNotExist:                                      (-200378)
 DAQmxErrorOnlyFrontEndChanOpsDuringScan:                                (-200377)
 DAQmxErrorInvalidOptionForDigitalPortChannel:                           (-200376)
 DAQmxErrorUnsupportedSignalTypeExportSignal:                            (-200375)
 DAQmxErrorInvalidSignalTypeExportSignal:                                (-200374)
 DAQmxErrorUnsupportedTrigTypeSendsSWTrig:                               (-200373)
 DAQmxErrorInvalidTrigTypeSendsSWTrig:                                   (-200372)
 DAQmxErrorRepeatedPhysicalChan:                                         (-200371)
 DAQmxErrorResourcesInUseForRouteInTask:                                 (-200370)
 DAQmxErrorResourcesInUseForRoute:                                       (-200369)
 DAQmxErrorRouteNotSupportedByHw:                                        (-200368)
 DAQmxErrorResourcesInUseForExportSignalPolarity:                        (-200367)
 DAQmxErrorResourcesInUseForInversionInTask:                             (-200366)
 DAQmxErrorResourcesInUseForInversion:                                   (-200365)
 DAQmxErrorExportSignalPolarityNotSupportedByHw:                         (-200364)
 DAQmxErrorInversionNotSupportedByHw:                                    (-200363)
 DAQmxErrorOverloadedChansExistNotRead:                                  (-200362)
 DAQmxErrorInputFIFOOverflowv:                                           (-200361)
 DAQmxErrorCJCChanNotSpecd:                                              (-200360)
 DAQmxErrorCtrExportSignalNotPossible:                                   (-200359)
 DAQmxErrorRefTrigWhenContinuous:                                        (-200358)
 DAQmxErrorIncompatibleSensorOutputAndDeviceInputRanges:                 (-200357)
 DAQmxErrorCustomScaleNameUsed:                                          (-200356)
 DAQmxErrorPropertyValNotSupportedByHw:                                  (-200355)
 DAQmxErrorPropertyValNotValidTermName:                                  (-200354)
 DAQmxErrorResourcesInUseForProperty:                                    (-200353)
 DAQmxErrorCJCChanAlreadyUsed:                                           (-200352)
 DAQmxErrorForwardPolynomialCoefNotSpecd:                                (-200351)
 DAQmxErrorTableScaleNumPreScaledAndScaledValsNotEqual:                  (-200350)
 DAQmxErrorTableScalePreScaledValsNotSpecd:                              (-200349)
 DAQmxErrorTableScaleScaledValsNotSpecd:                                 (-200348)
 DAQmxErrorIntermediateBufferSizeNotMultipleOfIncr:                      (-200347)
 DAQmxErrorEventPulseWidthOutOfRange:                                    (-200346)
 DAQmxErrorEventDelayOutOfRange:                                         (-200345)
 DAQmxErrorSampPerChanNotMultipleOfIncr:                                 (-200344)
 DAQmxErrorCannotCalculateNumSampsTaskNotStarted:                        (-200343)
 DAQmxErrorScriptNotInMem:                                               (-200342)
 DAQmxErrorOnboardMemTooSmall:                                           (-200341)
 DAQmxErrorReadAllAvailableDataWithoutBuffer:                            (-200340)
 DAQmxErrorPulseActiveAtStart:                                           (-200339)
 DAQmxErrorCalTempNotSupported:                                          (-200338)
 DAQmxErrorDelayFromSampClkTooLong:                                      (-200337)
 DAQmxErrorDelayFromSampClkTooShort:                                     (-200336)
 DAQmxErrorAIConvRateTooHigh:                                            (-200335)
 DAQmxErrorDelayFromStartTrigTooLong:                                    (-200334)
 DAQmxErrorDelayFromStartTrigTooShort:                                   (-200333)
 DAQmxErrorSampRateTooHigh:                                              (-200332)
 DAQmxErrorSampRateTooLow:                                               (-200331)
 DAQmxErrorPFI0UsedForAnalogAndDigitalSrC:                               (-200330)
 DAQmxErrorPrimingCfgFIFo:                                               (-200329)
 DAQmxErrorCannotOpenTopologyCfgFile:                                    (-200328)
 DAQmxErrorInvalidDTInsideWfmDataType:                                   (-200327)
 DAQmxErrorRouteSrcAndDestSame:                                          (-200326)
 DAQmxErrorReversePolynomialCoefNotSpecd:                                (-200325)
 DAQmxErrorDevAbsentOrUnavailable:                                       (-200324)
 DAQmxErrorNoAdvTrigForMultiDevScan:                                     (-200323)
 DAQmxErrorInterruptsInsufficientDataXferMech:                           (-200322)
 DAQmxErrorInvalidAttentuationBasedOnMinMax:                             (-200321)
 DAQmxErrorCabledModuleCannotRouteSSh:                                   (-200320)
 DAQmxErrorCabledModuleCannotRouteConvClk:                               (-200319)
 DAQmxErrorInvalidExcitValForScaling:                                    (-200318)
 DAQmxErrorNoDevMemForScript:                                            (-200317)
 DAQmxErrorScriptDataUnderflow:                                          (-200316)
 DAQmxErrorNoDevMemForWaveform:                                          (-200315)
 DAQmxErrorStreamDCMBecameUnlocked:                                      (-200314)
 DAQmxErrorStreamDCMLock:                                                (-200313)
 DAQmxErrorWaveformNotInMem:                                             (-200312)
 DAQmxErrorWaveformWriteOutOfBounds:                                     (-200311)
 DAQmxErrorWaveformPreviouslyAllocated:                                  (-200310)
 DAQmxErrorSampClkTbMasterTbDivNotAppropriateForSampTbSrC:               (-200309)
 DAQmxErrorSampTbRateSampTbSrcMismatch:                                  (-200308)
 DAQmxErrorMasterTbRateMasterTbSrcMismatch:                              (-200307)
 DAQmxErrorSampsPerChanTooBig:                                           (-200306)
 DAQmxErrorFinitePulseTrainNotPossible:                                  (-200305)
 DAQmxErrorExtMasterTimebaseRateNotSpecified:                            (-200304)
 DAQmxErrorExtSampClkSrcNotSpecified:                                    (-200303)
 DAQmxErrorInputSignalSlowerThanMeasTime:                                (-200302)
 DAQmxErrorCannotUpdatePulseGenProperty:                                 (-200301)
 DAQmxErrorInvalidTimingType:                                            (-200300)
 DAQmxErrorPropertyUnavailWhenUsingOnboardMemory:                        (-200297)
 DAQmxErrorCannotWriteAfterStartWithOnboardMemory:                       (-200295)
 DAQmxErrorNotEnoughSampsWrittenForInitialXferRqstCondition:             (-200294)
 DAQmxErrorNoMoreSpace:                                                  (-200293)
 DAQmxErrorSamplesCanNotYetBeWritten:                                    (-200292)
 DAQmxErrorGenStoppedToPreventIntermediateBufferRegenOfOldSamples:       (-200291)
 DAQmxErrorGenStoppedToPreventRegenOfOldSamples:                         (-200290)
 DAQmxErrorSamplesNoLongerWriteable:                                     (-200289)
 DAQmxErrorSamplesWillNeverBeGenerated:                                  (-200288)
 DAQmxErrorNegativeWriteSampleNumber:                                    (-200287)
 DAQmxErrorNoAcqStarted:                                                 (-200286)
 DAQmxErrorSamplesNotYetAvailable:                                       (-200284)
 DAQmxErrorAcqStoppedToPreventIntermediateBufferOverflow:                (-200283)
 DAQmxErrorNoRefTrigConfigured:                                          (-200282)
 DAQmxErrorCannotReadRelativeToRefTrigUntilDone:                         (-200281)
 DAQmxErrorSamplesNoLongerAvailable:                                     (-200279)
 DAQmxErrorSamplesWillNeverBeAvailable:                                  (-200278)
 DAQmxErrorNegativeReadSampleNumber:                                     (-200277)
 DAQmxErrorExternalSampClkAndRefClkThruSameTerm:                         (-200276)
 DAQmxErrorExtSampClkRateTooLowForClkIn:                                 (-200275)
 DAQmxErrorExtSampClkRateTooHighForBackplane:                            (-200274)
 DAQmxErrorSampClkRateAndDivCombo:                                       (-200273)
 DAQmxErrorSampClkRateTooLowForDivDown:                                  (-200272)
 DAQmxErrorProductOfAOMinAndGainTooSmall:                                (-200271)
 DAQmxErrorInterpolationRateNotPossible:                                 (-200270)
 DAQmxErrorOffsetTooLarge:                                               (-200269)
 DAQmxErrorOffsetTooSmall:                                               (-200268)
 DAQmxErrorProductOfAOMaxAndGainTooLarge:                                (-200267)
 DAQmxErrorMinAndMaxNotSymmetriC:                                        (-200266)
 DAQmxErrorInvalidAnalogTrigSrC:                                         (-200265)
 DAQmxErrorTooManyChansForAnalogRefTrig:                                 (-200264)
 DAQmxErrorTooManyChansForAnalogPauseTrig:                               (-200263)
 DAQmxErrorTrigWhenOnDemandSampTiming:                                   (-200262)
 DAQmxErrorInconsistentAnalogTrigSettings:                               (-200261)
 DAQmxErrorMemMapDataXferModeSampTimingCombo:                            (-200260)
 DAQmxErrorInvalidJumperedAttr:                                          (-200259)
 DAQmxErrorInvalidGainBasedOnMinMax:                                     (-200258)
 DAQmxErrorInconsistentExcit:                                            (-200257)
 DAQmxErrorTopologyNotSupportedByCfgTermBlock:                           (-200256)
 DAQmxErrorBuiltInTempSensorNotSupported:                                (-200255)
 DAQmxErrorInvalidTerm:                                                  (-200254)
 DAQmxErrorCannotTristateTerm:                                           (-200253)
 DAQmxErrorCannotTristateBusyTerm:                                       (-200252)
 DAQmxErrorNoDMAChansAvailable:                                          (-200251)
 DAQmxErrorInvalidWaveformLengthWithinLoopInScript:                      (-200250)
 DAQmxErrorInvalidSubsetLengthWithinLoopInScript:                        (-200249)
 DAQmxErrorMarkerPosInvalidForLoopInScript:                              (-200248)
 DAQmxErrorIntegerExpectedInScript:                                      (-200247)
 DAQmxErrorPLLBecameUnlocked:                                            (-200246)
 DAQmxErrorPLLLock:                                                      (-200245)
 DAQmxErrorDDCClkOutDCMBecameUnlocked:                                   (-200244)
 DAQmxErrorDDCClkOutDCMLock:                                             (-200243)
 DAQmxErrorClkDoublerDCMBecameUnlocked:                                  (-200242)
 DAQmxErrorClkDoublerDCMLock:                                            (-200241)
 DAQmxErrorSampClkDCMBecameUnlocked:                                     (-200240)
 DAQmxErrorSampClkDCMLock:                                               (-200239)
 DAQmxErrorSampClkTimebaseDCMBecameUnlocked:                             (-200238)
 DAQmxErrorSampClkTimebaseDCMLock:                                       (-200237)
 DAQmxErrorAttrCannotBeReset:                                            (-200236)
 DAQmxErrorExplanationNotFound:                                          (-200235)
 DAQmxErrorWriteBufferTooSmall:                                          (-200234)
 DAQmxErrorSpecifiedAttrNotValid:                                        (-200233)
 DAQmxErrorAttrCannotBeRead:                                             (-200232)
 DAQmxErrorAttrCannotBeSet:                                              (-200231)
 DAQmxErrorNULLPtrForC_Api:                                              (-200230)
 DAQmxErrorReadBufferTooSmall:                                           (-200229)
 DAQmxErrorBufferTooSmallForString:                                      (-200228)
 DAQmxErrorNoAvailTrigLinesOnDevice:                                     (-200227)
 DAQmxErrorTrigBusLineNotAvail:                                          (-200226)
 DAQmxErrorCouldNotReserveRequestedTrigLine:                             (-200225)
 DAQmxErrorTrigLineNotFound:                                             (-200224)
 DAQmxErrorSCXI1126ThreshHystCombination:                                (-200223)
 DAQmxErrorAcqStoppedToPreventInputBufferOverwrite:                      (-200222)
 DAQmxErrorTimeoutExceeded:                                              (-200221)
 DAQmxErrorInvalidDeviceId:                                              (-200220)
 DAQmxErrorInvalidAOChanOrder:                                           (-200219)
 DAQmxErrorSampleTimingTypeAndDataXferMode:                              (-200218)
 DAQmxErrorBufferWithOnDemandSampTiming:                                 (-200217)
 DAQmxErrorBufferAndDataXferMode:                                        (-200216)
 DAQmxErrorMemMapAndBuffer:                                              (-200215)
 DAQmxErrorNoAnalogTrigHw:                                               (-200214)
 DAQmxErrorTooManyPretrigPlusMinPostTrigSamps:                           (-200213)
 DAQmxErrorInconsistentUnitsSpecified:                                   (-200212)
 DAQmxErrorMultipleRelaysForSingleRelayOp:                               (-200211)
 DAQmxErrorMultipleDevIDsPerChassisSpecifiedInList:                      (-200210)
 DAQmxErrorDuplicateDevIDInList:                                         (-200209)
 DAQmxErrorInvalidRangeStatementCharInList:                              (-200208)
 DAQmxErrorInvalidDeviceIDInList:                                        (-200207)
 DAQmxErrorTriggerPolarityConflict:                                      (-200206)
 DAQmxErrorCannotScanWithCurrentTopology:                                (-200205)
 DAQmxErrorUnexpectedIdentifierInFullySpecifiedPathInList:               (-200204)
 DAQmxErrorSwitchCannotDriveMultipleTrigLines:                           (-200203)
 DAQmxErrorInvalidRelayName:                                             (-200202)
 DAQmxErrorSwitchScanlistTooBig:                                         (-200201)
 DAQmxErrorSwitchChanInUse:                                              (-200200)
 DAQmxErrorSwitchNotResetBeforeScan:                                     (-200199)
 DAQmxErrorInvalidTopology:                                              (-200198)
 DAQmxErrorAttrNotSupported:                                             (-200197)
 DAQmxErrorUnexpectedEndOfActionsInList:                                 (-200196)
 DAQmxErrorPowerBudgetExceeded:                                          (-200195)
 DAQmxErrorHWUnexpectedlyPoweredOffAndOn:                                (-200194)
 DAQmxErrorSwitchOperationNotSupported:                                  (-200193)
 DAQmxErrorOnlyContinuousScanSupported:                                  (-200192)
 DAQmxErrorSwitchDifferentTopologyWhenScanning:                          (-200191)
 DAQmxErrorDisconnectPathNotSameAsExistingPath:                          (-200190)
 DAQmxErrorConnectionNotPermittedOnChanReservedForRouting:               (-200189)
 DAQmxErrorCannotConnectSrcChans:                                        (-200188)
 DAQmxErrorCannotConnectChannelToItself:                                 (-200187)
 DAQmxErrorChannelNotReservedForRouting:                                 (-200186)
 DAQmxErrorCannotConnectChansDirectly:                                   (-200185)
 DAQmxErrorChansAlreadyConnected:                                        (-200184)
 DAQmxErrorChanDuplicatedInPath:                                         (-200183)
 DAQmxErrorNoPathToDisconnect:                                           (-200182)
 DAQmxErrorInvalidSwitchChan:                                            (-200181)
 DAQmxErrorNoPathAvailableBetween2SwitchChans:                           (-200180)
 DAQmxErrorExplicitConnectionExists:                                     (-200179)
 DAQmxErrorSwitchDifferentSettlingTimeWhenScanning:                      (-200178)
 DAQmxErrorOperationOnlyPermittedWhileScanning:                          (-200177)
 DAQmxErrorOperationNotPermittedWhileScanning:                           (-200176)
 DAQmxErrorHardwareNotResponding:                                        (-200175)
 DAQmxErrorInvalidSampAndMasterTimebaseRateCombo:                        (-200173)
 DAQmxErrorNonZeroBufferSizeInProgIOXfer:                                (-200172)
 DAQmxErrorVirtualChanNameUsed:                                          (-200171)
 DAQmxErrorPhysicalChanDoesNotExist:                                     (-200170)
 DAQmxErrorMemMapOnlyForProgIOXfer:                                      (-200169)
 DAQmxErrorTooManyChans:                                                 (-200168)
 DAQmxErrorCannotHaveCJTempWithOtherChans:                               (-200167)
 DAQmxErrorOutputBufferUnderwrite:                                       (-200166)
 DAQmxErrorSensorInvalidCompletionResistance:                            (-200163)
 DAQmxErrorVoltageExcitIncompatibleWith2WireCfg:                         (-200162)
 DAQmxErrorIntExcitSrcNotAvailable:                                      (-200161)
 DAQmxErrorCannotCreateChannelAfterTaskVerified:                         (-200160)
 DAQmxErrorLinesReservedForSCXIControl:                                  (-200159)
 DAQmxErrorCouldNotReserveLinesForSCXIControl:                           (-200158)
 DAQmxErrorCalibrationFailed:                                            (-200157)
 DAQmxErrorReferenceFrequencyInvalid:                                    (-200156)
 DAQmxErrorReferenceResistanceInvalid:                                   (-200155)
 DAQmxErrorReferenceCurrentInvalid:                                      (-200154)
 DAQmxErrorReferenceVoltageInvalid:                                      (-200153)
 DAQmxErrorEEPROMDataInvalid:                                            (-200152)
 DAQmxErrorCabledModuleNotCapableOfRoutingAi:                            (-200151)
 DAQmxErrorChannelNotAvailableInParallelMode:                            (-200150)
 DAQmxErrorExternalTimebaseRateNotKnownForDelay:                         (-200149)
 DAQmxErrorFREQOUTCannotProduceDesiredFrequency:                         (-200148)
 DAQmxErrorMultipleCounterInputTask:                                     (-200147)
 DAQmxErrorCounterStartPauseTriggerConflict:                             (-200146)
 DAQmxErrorCounterInputPauseTriggerAndSampleClockInvalid:                (-200145)
 DAQmxErrorCounterOutputPauseTriggerInvalid:                             (-200144)
 DAQmxErrorCounterTimebaseRateNotSpecified:                              (-200143)
 DAQmxErrorCounterTimebaseRateNotFound:                                  (-200142)
 DAQmxErrorCounterOverflow:                                              (-200141)
 DAQmxErrorCounterNoTimebaseEdgesBetweenGates:                           (-200140)
 DAQmxErrorCounterMaxMinRangeFreq:                                       (-200139)
 DAQmxErrorCounterMaxMinRangeTime:                                       (-200138)
 DAQmxErrorSuitableTimebaseNotFoundTimeCombo:                            (-200137)
 DAQmxErrorSuitableTimebaseNotFoundFrequencyCombo:                       (-200136)
 DAQmxErrorInternalTimebaseSourceDivisorCombo:                           (-200135)
 DAQmxErrorInternalTimebaseSourceRateCombo:                              (-200134)
 DAQmxErrorInternalTimebaseRateDivisorSourceCombo:                       (-200133)
 DAQmxErrorExternalTimebaseRateNotknownForRate:                          (-200132)
 DAQmxErrorAnalogTrigChanNotFirstInScanList:                             (-200131)
 DAQmxErrorNoDivisorForExternalSignal:                                   (-200130)
 DAQmxErrorAttributeInconsistentAcrossRepeatedPhysicalChannels:          (-200128)
 DAQmxErrorCannotHandshakeWithPort0:                                     (-200127)
 DAQmxErrorControlLineConflictOnPortC:                                   (-200126)
 DAQmxErrorLines4To7ConfiguredForOutput:                                 (-200125)
 DAQmxErrorLines4To7ConfiguredForInput:                                  (-200124)
 DAQmxErrorLines0To3ConfiguredForOutput:                                 (-200123)
 DAQmxErrorLines0To3ConfiguredForInput:                                  (-200122)
 DAQmxErrorPortConfiguredForOutput:                                      (-200121)
 DAQmxErrorPortConfiguredForInput:                                       (-200120)
 DAQmxErrorPortConfiguredForStaticDigitalOps:                            (-200119)
 DAQmxErrorPortReservedForHandshaking:                                   (-200118)
 DAQmxErrorPortDoesNotSupportHandshakingDataIo:                          (-200117)
 DAQmxErrorCannotTristate8255OutputLines:                                (-200116)
 DAQmxErrorTemperatureOutOfRangeForCalibration:                          (-200113)
 DAQmxErrorCalibrationHandleInvalid:                                     (-200112)
 DAQmxErrorPasswordRequired:                                             (-200111)
 DAQmxErrorIncorrectPassword:                                            (-200110)
 DAQmxErrorPasswordTooLong:                                              (-200109)
 DAQmxErrorCalibrationSessionAlreadyOpen:                                (-200108)
 DAQmxErrorSCXIModuleIncorrect:                                          (-200107)
 DAQmxErrorAttributeInconsistentAcrossChannelsOnDevice:                  (-200106)
 DAQmxErrorSCXI1122ResistanceChanNotSupportedForCfg:                     (-200105)
 DAQmxErrorBracketPairingMismatchInList:                                 (-200104)
 DAQmxErrorInconsistentNumSamplesToWrite:                                (-200103)
 DAQmxErrorIncorrectDigitalPattern:                                      (-200102)
 DAQmxErrorIncorrectNumChannelsToWrite:                                  (-200101)
 DAQmxErrorIncorrectReadFunction:                                        (-200100)
 DAQmxErrorPhysicalChannelNotSpecified:                                  (-200099)
 DAQmxErrorMoreThanOneTerminal:                                          (-200098)
 DAQmxErrorMoreThanOneActiveChannelSpecified:                            (-200097)
 DAQmxErrorInvalidNumberSamplesToRead:                                   (-200096)
 DAQmxErrorAnalogWaveformExpected:                                       (-200095)
 DAQmxErrorDigitalWaveformExpected:                                      (-200094)
 DAQmxErrorActiveChannelNotSpecified:                                    (-200093)
 DAQmxErrorFunctionNotSupportedForDeviceTasks:                           (-200092)
 DAQmxErrorFunctionNotInLibrary:                                         (-200091)
 DAQmxErrorLibraryNotPresent:                                            (-200090)
 DAQmxErrorDuplicateTask:                                                (-200089)
 DAQmxErrorInvalidTask:                                                  (-200088)
 DAQmxErrorInvalidChannel:                                               (-200087)
 DAQmxErrorInvalidSyntaxForPhysicalChannelRange:                         (-200086)
 DAQmxErrorMinNotLessThanMax:                                            (-200082)
 DAQmxErrorSampleRateNumChansConvertPeriodCombo:                         (-200081)
 DAQmxErrorAODuringCounter1DMAConflict:                                  (-200079)
 DAQmxErrorAIDuringCounter0DMAConflict:                                  (-200078)
 DAQmxErrorInvalidAttributeValue:                                        (-200077)
 DAQmxErrorSuppliedCurrentDataOutsideSpecifiedRange:                     (-200076)
 DAQmxErrorSuppliedVoltageDataOutsideSpecifiedRange:                     (-200075)
 DAQmxErrorCannotStoreCalConst:                                          (-200074)
 DAQmxErrorSCXIModuleNotFound:                                           (-200073)
 DAQmxErrorDuplicatePhysicalChansNotSupported:                           (-200072)
 DAQmxErrorTooManyPhysicalChansInList:                                   (-200071)
 DAQmxErrorInvalidAdvanceEventTriggerType:                               (-200070)
 DAQmxErrorDeviceIsNotAValidSwitch:                                      (-200069)
 DAQmxErrorDeviceDoesNotSupportScanning:                                 (-200068)
 DAQmxErrorScanListCannotBeTimed:                                        (-200067)
 DAQmxErrorConnectOperatorInvalidAtPointInList:                          (-200066)
 DAQmxErrorUnexpectedSwitchActionInList:                                 (-200065)
 DAQmxErrorUnexpectedSeparatorInList:                                    (-200064)
 DAQmxErrorExpectedTerminatorInList:                                     (-200063)
 DAQmxErrorExpectedConnectOperatorInList:                                (-200062)
 DAQmxErrorExpectedSeparatorInList:                                      (-200061)
 DAQmxErrorFullySpecifiedPathInListContainsRange:                        (-200060)
 DAQmxErrorConnectionSeparatorAtEndOfList:                               (-200059)
 DAQmxErrorIdentifierInListTooLong:                                      (-200058)
 DAQmxErrorDuplicateDeviceIDInListWhenSettling:                          (-200057)
 DAQmxErrorChannelNameNotSpecifiedInList:                                (-200056)
 DAQmxErrorDeviceIDNotSpecifiedInList:                                   (-200055)
 DAQmxErrorSemicolonDoesNotFollowRangeInList:                            (-200054)
 DAQmxErrorSwitchActionInListSpansMultipleDevices:                       (-200053)
 DAQmxErrorRangeWithoutAConnectActionInList:                             (-200052)
 DAQmxErrorInvalidIdentifierFollowingSeparatorInList:                    (-200051)
 DAQmxErrorInvalidChannelNameInList:                                     (-200050)
 DAQmxErrorInvalidNumberInRepeatStatementInList:                         (-200049)
 DAQmxErrorInvalidTriggerLineInList:                                     (-200048)
 DAQmxErrorInvalidIdentifierInListFollowingDeviceId:                     (-200047)
 DAQmxErrorInvalidIdentifierInListAtEndOfSwitchAction:                   (-200046)
 DAQmxErrorDeviceRemoved:                                                (-200045)
 DAQmxErrorRoutingPathNotAvailable:                                      (-200044)
 DAQmxErrorRoutingHardwareBusy:                                          (-200043)
 DAQmxErrorRequestedSignalInversionForRoutingNotPossible:                (-200042)
 DAQmxErrorInvalidRoutingDestinationTerminalName:                        (-200041)
 DAQmxErrorInvalidRoutingSourceTerminalName:                             (-200040)
 DAQmxErrorRoutingNotSupportedForDevice:                                 (-200039)
 DAQmxErrorWaitIsLastInstructionOfLoopInScript:                          (-200038)
 DAQmxErrorClearIsLastInstructionOfLoopInScript:                         (-200037)
 DAQmxErrorInvalidLoopIterationsInScript:                                (-200036)
 DAQmxErrorRepeatLoopNestingTooDeepInScript:                             (-200035)
 DAQmxErrorMarkerPositionOutsideSubsetInScript:                          (-200034)
 DAQmxErrorSubsetStartOffsetNotAlignedInScript:                          (-200033)
 DAQmxErrorInvalidSubsetLengthInScript:                                  (-200032)
 DAQmxErrorMarkerPositionNotAlignedInScript:                             (-200031)
 DAQmxErrorSubsetOutsideWaveformInScript:                                (-200030)
 DAQmxErrorMarkerOutsideWaveformInScript:                                (-200029)
 DAQmxErrorWaveformInScriptNotInMem:                                     (-200028)
 DAQmxErrorKeywordExpectedInScript:                                      (-200027)
 DAQmxErrorBufferNameExpectedInScript:                                   (-200026)
 DAQmxErrorProcedureNameExpectedInScript:                                (-200025)
 DAQmxErrorScriptHasInvalidIdentifier:                                   (-200024)
 DAQmxErrorScriptHasInvalidCharacter:                                    (-200023)
 DAQmxErrorResourceAlreadyReserved:                                      (-200022)
 DAQmxErrorSelfTestFailed:                                               (-200020)
 DAQmxErrorADCOverrun:                                                   (-200019)
 DAQmxErrorDACUnderflow:                                                 (-200018)
 DAQmxErrorInputFIFOUnderflow:                                           (-200017)
 DAQmxErrorOutputFIFOUnderflow:                                          (-200016)
 DAQmxErrorSCXISerialCommunication:                                      (-200015)
 DAQmxErrorDigitalTerminalSpecifiedMoreThanOnce:                         (-200014)
 DAQmxErrorDigitalOutputNotSupported:                                    (-200012)
 DAQmxErrorInconsistentChannelDirections:                                (-200011)
 DAQmxErrorInputFIFOOverflow:                                            (-200010)
 DAQmxErrorTimeStampOverwritten:                                         (-200009)
 DAQmxErrorStopTriggerHasNotOccurred:                                    (-200008)
 DAQmxErrorRecordNotAvailable:                                           (-200007)
 DAQmxErrorRecordOverwritten:                                            (-200006)
 DAQmxErrorDataNotAvailable:                                             (-200005)
 DAQmxErrorDataOverwrittenInDeviceMemory:                                (-200004)
 DAQmxErrorDuplicatedChannel:                                            (-200003)
 DAQmxWarningTimestampCounterRolledOver:                                  (200003)
 DAQmxWarningInputTerminationOverloaded:                                  (200004)
 DAQmxWarningADCOverloaded:                                               (200005)
 DAQmxWarningPLLUnlocked:                                                 (200007)
 DAQmxWarningCounter0DMADuringAIConflict:                                 (200008)
 DAQmxWarningCounter1DMADuringAOConflict:                                 (200009)
 DAQmxWarningStoppedBeforeDone:                                           (200010)
 DAQmxWarningRateViolatesSettlingTime:                                    (200011)
 DAQmxWarningRateViolatesMaxADCRate:                                      (200012)
 DAQmxWarningUserDefInfoStringTooLong:                                    (200013)
 DAQmxWarningTooManyInterruptsPerSecond:                                  (200014)
 DAQmxWarningPotentialGlitchDuringWrite:                                  (200015)
 DAQmxWarningDevNotSelfCalibratedWithDAQmx:                               (200016)
 DAQmxWarningAISampRateTooLow:                                            (200017)
 DAQmxWarningAIConvRateTooLow:                                            (200018)
 DAQmxWarningReadOffsetCoercion:                                          (200019)
 DAQmxWarningPretrigCoercion:                                             (200020)
 DAQmxWarningSampValCoercedToMax:                                         (200021)
 DAQmxWarningSampValCoercedToMin:                                         (200022)
 DAQmxWarningPropertyVersionNew:                                          (200024)
 DAQmxWarningUserDefinedInfoTooLong:                                      (200025)
 DAQmxWarningCAPIStringTruncatedToFitBuffer:                              (200026)
 DAQmxWarningSampClkRateTooLow:                                           (200027)
 DAQmxWarningPossiblyInvalidCTRSampsInFiniteDMAAcq:                       (200028)
 DAQmxWarningRISAcqCompletedSomeBinsNotFilled:                            (200029)
 DAQmxWarningPXIDevTempExceedsMaxOpTemp:                                  (200030)
 DAQmxWarningOutputGainTooLowForRFFreq:                                   (200031)
 DAQmxWarningOutputGainTooHighForRFFreq:                                  (200032)
 DAQmxWarningMultipleWritesBetweenSampClks:                               (200033)
 DAQmxWarningDeviceMayShutDownDueToHighTemp:                              (200034)
 DAQmxWarningReadNotCompleteBeforeSampClk:                                (209800)
 DAQmxWarningWriteNotCompleteBeforeSampClk:                               (209801)


; this is adapted from orginal nidaqmxbase.h file and was tested on a MacIntel computer
; first of all creates structures to emulate NI library

;******************************************************************************
;*** NI-DAQBasemx Function Declarations ***************************************
;******************************************************************************

;******************************************************
;***         Task Configuration/Control             ***
;******************************************************


DAQmxBaseLoadTask: make routine![
	{Loads an existing named task created by you with the NI-DAQmx Base Task Configuration Utility. 
	If you use this function to load a task, you must use DAQmxBaseClearTask to destroy it.}
	taskName [string!]
	PtrTaskHandle [struct! [uInt32 [integer!]]]
	return: [integer!]
] libni "DAQmxBaseLoadTask"


DAQmxBaseCreateTask: make routine! [
	{Creates a task. If you use this function to create a task, you must use DAQmxBaseClearTask to destroy it.}
	taskName [string!]
	PtrTaskHandle [struct! [uInt32 [integer!]]]
	return: [integer!]
] libni "DAQmxBaseCreateTask"

 
DAQmxBaseStartTask: make routine! [
	{Transitions the task from the committed state to the running state, which begins measurement or generation. 
	Using this function is required for all NI-DAQmx Base applications. 
	This function is not required if you are using a DAQmxBase Write function with autoStart set to TRUE.}
	TaskHandle [integer!]
	return: [integer!]
] libni "DAQmxBaseStartTask" 

DAQmxBaseStopTask: make routine! [
	{Stops the task and returns it to the state it was in before you called DAQmxBaseStartTask 
	or called an DAQmxBase Write function with autoStart set to TRUE. 
	Using this function is required for all NI-DAQmx Base applications.}
	TaskHandle [integer!]
	return: [integer!]
] libni  "DAQmxBaseStopTask" 
 
DAQmxBaseClearTask: make routine! [
	{Clears the task. Make sure the task has been stopped by calling DAQmxBaseStopTask.}
	TaskHandle [integer!]
	return: [integer!]
] libni "DAQmxBaseClearTask" 


DAQmxBaseIsTaskDone: make routine! [
	{Queries whether the task completed execution. 
	Use this function to ensure that the specified operation is complete before you stop the task.}
	TaskHandle [integer!]
	isTaskDone [struct! [bool32 [integer!]]]
	return: [integer!]
] libni "DAQmxBaseIsTaskDone" 


;******************************************************
;***        Channel Configuration/Creation          ***
;******************************************************
DAQmxBaseCreateAIVoltageChan: make routine![
	{Creates channel(s) for voltage measurement and adds the channel(s) to the task you specify with taskHandle.}
	TaskHandle [integer!]
	physicalChannel [string!]
	nameToAssignToChannel [string!]; not used/ use empty string
	terminalConfig [integer!]
	minVal [decimal!]
	maxVal [decimal!]
	units [integer!]
	customScaleName [string!] ;not used/ use empty string
	;customScaleName [struct! [pnil [string!]]["0"]] ;not used/ use none by setting CustomScaleName address to 0
	return: [integer!]
] libni "DAQmxBaseCreateAIVoltageChan"


DAQmxBaseCreateAIThrmcplChan: make routine! [
	{This function is only valid for a NI USB-9211 device. 
	Creates channel(s) that use a thermocouple to measure temperature and adds the channel(s) 
	to the task you specify with taskHandle.}
	TaskHandle [integer!]
	physicalChannel [string!]
	nameToAssignToChannel [string!]; not used/ use empty string
	minVal [decimal!]
	maxVal [decimal!]
	units [integer!]
	thermocoupleType [integer!]
	cjcSource [integer!]
	cjVal [decimal!]
	cjcChannel [string!]
	return: [integer!]
] libni "DAQmxBaseCreateAIThrmcplChan" 


DAQmxBaseCreateAOVoltageChan: make routine! [
	{Creates channel(s) to generate voltage and adds the channel(s) to the task you specify with taskHandle.}
	TaskHandle [integer!]
	physicalChannel [string!]
	nameToAssignToChannel [string!]; not used/ use empty string
	minVal [decimal!]
	maxVal [decimal!]
	units [integer!]
	customScaleName [string!] ;not used/ use empty string
	return: [integer!]
] libni "DAQmxBaseCreateAOVoltageChan"


DAQmxBaseCreateDIChan: make routine![
	{Creates channel(s) to measure digital signals and adds the channel(s) to the task you specify with taskHandle. 
	For some devices (such as E Series), NI-DAQmx Base supports grouping the digital lines of a port as single channel, 
	not multiple channels.}
	TaskHandle [integer!]
	lines [string!]
	nameToAssignToLines [string!]; not used/ use empty string
	lineGrouping [integer!]	
	return: [integer!]
] libni "DAQmxBaseCreateDIChan"
 

DAQmxBaseCreateDOChan: make routine![
	{Creates channel(s) to generate digital signals and adds the channel(s) to the task you specify with taskHandle. 
	For some devices (such as E Series), NI-DAQmx Base supports grouping the digital lines of a port as a single channel, 
	not multiple channels.}
	TaskHandle [integer!]
	lines [string!]
	nameToAssignToLines [string!]; not used/ use empty string
	lineGrouping [integer!]	
	return: [integer!]
] libni "DAQmxBaseCreateDOChan"

 
DAQmxBaseCreateCIPeriodChan: make routine![
	{Creates a channel to measure the period of a digital signal and adds the channel to the task you specify with taskHandle. 
	You can create only one counter input channel at a time with this function because a task can include only one counter input channel. 
	To read from multiple counters simultaneously, use a separate task for each counter. 
	Connect the input signal to the default input terminal of the counter.}
	TaskHandle [integer!]
	counter [string!] ;The name of the counter to use to create virtual channels such as Dev1/ctr0.
	nameToAssignToLines [string!]; not used/ use empty string
	minVal [decimal!]
	maxVal [decimal!]
	units [integer!]	
	edge [integer!]
	measMethod [integer!]
	measTime [decimal!] ;  always pass 0 for this parameter.
	divisor [integer!] ; always pass 1 for this parameter.
	customScaleName [string!] ;not used/ use none by setting CustomScaleName address to 0
	return: [integer!]
] libni "DAQmxBaseCreateCIPeriodChan"          


DAQmxBaseCreateCICountEdgesChan: make routine![
	{Creates a channel to count the number of rising or falling edges of a digital signal and adds the channel to the task you specify with taskHandle. 
	You can create only one counter input channel at a time with this function because a task can include only one counter input channel. 
	To read from multiple counters simultaneously, use a separate task for each counter. 
	Connect the input signal to the default input terminal of the counter.}
	TaskHandle [integer!]
	counter [string!] ;The name of the counter to use to create virtual channels such as Dev1/ctr0.
	nameToAssignToLines [string!]; not used/ use empty string
	edge [integer!]
	initialCount [integer!]
	countDirection [integer!]	
	return: [integer!]
] libni "DAQmxBaseCreateCICountEdgesChan"

        
DAQmxBaseCreateCIPulseWidthChan: make routine![
	{Creates a channel to measure the width of a digital pulse and adds the channel to the task you specify with taskHandle. 
	startingEdge determines whether to measure a high pulse or low pulse. 
	You can create only one counter input channel at a time with this function because a task can include only one counter input channel. 
	To read from multiple counters simultaneously, use a separate task for each counter. 
	Connect the input signal to the default input terminal of the counter.}
	TaskHandle [integer!]
	counter [string!] ;The name of the counter to use to create virtual channels such as Dev1/ctr0.
	nameToAssignToLines [string!]; not used/ use empty string
	minVal [decimal!]
	maxVal [decimal!]
	units [integer!]	
	startingEdge [integer!]
	customScaleName [string!] ;not used/ use none by setting CustomScaleName address to 0
	return: [integer!]
] libni "DAQmxBaseCreateCIPulseWidthChan"


DAQmxBaseCreateCILinEncoderChan: make routine![
	{Creates a channel that uses a linear encoder to measure linear position. 
	You can create only one counter input channel at a time with this function because a task can include only one counter input channel. T
	o read from multiple counters simultaneously, use a separate task for each counter. 
	Connect the input signals to the default input terminals of the counter unless you select different input terminals.}
	TaskHandle [integer!]
	counter [string!] ;The name of the counter to use to create virtual channels such as Dev1/ctr0.
	nameToAssignToLines [string!]; not used/ use empty string
	decodingType [integer!]
	ZidxEnable [integer!]
	ZidxVal [decimal!]
	ZidxPhase [integer!]
	Units [integer!]
	distPerPulse [decimal!]
	initialPos [decimal!]
	customScaleName [string!] ;not used/ use none by setting CustomScaleName address to 0
	return: [integer!]
] libni "DAQmxBaseCreateCILinEncoderChan"


DAQmxBaseCreateCIAngEncoderChan: make routine![
	{Creates a channel that uses an angular encoder to measure angular position. 
	You can create only one counter input channel at a time with this function because a task can include only one counter input channel. 
	To read from multiple counters simultaneously, use a separate task for each counter. 
	Connect the input signals to the default input terminals of the counter unless you select different input terminals.}
	TaskHandle [integer!]
	counter [string!] ;The name of the counter to use to create virtual channels such as Dev1/ctr0.
	nameToAssignToLines [string!]; not used/ use empty string
	decodingType [integer!]
	ZidxEnable [integer!]
	ZidxVal [decimal!]
	ZidxPhase [integer!]
	units [integer!]
	pulsesPerRev [integer!]
	initialAngle [decimal!]
	customScaleName [string!] ;not used/ use none by setting CustomScaleName address to 0
	return: [integer!]
] libni "DAQmxBaseCreateCIAngEncoderChan"
 
DAQmxBaseCreateCOPulseChanFreq: make routine! [
	{Creates a channel to generate digital pulses defined by freq and dutyCycle and adds the channel to the task you specify with taskHandle. 
	The pulses appear on the default output terminal of the counter.
	You can create only one counter output channel at a time with this function because a task can include only one counter output channel. 
	To use multiple counters simultaneously, use a separate task for each counter.}
	TaskHandle [integer!]
	counter [string!] ;The name of the counter to use to create virtual channels such as Dev1/ctr0.
	nameToAssignToLines [string!]; not used/ use empty string
	units [integer!]
	idleState [integer!]
	initialDelay [decimal!]
	freq [decimal!]
	dutyCycle [decimal!]
	return: [integer!]
] libni "DAQmxBaseCreateCOPulseChanFreq"


DAQmxBaseGetChanAttribute: make routine! [
	{ undocumented: to be tested for value parameter}
 	TaskHandle [integer!]
 	channel [string!]
 	attribute [integer!]
 	value [integer!] ;*void just a pointer
 	return: [integer!]
 ] libni "DAQmxBaseGetChanAttribute"
 
DAQmxBaseSetChanAttribute: make routine! [
 	{ undocumented}
 	TaskHandle [integer!]
 	channel [string!]
 	attribute [integer!]
 	value [integer!]
 	return: [integer!]
 ] libni "DAQmxBaseSetChanAttribute"
 


;******************************************************
;***                    Timing                      ***
;******************************************************


;(Analog/Counter Timing)
DAQmxBaseCfgSampClkTiming: make routine! [
	{Sets the source of the Sample Clock, the rate of the Sample Clock, and the number of samples to acquire or generate.}
	TaskHandle [integer!]
	source [string!]
	rate [decimal!]
	activeEdge [integer!]
	sampleMode [integer!]
	sampsPerChan [integer!]
	return: [integer!]
] libni "DAQmxBaseCfgSampClkTiming"

;(Digital Timing)
DAQmxBaseCfgImplicitTiming: make routine! [
	{Sets only the number of samples to acquire or generate without specifying timing. 
	Typically, you should use this function when the task does not require sample timing, 
	such as tasks that use counters for buffered frequency measurement, buffered period measurement, or pulse train generation.}
	TaskHandle [integer!]
	sampleMode [integer!]
	sampsPerChan [integer!]
	return: [integer!]
] libni "DAQmxBaseCfgImplicitTiming" 


;******************************************************
;***                  Triggering                    ***
;****************************************************** 

DAQmxBaseDisableStartTrig: make routine! [
	{Configures the task to start acquiring or generating samples immediately upon starting the task.}
	TaskHandle [integer!]
	return: [integer!]
] libni "DAQmxBaseDisableStartTrig"


DAQmxBaseCfgDigEdgeStartTrig: make routine! [
	{Configures the task to start acquiring or generating samples on a rising or falling edge of a digital signal.}
	TaskHandle [integer!]
	triggerSource[string!]
	triggerEdge [integer!]
	return: [integer!]
] libni "DAQmxBaseCfgDigEdgeStartTrig"

DAQmxBaseCfgAnlgEdgeStartTrig: make routine! [
	{Configures the task to start acquiring samples when an analog signal crosses the level you specify.}
	TaskHandle [integer!]
	triggerSource[string!]
	triggerSlope [integer!]
	triggerLevel [decimal!]
	return: [integer!]
] libni "DAQmxBaseCfgAnlgEdgeStartTrig"

DAQmxBaseDisableRefTrig: make routine! [
	{Disables reference triggering for the measurement or generation.}
	TaskHandle [integer!]
	return: [integer!]
] libni "DAQmxBaseDisableRefTrig"
 
DAQmxBaseCfgDigEdgeRefTrig: make routine! [
	{Configures the task to stop the acquisition when the device acquires all pretrigger samples, 
	detects a rising or falling edge of a digital signal, and acquires all posttrigger samples.}
	TaskHandle [integer!]
	triggerSource[string!]
	triggerEdge [integer!] 
	pretriggerSamples [integer!]
	return: [integer!]
] libni "DAQmxBaseCfgDigEdgeRefTrig"


DAQmxBaseCfgAnlgEdgeRefTrig: make routine! [
	{Configures the task to stop the acquisition when the device acquires all pretrigger samples, 
	an analog signal reaches the level you specify, and the device acquires all post-trigger samples.}
	TaskHandle [integer!]
	triggerSource[string!]
	triggerSlope [integer!]
	triggerLevel [decimal!]
	pretriggerSamples [integer!]
	return: [integer!]
] libni "DAQmxBaseCfgAnlgEdgeRefTrig"


	
;******************************************************
;***                 Read Data                      ***
;******************************************************

; readArray and sampsPerChanRead are pointers which are modified by the external library functions
; these pointers are send back to the rebol calling function 

int-ptr: make struct! [value [integer!]] none 


DAQmxBaseReadAnalogF64: make routine! compose/deep/only [
	{Reads multiple floating-point samples from a task that contains one or more analog input channels.}
	TaskHandle [integer!]
	numSampsPerChan [integer!] 
	timeout [decimal!] 
	fillMode [integer!]
	readArray [struct! [value [integer!]] [none]];calling function must pass a structure pointer to readArray
	arraySizeInSamps  [integer!]
	sampsPerChanRead [struct! (first int-ptr)] ; a pointer
	reserved [integer!]; Reserved for future use. Pass 0 to this parameter
	return: [integer!]
] libni "DAQmxBaseReadAnalogF64"
 

DAQmxBaseReadBinaryI16: make routine! [
	{Reads multiple unscaled, signed 16-bit integer samples from a task that contains one or more analog input channels.}
	TaskHandle [integer!]  
	numSampsPerChan [integer!]
	timeout [decimal!]
	fillMode [integer!] 
	readArray[struct! [value [integer!]] [none]];calling function must pass a structure pointer to readArray
	arraySizeInSamps [integer!]
	sampsPerChanRead [struct! [value [integer!]] [none]] ; a pointer
	reserved [integer!]; Reserved for future use. Pass 0 to this parameter
	return: [integer!]
] libni "DAQmxBaseReadBinaryI16"

DAQmxBaseReadBinaryI32: make routine! [
	{Reads multiple unscaled, signed 32-bit integer samples from a task that contains one or more analog input channels.}
	TaskHandle [integer!] 
	numSampsPerChan [integer!]
	timeout [decimal!]
	fillMode [integer!] 
	readArray [struct! [value [integer!]] [none]];calling function must pass a structure pointer to readArray
	arraySizeInSamps [integer!]
	sampsPerChanRead [struct! [value [integer!]] [none]] ; a pointer
	reserved [integer!]; Reserved for future use. Pass 0 to this parameter
	return: [integer!]
] libni "DAQmxBaseReadBinaryI32"

DAQmxBaseReadDigitalU8: make routine! [     
	{Reads multiple 8-bit integer samples from a task that one or more multiple digital input channels. 
	Use this function for devices with up to 8 lines per port. The data is returned in unsigned byte format.}
	TaskHandle [integer!]
	numSampsPerChan [integer!]
	timeout [decimal!]
	fillMode [integer!] 
	readArray [struct! [value [integer!]] [none]];calling function must pass a structure pointer to readArray
	arraySizeInSamps [integer!]
	sampsPerChanRead [struct! [value [integer!]] [none]] ; a pointer
	reserved [integer!]; Reserved for future use. Pass NULL to this parameter
	return: [integer!]
] libni "DAQmxBaseReadDigitalU8"

DAQmxBaseReadDigitalU32: make routine! [
	{Reads multiple 32-bit integer samples from a task that contains one or more digital input channels. 
	Use this return type for devices with up to 32 lines per port. The data is returned in unsigned integer format.}
	TaskHandle [integer!]
	numSampsPerChan [integer!]
	timeout [decimal!]
	fillMode [integer!] 
	readArray [struct! [value [integer!]] [none]];calling function must pass a structure pointer to readArray
	arraySizeInSamps [integer!]
	sampsPerChanRead [struct! [value [integer!]] [none]] ; a pointer
	reserved [integer!]; Reserved for future use. Pass 0 to this parameter
	return: [integer!]
] libni "DAQmxBaseReadDigitalU32"


DAQmxBaseReadDigitalScalarU32: make routine! [
	{Reads a single 32-bit integer sample from a task that contains a single digital input channel. 
	Use this return type for devices with up to 32 lines per port. 
	The data is returned in unsigned integer format.}
	TaskHandle [integer!]
	timeout [decimal!] 
	value [integer!] ; not a pointer just a value
	reserved [integer!]; Reserved for future use. Pass NULL to this parameter
	return: [integer!]
] libni "DAQmxBaseReadDigitalScalarU32"


DAQmxBaseReadCounterF64: make routine! [
	{Reads multiple floating-point samples from a counter task. 
	Use this function when counter samples are scaled to a floating-point value, such as for frequency and period measurements.}
	TaskHandle [integer!]
	numSampsPerChan [integer!]
	timeout [decimal!]
	readArray[struct! [value [integer!]] [none]];calling function must pass a structure pointer to readArray
	arraySizeInSamps [integer!]
	sampsPerChanRead [struct! [value [integer!]] [none]] ; a pointer
	reserved [integer!]; pointer Reserved for future use. Pass 0 to this parameter
	return: [integer!]
] libni "DAQmxBaseReadCounterF64"

DAQmxBaseReadCounterU32: make routine! [
	{Reads multiple 32-bit integer samples from a counter task. 
	Use this function when counter samples are returned unscaled, such as for edge counting.}
	TaskHandle [integer!]
	numSampsPerChan [integer!]
	timeout [decimal!]
	readArray [struct! [value [integer!]] [none]];calling function must pass a structure pointer to readArray
	arraySizeInSamps [integer!]
	sampsPerChanRead [struct! [value [integer!]] [none]] ; a pointer
	reserved [integer!]; pointer Reserved for future use. Pass 0 to this parameter
	return: [integer!]
] libni "DAQmxBaseReadCounterU32"


DAQmxBaseReadCounterScalarF64: make routine![
	{Reads a single floating-point sample from a counter task. 
	Use this function when the counter sample is scaled to a floating-point value, such as for frequency and period measurement.}
	TaskHandle [integer!]
	timeout [decimal!] 
	value [decimal!]
	reserved [integer!]; pointer Reserved for future use. Pass 0 to this parameter
	return: [integer!]
] libni "DAQmxBaseReadCounterScalarF64"


DAQmxBaseReadCounterScalarU32: make routine! [
	{Reads a 32-bit integer sample from a counter task. 
	Use this function when the counter sample is returned unscaled, such as for edge counting.}
	TaskHandle [integer!]
	timeout [decimal!] 
	value [integer!]; 
	reserved [integer!]; pointer Reserved for future use. Pass 0 to this parameter
	return: [integer!]
] libni "DAQmxBaseReadCounterScalarU32"




;******************************************************
;***                 Write Data                     ***
;******************************************************

; revoir les pointeurs

DAQmxBaseWriteAnalogF64: make routine! [
	{Writes multiple floating-point samples to a task that contains one or more analog output channels.}
	TaskHandle [integer!]
	numSampsPerChan [integer!]
	autoStart [integer!]; 0: false
	timeout [decimal!] 
	dataLayout [integer!]
	writeArray [struct! [value [integer!]] [none]] ;pointer The array of 64-bit samples to write to the task
	sampsPerChanWritten [integer!] ; pointer
	reserved [integer!]; null
	return: [integer!]
]  libni "DAQmxBaseWriteAnalogF64"
 

DAQmxBaseWriteDigitalU8: make routine! [
	{Writes multiple eight-bit unsigned integer samples to a task that contains one or more digital output channels. 
	Use this format for devices with up to 8 lines per port.
	Note: Buffered writes require a minimum buffer size of two samples.}
	TTaskHandle [integer!] 
	numSampsPerChan [integer!]
	autoStart [integer!]
	timeout [decimal!] 
	dataLayout [integer!]
	writeArray[struct! [value [integer!]] [none]] ; pointer The array of 8-bit integer samples to write to the task.
	sampsPerChanWritten [integer!]
	reserved [integer!]; null
	return: [integer!]
] libni "DAQmxBaseWriteDigitalU8"


DAQmxBaseWriteDigitalU32: make routine! [
	{Writes multiple 32-bit unsigned integer samples to a task that contains one or more digital output channels. 
	Use this format for devices with up to 32 lines per port.
	Note: Buffered writes require a minimum buffer size of 2 samples.}
	TaskHandle [integer!]
	numSampsPerChan [integer!]
	autoStart [integer!]
	timeout [decimal!] 
	dataLayout [integer!]
	writeArray [struct! [value [integer!]] [none]] ; pointer The array of 32-bit integer samples to write to the task.
	sampsPerChanWritten [integer!] ; pointer
	reserved [integer!]; null
	return: [integer!]
] libni "DAQmxBaseWriteDigitalU32"


DAQmxBaseWriteDigitalScalarU32: make routine! [
	{Writes a single 32-bit unsigned integer sample to a task that contains a single digital output channel. 
	Use this format for devices with up to 32 lines per port. Useful for static digital tasks only.}
	TaskHandle [integer!]
	autoStart [integer!]
	timeout [decimal!] 
	value [integer!] ; A 32-bit integer sample to write to the task
	reserved [integer!]; null
	return: [integer!]
] libni "DAQmxBaseWriteDigitalScalarU32"

DAQmxBaseGetWriteAttribute: make routine![
	{Undocumented; must be tested for void}
	TaskHandle [integer!]
	attribute [integer!]
	value [integer!] ; void pointer
	return: [integer!]
] libni "DAQmxBaseGetWriteAttribute"

DAQmxBaseSetWriteAttribute: make routine! [
	{Undocumented}
	TaskHandle [integer!]
	attribute [integer!]
	value [integer!] ;int
	return: [integer!]
] libni "DAQmxBaseSetWriteAttribute"


;******************************************************
;***               Events & Signals                 ***
;******************************************************

DAQmxBaseExportSignal: make routine! [
	{Routes a control signal to the specified terminal. 
	The output terminal can reside on the device that generates the control signal or on a different device. 
	Use this function to share clocks and triggers between multiple tasks and devices. 
	The routes created by this function are task-based routes.}
	TaskHandle [integer!]
	signalID [integer!]
	outputTerminal[string!]
	return: [integer!]
] libni "DAQmxBaseExportSignal" 

;******************************************************
;***              Scale Configurations              ***
;******************************************************
;not in the base version

;******************************************************
;***             Buffer Configurations              ***
;******************************************************

DAQmxBaseCfgInputBuffer: make routine! [
	{Overrides the automatic input buffer allocation that NI-DAQmx Base performs.}
	TaskHandle [integer!]
	numSampsPerChan [integer!]
	return: [integer!]
] libni "DAQmxBaseCfgInputBuffer"




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

DAQmxBaseResetDevice: make routine! [
	{Immediately aborts all tasks associated with a device and returns the device to an initialized state. 
	Aborting a task stops and releases any resources the task reserved.}
	deviceName [string!]
	return: [integer!]
] libni "DAQmxBaseResetDevice"




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

DAQmxBaseGetExtendedErrorInfo: make routine! [
	{Returns dynamic, specific error information. 
	This function is valid only for the last function that failed; additional NI-DAQmxBase calls may invalidate this information}
	errorString[string!]
	bufferSize [integer!]
	return: [integer!]
]  libni "DAQmxBaseGetExtendedErrorInfo"



;******************************************************************************
; *** NI-DAQmxBase Specific Attribute Get/Set/Reset Function Declarations *****
;******************************************************************************

DAQmxBaseGetDevSerialNum: make routine! compose/deep [
	device		[string!]
	*data		[struct! [uInt32 [integer!]]]; pointer to integer
	return: [integer!]
]libni "DAQmxBaseGetDevSerialNum"

 
;******************************************************************************
; *** some comments                                                       *****
;******************************************************************************

{most of the NI library routines are using pointers that are changed by the functions.
The best way to know which pointer values were changed by an external library function is
to use this method modified_pointers: second first :routine Name
example: second first :DAQmxBaseGetDevSerialNum
Another solution is to pass a struct! to the routine (struct! are pointers) 
and to get back the modified struct! elements 
example: *bool32: make struct! [uInt32 [integer!]] none
         DAQmxBaseGetDevSerialNum device *bool32
		print *bool32/uInt32
}



