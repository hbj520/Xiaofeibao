//
//  CompeletePayController.m
//  ConsumeTreasure
//
//  Created by apple on 2017/9/14.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "CompeletePayController.h"

@interface CompeletePayController ()
@property (weak, nonatomic) IBOutlet UILabel *paytypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymenLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;


@end

@implementation CompeletePayController
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -PrivateMethod
- (void)setUpUI{
    self.paytypeLabel.text = self.paytype;
    self.payMoneyLabel.text = self.payMoney;
}
@end
