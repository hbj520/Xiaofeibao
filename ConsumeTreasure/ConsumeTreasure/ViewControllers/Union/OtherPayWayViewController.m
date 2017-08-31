//
//  OtherPayWayViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "OtherPayWayViewController.h"

@interface OtherPayWayViewController ()
{
    NSInteger payType;
    
    NSString *tongBaomoney;//支付的智惠币额
    NSString *cashMoney;//现金
    NSString *toMemId;//收款人
    
    NSString *pswStr;//支付密码
}

@end

@implementation OtherPayWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    payType = 1;//支付宝
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self choosePayWay];
    [self needPAY];
}

- (void)needPAY{
    cashMoney = [NSString stringWithFormat:@"%.2f",[_dataArr[0] floatValue]];
    tongBaomoney = _dataArr[1];
    toMemId = _dataArr[2];
    pswStr = _dataArr[3];
    
    self.realPay.text = [NSString stringWithFormat:@"%.2f",([cashMoney floatValue] - [tongBaomoney floatValue])];
}

- (void)choosePayWay{
    self.aliBtn.selected = YES;
    [self.aliBtn setBackgroundImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    [self.aliBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [self.aliBtn addTarget:self action:@selector(choosePayWayClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.wxBtn.selected = NO;
    [self.wxBtn setBackgroundImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    [self.wxBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [self.wxBtn addTarget:self action:@selector(choosePayWayClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)choosePayWayClick:(UIButton*)button{
    if (button.tag == 666) {
        self.aliBtn.selected = YES;
        self.wxBtn.selected = NO;
        payType = 1;
    }else{
        self.aliBtn.selected = NO;
        self.wxBtn.selected = YES;
        payType = 2;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
}
- (IBAction)paySure:(id)sender {
    
    if (payType == 1) {
        
        NSDictionary *SignForPara = @{
                                      @"tradetype": @"APP",
                                      @"title": @"支付订单",
                                      @"ordertype": @"0",
                                      @"tomemid": toMemId ,//chuan
                                      @"price": cashMoney,
                                      @"price_tbb":tongBaomoney,
                                      @"paytype": @"2",
                                      @"zfpass":pswStr,
                                      };
        NSString *stringA = [MXWechatSignAdaptor createMd5Sign:SignForPara];
        
        NSString *sign = [MDEncryption md5:stringA];
        
        NSDictionary *para = @{
                               @"tradetype": @"APP",
                               @"title": @"支付订单",
                               @"ordertype": @"0",
                               @"tomemid": toMemId ,//chuan
                               @"price": cashMoney,
                               @"price_tbb":tongBaomoney,
                               @"paytype": @"2",
                               @"zfpass":pswStr,
                               @"sign":sign
                               };
        //调支付宝支付
        [[MyAPI sharedAPI] payMoneyWithParameters:para resut:^(BOOL sucess, NSString *msg) {
            if (sucess) {
                //[self.navigationController popToRootViewControllerAnimated:YES];
                //showAlert(msg);
                [self performSegueWithIdentifier:@"paySuccessSegue" sender:nil];
            }else{
                if ([msg isEqualToString:@"-1"]) {
                    [self logout];
                }
            }
            
        } errorResult:^(NSError *enginerError) {
            
        }];
    }else{
        
        NSDictionary *SignForPara = @{
                                      @"tradetype": @"APP",
                                      @"title": @"支付订单",
                                      @"ordertype": @"0",
                                      @"tomemid": toMemId ,//chuan
                                      @"price": cashMoney,
                                      @"price_tbb":tongBaomoney,
                                      @"paytype": @"1",
                                      @"zfpass":pswStr,
                                      };
        NSString *stringA = [MXWechatSignAdaptor createMd5Sign:SignForPara];
        
        NSString *sign = [MDEncryption md5:stringA];
        
        NSDictionary *para = @{
                               @"tradetype": @"APP",
                               @"title": @"支付订单",
                               @"ordertype": @"0",
                               @"tomemid": toMemId ,//chuan
                               @"price": cashMoney,
                               @"price_tbb":tongBaomoney,
                               @"paytype": @"1",
                               @"zfpass":pswStr,
                               @"sign":sign
                               };
        //调微信支付
        [[MyAPI sharedAPI] payMoneyWithParameters:para resut:^(BOOL sucess, NSString *msg) {
            
            if (sucess) {
                //[self.navigationController popToRootViewControllerAnimated:YES];
                //showAlert(msg);
                [self performSegueWithIdentifier:@"paySuccessSegue" sender:nil];
            }else{
                if ([msg isEqualToString:@"-1"]) {
                    [self logout];
                }
            }
        } errorResult:^(NSError *enginerError) {
            
        }];

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

@end
