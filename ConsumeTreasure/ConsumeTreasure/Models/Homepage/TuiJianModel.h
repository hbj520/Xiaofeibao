//
//  TuiJianModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"


@protocol TuiJianModel
@end

@interface TuiJianModel : JSONModel

@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *doorImg;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *islink;




@end



@interface arratModel : JSONModel

@property (nonatomic,strong) NSArray<TuiJianModel>* memList;


@end
