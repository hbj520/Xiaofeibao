//
//  ApplyContentTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ApplyContentTableViewCell.h"

@implementation ApplyContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)getName:(UITextField *)tf {
    if (self.trueNameBlock) {
        self.trueNameBlock(tf.text);
    }
}

- (IBAction)identiNum:(UITextField *)tf {
    if (self.identiNumBlock) {
        self.identiNumBlock(tf.text);
    }
}


- (IBAction)storeName:(UITextField *)tf {
    if (self.storeNameBlock) {
        self.storeNameBlock(tf.text);
    }
}

- (IBAction)phoneText:(UITextField *)tf {
    if (self.phoneTextBlock) {
        self.phoneTextBlock(tf.text);
    }
}

- (IBAction)storeAddrText:(UITextField *)tf {
    if (self.storeAddrTextBlock) {
        self.storeAddrTextBlock(tf.text);
    }
}

- (IBAction)inviteCodeText:(UITextField *)tf {
    if (self.inviteCodeTextBlock) {
        self.inviteCodeTextBlock(tf.text);
    }
}






- (IBAction)choose:(id)sender {
    if (self.chooseBlock) {
        self.chooseBlock();
    }
}

- (IBAction)position:(id)sender {
    if (self.positionBlock) {
        self.positionBlock();
    }
}


@end
