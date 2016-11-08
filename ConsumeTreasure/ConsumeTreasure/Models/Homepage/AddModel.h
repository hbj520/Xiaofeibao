//
//  AddModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@protocol AddModel
@end

@interface AddModel : JSONModel

@property (nonatomic,strong) NSString *adimg;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *title;

@end



@interface ShowModel : JSONModel

@property (nonatomic,strong) NSArray<AddModel>* adList;
@end


