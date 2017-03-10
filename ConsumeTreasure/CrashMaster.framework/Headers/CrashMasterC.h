//
//  CrashMasterC.h
//  CrashMaster
//
//  Copyright (c) 2014 testin. All rights reserved.
//

#ifndef __CRASH_MASTER_C_H_
#define __CRASH_MASTER_C_H_

#define CMASTER_TYPE_JAVA    0
#define CMASTER_TYPE_CPP     1
#define CMASTER_TYPE_OBJC    2
#define CMASTER_TYPE_LUA     3
#define CMASTER_TYPE_JS      4
#define CMASTER_TYPE_CSHARP  5

//default config
#define ENABLED_MONITOR_EXCEPTION      1
#define ENABLED_SHAKE_FEEDBACK         0
#define ALERT_BTN_CLOSE_SHAKE_FEEDBACK 0
#define USE_LOCATION_INFO              0
#define REPORT_ONLY_WIFI               1
#define PRINT_LOG_FOR_DEBUG            0

typedef struct __CrashMasterCConfig
{
    int enabledMonitorException;    //default ENABLED_MONITOR_EXCEPTION
    int enabledShakeFeedback;       //default ENABLED_SHAKE_FEEDBACK
    int alertBtnCloseShakeFeedback; //default ALERT_BTN_CLOSE_SHAKE_FEEDBACK
    int useLocationInfo;            //default USE_LOCATION_INFO
    int reportOnlyWIFI;             //default REPORT_ONLY_WIFI
    int printLogForDebug;           //default PRINT_LOG_FOR_DEBUG
}CrashMasterCConfig;

#ifdef __cplusplus
extern "C" {
#endif
    
    void cmasterInit(const char* cAppId, const char* cChannel);
    void cmasterInitWithConfig(const char* cAppId, const char* cChannel, CrashMasterCConfig config);
    void cmasterSetUserInfo(const char* cUserInfo);
    void cmasterLeaveBreadcrumb(const char* cString);
    void cmasterReportException(int nType, const char* cMessage, const char* cStacktrace);
    
#ifdef __cplusplus
    }
#endif

#endif //__CMASTER_C_H_
