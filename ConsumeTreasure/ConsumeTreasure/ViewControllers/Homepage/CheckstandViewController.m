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
@interface CheckstandViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)refreshBtn:(id)sender;

@end

@implementation CheckstandViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavBarTitle];
    NSString *cardName = [NSString stringWithFormat:@"http:www.xftb168.com/web/paytomem?tomem=%@",self.memId];
   __block UIImage *avatar = [UIImage imageNamed:@"logo"];
    UIImageView *loadImgView = [[UIImageView alloc] init];
    NSString *icon = [[XFBConfig Instance] getIcon];
    [loadImgView sd_setImageWithURL:[NSURL URLWithString:[[XFBConfig Instance] getIcon]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            avatar = image;
        }
        [HMScannerController cardImageWithCardName:cardName avatar:avatar scale:0.2 completion:^(UIImage *image) {
            self.imageView.image = image;
        }];
    }];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addNavBarTitle{
  NSString *  navTitle = @"收银台";
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = attributeDict;
    self.navigationItem.title = navTitle;
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
    NSString *cardName = [NSString stringWithFormat:@"http:www.xftb168.com/web/paytomem?tomem=%@",self.memId];
    __block UIImage *avatar = [UIImage imageNamed:@"logo"];
    UIImageView *loadImgView = [[UIImageView alloc] init];
   // NSString *icon = [[XFBConfig Instance] getIcon];
    [loadImgView sd_setImageWithURL:[NSURL URLWithString:[[XFBConfig Instance] getIcon]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            avatar = image;
        }
        [HMScannerController cardImageWithCardName:cardName avatar:avatar scale:0.2 completion:^(UIImage *image) {
            self.imageView.image = image;
        }];
    }];
}
@end
