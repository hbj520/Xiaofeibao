//
//  MyAPI.h
//  ConsumeTreasure
//
//  Created by youyou on 11/1/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^VoidBlock) (void);
typedef void (^StateBlock) (BOOL sucess, NSString *msg);
typedef void (^ModelBlock) (BOOL success, NSString *msg, id object);
typedef void (^ArrayBlock) (BOOL success, NSString *msg, NSArray *arrays);
typedef void (^ErrorBlock) (NSError *enginerError);
@interface MyAPI : NSObject
+ (MyAPI *)sharedAPI;

#pragma mark - 登录和注册
- (void)loginWithParameters:(NSDictionary *)para
                     result:(StateBlock)result
                errorResult:(ErrorBlock)errorResult;
#pragma mark - 注册发送验证码
- (void)postVerifyCodeWithParameters:(NSDictionary *)para
                              result:(StateBlock)result
                         errorResult:(ErrorBlock)errorResult;


#pragma mark - 首页热门商户
- (void)getHomeChartDataWithParameters:(NSDictionary*)para
                               resulet:(ArrayBlock)result
                           errorResult:(ErrorBlock)errorResult;
#pragma mark --收益权走势图
- (void)getHomeIncomeChartDataWithParameters:(NSDictionary*)para
                                      result:(ArrayBlock)result
                                 errorResult:(ErrorBlock)errorResult;
#pragma mark -- 首页广告位
- (void)getHomeAddDataWithParameters:(NSDictionary*)para
                              result:(ArrayBlock)result
                         errorResult:(ErrorBlock)errorResult;

#pragma mark --收益权详情

#pragma mark --合伙人超市地区

#pragma mark --合伙人超市

#pragma mark --我的账户

#pragma mark --浏览记录
- (void)getLookRecordDataWithParaMeters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;

#pragma mark --收益权

#pragma mark --我是商户

#pragma mark -联盟商户主页面各个区
- (void)unionShopAreaWithParameters:(NSDictionary *)para
                         result:(ArrayBlock)result
                    errorResult:(ErrorBlock)errorResult;
#pragma mark -获取联盟商户分类
- (void)unionCategoryListWithParameters:(NSDictionary *)para
                             result:(ArrayBlock)result
                        errorResult:(ErrorBlock)errorResult;
#pragma mark - 联盟商户详情列表
- (void)unionListDetailWithParameters:(NSDictionary *)para
                               result:(ArrayBlock)result
                          errorResult:(ErrorBlock)errorResult;
@end
