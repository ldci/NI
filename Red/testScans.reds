Red/System [
	Title:		"Ni Lib Test"
	Author:		"François Jouen"
	Rights:		"Copyright (c) 2012-2013 François Jouen. All rights reserved."
	License:        "BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt"
]

    #include %nidaqmxbase3-6.reds

    print ["Test with USB 6808" lf]
   
   ; for error 
     
   DAQmxErrChk: func [
        error [integer!]
        return: [c-string!]
        /local buffer bufferSize] [
         bufferSize: DAQmxBaseGetExtendedErrorInfo "" 0
         buffer: as c-string! allocate bufferSize 
         DAQmxBaseGetExtendedErrorInfo buffer bufferSize
         if error = 0 [buffer: "DAQmxSuccess"]
         ;print ["BufferSize: " bufferSize " error : " error ": " buffer lf]
         buffer
    ]
   
   
    dev: 0 
    ptr: declare pointer![integer!] 
    ptr: :dev 
     print ["Activating USB Device. Be Patient : " ]
    err: DAQmxBaseGetDevSerialNum "Dev1" ptr
    print [DAQmxErrChk err lf]
    
    ;Channel parameters
    device: "Dev1"
    chan: "Dev1/ai0:7" ; we use 8 channels
    nchans: 8
    min: -10.0
    max: 10.0
  
    ; Data read parameters
    numSampsPerChan: 1
    arraySize: nChans * numSampsPerChan * size? float!
    
    
    ;task parameters
    taskHandle: 0
    taskName: "Red_NI_ACQuisition"
    *taskHandle: declare pointer![integer!]
    *taskHandle: :taskHandle
    *taskHandle/value: taskHandle
   
   
    *data: declare pointer! [float!]    
    *data: as  [pointer! [float!]] allocate arraySize 
    ;*data: declare readData!
    
    pointsToRead: 1
    pointsRead: 1
    *pointsRead: declare pointer! [integer!]
    *pointsRead: :pointsRead
    
    
    timeout: 10.0
    
    print ["Creating task handle : " ]
    err: DAQmxBaseCreateTask taskName *taskHandle
    taskHandle: *taskHandle/value
    print [DAQmxErrChk err lf]
    
    print ["Creating AI Voltage Channel : " ]
    err: DAQmxBaseCreateAIVoltageChan taskHandle chan "" DAQmx_Val_Cfg_Default min max DAQmx_Val_Volts ""
    print [DAQmxErrChk err lf]
    
    print ["Starting Task : "]
    err: DAQmxBaseStartTask taskHandle
    print [DAQmxErrChk err lf]
    
    print ["Reading Data : "]
    err: DAQmxBaseReadAnalogF64 taskHandle pointsToRead timeout DAQmx_Val_GroupByChannel *data ArraySize *pointsRead null
    print [DAQmxErrChk err lf]
    
     ;write 8 values  : idem to *data: *data + 1 print *data/value  
    c: 1
    while [c < 9] [
        print [c ": " *data/c lf]
        c: c + 1
    ]
    
    print ["Ending Task : "]
    err: DAQmxBaseStopTask taskHandle
    print [DAQmxErrChk err lf] 

    print ["Clearing Task : " ]
    err: DAQmxBaseClearTask taskHandle
    print [DAQmxErrChk err lf]  

    print ["Resetting USB Device : " ]
    err: DAQmxBaseResetDevice device
    print [DAQmxErrChk err lf] 
    
    print ["Done. Bye!" lf]