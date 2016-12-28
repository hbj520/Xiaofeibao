//
//  WithDrawViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/27.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "WithDrawViewController.h"
#import "MyBankCardViewController.h"
#import <Masonry.h>


@interface WithDrawViewController ()<XWMoneyTextFieldLimitDelegate>
{
    XWMoneyTextField *Tongtf;
}

@end

@implementation WithDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setTextField];
}

- (void)setTextField{
    CGRect frame = CGRectMake(50,40,[UIScreen mainScreen].bounds.size.width - 100,40);
    Tongtf = [[XWMoneyTextField alloc] initWithFrame:frame];
    Tongtf.textAlignment = UITextAlignmentLeft;
    Tongtf.font = [UIFont systemFontOfSize:25];
    Tongtf.tintColor= [UIColor redColor];
    Tongtf.textColor = [UIColor redColor];
    Tongtf.placeholder = @"请输入金额";
    Tongtf.keyboardType = UIKeyboardTypeDecimalPad;
    Tongtf.limit.delegate = self;
    Tongtf.limit.max = @"999999999.99";
    
    [self.withdrawView addSubview:Tongtf];
    
    [Tongtf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
         make.left.equalTo(@50);
        make.right.equalTo(@(-10));
        make.top.equalTo(@35);
    }];
}

#pragma mark - XWMoneyTextFieldLimitDelegate
- (void)valueChange:(id)sender{
    
    if ([sender isKindOfClass:[XWMoneyTextField class]]) {
        
        XWMoneyTextField *tf = (XWMoneyTextField *)sender;
        
        
//        if ([tf.text floatValue] > leftMoney) {
//            self.disCountMoney.text = [NSString stringWithFormat:@"- %ld",(long)leftMoney];//折扣
//            
//            self.realPay.text = [NSString stringWithFormat:@"%.2f",([tf.text floatValue] - leftMoney)]; // ([tf.text floatValue] - leftMoney);//实付
//            self.getTongMoney.text = [NSString stringWithFormat:@"%.2f",([self.realPay.text floatValue]/10)];//获得通宝币
//            
//        }else{
//            self.disCountMoney.text = [NSString stringWithFormat:@"- %@",tf.text];
//            self.realPay.text = @"0";
//            self.getTongMoney.text = @"0";
//        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
}

- (IBAction)chooseBankClick:(id)sender {
    [self performSegueWithIdentifier:@"goBankSegue" sender:@"1"];
}

- (IBAction)getAllLeftMoney:(id)sender {
    
}


- (IBAction)getMoneyNow:(id)sender {
    NSLog(@"立即提现");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
 
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"goBankSegue"]) {
        NSString *str = (NSString*)sender;
        MyBankCardViewController *bankVC = segue.destinationViewController;
        bankVC.type = str;
        
        bankVC.bankBlock =^(bankCardModel *model){
            self.defaultBank.text = model.bankname;
            self.defaultBankNum.text = [NSString stringWithFormat:@"尾号%@",model.bankno];
            self.defaultCardType.text = @"储蓄卡";
        };
        
    }
    
    
}


@end
