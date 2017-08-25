//
//  NewAddContentTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 2017/7/17.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^textFBlock)(NSString *);
typedef void(^BtnBlock)();

@interface NewAddContentTableViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UITextField *serviceTF;
@property (weak, nonatomic) IBOutlet UITextField *aliasNameTF;
//@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *shopreturnrateTF;
@property (weak, nonatomic) IBOutlet UITextField *posrateTF;
@property (weak, nonatomic) IBOutlet UITextField *businessLicenseTF;
@property (weak, nonatomic) IBOutlet UITextField *cardNoTF;
@property (weak, nonatomic) IBOutlet UITextField *cardNameTF;

//@property (nonatomic,copy)textFBlock serviceBlock;
@property (nonatomic,copy)textFBlock aliasNameBlock;
//@property (nonatomic,copy)textFBlock emailBlock;
@property (nonatomic,copy)textFBlock shopreturnrateBlock;
@property (nonatomic,copy)textFBlock posrateBlock;
@property (nonatomic,copy)textFBlock businessLicenseBlock;
@property (nonatomic,copy)textFBlock cardNoBlock;
@property (nonatomic,copy)textFBlock cardNameBlock;


@property (weak, nonatomic) IBOutlet UIButton *shopReturnBtn;
@property (weak, nonatomic) IBOutlet UIButton *posBtn;



@property (nonatomic, copy) BtnBlock shopReturnBlock;
@property (nonatomic, copy) BtnBlock posBlock;









@end
