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
#import <HexColor.h>
@interface AgencyIntroViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *checkedBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation AgencyIntroViewController
- (IBAction)checkBtn:(id)sender {
    self.checkedBtn.selected = !self.checkedBtn.selected;
    BOOL checked = self.checkedBtn.isSelected;
    self.sureBtn.enabled = checked;
    if (checked) {
        self.sureBtn.backgroundColor = [UIColor colorWithHexString:@"FC4601"];
    }else{
        self.sureBtn.backgroundColor = [UIColor lightGrayColor];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    self.navigationController.navigationBarHidden = NO;
 
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
}
- (IBAction)sureBtn:(id)sender {
    
    NSString *isShopId = [[XFBConfig Instance] getIsAgency];
    if ([isShopId isEqualToString:@"0"]) {
        showAlert(@"正在审核中，请耐心等待");
    }else{
        [self performSegueWithIdentifier:@"tobeAgencySegue" sender:nil];
        
//        NSDictionary *para = @{
//
//                               };
//        [[MyAPI sharedAPI] PostNameAndPhoneWith:para result:^(BOOL sucess, NSString *msg) {
//            if (sucess) {
//                showAlert(@"已申请成功，请等候客服人员与您联系");
//            }else{
//                if ([msg isEqualToString:@"-1"]) {
//                    [self logout];
//                }
//                showAlert(msg);
//            }
//            
//        } errorResult:^(NSError *enginerError) {
//            
//        }];

        
    }
}
#pragma mark - PrivateMethod 
- (void)setupUI{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // Do any additional setup after loading the view.
    CGFloat height = 1100;
    if ([NoticeHelper ISIphoneType] == ISIphone5) {
        height = 320/345 * 1100;
    }else if ([NoticeHelper ISIphoneType] == ISIphone6){
        height = 375/345 * 1100;
    }else if ([NoticeHelper ISIphoneType] == ISIphone6P){
        height = 414/345 * 1100         ;
    }
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, height);
    self.scrollView.directionalLockEnabled = YES;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dzht"]];
    imageView.frame = CGRectMake(10, 0, ScreenWidth - 20, height);
    [self.scrollView addSubview:imageView];

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
