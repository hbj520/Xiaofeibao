//
//  TobeUnionViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TobeUnionViewController.h"
#import "BeUnionModel.h"

#import "ApplyViewController.h"
@interface TobeUnionViewController ()
{
    NSString *infoStr;
    
    NSArray *listArr;
    NSArray *addrArr;
    NSArray *businessArr;
    NSArray *contactArr;
 
}
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation TobeUnionViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];

    self.imageview.image = [UIImage imageNamed:@"tobeunion"];
    self.imageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goApply:)];
    [self.imageview addGestureRecognizer:tap];
    
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)loadData{
    
    NSDictionary *dic = @{
                          
                          };
    [[MyAPI sharedAPI] getShangHuRequestDataWithParameters:dic result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            listArr = arrays[0];
            addrArr = arrays[1];
            businessArr = arrays[2];
            contactArr = arrays[3];
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }else{
                [self showHint:msg];
            }
        }
 
    } errorResult:^(NSError *enginerError) {
        [self showHint:@"网络出错"];
    }];
    
    
    
    
    /*
    CGRect rect = [infoStr boundingRectWithSize:CGSizeMake(ScreenWidth, NSIntegerMax) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil];
    CGFloat height = rect.size.height+10;
    
    self.contentLab.text = infoStr;
    self.contentLab.bounds = CGRectMake(0, 0, ScreenWidth, height);
    */
}
- (void)goApply:(id)sender {
    if ([self.status isEqualToString:@"0"]) {
        showAlert(@"正在审核中，请耐心等待");
    }else{
        self.hidesBottomBarWhenPushed = YES;
        [self performSegueWithIdentifier:@"ApplySegue" sender:@[listArr,addrArr,businessArr,contactArr]];
    }
};





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ApplySegue"]) {
        NSArray *array = (NSArray*)sender;
        ApplyViewController *ApplyVC = segue.destinationViewController;
        ApplyVC.listArr = array[0];
        ApplyVC.addrArr = array[1];
        ApplyVC.businessArr = array[2];
        ApplyVC.contactArr = array[3];
    }
    
}


@end
