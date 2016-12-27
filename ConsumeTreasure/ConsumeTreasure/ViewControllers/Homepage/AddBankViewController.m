//
//  AddBankViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/27.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AddBankViewController.h"

@interface AddBankViewController ()

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
    
    NSDictionary *para = @{
                           @"payPwd":@"123456",
                           @"bankaddr":self.cardArea.text,
                           @"bankname":self.cardBankName.text,
                           @"bankno":self.cardNum.text
                           };
    
    [[MyAPI sharedAPI] typeInInfoWithParameters:para result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            
            showAlert(@"添加成功");
            if (self.chooseBank) {
                self.chooseBank();
            }
            [self backTolastPage];
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
    
   
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 555) {
        [UIView animateWithDuration:0.26 animations:^{
            self.view.frame=CGRectMake(0, -200, WIDTH, HEIGHT);
        }];
    }
   
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.26 animations:^{
        self.view.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
    }];
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
