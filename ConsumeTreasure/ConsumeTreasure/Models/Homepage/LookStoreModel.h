//
//  LookStoreModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@interface LookStoreModel : JSONModel

@property (nonatomic,strong) NSString *addr2;
@property (nonatomic,strong) NSString <Optional>*doorImage;
@property (nonatomic,strong) NSString *shopName;
//@property (nonatomic,strong) NSString *objid;
//@property (nonatomic,strong) NSString *collectsnum;
//-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

/*
@interface mListModel : JSONModel
@property (nonatomic,strong) NSArray<LookStoreModel *>* mLIst;

@end
*/
