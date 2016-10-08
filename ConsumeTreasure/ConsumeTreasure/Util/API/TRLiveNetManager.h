//
//  TRLiveNetManager.h
//  TRProject
//
//  Created by liwendong on 16/3/7.
//  Copyright © 2016年 lwd. All rights reserved.
//
#define kCompetionHandlerBlock (void(^)(id model, NSError *error))completionHandler;

#import <Foundation/Foundation.h>


//#import "TRRoomListModel.h"
//#import "TRRoomModel.h"
//#import "TRCategoriesModel.h"// 分类
//#import "TRCategoryModel.h"
//#import "TRSearchModel.h"
//#import "TRADListModel.h"
//#import "TRIntroModel.h"

@interface TRLiveNetManager : NSObject

+(id)testNetLoadWithCompletionHandler:kCompetionHandlerBlock
///** 获取游戏房间列表 */
//+ (id)getRoomListWithPage:(NSInteger)page completionHandler:kCompetionHandlerBlock
//
///**
// *  获取游戏房间的详细信息
// *
// *  @param uid 房间的唯一标识
// *
// *  @return 网络请求任务
// */
//+ (id)getRoomWithUID:(NSString *)uid completionHandler:kCompetionHandlerBlock
//
//
///** 获取类型列表 */ // 2.栏目
//+ (id)getCategoriesCompletionHandler:kCompetionHandlerBlock
//
///** 获得某种类型的房间列表 */
//+ (id)getCategoryWithSlug:(NSString *)slug page:(NSInteger)page completionHandler:kCompetionHandlerBlock
//
//
///** 搜索 */
//+ (id)search:(NSString *)words page:(NSInteger)page completionHandler:kCompetionHandlerBlock
//
///** 获取广告列表 */
//+ (id)getADListCompletionHandler:kCompetionHandlerBlock
//
///** 获取推荐页面信息列表 */
//+ (id)getIntroCompletionHandler:kCompetionHandlerBlock
@end
















