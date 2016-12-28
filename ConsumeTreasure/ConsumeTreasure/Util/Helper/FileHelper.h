//
//  FileHelper.h
//  ailfm
//
//  Created by sunpf on 13-3-10.
//  Copyright (c) 2013年 ailk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyEnum.h"

@interface FileHelper : NSObject



//获取笔记根目录地址
+(NSString *) getNotePath;


//获取文件夹的大小，包含子文件夹也可以
+(long)getFileSize:(NSString*)path;


//格式化文件大小
+(NSString *) formatFileSize:(long)fileSize;


///**
// 递归删除文件,保留当前文件夹
// */
+(void) deleteSub:(NSString *)filePath;

/**
 递归删除文件
 **/
+(void) delete:(NSString *) filePath;
/**
	删除文件或递归删除文件夹
 @param exceptFiles  不需要删除的文件列表
 */
+(void) delete:(NSString *) filePath exceptFiles:(NSArray *) exceptFiles;

//移动文件
+(BOOL) moveFile:(NSString *) fromPath toPath:(NSString *) toPath;
@end
