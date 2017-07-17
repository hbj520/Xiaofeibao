//
//  BeUnionModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@protocol BeUnionModel
@end

@interface BeUnionModel : JSONModel
@property (nonatomic,strong) NSString *iconurl;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *categoryId;
@end

@interface arrayUnionModel : JSONModel
@property (nonatomic,strong) NSArray<BeUnionModel>* list;
@end


/**
 地质类型
 */
@protocol AddressTypeModel
@end

@interface AddressTypeModel : JSONModel
@property (nonatomic,strong) NSString<Optional> *addressType;
@property (nonatomic,strong) NSString<Optional> *val;
@end

@interface ArrAddrTypeModel : JSONModel
@property (nonatomic,strong) NSArray<AddressTypeModel>* addressTypeList;
@end


/**
 营业执照类型
 */
@protocol BusinessTypeModel
@end

@interface BusinessTypeModel : JSONModel
@property (nonatomic,strong) NSString<Optional> *licenseId;
@property (nonatomic,strong) NSString<Optional> *licenseName;
@end

@interface ArrBusiTypeModel : JSONModel
@property (nonatomic,strong) NSArray<BusinessTypeModel>* businessList;
@end


/**
 联系人类型
 */
@protocol ContactTypeModel
@end

@interface ContactTypeModel : JSONModel
@property (nonatomic,strong) NSString<Optional> *typeId;
@property (nonatomic,strong) NSString<Optional> *typeName;
@end

@interface ArrConTypeModel : JSONModel
@property (nonatomic,strong) NSArray<ContactTypeModel>* contactTypeList;
@end





