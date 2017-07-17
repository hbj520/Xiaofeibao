//
//  TypeChooseTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 2017/7/17.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnBlock)();

@interface TypeChooseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@property (weak, nonatomic) IBOutlet UIButton *addrBtn;
@property (weak, nonatomic) IBOutlet UIButton *licenseBtn;

@property (nonatomic, copy) BtnBlock contactBlock;
@property (nonatomic, copy) BtnBlock addrBlock;
@property (nonatomic, copy) BtnBlock licenseBlock;

@property (weak, nonatomic) IBOutlet UITextField *conTf;
@property (weak, nonatomic) IBOutlet UITextField *addrTf;
@property (weak, nonatomic) IBOutlet UITextField *licenceTf;



@end
