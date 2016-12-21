//
//  OnlinePayViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 16/12/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "OnlinePayViewController.h"
#import "SecurityUtil.h"
//#import <md5.h>
@interface OnlinePayViewController ()
@property (weak, nonatomic) IBOutlet UITextField *otherPaystyleTextfield;
@property (weak, nonatomic) IBOutlet UITextField *tongbaoCointTextfield;
@property (weak, nonatomic) IBOutlet UILabel *allMoney;
@property (weak, nonatomic) IBOutlet UIButton *payNowBtn;
- (IBAction)payNowBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;
@property (weak, nonatomic) IBOutlet UIButton *alipayBtn;
@property (weak, nonatomic) IBOutlet UILabel *restMoney;//通宝币余额
- (IBAction)backBtn:(id)sender;

@end

@implementation OnlinePayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification  object:self.otherPaystyleTextfield];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification  object:self.tongbaoCointTextfield];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.weixinBtn.selected = YES;
}
- (void)textFieldChanged:(NSNotification *)noti
{
    UITextField *textFeild = noti.object;
    if (textFeild.text.length >= 2 && textFeild.text.integerValue < 10) {
        textFeild.text = [NSString stringWithFormat:@"%.2f",textFeild.text.floatValue];
    }
    NSInteger allMoney = self.otherPaystyleTextfield.text.integerValue + self.tongbaoCointTextfield.text.integerValue;
    self.allMoney.text = [NSString stringWithFormat:@"%ld",allMoney];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)otherPaystyleTextfield:(UITextField *)sender {
    if (sender.text.length > 0) {
        sender.text = [NSString stringWithFormat:@"%.2f",sender.text.floatValue];
    }
}
- (IBAction)tongbaoCointTextfield:(UITextField *)sender {
    if (sender.text.length > 0) {
        sender.text = [NSString stringWithFormat:@"%.2f",sender.text.floatValue];
    }
}
- (IBAction)weixinBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.alipayBtn.selected = NO;
        [self.alipayBtn setImage:[UIImage imageNamed:@"binggo"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"binggo_on"] forState:UIControlStateNormal];
    }else{
      [sender setImage:[UIImage imageNamed:@"binggo"] forState:UIControlStateNormal];
    }
}
- (IBAction)alipayBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.weixinBtn.selected = NO;
        [self.weixinBtn setImage:[UIImage imageNamed:@"binggo"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"binggo_on"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"binggo"] forState:UIControlStateNormal];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)payNowBtn:(UIButton *)sender {
    NSString *stringA = @"ordertype=0&paytype=1&price=30&price_tbb=0&title=支付订单&tomemid=00471daf-9297-4f1a-87ce-6888d9fcc351&tradetype=APP";
    NSString *stingSignTemp = [NSString stringWithFormat:@"%@&key=%@",stringA,@"XFB@96478YY"];
    NSString *sign = [[SecurityUtil encryptMD5String:stingSignTemp] uppercaseString];
   // NSString *encodeSign = [[SecurityUtil encodeBase64String:sign] uppercaseString];
    
    
    [[MyAPI sharedAPI] payMoneyWithParameters:@{@"tradetype": @"APP",
                                                @"title": @"支付订单",
                                                @"ordertype": @"0",
                                                @"tomemid": @"00471daf-9297-4f1a-87ce-6888d9fcc351" ,
                                                @"price": @"30",
                                                @"price_tbb": @"0",
                                                @"paytype": @"1",
                                                @"sign":sign
                                                } resut:^(BOOL sucess, NSString *msg) {
        
        
    } errorResult:^(NSError *enginerError) {
        
        
    }];
    
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
