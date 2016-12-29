//
//  MyAPI.m
//  ConsumeTreasure
//
//  Created by youyou on 11/1/16.
//  Copyright © 2016 youyou. All rights reserved.
//
#import "AppDelegate.h"
#import "MyAPI.h"
#import <AFNetworking.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"


#import "HomeStoreModel.h"
#import "AddModel.h"
#import "ChartModel.h"
#import "AreaModel.h"
#import "UnionCategoryModel.h"
#import "LookTimeMode.h"
#import "LookStoreModel.h"
#import "TuiJianModel.h"
#import "AccountModel.h"
#import "StoreMasterModel.h"
#import "BeUnionModel.h"
#import "EvaluateListModel.h"


#import "CommentModel.h"
#import "StoreDetailModel.h"
#import "SpecialGoodModel.h"
#import "CollectShopListModel.h"
#import "UnionContenModel.h"
#import "NemberModel.h"
#import "OrderConModel.h"
#import "PersonInfoModel.h"


@interface MyAPI()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end
@implementation MyAPI
- (id)init{
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:testURL]] ;
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
- (void)cancelAllOperation{
    [self.manager.operationQueue cancelAllOperations];
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
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1");
            [self cancelAllOperation];
        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSDictionary *userDic = responseObject[@"data"];
            NSString * goldNum = (NSString *)userDic[@"all_money"];//用户余额
            NSString *loginName = userDic[@"loginName"];//用户登录名
            NSString *token = userDic[@"token"];
            NSString *imgurl = userDic[@"imgUrl"];
            NSString *qrcode = userDic[@"qrcord"];
            
            NSString *phone = para[@"phone"];
            
            [[XFBConfig Instance] saveImgUrl:imgurl
                                       token:token
                                   loginName:loginName
                                     balance:goldNum
                                      qrCode:qrcode
                                       phone:phone];
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
        NSString *message = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1");
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            result(YES,message);
        }else{
            result(NO,message);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"验证码发送出错");
    }];
}

- (void)registerUserWithParameters:(NSDictionary *)para
                            result:(StateBlock)result
                       errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":@"",
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"userinfo/rigister" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1");
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            return result(YES,@"注册成功");
        }else{
            return result(NO,info);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        return errorResult(error);
        
    }];
}

#pragma mark -- 修改交易密码
- (void)postPayPswWithParameters:(NSDictionary *)para
                          result:(StateBlock)result
                     errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"shop/resetpassword" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1");
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            result(YES,info);
        }else{
            result(NO,info);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}


#pragma mark -- 通宝币数量和是否设置密码
- (void)getTongBaoBiAndPayPswWithParameters:(NSDictionary *)para
                                      resut:(ModelBlock)result
                                errorResult:(ErrorBlock)errorResult{
    
    NSDictionary *paraDic = @{
                              @"tokenid":KToken,
                              @"platform":@"",
                              @"param":para
                              };
    [self.manager POST:@"shop/preferential" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSError *error = nil;
            tongBaoModel *tongModel = [[tongBaoModel alloc]initWithDictionary:responseObject[@"data"] error:&error];
            result(YES,info,tongModel);
        }else{
            result(NO,info,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];

}

#pragma mark - 支付
- (void)payMoneyWithParameters:(NSDictionary *)para
                         resut:(StateBlock)result
                   errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
     [self.manager POST:@"pay/getpayorder" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         //微信支付
         if ([para[@"paytype"] isEqualToString:@"1"]) {
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
         }else if ([para[@"paytype"] isEqualToString:@"2"]){//支付宝支付
             NSString *orderString = responseObject[@"data"];
             NSString *appScheme = @"AliJustPay";
             [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary*resultDic) {
                 NSLog(@"reslut = %@",resultDic);
             }];
             
         }else{//通宝币支付
             NSString *info = responseObject[@"msg"];
             if ([responseObject[@"code"] isEqualToString:@"-1"]) {
                 result(NO,@"-1");
                 [self cancelAllOperation];

             }if ([responseObject[@"code"] isEqualToString:@"1"]) {
                 result(YES,info);
             }else{
                 result(NO,info);
             }
         }

     
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
         errorResult(error);
     
     }];
     
     
}

#pragma mark -- 保存部分个人资料
- (void)getInfoPersonalWithParameters:(NSDictionary*)para
                              resulet:(ModelBlock)result
                          errorResult:(ErrorBlock)errorResult{
    NSDictionary *paraDic = @{
                              @"tokenid":KToken,
                              @"platform":@"",
                              @"param":para
                              };
    [self.manager POST:@"userinfo/showPerson" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSError *error = nil;
            PersonInfoModel *InfoModel = [[PersonInfoModel alloc]initWithDictionary:responseObject[@"data"][@"person"] error:&error];
            result(YES,info,InfoModel);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];

    
    
}

#pragma mark -- 获取地区
- (void)getdevelopCityArrWithMeters:(NSDictionary*)para
                             result:(ArrayBlock)result
                        errorResult:(ErrorBlock)errorResult{
    NSDictionary * dicPara = @{
                               @"tokenid":@"",
                               @"platform":@"1",
                               @"param":para
                               };
    [self.manager POST:@"welcome/provinceCity" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            //  NSArray *arr = responseObject[@"data"][@"adList"];
            NSMutableArray *provinceArray = [NSMutableArray array];
            NSMutableArray *locationArr = [NSMutableArray array];
            
            NSError *err = nil;
            NSArray *data = responseObject[@"data"][@"pcList"];
            provinceArray = [provinceModel arrayOfModelsFromDictionaries:data error:&err];
            
            for (provinceModel *mode  in provinceArray) {
                NSMutableArray *modelArray = [NSMutableArray array];
                for (NSDictionary *modelDic in mode.clist) {
                    NSError* err = nil;
                    
                    locationModel* model = [[locationModel alloc] initWithDictionary:modelDic error:&err];
                    [modelArray addObject:model];
                }
                [locationArr addObject:modelArray];
            }
            result(YES,info,@[provinceArray,locationArr]);
        }else{
            result(NO,info,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}


#pragma mark - 首页热门商户
- (void)getHomeChartDataWithParameters:(NSDictionary*)para
                               resulet:(ArrayBlock)result
                           errorResult:(ErrorBlock)errorResult{
  
    NSDictionary *dicPara = @{
                              @"tokenid":@"",
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"welcome/hotShop" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSMutableArray *hotArr = [NSMutableArray array];
            NSError *error = nil;
            hotArr = [HomeStoreModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"memberPojoList"] error:&error];
            
            
            result(YES,info,hotArr);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        errorResult(error);
    }];
     
     
   
   
}

#pragma mark --收益权走势图
- (void)getHomeIncomeChartDataWithParameters:(NSDictionary*)para
                                      result:(ArrayBlock)result
                                 errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara =  @{
                               @"tokenid":@"",
                               @"platform":@"1",
                               @"param":para
                               };
    [self.manager POST:@"welcome/incomerightRate" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            
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
- (void)getHomeAddDataWithParameters:(NSDictionary*)para
                              result:(ArrayBlock)result
                         errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":@"",
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"welcome/adIndex" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
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
#pragma mark - 获取城市citycode
- (void)getCityCodeWithParameters:(NSDictionary*)para
                           result:(ArrayBlock)result
                       erorResult:(ErrorBlock)errorResult{
        AFHTTPSessionManager * testmanager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.map.baidu.com/"]] ;
        //申明返回的结果是json类型
        testmanager.responseSerializer = [AFJSONResponseSerializer serializer];
        //    //申明请求的数据是json类型
        testmanager.requestSerializer=[AFJSONRequestSerializer serializer];
        //    //如果报接受类型不一致请替换一致text/html或别的
        testmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    [testmanager POST:@"geocoder" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
        
    }];
}



#pragma mark --我的账户
- (void)getMyAccountDataWithParameters:(NSDictionary*)para
                                result:(ArrayBlock)result
                           errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"myAccount/mineAccount" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSMutableArray *accountArr = [NSMutableArray array];
            NSError *err = nil;
            NSArray *data = responseObject[@"data"][@"list"];
            accountArr = [AccountModel arrayOfModelsFromDictionaries:data error:&err];
            
            
            AccountArrayModel *model = [[AccountArrayModel alloc]initWithDictionary:responseObject[@"data"] error:&err];
            result(YES,info,@[accountArr,model.balance]);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}


#pragma mark --浏览记录
- (void)getLookRecordDataWithParaMeters:(NSDictionary*)para
                                 result:(ArrayBlock)result
                            errorResult:(ErrorBlock)errorResult{
    NSDictionary * dicPara = @{
                               @"tokenid":KToken,
                               @"platform":@"1",
                               @"param":para
                               };
    [self.manager POST:@"userinfo/getBrowseList" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
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

#pragma mark --推荐商家
- (void)getTuiJianStoreWithParameters:(NSDictionary*)para
                               result:(ArrayBlock)result
                          errorResult:(ErrorBlock)errorReult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"welcome/getRecommended" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSArray *arr = responseObject[@"data"][@"memList"];
            
            NSMutableArray *storeArr = [NSMutableArray array];
            storeArr = [TuiJianModel arrayOfModelsFromDictionaries:arr error:nil];
            
            result(YES,info,storeArr);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        errorReult(error);
    }];

}


#pragma mark --收益权

#pragma mark -- 申请商户入口
- (void)getShangHuRequestDataWithParameters:(NSDictionary*)para
                                     result:(ArrayBlock)result
                                errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"0",
                              @"param":para
                              };
    [self.manager POST:@"shop/applyNow" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSError *error = nil;
            NSMutableArray *typeArray = [NSMutableArray array];
            typeArray = [BeUnionModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"list"] error:&error];
            result(YES,info,typeArray);
            
        }else{
            result(NO,info,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

#pragma mark --详情（商家）
- (void)getDetailStoreWithParameters:(NSDictionary*)para
                              result:(ModelBlock)result
                         errorResult:(ErrorBlock)errorResult{
    NSDictionary *paraDic = @{
                              @"tokenid":KToken,
                              @"platform":@"",
                              @"param":para
                              };
    [self.manager POST:@"shop/getOneShop" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSError *error = nil;
            StoreDetailModel *detailModel = [[StoreDetailModel alloc]initWithDictionary:responseObject[@"data"][@"shop"] error:&error];
            result(YES,info,detailModel);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

#pragma mark -- 收藏/取消收藏
- (void)collectStoreOrNotWithParameters:(NSDictionary*)para
                                 result:(StateBlock)result
                            errorResult:(ErrorBlock)errorResult{
    NSDictionary *paraDic = @{
                              @"tokenid":KToken,
                              @"platform":@"0",
                              @"param":para
                              };
    [self.manager POST:@"myAccount/myCollection" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
           result(NO,@"-1");
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            
            result(YES,info);
        }else{
            result(NO,info);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

#pragma mark -- 详情（特色商品）
- (void)getSpecialGoodDataWithParameters:(NSDictionary*)para
                                  result:(ArrayBlock)result
                             errorResult:(ErrorBlock)errorResult{
    NSDictionary *paraDic = @{
                              @"tokenid":KToken,
                              @"platform":@"",
                              @"param":para
                              };
    [self.manager POST:@"shop/getProducts" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSError *error = nil;
            NSMutableArray *specialArray = [NSMutableArray array];
            specialArray = [SpecialGoodModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"products"] error:&error];
            result(YES,info,specialArray);
            
        }else{
            result(NO,info,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

#pragma mark -- 详情（评论）
- (void)getCommentsWithParameters:(NSDictionary*)para
                           result:(ArrayBlock)result
                      errorResult:(ErrorBlock)errorResult{
    NSDictionary *paraDic = @{
                              @"tokenid":KToken,
                              @"platform":@"",
                              @"param":para
                              };
    [self.manager POST:@"shop/getShopComment" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
           result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSError *error = nil;
            NSMutableArray *commentArray = [NSMutableArray array];
            commentArray = [CommentModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"commentlist"] error:&error];
            result(YES,info,commentArray);
            
        }else{
            result(NO,info,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];

    
    
}

#pragma mark ---我是代理
- (void)getDaiLiMasterDataWithParameters:(NSDictionary*)para
                                  result:(ModelBlock)result
                             errorResult:(ErrorBlock)errorResult{
    NSDictionary *paraDic = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };

    [self.manager POST:@"userinfo/myProxy" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            
            NSError *error = nil;
            DaLiMasterModel *model = [[DaLiMasterModel alloc]initWithDictionary:responseObject[@"data"][@"proxy"] error:&error];
            
            result(YES,info,model);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

#pragma mark -- 提现
- (void)getMoneyWithDrawWithParameters:(NSDictionary*)para result:(StateBlock)result errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"pay/wyktranfer" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1");
            [self cancelAllOperation];
            
        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            result (YES,info);
        }else{
            result (NO,info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult (error);
    }];
}


#pragma mark -- 我的银行卡
- (void)getMyBankCardDataWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                               };
    [self.manager POST:@"userinfo/myBank" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSError *error = nil;
            NSMutableArray *cardListArr = [NSMutableArray array];
            cardListArr = [bankCardModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"bkList"] error:&error];
            result(YES,info,@[cardListArr]);
        }else{
            result(NO,info,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

#pragma mark -- 银行卡信息录入
- (void)typeInInfoWithParameters:(NSDictionary*)para result:(StateBlock)result errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"userinfo/bankManage" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1");
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            result (YES,info);
        }else{
            result (NO,info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult (error);
    }];
}

#pragma mark -- 删除银行卡信息
- (void)deleteBankInfoWithParameters:(NSDictionary*)para result:(StateBlock)result errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"userinfo/deleteMyBank" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1");
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            result (YES,info);
        }else{
            result (NO,info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult (error);
    }];
}


#pragma mark --我的商户（代理）
- (void)getDaLiStoreListsWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"userinfo/proxyShop" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSError *error = nil;
            NSMutableArray *myShopListArr = [NSMutableArray array];
            myShopListArr = [shopModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"shopList"] error:&error];
            result(YES,info,@[myShopListArr]);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

#pragma mark --收益明细（代理）
- (void)getDaLiIncomeListsWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"userinfo/moneyDetail" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSError *error = nil;
            NSMutableArray *IncomeListsArr = [NSMutableArray array];
            IncomeListsArr = [DaLiIncomeModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"billlogList"] error:&error];
            result(YES,info,@[IncomeListsArr]);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

#pragma mark --我是商户
- (void)getStoreMasterDataWithParameters:(NSDictionary*)para
                                  result:(ModelBlock)result
                             errorResult:(ErrorBlock)errorResult{
    NSDictionary *paraDic = @{
                            @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    
    [self.manager POST:@"userinfo/myShopAccount" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            
            NSError *error = nil;
            StoreMasterModel *model = [[StoreMasterModel alloc]initWithDictionary:responseObject[@"data"][@"shop"] error:&error];
            
            result(YES,info,model);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

#pragma mark -- 我的会员
- (void)getMyMemberDataWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"userinfo/myMembers" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
           result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSError *error = nil;
            NSMutableArray *memberArr = [NSMutableArray array];
            memberArr = [NemberModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"memList"] error:&error];
            result(YES,info,@[memberArr]);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

#pragma mark -- 订单管理
- (void)orderDataWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"userinfo/shopOrders" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
           result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSError *error = nil;
            NSMutableArray *orderArr = [NSMutableArray array];
            orderArr = [OrderConModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"payorderList"] error:&error];
            result(YES,info,@[orderArr]);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

#pragma mark -- 店铺资料查询
- (void)getStoreInfoDataWithParameters:(NSDictionary *)para
                                result:(ModelBlock)result
                           errorResult:(ErrorBlock)errorResult{
    
    NSDictionary *paraDic = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    
    [self.manager POST:@"shop/queryApplyShop" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];
            
        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            
            NSError *error = nil;
            StoreMasterModel *model = [[StoreMasterModel alloc]initWithDictionary:responseObject[@"data"][@"shop"] error:&error];
            
            result(YES,info,model);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}
 
    

#pragma mark -- 店铺管理


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
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"welcome/getDistrictlist" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSArray *data = responseObject[@"data"][@"districts"];
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
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }
        if ([responseObject[@"code"] isEqualToString:@"1"]){
            NSArray *data = responseObject[@"data"][@"categorys"];
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
#pragma mark -根据条件查询商家列表
- (void)unionShopSearchWithParameters:(NSDictionary *)para
                               result:(ModelBlock)result
                          errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"shop/shopList" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSMutableArray *modelArray = [NSMutableArray array];
            NSError *error = nil;
            NSDictionary *dataDic = responseObject[@"data"];
            for (NSDictionary *dic in dataDic[@"shoplist"]) {
                UnionContenModel *model = [[UnionContenModel alloc] initWithDictionary:dic error:&error];
                [modelArray addObject:model];
                
            }
            result(YES,info,modelArray);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}
#pragma mark - 联盟商户详情列表
- (void)unionListDetailWithParameters:(NSDictionary *)para
                               result:(ArrayBlock)result
                          errorResult:(ErrorBlock)errorResult{
    [self.manager POST:@"shop/shopList" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 上传图片
- (void)postFilesWithFormData:(NSArray *)photosArr
                           result:(ModelBlock)result
                      errorResult:(ErrorBlock)errorResult{
//    AFHTTPSessionManager *uploadManager = [AFHTTPSessionManager manager];
//    uploadManager.requestSerializer.timeoutInterval = 20;
//    uploadManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    self.manager.requestSerializer.timeoutInterval = 20;
    // 在parameters里存放照片以外的对象
    [self.manager POST:@"upload/doUpload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        for (int i = 0; i < photosArr.count; i++) {
            
            UIImage *image = photosArr[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"]; //
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---上传进度--- %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"```上传成功``` %@",responseObject);
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSString *imgStr = responseObject[@"data"][@"filePath"];
             result(YES,imgStr,imgStr);
        }else{
            result(NO,info,nil);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"xxx上传失败xxx %@", error);
        errorResult(error);
    }];
}

#pragma mark -- 申请成为代理
- (void)PostNameAndPhoneWith:(NSDictionary*)para result:(StateBlock)result errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"userinfo/applyToProxy" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1");
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            result (YES,info);
        }else{
            result (NO,info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult (error);
    }];
}

#pragma mark -- 申请成为商户
- (void)upDateInfoForBeUnionWith:(NSDictionary*)para result:(StateBlock)result errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"shop/applyToShop" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1");
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            result (YES,info);
        }else{
            result (NO,info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult (error);
    }];
}

#pragma mark - 待评价列表
- (void)NoEvalueteListWithPara:(NSDictionary *)para
                        result:(ArrayBlock)result
                   errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":@"0430a46364f54bbebc326ca4dd13dcb2",
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"pay/queryOrderList" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *massage = responseObject[@"success"];
        if ([responseObject[@"code"] isEqualToString:@"1"]){
            NSMutableArray *modelArray = [NSMutableArray array];
            NSError *error = nil;
            NSDictionary *dataDic = responseObject[@"data"];
            for (NSDictionary *dic in dataDic[@"orderList"]) {
                //NSLog(@"dic %@",dic);
                EvaluateListModel *model = [[EvaluateListModel alloc] initWithDictionary:dic error:&error];
                [modelArray addObject:model];
            }
            result(YES,massage,modelArray);
        }else{
            result(NO,massage,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        errorResult(error);
    }];
    
}
#pragma mark -店铺关注
- (void)attentionShopWithParameters:(NSDictionary *)para
                             result:(ArrayBlock )result
                        errorResult:(ErrorBlock)errorResult{
    NSDictionary *paraDic = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"userinfo/queryAttShop" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1",nil);
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSMutableArray *modelArray = [NSMutableArray array];
            NSError *error = nil;
            NSDictionary *dataDic = responseObject[@"data"];
            for (NSDictionary *dic in dataDic[@"collectionlst"]) {
                NSLog(@"dic %@",dic);
                CollectShopListModel *model = [[CollectShopListModel alloc] initWithDictionary:dic error:&error];
                [modelArray addObject:model];
            }
            result(YES,info,modelArray);
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
}
#pragma mark - 上传头像
- (void)postIconWithParameters:(NSDictionary *)para
                        result:(StateBlock)result
                   errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"myAccount/modifyImgUrl" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1");
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            result(YES,info);
        }else{
            result(NO,info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}
#pragma mark - 修改用户名
- (void)fixUserNameWithParameters:(NSDictionary *)para
                           result:(StateBlock)result
                      errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"myAccount/modifyUserName" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            result(NO,@"-1");
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            result(YES,info);
        }else{
            result(NO,info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}
#pragma mark -修改手机号码
- (void)fixPhoneNumWithParameters:(NSDictionary *)para
                           result:(StateBlock)result
                      errorResult:(ErrorBlock)errorResult{
    NSDictionary *dicPara = @{
                              @"tokenid":KToken,
                              @"platform":@"1",
                              @"param":para
                              };
    [self.manager POST:@"myAccount/modifyPhone" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *info = responseObject[@"msg"];
        if ([responseObject[@"code"] isEqualToString:@"-1"]) {
           result(NO,@"-1");
            [self cancelAllOperation];

        }if ([responseObject[@"code"] isEqualToString:@"1"]) {
            result(YES,info);
        }else{
            result(NO,info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
    }];
}
@end
