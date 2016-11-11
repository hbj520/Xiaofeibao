//
//  AreaModel.h
//  ConsumeTreasure
//
//  Created by youyou on 11/11/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AreaModel : JSONModel
@property (nonatomic,copy) NSString *cityid;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *name;
@end
