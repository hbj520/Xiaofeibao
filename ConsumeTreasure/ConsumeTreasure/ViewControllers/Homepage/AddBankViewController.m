//
//  AddBankViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/27.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AddBankViewController.h"
#import "MyBankCardViewController.h"

#import "JHCoverView.h"

@interface AddBankViewController ()<JHCoverViewDelegate>
{
    NSString *payPsw;
    
}

@property (nonatomic, strong) JHCoverView *coverView;
@end

@implementation AddBankViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.cardNum.tag = 555;
    self.cardMasterName.enabled = NO;
    self.cardMasterName.text = @"啦啦啦";
    
    [self upPayKeyBoard];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
}
- (IBAction)sure:(id)sender {
    //确认绑定
    
    
    self.coverView.hidden = NO;
    [self.coverView.payTextField becomeFirstResponder];
    
    __weak typeof(self) weakSelf = self;
    self.coverView.tBlock =^(NSString *str){
        
        weakSelf.coverView.hidden = YES;
        [weakSelf.coverView.payTextField resignFirstResponder];
        payPsw = str;
        
         [weakSelf postDataWithStr:str];
    };
    
    
    
   
}

- (void)postDataWithStr:(NSString*)str{
    
    NSString *payPswSafe = [Tools loginPasswordSecurityLock:str];
    
    NSDictionary *para = @{
                           @"payPwd":payPswSafe,
                           @"bankaddr":self.cardArea.text,
                           @"bankname":self.cardBankName.text,
                           @"bankno":self.cardNum.text
                           };
    
    [[MyAPI sharedAPI] typeInInfoWithParameters:para result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            
            [self.coverView.payTextField resignFirstResponder];
            
            
            [self backTolastPage];
            
            if (self.chooseBank) {
                self.chooseBank();
            }
            
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
}

//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if (textField.tag == 555) {
//        [UIView animateWithDuration:0.26 animations:^{
//            self.view.frame=CGRectMake(0, -200, WIDTH, HEIGHT);
//        }];
//    }
//   
//    
//}
//
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [UIView animateWithDuration:0.26 animations:^{
//        self.view.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
//    }];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
