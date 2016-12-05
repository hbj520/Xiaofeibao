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
}

- (void)setDeModel:(StoreDetailModel *)deModel{
    if (deModel) {
        self.storeNameLab.text = deModel.shopName;
        self.adresssLab.text = deModel.addr2;
        self.phNum = deModel.branchPhone;
    }
}

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
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.phNum]];
        
        }
            
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
