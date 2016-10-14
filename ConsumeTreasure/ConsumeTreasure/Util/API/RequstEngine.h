//
//  RequstEngine.h
//  eShangBao
//
//  Created by Dev on 16/1/29.
//  Copyright © 2016年 doumee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequstEngine : NSObject
/**
 *  普通的post请求
 *
 *  @param urlNum   接口编码
 *  @param param    自定义参数
 *  @param complete 请求完成带回的数据
 */
+(void)requestHttp:(NSString *)urlNum paramDic:(NSDictionary *)param blockObject:(void(^)(NSDictionary *dic))complete;
/**
 *  分页请求的Post请求
 *
 *  @param urlNum     接口编码
 *  @param param      自定义参数
 *  @param pagination 分页请求的参数
 *  @param complete   请求完成带回的数据
 */
+(void)pagingRequestHttp:(NSString *)urlNum paramDic:(NSDictionary *)param pageDic:(NSDictionary *)pagination blockObject:(void (^)(NSDictionary *dic))complete;

@end
