//
//  FormData.h
//  MyConding
//
//  Created by 赵琛 on 15/12/8.
//  Copyright © 2015年 赵琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormData : NSObject

/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
