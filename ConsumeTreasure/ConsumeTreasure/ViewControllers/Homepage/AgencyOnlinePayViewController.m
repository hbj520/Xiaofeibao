//
//  AgencyOnlinePayViewController.m
//  ConsumeTreasure
//
//  Created by apple on 2017/9/14.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "AgencyOnlinePayViewController.h"

@interface AgencyOnlinePayViewController ()
@property (weak, nonatomic) IBOutlet UIButton *wxbtn;
@property (weak, nonatomic) IBOutlet UIButton *zfbbtn;

@end

@implementation AgencyOnlinePayViewController
- (IBAction)wxbtn:(id)sender {
    _wxbtn.selected = !_wxbtn.selected;
}
- (IBAction)zfbbtn:(id)sender {
    _zfbbtn.selected = !_zfbbtn.selected;
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)paynowBtn:(id)sender {
    [self performSegueWithIdentifier:@"comepelePaySegueId" sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
