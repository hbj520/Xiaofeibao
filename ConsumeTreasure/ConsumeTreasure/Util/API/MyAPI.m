//
//  MyAPI.m
//  ConsumeTreasure
//
//  Created by youyou on 11/1/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "MyAPI.h"
#import <AFNetworking.h>
#import "WXApi.h"

#import "AddModel.h"
#import "ChartModel.h"

@interface MyAPI()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end
@implementation MyAPI
- (id)init{
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]] ;
        //申明返回的结果是json类型
            self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //    //申明请求的数据是json类型
            self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //    //如果报接受类型不一致请替换一致text/html或别的
            self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];

    }
    return self;
}
+ (MyAPI *)sharedAPI{
    static MyAPI *sharedAPIInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAPIInstance = [[self alloc] init];
    });
    return sharedAPIInstance;
}
#pragma mark - 登录和注册
- (void)loginWithParameters:(NSDictionary *)para
                     result:(StateBlock)result
                errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":@"",
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"userinfo/login" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 首页热门商户
- (void)getHomeChartDataWithParameters:(NSDictionary*)para resulet:(ArrayBlock)result errorResult:(ErrorBlock)errorResult{
  
    NSDictionary *dicPara = @{
                              @"tokenid":@"",
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"welcome/hotShop" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"00000"]) {
            NSArray *arr = responseObject[@"data"][@"memberPojoList"];
            result(YES,info,arr);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        errorResult(error);
    }];
     
     
   
    /*
    [self.manager POST:@"pay/getwxpayorder" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PayReq *request = [[PayReq alloc] init];
        NSString *stamp = responseObject[@"data"][@"timestamp"];
        request.openID= responseObject[@"data"][@"appid"];
        request.partnerId =responseObject[@"data"][@"partnerid"];
        request.prepayId= responseObject[@"data"][@"prepayid"];
        request.package = responseObject[@"data"][@"packageStr"];
        request.nonceStr= responseObject[@"data"][@"noncestr"];
        request.sign=responseObject[@"data"][@"sign"];
        request.timeStamp=stamp.intValue;
        [WXApi sendReq:request];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
    */
}

#pragma mark --收益权走势图
- (void)getHomeIncomeChartDataWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara =  @{
                               @"tokenid":@"",
                               @"platform":@"1",
                               @"param":para
                               };
    [self.manager POST:@"welcome/incomerightRate" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"00000"]) {
            
            NSMutableArray *charArr = [NSMutableArray array];
            dataModel *model = [[dataModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
            [charArr addObject:model];
            
            result(YES,info,charArr);
        }else{
            result(NO,info,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
        
    }];
}

#pragma mark -- 首页广告位
- (void)getHomeAddDataWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":@"",
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"welcome/adIndex" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"00000"]) {
            //  NSArray *arr = responseObject[@"data"][@"adList"];
            NSMutableArray *addArray = [NSMutableArray array];
            NSError *err = nil;
            addArray = [AddModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"adList"] error:&err];
            //[addArray addObject:addmodel];
            
            result(YES,info,addArray);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

#pragma mark --收益权详情

#pragma mark --合伙人超市地区

#pragma mark --合伙人超市

#pragma mark --我的账户

#pragma mark --浏览记录

#pragma mark --收益权

#pragma mark --我是商户




@end
