//
//  AgencyIntroViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AgencyIntroViewController.h"
#import <Masonry.h>
@interface AgencyIntroViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation AgencyIntroViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    self.navigationController.navigationBarHidden = NO;
 
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // Do any additional setup after loading the view.
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, 1390);
    self.scrollView.directionalLockEnabled = YES;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"agencyApply"]];
   
    /*
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(0, 0, 100, 30);
    [btn setImage:[UIImage imageNamed:@"shouye_sq"] forState:0];
    [self.scrollView addSubview:btn];
     
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.scrollView);
        make.height.equalTo(@30);
        make.bottom.equalTo(@(-100));
        make.width.equalTo(@(100));
    }];
    */
     
    [self.scrollView addSubview:imageView];
    
    
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
     //   make.bottom.equalTo(@(-100));
        make.top.equalTo(@0);
        make.width.equalTo(@(ScreenWidth*0.9));
        make.height.equalTo(@(ScreenWidth*100));
        make.center.equalTo(self.scrollView);
     //make.left.and.top.mas_equalTo(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
}
- (IBAction)applyForAgency:(id)sender {
    
    NSString *isShopId = [[XFBConfig Instance] getIsAgency];
    if ([isShopId isEqualToString:@"0"]) {
        showAlert(@"正在审核中，请耐心等待");
    }else{
        [self performSegueWithIdentifier:@"tobeAgencySegue" sender:nil];
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
