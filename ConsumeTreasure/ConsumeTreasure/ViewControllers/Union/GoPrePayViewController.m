//
//  GoPrePayViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "GoPrePayViewController.h"
#import "SetPayPswViewController.h"
#import "OtherPayWayViewController.h"
#import "PersonInfoModel.h"

#import "SecurityUtil.h"

#import <Masonry.h>

#import "MDEncryption.h"
#import "JHCoverView.h"

@interface GoPrePayViewController ()<XWMoneyTextFieldLimitDelegate>
{
    float leftMoney;//可用通宝币余额
    float realMoney;//拥有通宝币
    
    XWMoneyTextField *Tongtf;
    
    tongBaoModel *tongModel;
}

@property (nonatomic, strong) JHCoverView *coverView;

@end

@implementation GoPrePayViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //leftMoney = 20;
    [self setTextField];
    [self setUseLeftMoney];
    [self getTongLeft];//请求余额
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
     [self upPayKeyBoard];
}

- (void)getTongLeft{
    NSDictionary *para = @{
                           
                           };
    [[MyAPI sharedAPI] getTongBaoBiAndPayPswWithParameters:para resut:^(BOOL success, NSString *msg, id object) {
        if (success) {
            tongModel = (tongBaoModel*)object;
            leftMoney = [tongModel.goldNum floatValue];
            realMoney = [tongModel.goldNum floatValue];
            self.leftTongMoney.text = [NSString stringWithFormat:@"可用余额%@",tongModel.goldNum];

            if ([tongModel.hasPayPwd isEqualToString:@"0"]) {
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您尚未设置支付密码，是否立即前往设置。或者您可以在”我“->“设置”中去设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
                [alert show];
            }
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }
        
        
    } errorResult:^(NSError *enginerError) {
        
    }];
    
    
}


#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
            
            break;
            
        case 1:
        {
           //去设置支付密码
            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
            SetPayPswViewController *SetPayPswVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"setPayPswSB"];
            [self.navigationController pushViewController:SetPayPswVC animated:YES];

        }
            break;
    }
}

- (void)setTextField{
    CGRect frame = CGRectMake(100,0,[UIScreen mainScreen].bounds.size.width - 100,44);
    Tongtf = [[XWMoneyTextField alloc] initWithFrame:frame];
    Tongtf.textAlignment = UITextAlignmentRight;
    Tongtf.font = [UIFont systemFontOfSize:20];
    Tongtf.tintColor= [UIColor redColor];
    Tongtf.textColor = [UIColor redColor];
    Tongtf.placeholder = @"请输入金额";
    Tongtf.keyboardType = UIKeyboardTypeDecimalPad;
    Tongtf.limit.delegate = self;
    Tongtf.limit.max = @"99999.99";
    
    [self.tfView addSubview:Tongtf];
    
    [Tongtf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        // make.left.equalTo(@100);
        make.right.equalTo(@(-10));
        make.top.equalTo(@0);
    }];
}

- (void)setUseLeftMoney{
    self.useLeftMoneyBtn.selected = YES;
    [self.useLeftMoneyBtn setBackgroundImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    [self.useLeftMoneyBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [self.useLeftMoneyBtn addTarget:self action:@selector(chooseUse:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)chooseUse:(UIButton*)button{

    
    self.disCountMoney.text = @"";
    Tongtf.text = @"";
    self.realPay.text = @"";
    self.getTongMoney.text = @"";
    button.selected = !button.selected;
    if (button.selected == NO) {
        leftMoney = 0;
    }else{
        leftMoney = realMoney;
    }
}


#pragma mark - XWMoneyTextFieldLimitDelegate
- (void)valueChange:(id)sender{
    
    if ([sender isKindOfClass:[XWMoneyTextField class]]) {
        
        XWMoneyTextField *tf = (XWMoneyTextField *)sender;
        
      
        if ([tf.text floatValue] > leftMoney) {
            self.disCountMoney.text = [NSString stringWithFormat:@"- %ld",(long)leftMoney];//折扣
            
            self.realPay.text = [NSString stringWithFormat:@"%.2f",([tf.text floatValue] - leftMoney)]; // ([tf.text floatValue] - leftMoney);//实付
            self.getTongMoney.text = [NSString stringWithFormat:@"%.2f",([self.realPay.text floatValue]/10)];//获得通宝币
            
        }else{
            self.disCountMoney.text = [NSString stringWithFormat:@"- %@",tf.text];
            self.realPay.text = @"0";
            self.getTongMoney.text = @"0";
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [Tongtf resignFirstResponder];
}

- (void)upPayKeyBoard{
    
    [self.view layoutIfNeeded];
    JHCoverView *coverView = [[JHCoverView alloc] initWithFrame:self.view.bounds];
    coverView.delegate = self;
    self.coverView = coverView;
    //coverView.hidden = YES;
    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.coverView.payTextField becomeFirstResponder];
    [self.view addSubview:self.coverView];
    __weak typeof(self) weakSelf = self;

    self.coverView.tBlock =^(NSString *str){
        
        weakSelf.coverView.hidden = YES;
        [weakSelf.coverView.payTextField resignFirstResponder];
        [weakSelf postDataWithStr:str];
        [weakSelf.coverView removeFromSuperview];
    };
    
}

- (IBAction)GopayNext:(id)sender {
    
    if ([Tongtf.text floatValue] > leftMoney) {
        self.hidesBottomBarWhenPushed = YES;
        [Tongtf resignFirstResponder];
       // NSString *needPayStr = [NSString stringWithFormat:@"%f",([Tongtf.text floatValue] - leftMoney)];
        NSString *leftMoneyStr = [NSString stringWithFormat:@"%f",leftMoney];

        [self performSegueWithIdentifier:@"gotoPay" sender:@[Tongtf.text,leftMoneyStr,self.toMemId]];

    }else{
       // self.coverView.hidden = NO;
        
        [self upPayKeyBoard];

    }
        
        
           }


- (void)postDataWithStr:(NSString*)str{

     NSString *payPswSafe = [Tools loginPasswordSecurityLock:str];
    
    NSDictionary *SignForPara = @{
                                  @"tradetype": @"APP",
                                  @"title": @"支付订单",
                                  @"ordertype": @"0",
                                  @"tomemid": self.toMemId ,//chuan
                                  @"price": Tongtf.text,
                                  @"price_tbb":Tongtf.text,
                                  @"paytype": @"3",
                                  @"zfpass":payPswSafe,
                                  };
    
    NSString *stringA = [MXWechatSignAdaptor createMd5Sign:SignForPara];
    
    NSString *sign = [MDEncryption md5:stringA];
    
    /*
     NSString *stingSignTemp = [NSString stringWithFormat:@"%@&key=%@",stringA,@"XFB@96478YY"];
     NSString *sign = [[SecurityUtil encryptMD5String:stingSignTemp] uppercaseString];
     */
    
    NSDictionary *para = @{
                           @"tradetype": @"APP",
                           @"title": @"支付订单",
                           @"ordertype": @"0",
                           @"tomemid": self.toMemId ,//chuan
                           @"price": Tongtf.text,
                           @"price_tbb":Tongtf.text,
                           @"paytype": @"3",
                           @"zfpass":payPswSafe,
                           @"sign":sign
                           };
    
    
    
    //调通宝币支付
    [[MyAPI sharedAPI] payMoneyWithParameters:para resut:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            [self showHint:msg];
            //showAlert(msg);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
            [self showHint:msg];

           // showAlert(msg);
        }
    } errorResult:^(NSError *enginerError) {
        
    }];

    
}



- (IBAction)back:(id)sender {
    [self backTolastPage];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"gotoPay"]) {
        NSArray *passMoneyArr = (NSArray*)sender;
        OtherPayWayViewController *otherVC = segue.destinationViewController;
        otherVC.dataArr = passMoneyArr;
    }
    
    
}

@end
