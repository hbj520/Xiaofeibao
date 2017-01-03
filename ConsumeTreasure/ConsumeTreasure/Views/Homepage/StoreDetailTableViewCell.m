//
//  StoreDetailTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/9.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StoreDetailTableViewCell.h"
#import "UIAlertView+flash.h"
@implementation StoreDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

    
    self.collectBtn.hidden = YES;
}

- (void)setDeModel:(StoreDetailModel *)deModel{
    if (deModel) {
        self.storeNameLab.text = deModel.shopName;
        self.adresssLab.text = deModel.addr;
        self.phNum = deModel.shopPhone;
        self.discountLab.text = [NSString stringWithFormat:@"现金支付立返%.2f%%",[deModel.shopReturnRate floatValue]*100];
//        if ([deModel.collect isEqualToString:@"1"]) {
//            self.collectBtn.selected = YES;
//        }else{
//            self.collectBtn.selected = NO;
//        }
    }
}



- (IBAction)location:(id)sender {
    
    if (self.colleBlock) {
         self.colleBlock();
    }
}



//- (IBAction)collectClick:(UIButton*)button {
//    button.selected = !button.selected;
//    if (self.colleBlock) {
//        self.colleBlock(button.selected);
//    }
//}

- (IBAction)phoneClick:(id)sender {
    
    NSString *str = [NSString stringWithFormat:@"是否确认拨打%@",self.phNum];
    
    if (self.phNum.length >0) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }else{
        [UIAlertView alertWithTitle:@"温馨提示" message:@"直营超市暂未开通电话功能" buttonTitle:nil];
    }
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
            
        case 1:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.phNum]]];
        }
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
