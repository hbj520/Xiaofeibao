//
//  SettingTableViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 16/12/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "SettingTableViewController.h"
#import "LoginAndRegisterViewController.h"
#import "AppDelegate.h"
#import "SetPayPswViewController.h"
@interface SettingTableViewController ()<UIAlertViewDelegate>
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *cash;

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationItem.hidesBackButton = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 1;
    }
//#warning Incomplete implementation, return the number of rows
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  15;
    }else if (section == 1){
        return 40;
    }
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//清除图片缓存
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"确定清空缓存数据吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil, nil];
            alert.tag = 1008;
            [alert show];
        }else if (indexPath.row == 1){
            
        }else if (indexPath.row == 2){
            
        }else if (indexPath.row == 3){//设置支付宝密码
            SetPayPswViewController *setPayPswVC = [[SetPayPswViewController alloc] init];
            [self.navigationController pushViewController:setPayPswVC animated:YES];
        }

    }else if (indexPath.section == 1){
        
        [Tools logoutWithNowVC:self];
//       UIStoryboard *mStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//        UINavigationController *loginVC = [mStorybord instantiateViewControllerWithIdentifier:@"LoginAndRegisterId"];
//        loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//
//        [self.navigationController presentModalViewController:loginVC animated:YES];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutNotice" object:nil];
               // ApplicationDelegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:loginAndRegisterVC];
               // LoginAndRegisterViewController *loginAndRegisterVC = [mStorybord instantiateViewControllerWithIdentifier:@"LoginAndRegisterId"];
       // [ApplicationDelegate.window.rootViewController removeFromParentViewController];
//        for (UIView *vc in self.view.subviews) {
//            
//            
//            [vc removeFromSuperview];
//        }
        [[XFBConfig Instance] logout];
//         ApplicationDelegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:loginAndRegisterVC];
    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc{
    [self removeFromParentViewController];
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1008) {
        if (buttonIndex == 1) {
            self.cash.text = @"0.0M";
        }
    }
    
}
@end
