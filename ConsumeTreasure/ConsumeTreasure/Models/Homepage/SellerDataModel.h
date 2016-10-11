//
//  SellerDataModel.h
//  eShangBao
//
//  Created by Dev on 16/1/30.
//  Copyright © 2016年 doumee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SellerDataModel : NSObject

@end

/**
 *  1006 商家列表查询接口
 */
@interface SellerListModel : NSObject

@property(nonatomic,strong)NSString         *memberId;//ID
@property(nonatomic,strong)NSString         *shopName;//店名
@property(nonatomic,strong)NSString         *shopId;
@property(nonatomic,strong)NSString         *branchName;//电话
@property(nonatomic,strong)NSString         *branchPhone;//分店的名称
@property(nonatomic,strong)NSString         *province;//省份名称
@property(nonatomic,strong)NSString         *city;//城市
@property(nonatomic,strong)NSString         *score;//店铺评价
@property(nonatomic,strong)NSString         *doorImg;//门店图片
@property(nonatomic,strong)NSString         *monthOrderNum;//月销量
@property(nonatomic,strong)NSString         *startSendPrice;//起送费
@property(nonatomic,strong)NSString         *sendPrice;//配送费
@property(nonatomic,strong)NSString         *replyNum;//评论数
@property(nonatomic,strong)NSString         *distance;//距离
@property(nonatomic,strong)NSString         *shopAddr;//店铺地址
@property(nonatomic,strong)NSString         *isCollected;//是否收藏 0 No 1 Yes
@property(nonatomic,strong)NSString         *isOpenning;
@property(nonatomic,strong)NSString         *isSupportGold;
@property(nonatomic,strong)NSString         *shopreturnrate;//反币比例


//自定义参数
@property(nonatomic,strong)NSString         *firstQueryTime;//时间
@property(nonatomic,strong)NSString         *page;//页码
@property(nonatomic,strong)NSString         *totalCount;//总数

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
/**
 *   1010 商家商品列表
 */
@interface SellerGoodsListModel : NSObject
@property(nonatomic,strong)NSString         *goodsId;//
@property(nonatomic,strong)NSString         *goodsName;//名称
@property(nonatomic,strong)NSString         *imgUrl;//首图
@property(nonatomic,strong)NSString         *monthOrderNum;//月销量
@property(nonatomic,strong)NSString         *price;//单价
@property(nonatomic,strong)NSString         *shopId;//所属店铺ID
@property(nonatomic,strong)NSString         *shopName;//店铺名称
@property(nonatomic,strong)NSString         *branchName;//分店名称
@property(nonatomic,strong)NSString         *returnBate;//商店返币比例
@property(nonatomic,strong)NSString         *createDate;//创建时间
@property(nonatomic,strong)NSString         *stockNum;//库存
@property(nonatomic,strong)NSString         *isDeleted;//判断是否下架 0未下架 1下架

//自定义参数
@property(nonatomic,strong)NSString         *chooseNum;//选择的个数
@property(nonatomic,strong)NSString         *pageStr;
@property(nonatomic,strong)NSString         *firstQueryTime;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end

/**
 *  1012 商店详情
 */
@interface SellerInfoModel : NSObject

@property(nonatomic,strong)NSString          *shopId;//id
@property(nonatomic,strong)NSString          *shopName;//店铺名称
@property(nonatomic,strong)NSString          *branchName;//分店名称
@property(nonatomic,strong)NSString          *branchPhone;//电话
@property(nonatomic,strong)NSString          *shopAddr;//地址
@property(nonatomic,strong)NSString          *categoryId;//经营分类编码
@property(nonatomic,strong)NSString          *categoryName;//分类名称
@property(nonatomic,strong)NSString          *doorImg;//门面首图
@property(nonatomic,strong)NSString          *businessNum;//营业执照编码
@property(nonatomic,strong)NSString          *businessImg;//执照图
@property(nonatomic,strong)NSString          *licenseImg;//经营许可证
@property(nonatomic,strong)NSString          *maxScoreCount;//好评数量
@property(nonatomic,strong)NSString          *mediumScoreCount;//中评数量
@property(nonatomic,strong)NSString          *minScoreCount;//差评数
@property(nonatomic,strong)NSString          *totalScore;//总体得分
@property(nonatomic,strong)NSString          *qualityScore;//质量得分
@property(nonatomic,strong)NSString          *sendScore;//配送得分
@property(nonatomic,strong)NSString          *startBusinessTime;//开始时间
@property(nonatomic,strong)NSString          *endBusinessTime;//结束时间
@property(nonatomic,strong)NSString          *isSupportGold;//
@property(nonatomic,strong)NSString          *latitude;//
@property(nonatomic,strong)NSString          *longitude;//
@property(nonatomic,strong)NSString          *startSendPrice;//起送价
@property(nonatomic,strong)NSString          *sendPrice;//配送费
@property(nonatomic,strong)NSString          *transitTime;//送达时间
@property(nonatomic,strong)NSString          *isCollected;//是否收藏
@property(nonatomic,strong)NSString          *monthOrderNum;//月销量
@property(nonatomic,strong)NSString          *isOpenning;//是否正在营业
@property(nonatomic,strong)NSString          *returnGoldRate;//反币比例

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

/**
 *  1013  商家评论
 */
@interface CommentList : NSObject

@property(nonatomic,strong)NSString          *memberImgUrl;//头像
@property(nonatomic,strong)NSString          *memberId;//用户ID
@property(nonatomic,strong)NSString          *memberName;//昵称
@property(nonatomic,strong)NSString          *createdate;//创建时间
@property(nonatomic,strong)NSString          *content;//内容
@property(nonatomic,strong)NSString          *score;//打分
@property(nonatomic,strong)NSString          *commentId;//评论编码

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

/**
 *  1008 商店分类
 */
@interface CategoryListModel : NSObject

@property(nonatomic,strong)NSString         *cateId;
@property(nonatomic,strong)NSString         *cateName;
@property(nonatomic,strong)NSString         *iconUrl;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

