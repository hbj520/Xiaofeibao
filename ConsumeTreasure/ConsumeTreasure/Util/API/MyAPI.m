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
#import "AreaModel.h"
#import "UnionCategoryModel.h"
#import "LookTimeMode.h"
#import "LookStoreModel.h"
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
        if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSDictionary *userDic = responseObject[@"data"];
            NSString * goldNum = (NSString *)userDic[@"balance"];//用户余额
            NSString *loginName = userDic[@"loginName"];//用户登录名
            NSString *token = userDic[@"token"];
            NSString *imgurl = userDic[@"imgUrl"];
            NSString *qrcode = userDic[@"qrcord"];
            [[XFBConfig Instance] saveImgUrl:imgurl token:token loginName:loginName balance:goldNum qrCode:qrcode];
            result(YES,@"登陆成功");
        }else{
            result(NO,@"登录失败");
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         errorResult(error);
    }];
}
#pragma mark - 注册发送验证码
- (void)postVerifyCodeWithParameters:(NSDictionary *)para
                              result:(StateBlock)result
                         errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":@"",
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"sms/sendRegisterMessage" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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
        if ([responseObject[@"code"] isEqualToString:@"1"]) {
            
            NSMutableArray *charArr = [NSMutableArray array];
            charArr = [ChartModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"IncomerightRateList"] error:nil];
            
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
        if ([responseObject[@"code"] isEqualToString:@"1"]) {
            //  NSArray *arr = responseObject[@"data"][@"adList"];
            NSMutableArray *addArray = [NSMutableArray array];
            NSError *err = nil;
            NSArray *data = responseObject[@"data"][@"adList"];
            addArray = [AddModel arrayOfModelsFromDictionaries:data error:&err];
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
- (void)getLookRecordDataWithParaMeters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult{
    NSDictionary * dicPara = @{
                               @"tokenid":@"f2c70e32b68b4a618215b9834ca3f28c",
                               @"platform":@"1",
                               @"param":para
                               };
    [self.manager POST:@"userinfo/getBrowseList" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"1"]) {
            //  NSArray *arr = responseObject[@"data"][@"adList"];
            NSMutableArray *LookTimeArray = [NSMutableArray array];
            NSMutableArray *lookStoreArr = [NSMutableArray array];
            
            NSError *err = nil;
            NSArray *data = responseObject[@"data"][@"mapList"];
            LookTimeArray = [LookTimeMode arrayOfModelsFromDictionaries:data error:&err];
            
            for (LookTimeMode *mode  in LookTimeArray) {
                NSMutableArray *modelArray = [NSMutableArray array];
                for (NSDictionary *modelDic in mode.mlist) {
                    NSError* err = nil;
                    
                    LookStoreModel* model = [[LookStoreModel alloc] initWithDictionary:modelDic error:&err];
                    [modelArray addObject:model];
                }
                [lookStoreArr addObject:modelArray];
            }
            result(YES,info,@[LookTimeArray,lookStoreArr]);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

#pragma mark --收益权

#pragma mark --我是商户


#pragma mark -联盟商户主页面获取城市大区
- (void)unionShopAreaWithParameters:(NSDictionary *)para
                         result:(ArrayBlock)result
                    errorResult:(ErrorBlock)errorResult{
//    AFHTTPSessionManager * testmanager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://192.168.1.67:8080/xfb/"]] ;
//    //申明返回的结果是json类型
//    testmanager.responseSerializer = [AFJSONResponseSerializer serializer];
//    //    //申明请求的数据是json类型
//    testmanager.requestSerializer=[AFJSONRequestSerializer serializer];
//    //    //如果报接受类型不一致请替换一致text/html或别的
//    testmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    NSDictionary *dicPara = @{
                              @"tokenid":@"",
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"welcome/getDistrictlist" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSArray *data = responseObject[@"data"][@"districtList"];
            NSMutableArray *modelArray = [NSMutableArray array];
            NSError *err = nil;
            for (NSDictionary *dic in data) {
                AreaModel *model = [[AreaModel alloc] initWithDictionary:dic error:&err];
                [modelArray addObject:model];

            }
           
            result(YES,@"success",modelArray);

        }else{
            result(NO,@"fail",nil);

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);

    }];
}
#pragma mark -获取联盟商户分类
- (void)unionCategoryListWithParameters:(NSDictionary *)para
                             result:(ArrayBlock)result
                        errorResult:(ErrorBlock)errorResult{
    [self.manager POST:@"shop/getCategory" parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"1"]){
            NSArray *data = responseObject[@"data"][@"categoryList"];
            NSMutableArray *modelArray = [NSMutableArray array];
            NSError *err = nil;
            for (NSDictionary *dic in data) {
                UnionCategoryModel *model = [[UnionCategoryModel alloc] initWithDictionary:dic error:&err];
                [modelArray addObject:model];
                
            }
            
            result(YES,@"success",modelArray);
        }else{
            
            result(NO,@"fail",nil);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        errorResult(error);
        
    }];
}
@end
