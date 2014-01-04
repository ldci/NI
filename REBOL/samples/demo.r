#!/usr/bin/rebol -cs
REBOL [
    Title: "NI USB Acquisition 2.0 Demo"
     Author: "François Jouen"
]

; load NI Library 
do %nidaqmxbase3-6.r 


;Channel parameters
Val_cfg: DAQmx_Val_RSE
device: make string! "Dev1"
chan: join device "/ai0:7" ; 8 channels 
nChans: 8
amin: -10.0;
amax: 10.0;

; Data read parameters
numSampsPerChan: 1
ArraySize: nChans * numSampsPerChan; 

; this struct! is passed as pointer to NI Lib 
; 8 channels with USB 6008 ; Up to 16 with other USB devices 

*data: make struct! [
		chan1 [decimal!] 
		chan2 [decimal!] 
		chan3 [decimal!]
		chan4 [decimal!]
		chan5 [decimal!]
		chan6 [decimal!]
		chan7 [decimal!]
		chan8 [decimal!]
] none


readData: copy []; block for read data / channel
*sampsPerChanRead: make struct! [value [integer!]] reduce [numSampsPerChan]

timeout: 10.0;

; task parameters

taskHandle: make integer! 0
*taskHandle: make struct! [uInt32 [integer!]] reduce [TaskHandle]

ercode: 0


*bool32: make struct! [uInt32 [integer!]] none



DAQmxErrChk: func [error [integer!] /local buffer] [
    	either error <> 0 [
		buffer: make string! 256
		DAQmxBaseGetExtendedErrorInfo buffer 256
		info: to-string first second first :DAQmxBaseGetExtendedErrorInfo
		print [error ":" info ]
	]
	[print "DAQmxSuccess" ]
]
 


print "Activating USB Device. Be Patient..." 
 


DAQmxErrChk DAQmxBaseGetDevSerialNum device *bool32
print [mold second first :DAQmxBaseGetDevSerialNum " " to-hex *bool32/uInt32] ; serial number in hexadecimal

print "Creating Acquistion Task..."
TaskName: "Acquisition_Sample"


DAQmxErrChk DAQmxBaseCreateTask (TaskName) *taskHandle
print [mold second first :DAQmxBaseCreateTask]

taskHandle: *taskHandle/uInt32; VIP : returned value is the pointer address of the Task
print [mold third *taskHandle " " taskHandle]


print "Creating Voltage Measures"
DAQmxErrChk DAQmxBaseCreateAIVoltageChan taskHandle chan "" Val_cfg amin amax DAQmx_Val_Volts "" 




print "Starting Acquisition for 8 channels" 
DAQmxErrChk DAQmxBaseStartTask Taskhandle

for ct 0 9 1 [
	ercode: DAQmxBaseReadAnalogF64 TaskHandle 
		numSampsPerChan timeout DAQmx_Val_GroupByScanNumber *data ArraySize *sampsPerChanRead 0
		;tmp: parse str ":"
        ;ercode: to-integer first tmp

	either ercode = 0 [
			clear readData; block for read data by channel
			; get values by channel
			for i 1 nChans 1 [value: pick second first :DAQmxBaseReadAnalogF64 (4 + i) append readData round/to value 0.001]
			;print [count " " readData]
			] 
			[for i 1 nChans 1 [append readData -0.0]]
	print [ct " " readData]	     
]

print [ "Task is done" ]

DAQmxErrChk DAQmxBaseIsTaskDone taskHandle *bool32



print [ "Stop Task"]
DAQmxErrChk DAQmxBaseStopTask taskHandle


print [ "Clearing Task"]
DAQmxErrChk DAQmxBaseClearTask taskHandle

print [ "Resetting USB Device"]
DAQmxErrChk DAQmxBaseResetDevice device

Print "Bye!" 
		
		

    