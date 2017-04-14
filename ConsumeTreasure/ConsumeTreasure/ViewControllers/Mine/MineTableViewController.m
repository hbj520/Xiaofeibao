//
//  MineTableViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 10/17/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "MineTableViewController.h"
#import "TongbaoMoneyView.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "WechatAuthSDK.h"
#import "LookRecordViewController.h"
#import "ImUnionStoreViewController.h"
#import "MyAccountViewController.h"
#import "TobeUnionViewController.h"
#import "ApplyViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CHSocialService.h"
#import "MyMemberViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface MineTableViewController ()
{
    NSString *isShop;
    TongbaoMoneyView *tongbaoMoneyView;
}
@property (weak, nonatomic) IBOutlet UILabel *usernamelabel;
@property (weak, nonatomic) IBOutlet UILabel *shnagjiaLab;

@property (weak, nonatomic) IBOutlet UIView *moneyView;
- (IBAction)settingBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation MineTableViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = NO;
    [self createUI];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //
//    NSString *memId = [[XFBConfig Instance]getmemId];
    tongbaoMoneyView =  [[TongbaoMoneyView alloc] initWithFrame:CGRectMake(25, 44, 0, 0) money:[[XFBConfig Instance] getMoney].floatValue];
    [self.moneyView addSubview: tongbaoMoneyView];
    [self addRefresh];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
       return  1;
    }else if (section == 1){
        return 4;
    }else if (section == 2){
        return 3;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  0;
    }else if (section == 1){
        return 5;
    }else if (section == 2){
        return 10;
    }
    return 1;
}
- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {return(UIImageView*)view;}for(UIView*subview in view.subviews) {UIImageView*imageView = [self findHairlineImageViewUnder:subview];
                if(imageView) {
            return imageView;
                }
    }
       return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([KToken isEqualToString:@""]) {
        [Tools logoutWithNowVC:self];
    }else{
        if (indexPath.section == 0) {
            [self performSegueWithIdentifier:@"userInfoSegueId" sender:nil];
        }
        if (indexPath.section == 1 ) {
            if (indexPath.row == 1) {
                
                [self performSegueWithIdentifier:@"evaluaListSegue" sender:nil];
                
            }else if (indexPath.row == 2){
                showAlert(@"正在建设中. . .");
                // [self performSegueWithIdentifier:@"attentionShopSegueId" sender:nil];
                
            }else if (indexPath.row == 3){
                self.mStorybord = [UIStoryboard storyboardWithName:@"Hompage" bundle:nil];
                LookRecordViewController *lookVC = [self.mStorybord instantiateViewControllerWithIdentifier:@"watchRecordStorybordId"];
               // self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:lookVC animated:YES];
            }else{
                self.mStorybord = [UIStoryboard storyboardWithName:@"Hompage" bundle:nil];
                MyAccountViewController *AccountVC = [self.mStorybord instantiateViewControllerWithIdentifier:@"accountSB"];
                [self.navigationController pushViewController:AccountVC animated:YES];
                
            }
        }else if (indexPath.section == 2 ){
            if (indexPath.row == 0) {
//                [[CHSocialServiceCenter shareInstance]shareTitle:@"智惠返邀您一起享优惠" content:@"扫码支付实时到账，商户提现秒到，万亿市场等您来享！" imageURL:@"http://p2pguide.sudaotech.com/platform/image/1/20160318/3c896c87-65b6-481d-81ca-1b4a0b6d8dd4/" image:[UIImage imageNamed:@"qrImg"] urlResource:[NSString stringWithFormat:@"http://www.xftb168.com/web/toWxRegister?merchantMemId=%@",[[XFBConfig Instance]getmemId]] controller:self completion:^(BOOL successful) {
//                    
//                }];
                [self performSegueWithIdentifier:@"myrecommendSegueId" sender:nil];
            }else if (indexPath.row == 1){
              [self performSegueWithIdentifier:@"myShareSegue" sender:@"0"];
            }else if (indexPath.row == 2){
                [self performSegueWithIdentifier:@"settingSegueId" sender:nil];

            }
        
            
        }
    }
   // [self testWeixinPay];
}
//- (void)testWeixinPay{
//    //============================================================
//    // V3&V4支付流程实现
//    // 注意:参数配置请查看服务器端Demo
//    // 更新时间：2015年11月20日
//    //============================================================
//    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
//    //解析服务端返回json数据
//    NSError *error;
//    //加载一个NSURL对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    if ( response != nil) {
//        NSMutableDictionary *dict = NULL;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//        
//        NSLog(@"url:%@",urlString);
//        if(dict != nil){
//            NSMutableString *retcode = [dict objectForKey:@"retcode"];
//            if (retcode.intValue == 0){
//                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//                
//                //调起微信支付
//                PayReq* req             = [[PayReq alloc] init];
//                req.partnerId           = [dict objectForKey:@"partnerid"];
//                req.prepayId            = [dict objectForKey:@"prepayid"];
//                req.nonceStr            = [dict objectForKey:@"noncestr"];
//                req.timeStamp           = stamp.intValue;
//                req.package             = [dict objectForKey:@"package"];
//                req.sign                = [dict objectForKey:@"sign"];
//                [WXApi sendReq:req];
//                //日志输出
//                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//               // return @"";
//            }else{
//                //return [dict objectForKey:@"retmsg"];
//            }
//        }else{
//            //return @"服务器返回错误，未获取到json对象";
//        }
//    }else{
//       // return @"服务器返回错误";
//    }
//    
//}
#pragma mark - PrivateMethod
- (void)addRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadAccountDataWithPage:1 pageNum:@"2"];
    }];
}
- (void)loadAccountDataWithPage:(NSInteger)page pageNum:(NSString*)pageNum{
    NSString *pageNow = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *dic = @{
                          @"pageNum":pageNow,
                          @"pageOffset":@"10"
                          };
    [[MyAPI sharedAPI] getMyAccountDataWithParameters:dic result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            [self.tableView reloadData];
            [self createUI];

        }else{
            
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }
        
        [self endRefresh];
    } errorResult:^(NSError *enginerError) {
        [self endRefresh];
    }];
}
- (void)logout{
    [Tools logoutWithNowVC:self];
}
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)createUI{
    isShop = [[XFBConfig Instance] getIsShop];
    UIImageView * navBarHairlineImageView= [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = YES;
    NSString *navTitle = @"我";
    if ([isShop isEqualToString:@"1"]) {
        self.shnagjiaLab.text = @"我是商家";
    }else{
        self.shnagjiaLab.text = @"成为联盟商家";
    }
    
    if ([KToken isEqualToString:@""]) {//未登录
        self.usernamelabel.text = @"未登录,点击登录";
        tongbaoMoneyView.moneyLabel.text = @"****";
    }else{
        self.usernamelabel.text = [[XFBConfig Instance] getUserName];
        // self.navigationController.navigationBar.barTintColor = RGBACOLOR(253, 87, 54, 1);
        NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        self.navigationController.navigationBar.titleTextAttributes = attributeDict;
        self.navigationItem.title = navTitle;
        if (!tongbaoMoneyView.enableSeeButton.selected) {
            tongbaoMoneyView.money = [NSString stringWithFormat:@"%.3f",[[XFBConfig Instance] getMoney].floatValue];
        }
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[[XFBConfig Instance] getIcon]] placeholderImage:[UIImage imageNamed:@"tx"]];
        self.iconImageView.layer.masksToBounds = YES;
    }
    


   
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shangjiaCellId" forIndexPath:indexPath];
    
    // Configure the cell...
    if ([isShop isEqualToString:@"1"]) {
        cell.textLabel.text = @"我是商家";
    }else{
        cell.textLabel.text = @"成为联盟商家";
    }
    
    
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

- (IBAction)settingBtn:(id)sender {
    [self performSegueWithIdentifier:@"settingSegueId" sender:nil];
}
#pragma mark -PrepareSegueDelegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     if ([segue.identifier isEqualToString:@"myShareSegue"]){
        NSString *memStr = sender;
        MyMemberViewController *myMemberVC = segue.destinationViewController;
        myMemberVC.isMember = memStr.boolValue;
    }
}
@end
