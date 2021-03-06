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
@property (nonatomic,strong) NSString *totalScore;
@property (nonatomic,strong) NSString <Optional>*imgUrl;

@end


@interface arrayCommModel : JSONModel

@property (nonatomic,strong) NSArray <CommentModel>*commentlist;

@end
