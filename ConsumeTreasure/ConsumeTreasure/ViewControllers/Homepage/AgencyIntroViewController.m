//
//  AgencyIntroViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AgencyIntroViewController.h"
#import <Masonry.h>
#import "NoticeHelper.h"
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
    CGFloat height = 1390;
    if ([NoticeHelper ISIphoneType] == ISIphone5) {
        height = 528;
    }else if ([NoticeHelper ISIphoneType] == ISIphone6){
        height = 619;
    }else if ([NoticeHelper ISIphoneType] == ISIphone6P){
        height = 891;
    }
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, height);
    self.scrollView.directionalLockEnabled = YES;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"agencyApply"]];
    imageView.frame = CGRectMake(0, 0, ScreenWidth, height);
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
//    
//    
//    
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//   make.edges.equalTo(self.scrollView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
 
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
        //[self performSegueWithIdentifier:@"tobeAgencySegue" sender:nil];
        
        NSDictionary *para = @{

                               };
        [[MyAPI sharedAPI] PostNameAndPhoneWith:para result:^(BOOL sucess, NSString *msg) {
            if (sucess) {
                showAlert(@"已申请成功，请等候客服人员与您联系");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
