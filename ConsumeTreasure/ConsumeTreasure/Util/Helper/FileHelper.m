//
//  FileHelper.m
//  ailfm
//
//  Created by sunpf on 13-3-10.
//  Copyright (c) 2013年 ailk. All rights reserved.
//

#import "FileHelper.h"

#import "Tools.h"

static NSString  *notePath; //笔记根目录地址
static NSString  *chapterPath; //公章根目录地址
static NSString  *workPath; //工作根目录地址
static NSString  *projectPath; //业务根目录地址
static NSDictionary * mimeTypeMap;  //MIME表

@implementation FileHelper




//获取笔记根目录地址
+(NSString *) getNotePath{
    if(!notePath){
        NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        notePath = [paths objectAtIndex:0];
        notePath=[notePath stringByAppendingPathComponent:@"note"];
    }
    return notePath;
}


//获取文件夹的大小，包含子文件夹也可以
+(long)getFileSize:(NSString*)path
{
    long size=0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            size+= fileAttributeDic.fileSize;
        }
        else
        {
            size+=[self getFileSize:fullPath];
        }
    }
    return size;
}

//格式化文件大小
+(NSString *) formatFileSize:(long)fileSize
{
    if (fileSize <= 0)
        return @"0 KB";
    
    NSString * fileSizeString = @"";
    if (fileSize < 1024)
    {
        fileSizeString= @"< 1 KB";
    }
    else if (fileSize < 1048576)
    {
        double fs=(double) fileSize / 1024;
        fileSizeString=[NSString stringWithFormat:@"%0.0f KB",fs];
    }else if (fileSize < 1073741824)
    {
        double fs=(double) fileSize / 1048576;
        fileSizeString=[NSString stringWithFormat:@"%0.1f MB",fs];
    }else
    {
        double fs=(double) fileSize / 1073741824;
        fileSizeString=[NSString stringWithFormat:@"%0.2f GB",fs];
    }
    
    return fileSizeString;
}



+(void) deleteSub:(NSString *)filePath
{
     NSArray *arr=[[NSArray alloc] initWithObjects:filePath, nil];
    [self delete:filePath exceptFiles:arr];
}

/**
  递归删除文件
 */
+(void) delete:(NSString *) filePath
{
    [self delete:filePath exceptFiles:nil];
}

/**
 递归删除文件夹
 @param exceptFiles  额外文件 不需要删除的文件列表
 */
+(void) delete:(NSString *) filePath exceptFiles:(NSArray *) exceptFiles{
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if(!exceptFiles || exceptFiles.count==0){   //不包含“额外文件exceptFiles”时立刻删除
        [fileManager removeItemAtPath:filePath error:nil];
        return;
    }

    NSArray* array = [fileManager contentsOfDirectoryAtPath:filePath error:nil];
    for(int i = 0; i<[array count]; i++){
        NSString *fullPath = [filePath stringByAppendingPathComponent:[array objectAtIndex:i]];
        BOOL isDir;
        if(![fileManager fileExistsAtPath:fullPath isDirectory:&isDir]) //文件不存在时继续
            continue;
        if(isDir){         //为文件夹时
            NSError *err;
            NSArray *files = [fileManager contentsOfDirectoryAtPath: fullPath error: &err];
            [self delete:fullPath exceptFiles:exceptFiles]; //嵌套遍历文件夹

            files = [fileManager contentsOfDirectoryAtPath: fullPath error: &err];
            if([files count]==0 && ![exceptFiles containsObject:fullPath]) //文件夹为空，并且不包含"额外文件exceptFiles" ，删除文件
                [fileManager removeItemAtPath:fullPath error:nil];

        }else{
            if(![exceptFiles containsObject:fullPath])
                [fileManager removeItemAtPath:fullPath error:nil];
        }
    }
    
}


//移动文件
+(BOOL) moveFile:(NSString *) fromPath toPath:(NSString *) toPath
{
    BOOL success=NO;
    NSError *err;
    success= [[NSFileManager defaultManager] moveItemAtPath:fromPath toPath:toPath error:&err];
    if(!success)
        NSLog(@"moveFile error:%@",err);
    return success;
}

@end
