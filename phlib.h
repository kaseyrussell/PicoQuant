/* Functions exported by the PicoHarp programming library PHLib*/

/* Ver. 2.3      April 2009 */

#ifndef _WIN32
#define __stdcall
#endif

extern int __stdcall PH_GetLibraryVersion(char* vers);
extern int __stdcall PH_GetErrorString(char* errstring, int errcode);

extern int __stdcall PH_OpenDevice(int devidx, char* serial); //new since v2.0
extern int __stdcall PH_CloseDevice(int devidx);  //new since v2.0
extern int __stdcall PH_Initialize(int devidx, int mode);

//all functions below can only be used after PH_Initialize

extern int __stdcall PH_GetHardwareVersion(int devidx, char* model, char* vers);
extern int __stdcall PH_GetSerialNumber(int devidx, char* serial);
extern int __stdcall PH_GetBaseResolution(int devidx);

extern int __stdcall PH_Calibrate(int devidx);
extern int __stdcall PH_SetSyncDiv(int devidx, int div);
extern int __stdcall PH_SetCFDLevel(int devidx, int channel, int value);
extern int __stdcall PH_SetCFDZeroCross(int devidx, int channel, int value);

extern int __stdcall PH_SetStopOverflow(int devidx, int stop_ovfl, int stopcount);	
extern int __stdcall PH_SetRange(int devidx, int range);
extern int __stdcall PH_SetOffset(int devidx, int offset);

extern int __stdcall PH_ClearHistMem(int devidx, int block);
extern int __stdcall PH_StartMeas(int devidx, int tacq);
extern int __stdcall PH_StopMeas(int devidx);
extern int __stdcall PH_CTCStatus(int devidx);

extern int __stdcall PH_GetBlock(int devidx, unsigned int *chcount, int block);
extern int __stdcall PH_GetResolution(int devidx);
extern int __stdcall PH_GetCountRate(int devidx, int channel);
extern int __stdcall PH_GetFlags(int devidx);
extern int __stdcall PH_GetElapsedMeasTime(int devidx);

extern int __stdcall PH_GetWarnings(int devidx); //new since v.2.3
extern int __stdcall PH_GetWarningsText(int devidx, char* text, int warnings); //new since v.2.3

//for TT modes
extern int __stdcall PH_TTSetMarkerEdges(int devidx, int me0, int me1, int me2, int me3);
extern int __stdcall PH_TTReadData(int devidx, unsigned int* buffer, unsigned int count);

//for Routing
extern int __stdcall PH_GetRouterVersion(int devidx, char* model, char* vers);  
extern int __stdcall PH_GetRoutingChannels(int devidx);
extern int __stdcall PH_EnableRouting(int devidx, int enable);
extern int __stdcall PH_SetPHR800Input(int devidx, int channel, int level, int edge);  
extern int __stdcall PH_SetPHR800CFD(int devidx, int channel, int dscrlevel, int zerocross); 
 
