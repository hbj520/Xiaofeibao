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

#import "JHCoverView.h"

@interface WithDrawViewController ()<XWMoneyTextFieldLimitDelegate,JHCoverViewDelegate>
{
    XWMoneyTextField *Tongtf;
    
    NSString *_payPsw;
    NSMutableArray *_cardList;
    
    NSString *theType;//区分今日或历史
    
    NSString *_bankID;
}
@property (nonatomic, strong) JHCoverView *coverView;
@end

@implementation WithDrawViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self judgeBankCard];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _cardList = [NSMutableArray array];
    
    [self setTextField];
    [self judgeBankCard];
    [self upPayKeyBoard];
    
    self.leftMoney.text = [NSString stringWithFormat:@"可提现余额为%@元",self.moneyType[0]];
    theType = self.moneyType[1];
}

- (void)upPayKeyBoard{
    
    [self.view layoutIfNeeded];
    JHCoverView *coverView = [[JHCoverView alloc] initWithFrame:self.view.bounds];
    coverView.delegate = self;
    self.coverView = coverView;
    coverView.hidden = YES;
    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.view addSubview:coverView];
    
}

- (void)judgeBankCard{
    NSDictionary *para = @{
                           
                           };
    [[MyAPI sharedAPI] getMyBankCardDataWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        
        if (success) {
            [_cardList removeAllObjects];
            _cardList = arrays[0];
            if (_cardList.count > 0) {
                bankCardModel *model = _cardList[0];
                self.defaultBank.text = model.bankname;
                self.defaultBankNum.text = [NSString stringWithFormat:@"尾号%@",model.bankno];
                self.defaultCardType.text = @"储蓄卡";
                
                _bankID = model.bank_id;
            }else{
                self.defaultBank.text = @"尚未设置银行卡";
                self.defaultBankNum.text = @"请点击前往添加";
                self.defaultCardType.text = @"";
                [self gotoAddBankCard];
                
            }
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [Tools logoutWithNowVC:self];
            }
        }
        
    
    } errorResult:^(NSError *enginerError) {
        
    }];

}


- (void)gotoAddBankCard{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"尚未设置银行卡，请前往添加。" preferredStyle:1];
    UIAlertAction *goAction = [UIAlertAction actionWithTitle:@"前往添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     
        
        [self performSegueWithIdentifier:@"goAddBankCardSegue" sender:nil];
        
        
    }];
    [alertCon addAction:goAction];
    [self presentViewController:alertCon animated:YES completion:nil];
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
    Tongtf.limit.max = @"9999999.99";
    
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
        
        if (tf.text.floatValue < 1000) {
            self.chargeNum.text = @"提现手续费为0.5元";
        }else{
            self.chargeNum.text = @"提现手续费为0元";
        }
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

    NSLog(@"%@",self.moneyType);
    Tongtf.text = self.moneyType[0];
}


- (IBAction)getMoneyNow:(id)sender {
    NSLog(@"立即提现");
   // NSLog(@"========%@======",_bankID);
    if (Tongtf.text.floatValue >= 1) {
        
        self.coverView.hidden = NO;
        [self.coverView.payTextField becomeFirstResponder];
        
        __weak typeof(self) weakSelf = self;
        self.coverView.tBlock =^(NSString *str){
            
            weakSelf.coverView.hidden = YES;
            [weakSelf.coverView.payTextField resignFirstResponder];
            //payPsw = str;
            //加个密
            _payPsw = [Tools loginPasswordSecurityLock:str];
            [weakSelf postDataWithStr:_payPsw];
        };
        
        
        
    }else{
        showAlert(@"请确认提现额度不得低于1元");
    }
}

- (void)postDataWithStr:(NSString*)str{

    [BQActivityView showActiviTy];
    NSDictionary *para = @{
                           @"total_fee":Tongtf.text,
                           @"trade_type":theType,
                           @"bankid":_bankID,
                           @"zfpass":str
                           };
    [[MyAPI sharedAPI] getMoneyWithDrawWithParameters:para result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            [BQActivityView hideActiviTy];
            showAlert(msg);
            
        }else{
            [BQActivityView hideActiviTy];
            showAlert(msg);
        }
        
    } errorResult:^(NSError *enginerError) {
        [BQActivityView hideActiviTy];
    }];


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
            _bankID = model.bank_id;
        };
        
    }
    
    
}


@end
