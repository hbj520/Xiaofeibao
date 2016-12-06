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
 
}
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation TobeUnionViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    self.navigationController.navigationBarHidden = NO;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //self.navigationController.navigationBar.barTintColor = RGBACOLOR(255, 87, 59, 1);
    self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self loadData];
    
    
}

- (void)loadData{
    
    NSDictionary *dic = @{
                          
                          };
    [[MyAPI sharedAPI] getShangHuRequestDataWithParameters:dic result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            listArr = arrays;
        }
 
    } errorResult:^(NSError *enginerError) {
        
    }];
    
    
    
    
    /*
    CGRect rect = [infoStr boundingRectWithSize:CGSizeMake(ScreenWidth, NSIntegerMax) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil];
    CGFloat height = rect.size.height+10;
    
    self.contentLab.text = infoStr;
    self.contentLab.bounds = CGRectMake(0, 0, ScreenWidth, height);
    */
}
- (IBAction)goApply:(id)sender {
    
       [self performSegueWithIdentifier:@"ApplySegue" sender:listArr];
}


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
        ApplyVC.listArr = array;
    }
    
}


@end
