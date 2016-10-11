//
//  ScanerVC.h
//  SuperScanner
//
//  Created by Jeans Huang on 10/19/15.
//  Copyright © 2015 gzhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SellerDataModel.h"

@interface ScanerVC : UIViewController
{
    NSString * _orderNO;
}

@property (nonatomic,copy)void(^block)(NSDictionary*dic);

@property (nonatomic,strong)SellerInfoModel *infoModel;

@property (nonatomic,copy)UITextField*orderNumTF;// 订单号输入框

@property (nonatomic,copy)UIImageView*imageView;// 输入框背景图片

@property (nonatomic,copy)UIScrollView*mainScrollView;// 点击扫描和手工录入可以滑动

@property (nonatomic,copy)UIButton*scanBtn;// 扫描按钮

@property (nonatomic,copy)UIButton*keyinBtn;// 手工录入按钮

@property (nonatomic,copy)UIButton*sureBtn;// 确认发单按钮

@property (nonatomic,copy)UIButton*cancelBtn;// 输入框内的取消按钮

@property (nonatomic,copy)UIView * backView;

@property (nonatomic,strong)NSString * whichPage;

@property(nonatomic,strong)NSString * shopName;//店铺名称

@property(nonatomic,strong)NSString * returnBate;//返币比例

@property(nonatomic,strong)NSString * goldNum;//通宝币

@property(nonatomic,strong)NSString * shopId;//店铺Id

@property(nonatomic,strong)NSString * headImgUrl;//店铺头像

@property(nonatomic,strong)NSString * judge;//店铺评分
@end

