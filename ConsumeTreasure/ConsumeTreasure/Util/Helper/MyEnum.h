//
//  MyEnum.h
//  CRM
//
//  Created by ebadu on 14-9-4.
//  Copyright (c) 2014年 Razi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyEnum : NSObject

/**
 *  邮件类型
 */
typedef NS_ENUM(NSUInteger, MailType) {
    
    MailTypeInBox,
    MailTypeOutBox,
    MailTypeDrafts
    
};

/**
 *  订单类型
 */
typedef NS_ENUM(NSUInteger, OrderType) {
    
    OrderTypeGoing = 0,         //进行中
    OrderTypeCompelet,      //完成
    OrderTypeAdults,        //维权
    OrderTypeReturn,        //退货
    OrderTypeRefund,        //退款
    
};


typedef NS_ENUM(NSUInteger, TableViewCellType){
    
    CellTypeTextField,      //输入框
    CellTypeSelector,       //选择
    CellTypeSwitch,         //开关
    CellTypeTextView,       //textView
    CellTypeTextView2,      //textView
    
};

typedef NS_ENUM(NSUInteger, CirculateType){
    
    CirculateTypeNO = 0,        //不循环
    CirculateTypeByDay,         //每天
    CirculateTypeByWeek,        //每周
    CirculateTypeByMonth,       //每月
    CirculateTypeByYear,        //每年
    
};

typedef NS_ENUM(NSUInteger, ProductCellType){
    
//    ProductCellTypeText = 0,    //纯文本
    ProductCellTypeSmall = 0,       //细条
    ProductCellTypeMiddle,      //小方块
//    ProductCellTypeLager,       //大块
    
};

typedef NS_ENUM(NSUInteger, WorkNoteType){
    
    WorkNoteTypeNormal = 1,     //日常工作
    WorkNoteTypePrivate,        //私人日志
    WorkNoteTypeAssign,         //协助日志
    WorkNoteTypeTask,           //指令
    WorkNoteTypeWeekPlan,       //周计划
    WorkNoteTypeMonthPlan       //月计划
};

//客户类型枚举
typedef NS_ENUM(NSUInteger, CustomerType){
    followCustomers = 0, //今日跟进客户
    allCustomers,        //全部客户
    companyCustomers,    //公司客户
    highSeaCustomers,    //公海客户
    appreciateCustomer,  //回收客户
    dealCustomer         //成交客户
};

//主页枚举
typedef NS_ENUM(NSUInteger, HomeMenuType){
    HomeWorkNote = 1,
    HomeMail,
    HomeBirthday,
    HomeAdressBook,
    HomeFile,
    HomeNotice,
    HomeCircle,
    HomeSigned,
    HomeVerify
};



@end
