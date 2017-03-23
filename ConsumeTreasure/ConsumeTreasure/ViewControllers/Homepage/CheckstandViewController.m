//
//  CheckstandViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/9.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "CheckstandViewController.h"
#import "HMScannerController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+Utilities.h"
@interface CheckstandViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)refreshBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *codeTitleLabel;

@end

@implementation CheckstandViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -PrivateMethod
- (void)createUI{
    //添加navbar
    NSString *  navTitle;
    NSString *baseUrl ;
    if (self.storeName) {
        navTitle = @"收银台";
        baseUrl = @"http://www.xftb168.com/web/paytomem?tomem=%@";
        self.storeNameLabel.text = [NSString stringWithFormat:@"%@的收款码",self.storeName];
    }else{
        navTitle = @"注册邀请";
        self.codeTitleLabel.text = @"注册邀请二维码";
        baseUrl = @"http://www.xftb168.com/web/toWxRegister?merchantMemId=%@";
        self.storeNameLabel.text = @"智惠返邀请您一起享优惠";
    }
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = attributeDict;
    self.navigationItem.title = navTitle;
    
    NSString *cardName = [NSString stringWithFormat:baseUrl,self.memId];
    
    [HMScannerController cardImageWithCardName:cardName avatar:[UIImage imageNamed:@"qrImg"] scale:0.2 completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    self.timeLable.text =  [NSDate date].raziString;
}

- (IBAction)backBtn:(id)sender {
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

- (IBAction)refreshBtn:(id)sender {
    NSString *baseUrl ;
    if (self.storeName) {
        baseUrl = @"http://www.xftb168.com/web/paytomem?tomem=%@";
        self.storeNameLabel.text = [NSString stringWithFormat:@"%@的收款码",self.storeName];
        self.storeNameLabel.text = [NSString stringWithFormat:@"%@的收款码",self.storeName];

    }else{
        baseUrl = @"http://www.xftb168.com/web/toWxRegister?merchantMemId=%@";
    }
    NSString *cardName = [NSString stringWithFormat:baseUrl,self.memId];

        [HMScannerController cardImageWithCardName:cardName avatar:[UIImage imageNamed:@"qrImg"] scale:0.2 completion:^(UIImage *image) {
            self.imageView.image = image;
        }];
    self.timeLable.text =  [NSDate date].raziString;
}
@end
