//
//  CommentModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/2.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@protocol CommentModel

@end

@interface CommentModel : JSONModel

@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *createdate;
@property (nonatomic,strong) NSString *membername;

@end


@interface arrayModel : JSONModel

@property (nonatomic,strong) NSArray <CommentModel>*commentlist;

@end
