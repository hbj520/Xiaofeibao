//
//  AttractInvestModel.h
//  ConsumeTreasure
//
//  Created by youyou on 2017/5/24.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol AttractInvestModel

@end
@interface AttractInvestModel : JSONModel

@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *agentType;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

@interface AttractInvestModelAray : JSONModel

@property (nonatomic,strong) NSString *balance;

@property (nonatomic,strong) NSArray<AttractInvestModel>* myRecommendProxyList;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;


@end
