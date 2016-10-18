//
//  TongbaoMoneyView.m
//  ConsumeTreasure
//
//  Created by youyou on 10/18/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "TongbaoMoneyView.h"

@implementation TongbaoMoneyView
- (id)initWithFrame:(CGRect)frame money:(float)money{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIWithmoney:money];
    }
    return self;
}
- (void)createUIWithmoney:(float)money{
    NSString *moneyString = [NSString stringWithFormat:@"%.2f",money];
    NSArray *moneyArray = [moneyString componentsSeparatedByString:@"."];
    NSString *integerMoney = moneyArray[0];
    NSString *newInterMoney = [self newMoneyString:integerMoney];
    NSString *newMoney = [NSString stringWithFormat:@"%@.%@",newInterMoney,moneyArray[1]];
    CGSize moneySize = [Tools stringToSize:newMoney];
    self.moneyLabel = [[UILabel alloc] init];
    self.enableSeeButton = [[UIButton alloc] init];
    [self.enableSeeButton setImage:[UIImage imageNamed:@"see"] forState:UIControlStateNormal];
    self.moneyLabel.frame = CGRectMake(0, 0, moneySize.width + 20, 15);
    self.moneyLabel.text = newMoney;
    self.enableSeeButton.frame = CGRectMake(moneySize.width + 25, 0, 20, 15);
    self.frame = CGRectMake(12, 22, moneySize.width + 90, 15);
    [self addSubview:self.moneyLabel];
    [self addSubview:self.enableSeeButton];
    
}
- (NSString *)newMoneyString:(NSString *)money{
    NSMutableString * newMoneyString = [NSMutableString stringWithString:money];
    if (money.length/3 > 0) {
        for (NSInteger i = 0; i < money.length/3; i++) {
            [newMoneyString insertString:@"," atIndex:(i+1)*3 +i];
        }
    }
    return newMoneyString;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
