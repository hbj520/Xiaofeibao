//
//  ShareQRCodeViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 17/4/5.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "ShareQRCodeViewController.h"

@interface ShareQRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)backBtn:(id)sender;

@end

@implementation ShareQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@web/shopShare?memid=%@",XFBUrl,self.memId]]];
    //NSString *url = [NSString stringWithFormat:@"%@web/shopShare?memid=%@",XFBUrl,self.memId];
    [self.webView loadRequest:request];
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

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
