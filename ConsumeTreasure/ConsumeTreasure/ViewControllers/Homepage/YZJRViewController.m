//
//  YZJRViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//   合伙人超市

#import "YZJRViewController.h"

#import "ChildViewController.h"

#import <Masonry.h>
@implementation YZJRViewController


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
   
    if (self.childViewControllers.count > 0) {
         [self setUpVc:2];
    }
    
    self.navigationController.navigationBarHidden = NO;
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //self.navigationController.navigationBar.barTintColor = RGBACOLOR(255, 87, 59, 1);
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self refreshDisplay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.titleArr removeAllObjects];

     self.titleArr = [[NSMutableArray alloc]initWithObjects:@"瑶海区",@"政务区",@"庐阳区",@"滨湖新区", nil];
    // 模仿网络延迟，0.2秒后，才知道有多少标题
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    

        
        // 移除之前所有子控制器
        [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
        // 把对应标题保存控制器中，并且成为子控制器，才能刷新
        // 添加所有新的子控制器
        [self setUpAllViewController];
       
        // 注意：必须先确定子控制器
        [self refreshDisplay];
        
    });
     // 标题渐变
     self.isShowTitleGradient = YES;
     // 标题填充模式
     self.titleColorGradientStyle = YZTitleColorGradientStyleFill;
    //[self addLayout];
    
}
#pragma mark -PrivateMethod

- (void)setUpVc:(NSInteger)i
{
    
    NSLog(@"😄%@😄😝",self.childViewControllers);
    UIViewController *vc = self.childViewControllers[i];
    NSString *str = self.titleArr[i];
    //vc.view.frame = self.contentView.bounds;
 
    // 获取对应的cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
    
    UICollectionViewCell *cell = [super.contentScrollView cellForItemAtIndexPath:indexPath];
    
    [cell.contentView addSubview:vc.view];
}

- (void)addLayout{
   [self.contentScrollView.superview mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(@0);
       make.left.equalTo(@0);
       make.width.equalTo(@(ScreenWidth));
       make.height.equalTo(@(ScreenHeight-64));
   }];
    
}
- (IBAction)back:(id)sender {
 
    [self.navigationController popViewControllerAnimated:YES];
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    
    
    for (NSString *titleStr in self.titleArr) {
        ChildViewController *childVC = [[ChildViewController alloc]init];
        childVC.title = titleStr;
        [self addChildViewController:childVC];
    }
    
    /*
    // 段子
    ChildViewController *wordVc1 = [[ChildViewController alloc] init];
    wordVc1.title = @"瑶海区";
    [self addChildViewController:wordVc1];
    
    // 段子
    ChildViewController *wordVc2 = [[ChildViewController alloc] init];
    wordVc2.title = @"滨湖新区";
    [self addChildViewController:wordVc2];
    
    // 段子
    ChildViewController *wordVc3 = [[ChildViewController alloc] init];
    wordVc3.title = @"政务区";
    [self addChildViewController:wordVc3];
    
    ChildViewController *wordVc4 = [[ChildViewController alloc] init];
    wordVc4.title = @"蜀山区";
    [self addChildViewController:wordVc4];
    
    // 全部
    ChildViewController *allVc = [[ChildViewController alloc] init];
    allVc.title = @"高新区";
    [self addChildViewController:allVc];
    
    // 视频
    ChildViewController *videoVc = [[ChildViewController alloc] init];
    videoVc.title = @"庐阳区";
    [self addChildViewController:videoVc];
 
   */
    
}


@end
