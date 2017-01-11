 //
//  HomeTabbarViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomeTabbarViewController.h"
@interface HomeTabbarViewController ()<UITabBarControllerDelegate>
{
    NSArray *titleArrays;
    NSMutableArray *menusVCs;//tabbars的控制器
}
@property (nonatomic,retain) UIStoryboard *homePageSB;
@property (nonatomic,retain) UIStoryboard *UnionSB;
@property (nonatomic,retain) UIStoryboard *mineSB;
@end

@implementation HomeTabbarViewController


- (UIStoryboard *)homepageSB{
    if (!_homePageSB) {
        _homePageSB = [UIStoryboard storyboardWithName:@"Hompage" bundle:[NSBundle mainBundle]];
    }
    return _homePageSB;
}
- (UIStoryboard *)UnionSB{
    if (!_UnionSB) {
        _UnionSB = [UIStoryboard storyboardWithName:@"Union" bundle:[NSBundle mainBundle]];
    }
    return _UnionSB;
}
- (UIStoryboard *)mineSB{
    if (!_mineSB) {
        _mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    }
    return _mineSB;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLog:) name:@"logoutNotice" object:nil];
       menusVCs = [NSMutableArray array];
    self.tabBar.tintColor = [UIColor redColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HomeTabar" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *array = dict[@"tabBarMenus"];
    for (NSDictionary *dic in array) {
        UITabBarItem *tabbarItem = [[UITabBarItem alloc] init];
        [tabbarItem setImage:[UIImage imageNamed:dic[@"image"]]];
        [tabbarItem setSelectedImage:[UIImage imageNamed:dic[@"select_image"]]];
        [tabbarItem setTitle:dic[@"title"]];
        SEL selector = NSSelectorFromString(dic[@"storybordId"]);
        IMP imp = [self methodForSelector:selector];
        UIStoryboard * (*func)(id,SEL) = (void *)imp;
        UIStoryboard *sb = func(self,selector);
//        NSString *nibName = (NSString *)dic[@"storybordId"];
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:nibName bundle:nil];
        UIViewController *vc = [sb instantiateInitialViewController];
        vc.tabBarItem = tabbarItem;
        [menusVCs addObject:vc];
      
    }
    self.viewControllers = menusVCs;
}

- (void)receiveLog:(id)sender{
    self.selectedIndex = 0;
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
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"logoutNotice" object:nil];
}
@end
