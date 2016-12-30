//
//  AboutViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 16/12/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AboutViewController.h"
#import "NoticeHelper.h"
@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat height = 862;
    if ([NoticeHelper ISIphoneType] == ISIphone6P) {
        height = 1293;
    }
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, height);
    self.scrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sqjr"]];
    imageView.frame = CGRectMake(0, 0, ScreenWidth, height);
    [self.scrollView addSubview:imageView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
