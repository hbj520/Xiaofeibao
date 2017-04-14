//
//  MyRecommendViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 17/4/13.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "MyRecommendViewController.h"
#import "RecommendTableViewCell.h"
#import "CHSocialService.h"
#import "ShareQRCodeViewController.h"

@interface MyRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UILabel *allbenifitLabel;
@property (weak, nonatomic) IBOutlet UILabel *invitemenLabel;
@property (weak, nonatomic) IBOutlet UITableView *benifitTableView;
@property (weak, nonatomic) IBOutlet UILabel *checkrulesLabel;
- (IBAction)backBtn:(id)sender;

@end

@implementation MyRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 1;
    [self loadDataWithPage:page];
    [self configTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -PrivateMethod
- (void)loadDataWithPage:(NSInteger)page{
    [[MyAPI sharedAPI] recmmendPriceWithParameters:@{@"pageNum":[NSString stringWithFormat:@"%ld",page],
                                                    @"pageOffset":@"10"} result:^(BOOL success, NSString *msg, id object) {
                                                        
                                                    } errorResult:^(NSError *enginerError) {
                                                        
                                                    }];
}
- (void)configTableView{
    self.benifitTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.benifitTableView.frame = CGRectMake(0, 97, ScreenWidth, ScreenHeight - 480);
    self.benifitTableView.delegate = self;
    self.benifitTableView.dataSource = self;
    [self.benifitTableView registerNib:[UINib nibWithNibName:@"RecommendTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RecommendReuseId];
}
- (IBAction)weixinChatBtn:(id)sender {
[[CHSocialServiceCenter shareInstance] shareTitle:@"智惠返邀您一起享优惠" content:@"扫码支付实时到账，商户提现秒到，万亿市场等您来享！" imageURL:@"http://p2pguide.sudaotech.com/platform/image/1/20160318/3c896c87-65b6-481d-81ca-1b4a0b6d8dd4/" image:[UIImage imageNamed:@"qrImg"] urlResource:[NSString stringWithFormat:@"http://www.xftb168.com/web/toWxRegister?merchantMemId=%@",[[XFBConfig Instance]getmemId]] type:CHSocialWeChat controller:self completion:^(BOOL successful) {
    
    
                    }];
}
- (IBAction)weixinCircleBtn:(id)sender {
    [[CHSocialServiceCenter shareInstance] shareTitle:@"智惠返邀您一起享优惠" content:@"扫码支付实时到账，商户提现秒到，万亿市场等您来享！" imageURL:@"http://p2pguide.sudaotech.com/platform/image/1/20160318/3c896c87-65b6-481d-81ca-1b4a0b6d8dd4/" image:[UIImage imageNamed:@"qrImg"] urlResource:[NSString stringWithFormat:@"http://www.xftb168.com/web/toWxRegister?merchantMemId=%@",[[XFBConfig Instance]getmemId]] type:CHSocialWeChatTimeLine controller:self completion:^(BOOL successful) {
        
        
    }];
}
- (IBAction)facetofaceBtn:(id)sender {
    [self performSegueWithIdentifier:@"facetofaceSegue" sender:[[XFBConfig Instance] getmemId
                                                                ]];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendTableViewCell *recommendCell = [tableView dequeueReusableCellWithIdentifier:RecommendReuseId forIndexPath:indexPath];
    return recommendCell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"facetofaceSegue"]) {
        NSString *memStr = sender;
        ShareQRCodeViewController *shareVC = segue.destinationViewController;
        shareVC.memId = memStr;
    }
}


- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
