//
//  CrashMasterConfig.h
//  
//
//  Created by maximli on 15/4/20.
//  Copyright (c) 2015年 testin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CrashMasterDelegate.h"

@interface CrashMasterConfig : NSObject
{
    __unsafe_unretained id crashDelegate_;
}

// delegate.
@property(nonatomic, assign) id crashDelegate;

// Exception monitor enabled, default YES.
@property(nonatomic, assign) BOOL enabledMonitorException;

// Enabled feedback, default NO.
@property(nonatomic, assign) BOOL enabledShakeFeedback;

// Show shake feedback off option, default NO. if enabledShakeFeedback is NO, this value invalid.
@property(nonatomic, assign) BOOL alertBtnCloseShakeFeedback;

// use user location info, default NO.
@property(nonatomic, assign) BOOL useLocationInfo;

// only wifi report data, default YES.
@property(nonatomic, assign) BOOL reportOnlyWIFI;

// print log in simulator for debug, default NO.
@property(nonatomic, assign) BOOL printLogForDebug;


+ (CrashMasterConfig*)defaultConfig;

@end
