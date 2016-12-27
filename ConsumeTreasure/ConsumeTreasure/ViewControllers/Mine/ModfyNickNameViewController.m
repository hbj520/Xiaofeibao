//
//  ModfyNickNameViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ModfyNickNameViewController.h"

@interface ModfyNickNameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nicknamefield;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@end

@implementation ModfyNickNameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.nicknamefield.delegate = self;
    self.saveBtn.layer.cornerRadius = 6;
    self.saveBtn.layer.masksToBounds = YES;
    self.navigationItem.title = self.title;
    self.nicknamefield.text = self.textfieldContent;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationItem.hidesBackButton = YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//保存昵称
- (IBAction)saveNickname:(id)sender {
    NSString *key = nil;
    if ([self.title isEqualToString:@"用户名"]) {
        key = @"nickname";
        [[MyAPI sharedAPI] fixUserNameWithParameters:@{@"loginName":self.nicknamefield.text} result:^(BOOL sucess, NSString *msg) {
            if (sucess) {
                [[XFBConfig Instance] saveUsername:self.nicknamefield.text];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showHint:@"修改失败"];
            }
        } errorResult:^(NSError *enginerError) {
            [self showHint:@"修改出错"];

        }];
    }else{
        key = @"phoneNum";
        [[MyAPI sharedAPI] fixPhoneNumWithParameters:@{@"phone":self.nicknamefield.text} result:^(BOOL sucess, NSString *msg) {
            if (sucess) {
                [[XFBConfig Instance] savePhoneNum:self.nicknamefield.text];
                [self.navigationController popViewControllerAnimated:YES];
             
            }else{
                [self showHint:@"修改失败"];
 
            }
        } errorResult:^(NSError *enginerError) {
            [self showHint:@"修改出错"];

        }];
    }
//    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.nicknamefield.text,key ,nil];
//    NSNotification * notification = [NSNotification notificationWithName:@"returnnick" object:nil userInfo:dict];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
//    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

@end
