//
//  UserInfoTableViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 16/12/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "ModfyNickNameViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "KGModal.h"
#import "ChangeHeadView.h"
#import "CHSocialService.h"
@interface UserInfoTableViewController ()<UIImagePickerControllerDelegate>
{
    UIImagePickerController * _picker;                              //照片选择控制器
    NSString * imageUrl;
    
}
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *wxLinkLabel;
@property (weak, nonatomic) IBOutlet UILabel *zfbLinkLabel;
@end

@implementation UserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPickView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 //   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //添加通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNotice:) name:@"returnnick" object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationItem.hidesBackButton = YES;
    [self createUI];
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
        return 3;
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
        if (indexPath.row == 0) {
            [self showModalView];
        }else if (indexPath.row == 1) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UILabel *userNameLabel = [cell viewWithTag:10];
            [self performSegueWithIdentifier:@"fixNameSegueId" sender:@[@"用户名",userNameLabel.text]];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UILabel *phoneLabel = [cell viewWithTag:10];
            [self performSegueWithIdentifier:@"fixNameSegueId" sender:@[@"手机号",phoneLabel.text]];
        }else if (indexPath.row == 1){
            if ([self.wxLinkLabel.text isEqualToString:@"已绑定"]) {
                [self releaseThirdPlatformLinkIsWX:YES];
            }else{
                [self LinkThirdPlatformIsWX:YES];
            }
        }else if (indexPath.row == 2){
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
//解绑
- (void)releaseThirdPlatformLinkIsWX:(BOOL)isWX{
    if (isWX) {//解绑微信
        showAlert(@"是否解除微信绑定");
    }else{//解绑支付宝
        showAlert(@"是否解除支付宝绑定");
    }
}
//绑定
- (void)LinkThirdPlatformIsWX:(BOOL)isWX{
    if (isWX) {//绑定微信
        [[CHSocialServiceCenter shareInstance]loginInAppliactionType:CHSocialWeChat controller:self completion:^
         (CHSocialResponseData *response) {
             if (response.openId) {
                 [self thirdLoginWithPlatform:@"wx"
                                       openId:response.openId
                                     nickName:response.userName
                                      iconUrl:response.iconURL];
                 
             }
             
         }];
    }else{//绑定支付宝
        
    }
}
- (void)thirdLoginWithPlatform:(NSString *)platform
                        openId:(NSString *)openId
                      nickName:(NSString *)nickName
                       iconUrl:(NSString *)iconUrl {
    [[MyAPI sharedAPI] ThirdPlatformLoginWithParamters:platform
                                           thirdOpenId:openId
                                                result:^(BOOL success, NSString *msg, id object) {
                                                    
                                                    if (success) {
                                                        //已经绑定的直接登录
                                                        [self showHint:@"绑定成功!"];
                                                        [self changeTohom];
                                                    }else{
                                                        //未绑定的进行账号绑定
                                                        [self performSegueWithIdentifier:@"thirdPlatformLinkSegue" sender:@[platform,openId,nickName,iconUrl]];
                                                    }
                                                } errorResult:^(NSError *enginerError) {
                                                    
                                                    
                                                }];
}
- (void)changeTohom{
    //[self.tabBarController setSelectedIndex:0];
    [self dismissViewControllerAnimated:YES completion:nil];
    //    self.mStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    HomepageViewController *homVC = [self.mStorybord instantiateViewControllerWithIdentifier:@"HomeTabBarVC"];
    //    [self.navigationController didAnimateFirstHalfOfRotationToInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    //    [self.navigationController pushViewController:homVC animated:YES];
}
//弹出选择照片视图
- (void)showModalView
{
    
    [[KGModal sharedInstance] setCloseButtonType:KGModalCloseButtonTypeNone];
    [KGModal sharedInstance].modalBackgroundColor = [UIColor whiteColor];
    
    ChangeHeadView * modifyView = [[[NSBundle mainBundle] loadNibNamed:@"ChangeHeadView" owner:self options:nil] lastObject];
    
    [[KGModal sharedInstance] showWithContentView:modifyView andAnimated:YES];
    
    modifyView.LibraryBlock = ^(){
        [self openPhotoAlbun];
        [[KGModal sharedInstance] hideAnimated:YES];
    };
    modifyView.TakeBlock = ^(){
        [self openCamera];
        [[KGModal sharedInstance] hideAnimated:YES];
    };
    
    
}


#pragma mark-UINavigationControllerDelegate & UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    //NSData * data = UIImageJPEGRepresentation(image, 0.1);
    
    [self showHudInView:self.view hint:@"上传图片中"];
    [[MyAPI sharedAPI] postFilesWithFormData:@[image] result:^(BOOL success, NSString *msg, id object) {
        if (success) {
            imageUrl = msg;
            [[MyAPI sharedAPI] postIconWithParameters:@{@"imgUrl":msg} result:^(BOOL sucess, NSString *msg) {
                if (success) {
                    NSString *Url = [NSString stringWithFormat:@"%@img%@",XFBUrl,imageUrl];
                    [[XFBConfig Instance] saveIcon:Url];
                    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[[XFBConfig Instance] getIcon]] placeholderImage:[UIImage imageNamed:@"logo"]];
                }else{
                    if ([msg isEqualToString:@"-1"]) {
                        [Tools logoutWithNowVC:self];
                    }
                    [self showHint:@"上传失败"];
                }
                [self hideHud];
            } errorResult:^(NSError *enginerError) {
                [self hideHud];
            }];
        }else{
            [self showHint:@"上传失败"];
            [self hideHud];
        }
    } errorResult:^(NSError *enginerError) {
        [self showHint:@"上传出错"];
        [self hideHud];
    }];

}
//初始化照片选择控制器
- (void)initPickView
{
    _picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
}

//打开手机照相机
- (void)openCamera
{
    _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_picker animated:YES completion:nil];
}

//打开手机相册
- (void)openPhotoAlbun
{
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_picker animated:YES completion:nil];
}

- (void)createUI{
    self.userNameLabel.text = [[XFBConfig Instance] getUserName];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[[XFBConfig Instance] getIcon]] placeholderImage:[UIImage imageNamed:@"logo"]];
    self.phoneNumLabel.text = [[XFBConfig Instance] getphoneNum];
    self.iconImageView.layer.masksToBounds = YES;
    
    if ([[XFBConfig Instance] getLinkWX].length > 2 ) {
        self.wxLinkLabel.text = @"已绑定";
    }else{
        self.wxLinkLabel.text = @"未绑定";
    }
    if ([[XFBConfig Instance] getZFB].length > 2 ) {
            self.zfbLinkLabel.text = @"已绑定";
    }else{
        self.zfbLinkLabel.text = @"未绑定";
    }
}
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 1:
        {
            if ([alertView.message isEqualToString:@"是否解除微信绑定"]) {
                [[MyAPI sharedAPI] releaseThirdPlatformWithParameters:@{
                                                                       @"type":@"wx",
                                                                       @"phone":[[XFBConfig Instance] getphoneNum]
                                                                       }result:^(BOOL sucess, NSString *msg) {
                                                                           if (sucess) {
                                                                               [[XFBConfig Instance] saveWeixin:@""];
                                                                               self.wxLinkLabel.text = @"未绑定";
                                                                           }
                                                                           [self showHint:msg];
                                                                       } errorResult:^(NSError *enginerError) {
                                                                           
                                                                       }];
            }else if ([alertView.message isEqualToString:@"是否解除支付宝绑定"]){//解除支付宝绑定
                
            }
        }
            break;
    }
}
//- (void)recieveNotice:(NSNotification *)sender{
//    NSDictionary *noti = sender.userInfo;
//    NSArray *keys = [noti allKeys];
//    NSString *key = keys[0];
//    NSString *content = noti[key];
//   
//    if ([key isEqualToString:@"nickname"]) {
//        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:0];
//        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//        UILabel *nicknameLabel = [cell viewWithTag:10];
//        nicknameLabel.text = content;
//    }else if ([key isEqualToString:@"phoneNum"]){
//        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:1];
//        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//        UILabel *phoneLabel = [cell viewWithTag:10];
//        phoneLabel.text = content;
//        
//    }
//    
//}
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
//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"returnnick" object:nil];
//}
@end
