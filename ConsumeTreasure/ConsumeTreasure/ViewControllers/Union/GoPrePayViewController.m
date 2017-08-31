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
#import "StoreDetailModel.h"
#import "SecurityUtil.h"

#import <Masonry.h>

#import "MDEncryption.h"
#import "JHCoverView.h"

@interface GoPrePayViewController ()<XWMoneyTextFieldLimitDelegate,JHCoverViewDelegate>
{
    float leftMoney;//可用智惠币余额
    float realMoney;//拥有智惠币
    
    XWMoneyTextField *Tongtf;
    
    tongBaoModel *tongModel;
    
    double discountStr;
    
    StoreDetailModel *_deModel;
    
    NSString *payWayStr;//支付方式
    NSString *useZHB;
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
    
    payWayStr  = @"0";//默认通宝币支付
    
    [self setTextField];
    [self setUseLeftMoney];
    [self getTongLeft];//请求余额
    [self getDisCount];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    // [self upPayKeyBoard];
}

- (void)getDisCount{
    NSDictionary *para = @{
                           @"memid":self.toMemId
                           };
    [[MyAPI sharedAPI] getDetailStoreWithParameters:para result:^(BOOL success, NSString *msg, id object) {
        if (success) {
            _deModel = object;
            discountStr = _deModel.shopReturnRate;
        
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];

    
    
}


- (void)getTongLeft{
    NSDictionary *para = @{
                           
                           };
    [[MyAPI sharedAPI] getTongBaoBiAndPayPswWithParameters:para resut:^(BOOL success, NSString *msg, id object) {
        if (success) {
            tongModel = (tongBaoModel*)object;
            leftMoney = [tongModel.goldNum floatValue];
            realMoney = [tongModel.goldNum floatValue];
            self.leftTongMoney.text = [NSString stringWithFormat:@"可用余额%.2f",[tongModel.goldNum floatValue]];

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
    Tongtf.limit.max = @"9999.99";
    
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
    
    button.selected = !button.selected;
    
    //self.disCountMoney.text = @"";
    //Tongtf.text = @"";
    self.realPay.text = @"";
    self.getTongMoney.text = @"";
    
    if (button.selected == NO) {
        
        self.disCountMoney.text = @"";
        leftMoney = 0;
        useZHB = @"0";
        self.realPay.text = Tongtf.text;
        self.getTongMoney.text = [NSString stringWithFormat:@"%.2f",([self.realPay.text floatValue]*discountStr)];
    }else{
        leftMoney = realMoney;
        useZHB = @"1";
        if ([Tongtf.text floatValue] <= realMoney) {
            self.disCountMoney.text = [NSString stringWithFormat:@"- %.2f",[Tongtf.text floatValue]];
            self.realPay.text = @"0";
            self.getTongMoney.text = @"0";
        }else{
            self.disCountMoney.text = [NSString stringWithFormat:@"- %.2f",realMoney];
            self.realPay.text = [NSString stringWithFormat:@"%.2f",([Tongtf.text floatValue] - leftMoney)];
            self.getTongMoney.text = [NSString stringWithFormat:@"%.2f",([self.realPay.text floatValue]*discountStr)];
        }
        
        
        
        
        
        
        
        
    }
}


#pragma mark - XWMoneyTextFieldLimitDelegate
- (void)valueChange:(id)sender{
    
    if ([sender isKindOfClass:[XWMoneyTextField class]]) {
        
        XWMoneyTextField *tf = (XWMoneyTextField *)sender;
        
        
        if ([tf.text floatValue] > leftMoney) {
            self.disCountMoney.text = [NSString stringWithFormat:@"- %.2f",leftMoney];//折扣
            
            self.realPay.text = [NSString stringWithFormat:@"%.2f",([tf.text floatValue] - leftMoney)]; // ([tf.text floatValue] - leftMoney);//实付
            self.getTongMoney.text = [NSString stringWithFormat:@"%.2f",([self.realPay.text floatValue]*discountStr)];//获得智惠币
            
        }else{
            self.disCountMoney.text = [NSString stringWithFormat:@"- %@",tf.text];
            self.realPay.text = @"0";
            self.getTongMoney.text = @"0";
        }
    }}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [Tongtf resignFirstResponder];
}

- (void)upPayKeyBoardWithPayWay:(NSString*)PWStr{
    
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
        
        if ([PWStr isEqualToString:@"1"]) {
            
            weakSelf.coverView.hidden = YES;
            [weakSelf.coverView.payTextField resignFirstResponder];
            [weakSelf postDataWithStr:str];
            [self.coverView removeFromSuperview];
            
        }else{
            
            NSString *SafeStr = [Tools loginPasswordSecurityLock:str];
            
            NSDictionary *para = @{
                                   @"zfpass":SafeStr
                                   };
            [[MyAPI sharedAPI] makeSurePassWordWithParameters:para result:^(BOOL sucess, NSString *msg) {
                if (sucess) {
                    self.hidesBottomBarWhenPushed = YES;
                    [self.coverView.payTextField resignFirstResponder];
                    [self.coverView removeFromSuperview];
                    // NSString *needPayStr = [NSString stringWithFormat:@"%f",([Tongtf.text floatValue] - leftMoney)];
                    NSString *leftMoneyStr = [NSString stringWithFormat:@"%.2f",leftMoney];
                    
                    [self performSegueWithIdentifier:@"gotoPay" sender:@[Tongtf.text,leftMoneyStr,self.toMemId,SafeStr]];
                    
                }else{
                    [self.coverView.payTextField resignFirstResponder];
                    [self.coverView removeFromSuperview];
                    [self showHint:msg];
                }
                
            } errorResult:^(NSError *enginerError) {
                
            }];
            
        }
    };
}


- (IBAction)GopayNext:(id)sender {
    
    if ([Tongtf.text floatValue] <= 0) {
        [self showHint:@"金额不可小于等于0"];
    }else{
    
    if ([Tongtf.text floatValue] > leftMoney) {
        //不用智慧币
        if ([useZHB isEqualToString:@"0"]||leftMoney==0 ) {
            self.hidesBottomBarWhenPushed = YES;
            NSString *leftMoneyStr = [NSString stringWithFormat:@"%f",leftMoney];
            [self performSegueWithIdentifier:@"gotoPay" sender:@[Tongtf.text,leftMoneyStr,self.toMemId,@"0"]];
        }else{
            [self upPayKeyBoardWithPayWay:@"0"];//多方支付
        }
    }else{
        // self.coverView.hidden = NO;
        [self upPayKeyBoardWithPayWay:@"1"];//智慧币支付
        
    }
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
    
    
    
    //调智惠币支付
    [[MyAPI sharedAPI] payMoneyWithParameters:para resut:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            //[self showHint:msg];
            //showAlert(msg);
            //[self.navigationController popViewControllerAnimated:YES];
            [self performSegueWithIdentifier:@"paySuccessSegue" sender:nil];
            
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
          //
            
            [self showHint:msg];

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
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
@end
