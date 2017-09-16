//
//  AgencyOnlinePayViewController.m
//  ConsumeTreasure
//
//  Created by apple on 2017/9/14.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "AgencyOnlinePayViewController.h"
#import "DaliStarLevelButton.h"
#import "CompeletePayController.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
@interface AgencyOnlinePayViewController ()<WXApiDelegate>

@property (weak, nonatomic) IBOutlet UIButton *wxbtn;
@property (weak, nonatomic) IBOutlet UIButton *zfbbtn;
@property (strong,nonatomic) NSMutableArray *buttonAraay;
@property (strong,nonatomic) NSString *moneyStr;
@end

@implementation AgencyOnlinePayViewController
- (IBAction)wxbtn:(id)sender {
    _wxbtn.selected = !_wxbtn.selected;
    _zfbbtn.selected = !_wxbtn.selected;
}
- (IBAction)zfbbtn:(id)sender {
    _zfbbtn.selected = !_zfbbtn.selected;
    _wxbtn.selected = !_zfbbtn.selected;
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)paynowBtn:(id)sender {
//[self performSegueWithIdentifier:@"comepelePaySegueId" sender:nil];
    NSString *agenttype = @"";
    for (DaliStarLevelButton *btn  in _buttonAraay) {
        if (btn.selectImageView.hidden == NO) {
            agenttype = [NSString stringWithFormat:@"%ld",btn.tag];
        }
    }
    NSString *payType = (_wxbtn.selected == YES) ? @"1" : @"2";
    if (!self.recommendPhone) {
        self.recommendPhone = @"";
    }
    NSDictionary *dic = @{
                          @"agenttype":agenttype,
                          @"paytype":payType,
                          @"tjr_phone":self.recommendPhone
                          };
    
    [[MyAPI sharedAPI] buyAgencyWithParameters:dic result:^(BOOL success, NSString *msg, id responseObject) {
        //微信支付
        if ([dic[@"paytype"] isEqualToString:@"1"]) {
            PayReq *request = [[PayReq alloc] init];
            NSString *stamp = responseObject[@"data"][@"timestamp"];
            request.openID= responseObject[@"data"][@"appid"];
            request.partnerId =responseObject[@"data"][@"partnerid"];
            request.prepayId= responseObject[@"data"][@"prepayid"];
            request.package = responseObject[@"data"][@"packageStr"];
            request.nonceStr= responseObject[@"data"][@"noncestr"];
            request.sign=responseObject[@"data"][@"sign"];
            request.timeStamp=stamp.intValue;
            [WXApi sendReq:request];
            [self performSegueWithIdentifier:@"comepelePaySegueId" sender:nil];

        }else if ([dic[@"paytype"] isEqualToString:@"2"]){//支付宝支付
            NSString *orderString = responseObject[@"data"];
            NSString *appScheme = @"AliJustPay";
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary*resultDic) {
                
                
                NSLog(@"reslut = %@",resultDic);
            }];
            [self performSegueWithIdentifier:@"comepelePaySegueId" sender:nil];
            
        }

    } errorResult:^(NSError *enginerError) {
        
    }   ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PrivateMethod
- (void)setUpUI{
    _wxbtn.selected = YES;
    _buttonAraay = [NSMutableArray array];
    CGFloat superViewHeight = 220;
    CGFloat withMargin = 30;
    CGFloat heightMargin = 15;
    CGFloat with = (ScreenWidth - 3 * withMargin) / 2;
    CGFloat height = (superViewHeight - 3 * heightMargin)/2;
    for (NSInteger i = 0; i < 4; i++) {
        DaliStarLevelButton *button = [DaliStarLevelButton loadNibView];
        NSString *imageName = [NSString stringWithFormat:@"agency_%ld",i];
        button.backImageView.image = [UIImage imageNamed:imageName];
        if (i==0) {
            button.selectImageView.hidden = NO;
        }
        //行
        NSInteger line = i/2;
        //列
        NSInteger col = i % 2;
        button.frame = CGRectMake((col+1)*withMargin + with*col , (line+1)*heightMargin + height*line + 157, with, height);
        button.tag = i + 3;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [_buttonAraay addObject:button];
    }
    //defual money
    _moneyStr = @"6000元";
}
- (void)clickButton:(id)sender{
    DaliStarLevelButton *btn =  (DaliStarLevelButton *)sender;
    for (DaliStarLevelButton *daliBtn in _buttonAraay) {
        BOOL selectState = (daliBtn == btn) ? NO : YES;
        daliBtn.selectImageView.hidden = selectState;
        if (!selectState) {
            switch (daliBtn.tag) {
                case 3:
                    _moneyStr = @"6000元";
                    break;
                case 4:
                    _moneyStr = @"12000元";
                    break;
                case 5:
                    _moneyStr = @"36000元";
                    break;
                    
                default:
                    _moneyStr = @"请联系客服:0551-65411866";
                    break;
            }
        }
       

    }
}
#pragma mark - WXDelegate
- (void)onReq:(BaseReq *)req{
    
}
#pragma mark - PrepareSegueDelegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CompeletePayController *comepeVC = (CompeletePayController *)segue.destinationViewController;
    comepeVC.paytype = (_wxbtn.isSelected == YES) ? @"微信支付" : @"支付宝支付";
    comepeVC.payMoney = _moneyStr;
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
