//
//  TRLiveNetManager.m
//  TRProject
//
//  Created by liwendong on 16/3/7.
//  Copyright © 2016年 lwd. All rights reserved.
//  wangqi

#import "TRLiveNetManager.h"
#import "NSObject+AFNetworking.h"
@implementation TRLiveNetManager
+(id)testNetLoadWithCompletionHandler:(void (^)(id, NSError *))completionHandler{
    
    
    
    
    return [self GET:@"http://localhost:8080/xfb/welcome/hotShopMember" parameters:nil progress:^(NSProgress *downloadProgress) {
        
        
    } completionHandler:^(id responseObj, NSError *error) {
       
        
    }];
}






//+ (id)getRoomListWithPage:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandler{
//    NSString *pageStr = [NSString stringWithFormat:@"_%ld", page];
//    if (page == 0) {
//        pageStr = @"";
//    }
//    NSString *path = [NSString stringWithFormat:kRoomsPath, pageStr];
//    return [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
//        completionHandler([TRRoomListModel parse:responseObj], error);
//    }];
//}
//
//+ (id)getRoomWithUID:(NSString *)uid completionHandler:(void (^)(id, NSError *))completionHandler{
//    NSString *path = [NSString stringWithFormat:kRoomDetailPath, uid];
//    return [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
//        completionHandler([TRRoomModel parse:responseObj], error);
//    }];
//}
//
//+(id)getCategoriesCompletionHandler:(void (^)(id, NSError *))completionHandler{
//    return [self GET:kCategoriesPath parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
//        completionHandler([TRCategoriesModel parse:responseObj], error);
//    }];
//}
//
//+ (id)getCategoryWithSlug:(NSString *)slug page:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandler{
//    NSString *pageStr = [NSString stringWithFormat:@"_%ld", page];
//    if (page == 0) {
//        pageStr = @"";
//    }
//    NSString *path = [NSString stringWithFormat:kCategoryRoomsPath, slug, pageStr];
//    return [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
//        completionHandler([TRCategoryModel parse:responseObj], error);
//    }];
//}
//
/*
+ (id)search:(NSString *)words page:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandler{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:@"site.search" forKey:@"m"];
    [params setObject:@"2" forKey:@"os"];
    [params setObject:@"0" forKey:@"p[categoryId]"];
    [params setObject:words forKey:@"p[key]"];
    [params setObject:@(page) forKey:@"p[page]"];
    [params setObject:@"10" forKey:@"p[size]"];
    [params setObject:@"1.3.2" forKey:@"v"];
    
    return [self POST:kSearchPath parameters:params progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([TRSearchModel parse:responseObj], error);
    }];
}
*/
//+ (id)getADListCompletionHandler:(void (^)(id, NSError *))completionHandler{
//    return [self GET:kADPath parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
//        completionHandler([TRADListModel parse:responseObj], error);
//    }];
//}
//
//+ (id)getIntroCompletionHandler:(void (^)(id, NSError *))completionHandler{
//    return [self GET:kIntroPath parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
//        completionHandler([TRIntroModel parse:responseObj], error);
//    }];
//}

@end












