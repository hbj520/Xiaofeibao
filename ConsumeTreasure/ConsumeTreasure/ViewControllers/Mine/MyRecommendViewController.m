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
#import "RecommendPriceModel.h"
#import "ActivityRulesViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <UIImageView+WebCache.h>

@interface MyRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    RecommendPriceArrayModel *recommendModel;
    NSMutableArray *dataSource;
}
@property (weak, nonatomic) IBOutlet UILabel *allbenifitLabel;
@property (weak, nonatomic) IBOutlet UILabel *invitemenLabel;
@property (weak, nonatomic) IBOutlet UITableView *benifitTableView;
- (IBAction)activityRulesBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *checkrulesLabel;
- (IBAction)backBtn:(id)sender;

@end

@implementation MyRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 1;
    dataSource = [NSMutableArray array];
    [self loadDataWithPage:page];
    [self configTableView];
    [self addMJRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -PrivateMethod
- (void)addMJRefresh{
    __weak typeof(self) weakSelf = self;
    self.benifitTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (dataSource.count > 0 ) {
            [dataSource removeAllObjects];
        }
        page = 1;
        [weakSelf loadDataWithPage:page];
    }];
    self.benifitTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [weakSelf loadDataWithPage:page];
    }];
}
- (void)loadDataWithPage:(NSInteger)page{
    [[MyAPI sharedAPI] recmmendPriceWithParameters:@{@"pageNum":[NSString stringWithFormat:@"%ld",page],
                                                    @"pageOffset":@"10"} result:^(BOOL success, NSString *msg, id object) {
                                                        if (success) {
                                                            recommendModel = object;
                                                            if (recommendModel.moneyList.count == 0) {
                                                                self.benifitTableView.hidden = YES;
                                                                [self.benifitTableView.mj_footer endRefreshingWithNoMoreData];
                                                            }else{
                                                                [dataSource addObjectsFromArray:recommendModel.moneyList];
                                                                
                                                            }
                                                            [self createUI];
                                                        }else{
                                                            if ([msg isEqualToString:@"-1"]) {
                                                                [self logout];
                                                            } 
                                                        }
                                                        [self.benifitTableView.mj_footer endRefreshing];
                                                        [self.benifitTableView.mj_header endRefreshing];
                                                    } errorResult:^(NSError *enginerError) {
                                                        [self showHint:@"数据请求出错"];
                                                    }];
}
- (void)createUI{
    self.allbenifitLabel.text = recommendModel.total;
    self.invitemenLabel.text = recommendModel.num;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:recommendModel.adimg] placeholderImage:[UIImage imageNamed:@"recommendBanner"]];
       [self.benifitTableView reloadData];
}
- (void)configTableView{
    self.benifitTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.benifitTableView.frame = CGRectMake(0, 97, ScreenWidth, ScreenHeight - 480);
    self.benifitTableView.delegate = self;
    self.benifitTableView.dataSource = self;
    [self.benifitTableView registerNib:[UINib nibWithNibName:@"RecommendTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RecommendReuseId];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActivityAct:)];
    self.checkrulesLabel.userInteractionEnabled = YES;
    [self.checkrulesLabel addGestureRecognizer:tapGes];
}
- (void)tapActivityAct:(id)ges{
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
    [self performSegueWithIdentifier:@"facetofaceSegue" sender:[[XFBConfig Instance] getmemId]];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendTableViewCell *recommendCell = [tableView dequeueReusableCellWithIdentifier:RecommendReuseId forIndexPath:indexPath];
    RecommendPriceModel *model = dataSource[indexPath.row];
    [recommendCell configWithData:model];
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
    }else if ([segue.identifier isEqualToString:@"activitySegue"]){
        NSString *url = sender;
        ActivityRulesViewController *activityVC = segue.destinationViewController;
        activityVC.url = url;
    }
}


- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)activityRulesBtn:(id)sender {
    [self performSegueWithIdentifier:@"activitySegue" sender:recommendModel.url];

}
@end
