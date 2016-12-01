//
//  AdDetailViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AdDetailViewController.h"
#import <Masonry.h>

@interface AdDetailViewController ()

@end

@implementation AdDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
   //self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)setAdmodel:(AddModel *)admodel{
    _admodel = admodel;
    self.title = _admodel.title;
    UIWebView *webView = [[UIWebView alloc]init];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    
    if ([_admodel.islink isEqualToString:@"0"]) {
        [webView loadHTMLString:_admodel.content baseURL:nil];
    }else{
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_admodel.content]]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
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
