//
//  WithDrawViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/27.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "WithDrawViewController.h"

#import <Masonry.h>


@interface WithDrawViewController ()
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
//    CGRect frame = CGRectMake(100,0,[UIScreen mainScreen].bounds.size.width - 100,44);
//    Tongtf = [[XWMoneyTextField alloc] initWithFrame:frame];
//    Tongtf.textAlignment = UITextAlignmentRight;
//    Tongtf.font = [UIFont systemFontOfSize:20];
//    Tongtf.tintColor= [UIColor redColor];
//    Tongtf.textColor = [UIColor redColor];
//    Tongtf.placeholder = @"请输入金额";
//    Tongtf.keyboardType = UIKeyboardTypeDecimalPad;
//    Tongtf.limit.delegate = self;
//    Tongtf.limit.max = @"99999.99";
//    
//    [self.tfView addSubview:Tongtf];
//    
//    [Tongtf mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(@0);
//        // make.left.equalTo(@100);
//        make.right.equalTo(@(-10));
//        make.top.equalTo(@0);
//    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
}

- (IBAction)chooseBankClick:(id)sender {
    
}

- (IBAction)getAllLeftMoney:(id)sender {
    
}


- (IBAction)getMoneyNow:(id)sender {
    NSLog(@"立即提现");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
