//
//  TobeAgencyViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TobeAgencyViewController.h"
#import "CheckID.h"
#import "AgencyOnlinePayViewController.h"
@interface TobeAgencyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *IDCardTextfeild;
@property (weak, nonatomic) IBOutlet UITextField *recommendPhone;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegment;

@end

@implementation TobeAgencyViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // self.view.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    self.navigationController.navigationBarHidden = NO;
    
    //self.navigationController.navigationBar.barTintColor = RGBACOLOR(255, 87, 59, 1);
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)upInfo:(id)sender {
   // [self performSegueWithIdentifier:@"AgencyOnlinePaySegueId" sender:nil];

    if ([CheckID deptNameInputShouldChineseWithStr:self.realName.text] == NO) {
        showAlert(@"请输入汉字格式的真实姓名");
    }else if ([CheckID isMobileNumber:self.realPhone.text] == NO){
        showAlert(@"请输入正确格式的手机号");
    }else if ([CheckID verifyIDCardNumber:self.IDCardTextfeild.text] == NO){
        showAlert(@"请输入正确格式的身份证号");
    }else{
        NSString *sex = [NSString stringWithFormat:@"%ld",self.sexSegment.selectedSegmentIndex];
        NSDictionary *para = @{
                                       @"name":self.realName.text,
                                       @"sex":sex,
                                       @"phone":self.realPhone.text,
                                       @"idCardNo":self.IDCardTextfeild.text,
                                       @"recommendPhone":self.recommendPhone.text
                               };
        
        [[MyAPI sharedAPI] applyDaliDataWithParameters:para result:^(BOOL sucess, NSString *msg) {
            if (sucess) {
                [self performSegueWithIdentifier:@"AgencyOnlinePaySegueId" sender:nil];
            }else{
                if ([msg isEqualToString:@"-1"]) {
                    [self logout];
                }
                showAlert(msg);
            }
            
        } errorResult:^(NSError *enginerError) {
            
        }];
    }
    
    
    
}


- (IBAction)back:(id)sender {
    [self backTolastPage];
}
#pragma mark - prepareSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    AgencyOnlinePayViewController *onlineVC = (AgencyOnlinePayViewController *)segue.destinationViewController;
    onlineVC.recommendPhone = self.recommendPhone.text;
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
