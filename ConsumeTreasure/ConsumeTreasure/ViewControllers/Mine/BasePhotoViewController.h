//
//  BasePhotoViewController.h
//  CRM
//
//  Created by ebadu on 15/4/17.
//  Copyright (c) 2015年 Razi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface BasePhotoViewController :BaseViewController

@property (nonatomic, copy) void (^imageBlock)(UIImage * img);

- (void)uploadImageWithImages:(NSMutableArray *)images;

//单个相片选择
- (void)openPhoto;

//相机选取
- (void)openCamera;

//相册选取
- (void)openPhotoAlbum;

//选取完照片
- (void)selectPhotos:(NSMutableArray *)array;

- (void)imageUrl:(NSString *)imageUrl;

@end
