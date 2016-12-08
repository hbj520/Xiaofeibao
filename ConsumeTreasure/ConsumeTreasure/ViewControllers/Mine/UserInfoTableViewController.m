//
//  UserInfoTableViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 16/12/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "ModfyNickNameViewController.h"

@interface UserInfoTableViewController ()
- (IBAction)backBtn:(id)sender;

@end

@implementation UserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNotice:) name:@"returnnick" object:nil];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 4;
    }else if (section == 2){
        return 2;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UILabel *userNameLabel = [cell viewWithTag:10];
            [self performSegueWithIdentifier:@"fixNameSegueId" sender:@[@"用户名",userNameLabel.text]];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UILabel *phoneLabel = [cell viewWithTag:10];
            [self performSegueWithIdentifier:@"fixNameSegueId" sender:@[@"手机号",phoneLabel.text]];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            [self performSegueWithIdentifier:@"resetPasswordSegueId" sender:@"登录密码"];
        }else if (indexPath.row == 1){
            [self performSegueWithIdentifier:@"resetPasswordSegueId" sender:@"支付密码"];
        }
    }
}
#pragma mark - SegueDelegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"fixNameSegueId"]) {//修改用户名
        NSArray *senderArray = (NSArray *)sender;
        ModfyNickNameViewController *modifyVC = (ModfyNickNameViewController *)segue.destinationViewController;
        modifyVC.title = senderArray[0];
        modifyVC.textfieldContent = senderArray[1];
    }
    
}
#pragma mark -PrivateMethod
- (void)recieveNotice:(NSNotification *)sender{
    NSDictionary *noti = sender.userInfo;
    NSArray *keys = [noti allKeys];
    NSString *key = keys[0];
    NSString *content = noti[key];
   
    if ([key isEqualToString:@"nickname"]) {
        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:0];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        UILabel *nicknameLabel = [cell viewWithTag:10];
        nicknameLabel.text = content;
    }else if ([key isEqualToString:@"phoneNum"]){
        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:1];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        UILabel *phoneLabel = [cell viewWithTag:10];
        phoneLabel.text = content;
        
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

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"returnnick" object:nil];
}
@end
