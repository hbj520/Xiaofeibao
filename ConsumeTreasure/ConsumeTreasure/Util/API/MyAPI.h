//
//  MyAPI.h
//  ConsumeTreasure
//
//  Created by youyou on 11/1/16.
//  Copyright © 2016 youyou. All rights reserved.
//  666

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

- (void)registerUserWithParameters:(NSDictionary *)para
                            result:(StateBlock)result
                       errorResult:(ErrorBlock)errorResult;

#pragma mark -- 修改交易密码
- (void)postPayPswWithParameters:(NSDictionary *)para
                          result:(StateBlock)result
                     errorResult:(ErrorBlock)errorResult;

#pragma mark -- 通宝币数量和设置密码
- (void)getTongBaoBiAndPayPswWithParameters:(NSDictionary *)para
                                      resut:(ModelBlock)result
                                errorResult:(ErrorBlock)errorResult;

#pragma mark - 支付
- (void)payMoneyWithParameters:(NSDictionary *)para
                         resut:(StateBlock)result
                   errorResult:(ErrorBlock)errorResult;
#pragma mark -- 保存部分个人资料
- (void)getInfoPersonalWithParameters:(NSDictionary*)para
                              resulet:(ModelBlock)result
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
#pragma mark - 获取城市citycode
- (void)getCityCodeWithParameters:(NSDictionary*)para
                           result:(ArrayBlock)result
                       erorResult:(ErrorBlock)errorResult;

#pragma mark --收益权详情

#pragma mark --合伙人超市地区

#pragma mark --合伙人超市

#pragma mark --我的账户
- (void)getMyAccountDataWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;
#pragma mark --浏览记录
- (void)getLookRecordDataWithParaMeters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;

#pragma mark --推荐商家
- (void)getTuiJianStoreWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorReult;

#pragma mark --收益权

#pragma mark -- 申请商户入口
- (void)getShangHuRequestDataWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;

#pragma mark --详情（商家）
- (void)getDetailStoreWithParameters:(NSDictionary*)para
                              result:(ModelBlock)result
                         errorResult:(ErrorBlock)errorResult;

#pragma mark -- 收藏/取消收藏
- (void)collectStoreOrNotWithParameters:(NSDictionary*)para result:(StateBlock)result errorResult:(ErrorBlock)errorResult;

#pragma mark -- 详情（特色商品）
- (void)getSpecialGoodDataWithParameters:(NSDictionary*)para
                                  result:(ArrayBlock)result
                             errorResult:(ErrorBlock)errorResult;
#pragma mark -- 详情（评论）
- (void)getCommentsWithParameters:(NSDictionary*)para
                           result:(ArrayBlock)result
                      errorResult:(ErrorBlock)errorResult;

#pragma mark ---我是代理
- (void)getDaiLiMasterDataWithParameters:(NSDictionary*)para
                                  result:(ModelBlock)result
                             errorResult:(ErrorBlock)errorResult;

#pragma mark --我的商户（代理）
- (void)getDaLiStoreListsWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;

#pragma mark --收益明细（代理）
- (void)getDaLiIncomeListsWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;

#pragma mark --我是商户
- (void)getStoreMasterDataWithParameters:(NSDictionary*)para result:(ModelBlock)result errorResult:(ErrorBlock)errorResult;

#pragma mark -- 我的会员
- (void)getMyMemberDataWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;

#pragma mark -- 订单管理
- (void)orderDataWithParameters:(NSDictionary*)para result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;

#pragma mark -- 店铺管理

#pragma mark -联盟商户主页面各个区
- (void)unionShopAreaWithParameters:(NSDictionary *)para
                         result:(ArrayBlock)result
                    errorResult:(ErrorBlock)errorResult;
#pragma mark -获取联盟商户分类
- (void)unionCategoryListWithParameters:(NSDictionary *)para
                             result:(ArrayBlock)result
                        errorResult:(ErrorBlock)errorResult;
#pragma mark -根据条件查询商家列表
- (void)unionShopSearchWithParameters:(NSDictionary *)para
                               result:(ArrayBlock)result
                          errorResult:(ErrorBlock)errorResult;
#pragma mark - 联盟商户详情列表
- (void)unionListDetailWithParameters:(NSDictionary *)para
                               result:(ArrayBlock)result
                          errorResult:(ErrorBlock)errorResult;
#pragma mark - 上传图片
- (void)postFilesWithFormData:(NSArray *)photosArr
                           result:(ModelBlock)result
                      errorResult:(ErrorBlock)errorResult;
#pragma mark -- 申请成为代理
- (void)PostNameAndPhoneWith:(NSDictionary*)para result:(StateBlock)result errorResult:(ErrorBlock)errorResult;

#pragma mark -- 申请成为商户
- (void)upDateInfoForBeUnionWith:(NSDictionary*)para result:(StateBlock)result errorResult:(ErrorBlock)errorResult;

#pragma mark - 待评价列表
- (void)NoEvalueteListWithPara:(NSDictionary *)para
                        result:(ArrayBlock)result
                   errorResult:(ErrorBlock)errorResult;
#pragma mark -店铺关注
- (void)attentionShopWithParameters:(NSDictionary *)para
                             result:(ArrayBlock )result
                        errorResult:(ErrorBlock)errorResult;
#pragma mark - 上传头像
- (void)postIconWithParameters:(NSDictionary *)para
                        result:(StateBlock)result
                   errorResult:(ErrorBlock)errorResult;
#pragma mark - 修改用户名
- (void)fixUserNameWithParameters:(NSDictionary *)para
                           result:(StateBlock)result
                      errorResult:(ErrorBlock)errorResult;
#pragma mark -修改手机号码
- (void)fixPhoneNumWithParameters:(NSDictionary *)para
                           result:(StateBlock)result
                      errorResult:(ErrorBlock)errorResult;
@end
