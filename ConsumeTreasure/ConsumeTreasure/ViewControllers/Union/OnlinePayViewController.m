//
//  OnlinePayViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 16/12/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "OnlinePayViewController.h"

@interface OnlinePayViewController ()
@property (weak, nonatomic) IBOutlet UITextField *otherPaystyleTextfield;
@property (weak, nonatomic) IBOutlet UITextField *tongbaoCointTextfield;
@property (weak, nonatomic) IBOutlet UILabel *allMoney;

@end

@implementation OnlinePayViewController
- (IBAction)otherPaystyleTextfield:(UITextField *)sender {
}
- (IBAction)tongbaoCointTextfield:(UITextField *)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification  object:self.otherPaystyleTextfield];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification  object:self.tongbaoCointTextfield];
}
- (void)textFieldChanged:(NSNotification *)noti
{
    self.allMoney.text = @"122";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)weixinBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"binggo_on"] forState:UIControlStateNormal];
    }else{
      [sender setImage:[UIImage imageNamed:@"binggo"] forState:UIControlStateNormal];
    }
}
- (IBAction)alipayBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
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

@end
