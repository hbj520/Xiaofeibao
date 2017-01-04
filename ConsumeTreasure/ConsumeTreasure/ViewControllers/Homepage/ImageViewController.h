//
//  ImageViewController.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BasePhotoViewController.h"
typedef void(^IMGBlock) (NSString *imgStr);
@interface ImageViewController : BasePhotoViewController
@property (strong, nonatomic) IBOutlet UIImageView *theImage;
@property (strong, nonatomic) IBOutlet UIButton *chooseBtn;


@property (nonatomic,strong) NSArray *imageArray;

@property (nonatomic,copy) IMGBlock imgBlock;

@end
