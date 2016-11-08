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



#pragma mark - 首页热门商户
- (void)getHomeChartDataWithParameters:(NSDictionary*)para resulet:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;
#pragma mark --收益权走势图
- (void)getHomeIncomeChartDataWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;
#pragma mark -- 首页广告位
- (void)getHomeAddDataWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;
@end
