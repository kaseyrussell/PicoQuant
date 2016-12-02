"""
    A Cython wrapper around the PicoHarp300 type library.
    Compile this with
    python setup.py build_ext --inplace
    --Kasey J. Russell, SEAS Harvard, 2011

"""
import numpy as np
cimport numpy as np
from cpython cimport bool # This is the python type of bool, not the c++ type!!

cdef extern from "<windows.h>":
    pass
cdef extern from "<dos.h>":
    pass
cdef extern from "<stdio.h>":
    pass
cdef extern from "<conio.h>":
    pass
cdef extern from "<stdlib.h>":
    pass
cdef extern from "<string.h>":
    pass

 
""" Wrap all constants from phdefin.h
"""
cdef extern from "phdefin.h":
    int TTREADMAX
    int MAXDEVNUM
    int HISTCHAN
    int TTREADMAX
    int RANGES
    int MODE_HIST
    int MODE_T2
    int MODE_T3
    int FLAG_OVERFLOW
    int FLAG_FIFOFULL
    int ZCMIN
    int ZCMAX
    int DISCRMIN
    int DISCRMAX
    int OFFSETMIN
    int OFFSETMAX
    int ACQTMIN
    int ACQTMAX
    int PHR800LVMIN
    int PHR800LVMAX
    
    # The following are bitmasks for return values from GetWarnings()
    int WARNING_INP0_RATE_ZERO        #        0x0001
    int WARNING_INP0_RATE_TOO_LOW     #        0x0002
    int WARNING_INP0_RATE_TOO_HIGH    #        0x0004
    int WARNING_INP1_RATE_ZERO        #        0x0010
    int WARNING_INP1_RATE_TOO_HIGH    #        0x0040
    int WARNING_INP_RATE_RATIO        #        0x0100
    int WARNING_DIVIDER_GREATER_ONE   #        0x0200
    int WARNING_TIME_SPAN_TOO_SMALL   #        0x0400
    int WARNING_OFFSET_UNNECESSARY    #        0x0800

""" Wrap all functions from phlib.h
"""
cdef extern from "phlib.h":
    int __stdcall PH_GetLibraryVersion(char* vers)
    int __stdcall PH_GetErrorString(char* errstring, int errcode)

    int __stdcall PH_OpenDevice(int devidx, char* serial) #new since v2.0
    int __stdcall PH_CloseDevice(int devidx)              #new since v2.0
    int __stdcall PH_Initialize(int devidx, int mode)

    # all functions below can only be used after PH_Initialize

    int __stdcall PH_GetHardwareVersion(int devidx, char* model, char* vers)
    int __stdcall PH_GetSerialNumber(int devidx, char* serial)
    int __stdcall PH_GetBaseResolution(int devidx)

    int __stdcall PH_Calibrate(int devidx)
    int __stdcall PH_SetSyncDiv(int devidx, int div)
    int __stdcall PH_SetCFDLevel(int devidx, int channel, int value)
    int __stdcall PH_SetCFDZeroCross(int devidx, int channel, int value)

    int __stdcall PH_SetStopOverflow(int devidx, int stop_ovfl, int stopcount)    
    int __stdcall PH_SetRange(int devidx, int range)
    int __stdcall PH_SetOffset(int devidx, int offset)

    int __stdcall PH_ClearHistMem(int devidx, int block)
    int __stdcall PH_StartMeas(int devidx, int tacq)
    int __stdcall PH_StopMeas(int devidx)
    int __stdcall PH_CTCStatus(int devidx)

    int __stdcall PH_GetBlock(int devidx, unsigned int *chcount, int block)
    int __stdcall PH_GetResolution(int devidx)
    int __stdcall PH_GetCountRate(int devidx, int channel)
    int __stdcall PH_GetFlags(int devidx)
    int __stdcall PH_GetElapsedMeasTime(int devidx)

    int __stdcall PH_GetWarnings(int devidx)                               #new since v.2.3
    int __stdcall PH_GetWarningsText(int devidx, char* text, int warnings) #new since v.2.3

    # for TT modes
    int __stdcall PH_TTSetMarkerEdges(int devidx, int me0, int me1, int me2, int me3)
    int __stdcall PH_TTReadData(int devidx, unsigned int* buffer, unsigned int count)

    # for Routing
    int __stdcall PH_GetRouterVersion(int devidx, char* model, char* vers)  
    int __stdcall PH_GetRoutingChannels(int devidx)
    int __stdcall PH_EnableRouting(int devidx, int enable)
    int __stdcall PH_SetPHR800Input(int devidx, int channel, int level, int edge)  
    int __stdcall PH_SetPHR800CFD(int devidx, int channel, int dscrlevel, int zerocross) 


""" Wrap all constants from errorcodes.h
"""
cdef extern from "errorcodes.h":
    int ERROR_NONE                        
    
    int ERROR_DEVICE_OPEN_FAIL            
    int ERROR_DEVICE_BUSY                
    int ERROR_DEVICE_HEVENT_FAIL         
    int ERROR_DEVICE_CALLBSET_FAIL       
    int ERROR_DEVICE_BARMAP_FAIL          
    int ERROR_DEVICE_CLOSE_FAIL          
    int ERROR_DEVICE_RESET_FAIL          
    int ERROR_DEVICE_GETVERSION_FAIL     
    int ERROR_DEVICE_VERSION_MISMATCH    
    int ERROR_DEVICE_NOT_OPEN            
    
    int ERROR_INSTANCE_RUNNING           
    int ERROR_INVALID_ARGUMENT           
    int ERROR_INVALID_MODE               
    int ERROR_INVALID_OPTION              
    int ERROR_INVALID_MEMORY              
    int ERROR_INVALID_RDATA              
    int ERROR_NOT_INITIALIZED             
    int ERROR_NOT_CALIBRATED             
    int ERROR_DMA_FAIL                   
    int ERROR_XTDEVICE_FAIL              
    int ERROR_FPGACONF_FAIL              
    int ERROR_IFCONF_FAIL                
    int ERROR_FIFORESET_FAIL              
    
    int ERROR_USB_GETDRIVERVER_FAIL      
    int ERROR_USB_DRIVERVER_MISMATCH     
    int ERROR_USB_GETIFINFO_FAIL          
    int ERROR_USB_HISPEED_FAIL          
    int ERROR_USB_VCMD_FAIL           
    int ERROR_USB_BULKRD_FAIL        
    
    int ERROR_HARDWARE_F01        
    int ERROR_HARDWARE_F02       
    int ERROR_HARDWARE_F03       
    int ERROR_HARDWARE_F04       
    int ERROR_HARDWARE_F05        
    int ERROR_HARDWARE_F06         
    int ERROR_HARDWARE_F07         
    int ERROR_HARDWARE_F08         
    int ERROR_HARDWARE_F09         
    int ERROR_HARDWARE_F10         
    int ERROR_HARDWARE_F11         
    int ERROR_HARDWARE_F12 
    int ERROR_HARDWARE_F13       
    int ERROR_HARDWARE_F14       
    int ERROR_HARDWARE_F15      



""" ##########################################################################
    Here down is all custom classes, methods, and functions
    KJR 2011
"""
cpdef get_library_version():
    """Returns the version number of the PicoHarp library."""
    cdef char LIB_Version[8]
    cdef int return_value
    return_value = PH_GetLibraryVersion(LIB_Version)
    return LIB_Version


modes=[MODE_HIST, MODE_T2, MODE_T3]

cdef class PH300:
    """ Class for communicating with a two-channel PicoHarp300 control unit.
        This is intended to be used one device at a time (in the fortunate case
        that you have more than one unit).
    """
    cdef int dev_num, resolution, mode
    cdef unsigned int buffer[131072] # If you change this length, also change it in method reset_buffer and init of self.channel0
    cdef np.ndarray channel0
    cdef np.ndarray channel1
    cdef char serial_num[8]
    def __init__(self,
                 int device_num=0,
                 int mode=1, # integer specifying the element of the modes list
                 int range=0,
                 int offset=0,
                 int sync_divider=8,
                 int ch0_zerocross=10,
                 int ch0_disc=25,
                 int ch1_zerocross=10,
                 int ch1_disc=50):
        self.dev_num=device_num
        self.open_device()
        self.set_mode(mode)
        self.initialize()
        self.calibrate()
        self.set_range(range)
        self.set_offset(offset)
        self.set_sync_divider(sync_divider)
        self.set_ch0_cfdlevels( zerocross=ch0_zerocross, disc=ch0_disc )
        self.set_ch1_cfdlevels( zerocross=ch1_zerocross, disc=ch1_disc )
        self.get_resolution()
        self.channel0 = np.zeros(131072, dtype=int)
        self.channel1 = np.zeros(131072, dtype=int)

    def open_device(self):
        """Open communication with device."""
        if 0 != PH_OpenDevice(self.dev_num, self.serial_num):
            raise ValueError("Error opening device number %d." % (self.device_num))
        #print "serial number:", self.serial_num
        
        
    def close_device(self):
        """Close communication with device."""
        PH_CloseDevice(self.dev_num)
        
        
    def initialize(self):
        """Initialize device."""
        if 0 > PH_Initialize(self.dev_num, self.mode):
            self.close_device()
            raise ValueError("Error initializing device.")
    
    
    def calibrate(self):
        """Calibrate device. Not sure what that means..."""
        if 0 > PH_Calibrate(self.dev_num):
            self.close_device()
            raise ValueError("Error calibrating device.")
    
    
    def get_avg_count_rate(self, int channel=0):
        """Return average count rate for the specified channel (channel is an integer, 0 or 1).
        According to email correspondence with PicoQuant, this rate is measured as
        a 100ms rolling average on the channel."""
        return PH_GetCountRate(self.dev_num, channel)


    cpdef int get_flags(self) except *:
        """ Returns the current state of the flags. """
        return PH_GetFlags(self.dev_num)


    cdef bool get_fifo_full(self):
        """ returns True if FiFo buffer was full """
        #print "Flags:", self.get_flags()
        #print "AND:", self.get_flags() & FLAG_FIFOFULL
        return (self.get_flags() & FLAG_FIFOFULL) == 1


    def get_resolution(self):
        """Sets self.resolution with the resolution (in ps?)"""
        self.resolution = PH_GetResolution(self.dev_num)
    
    
    def set_channel_type(self, int channel=0, input_type="Laser"):
        """A high-level method to make it so you don't have to remember what
        the appropriate zerocross and discriminator levels are for laser
        versus MPC photodiode versus PerkinElmer photodiode."""
        assert input_type in ["Laser", "MPC", "PerkinElmer"]
        if input_type=='Laser':
            self.set_cfdlevels(channel, 10, 25)
        elif input_type=='MPC':
            self.set_cfdlevels(channel, 10, 50)
        elif input_type=='PerkinElmer':
            self.set_cfdlevels(channel, 10, 25)
            
            
    def set_ch0_cfdlevels(self, int zerocross=10, int disc=25 ):
        """Set the CFD levels (zerocross and discriminator) for channel 0.
        Units are in mV.
        """
        self.set_cfdlevels( 0, zerocross, disc )
    
    
    def set_ch1_cfdlevels(self, int zerocross=10, int disc=50 ):
        """Set the CFD levels (zerocross and discriminator) for channel 1.
        Units are in mV.
        """
        self.set_cfdlevels( 1, zerocross, disc )
    
    
    def set_cfdlevels(self, int channel, int zerocross, int disc):
        """sub-method meant to be used by set_ch0_cfdlevels, etc."""
        if 0 > PH_SetCFDLevel(self.dev_num, channel, disc):
            self.close_device()
            raise ValueError("Error setting CFD discriminator for channel %d." % (channel))
        if 0 > PH_SetCFDZeroCross(self.dev_num, channel, zerocross):
            self.close_device()
            raise ValueError("Error setting CFD zero-cross level for channel %d." % (channel))
        
        
    def set_mode(self, int mode=1):
        """Set the operation mode (needed before calling initialize() method).
        The value of mode is an integer specifying the element of this list:
        modes=[MODE_HIST, MODE_T2, MODE_T3]
        so mode=1 specifies MODE_T2, etc."""
        self.mode = modes[mode]
        

    def set_offset(self, int offset=0):
        """ Sets measurement offset. I'm not sure what the units or possible values
        of this are...
        According to demo C code from PicoQuant: 'normally no need to change this.'"""
        if 0 > PH_SetOffset(self.dev_num, offset):
            self.close_device()
            raise ValueError("Error setting offset.")
    

    def set_range(self, int range=0):
        """ Sets measurement range. I'm not sure what the units or possible values
        of this are...
        According to the demo C code PicoQuant sends, the range is:
        'meaningless in T2 mode, important in T3 mode!' """
        if 0 > PH_SetRange(self.dev_num, range):
            self.close_device()
            raise ValueError("Error setting range.")


    def set_sync_divider(self, int sync_divider=8):
        """Set sync divider of device. It's important that this
        is set correctly depending on what mode you're in.
        Read the manual for more info.
        The only time this should be set to something other than 0 is
        when channel 0 is monitoring the pulsed laser.
        This must be set to 0 if channel 0 is monitoring a detector or
        if the pulsed pump source has a low repetition rate (less than 1MHz).
        And here's a quote from the manual:
        [The divider] must be set so that the sync rate divided by the shown
        divider value does not exceed 10 MHz. E.g. for a diode laser with
        80 MHz repetition rate it must be set to 8. For a slow source such
        as a flash lamp it must be set to 'None'. Generally it is recommended
        to use the lowest suitable divider.
        
        Since our Ti:Sapphire laser has a 76MHz rep rate, we should use 8 unless
        we are doing g2 measurements."""
        if 0 > PH_SetSyncDiv(self.dev_num, sync_divider):
            self.close_device()
            raise ValueError("Error setting sync divider.")
        
    cdef int reset_buffer(self) except *:
        cdef Py_ssize_t i
        cdef unsigned int unsigned_zero = 0
        for i in range(131072): self.buffer[i] = unsigned_zero
        return 0

    cdef int reset_histogram_arrays(self) except *:
        cdef Py_ssize_t i
        for i in range(131072): self.channel0[i] = 0
        for i in range(131072): self.channel1[i] = 0
        return 0

    cpdef int start_measurement(self, int t_acq) except *:
        """Start a TSCPC measurement of length t_acq (in units of ms)."""
        if 0 > PH_StartMeas(self.dev_num, t_acq):
            self.close_device()
            raise ValueError("Error starting measurement.")
        
    cpdef int stop_measurement(self) except *:
        """Abort measurement."""
        PH_StopMeas(self.dev_num)
    
    cpdef get_counts(self, int t_acq):
        """A more flexible way to find counts on a channel (as compared to get_avg_count_rate).
        This one lets you specify how long you want to do the acquisition.
        Arguments: acquisition time in ms (integer)
        Returns: a two-element tuple of the number of counts measured on channel0 and channel1."""
        cdef int c0, c1, t, channel
        cdef int t_offset
        cdef unsigned int item
        cdef int wrap_time
        
        self.start_measurement(t_acq)
        self.reset_buffer()
        while 0 == PH_CTCStatus( self.dev_num ):
            if self.get_fifo_full():
                self.close_device()
                raise ValueError("FIFO buffer is full. Decrease acquisition time or count rate.")
            
        self.read_data()
        
        """ This parsing is appropriate for T2 mode (i.e. g2 measurement) but 
            not for T3 (i.e. Ti:Sapphire lifetime) because in T3 mode the
            time record is split into a part for identifying which pulse
            this came after and the delay since that pulse. """
            
        c0, c1 = 0, 0
        wrap_time = 210698240 # in ps. particular to 4ps resolution? why this isn't 4ps * 2**28 I have no idea...
        t_offset = 0
        
        for item in self.buffer:
            if item != 0:
                t = (item & 2**28-1) + t_offset
                channel = (item >> 28) & 15
                if channel == 0:
                    c0 += 1
                elif channel == 1:
                    c1 += 1
                elif channel == 15:
                    ## special record
                    if (item & 15) == 0:
                        ## the time counter has rolled over, so move the offset
                        t_offset += wrap_time

        return c0, c1
    
    cpdef get_arrival_times(self, int t_acq):
        """Return raw arrival times of counts on channel0 and channel1.
        Arguments: acquisition time in ms (integer)
        Returns: a tuple of two arrays holding the arrival times of the counts
            in channel0 and channel1.
            These arrays are of variable length: one element per count on each channel.
        """
        cdef int m,n
        cdef int t, channel
        cdef int t_offset
        cdef unsigned int item
        cdef int wrap_time
        
        self.start_measurement(t_acq)
        self.reset_buffer()
        while 0 == PH_CTCStatus( self.dev_num ):
            if self.get_fifo_full():
                self.close_device()
                raise ValueError("FIFO buffer is full. Decrease acquisition time or count rate.")

        self.read_data()
        
        wrap_time = 210698240 # in ps. particular to 4ps resolution? why this isn't 4ps * 2**28 I have no idea...
        t_offset = 0
        
        m, n = 0, 0
        
        for item in self.buffer:
            if item != 0:
                t = (item & 2**28-1) + t_offset
                channel = (item >> 28) & 15
                if channel == 0:
                    self.channel0[m] = t
                    m += 1
                elif channel == 1:
                    self.channel1[n] = t
                    n += 1
                elif channel == 15:
                    ## special record
                    if (item & 15) == 0:
                        ## the time counter has rolled over, so move the offset
                        t_offset += wrap_time


        return self.channel0[:m], self.channel1[:n]
    
    cpdef int get_status(self) except *:
        """Returns CTC status."""
        return PH_CTCStatus( self.dev_num )

    cdef int read_data(self) except *:
        """Reads an array of event records from the PicoHarp and stores them in self.buffer."""
        cdef unsigned int blocksz = 131072
        cdef int ret
        ret = PH_TTReadData(self.dev_num, self.buffer, blocksz)
        if ret < 0:
            self.stop_measurement()
            self.close_device()
            self.interpret_error_code(ret)
            raise ValueError("Error reading data, return value: %d." % (ret))
        return 0

    def interpret_error_code(self, int error_code):
        cdef char errstring[30]
        PH_GetErrorString(errstring, error_code)
        print "error:", errstring
