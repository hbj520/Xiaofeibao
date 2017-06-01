//
//  AtractInvestViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 2017/5/23.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "AtractInvestViewController.h"
#import "AttractInvestModel.h"
#import "AttractInvestTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "WithDrawViewController.h"
#import "UnionIncomeViewController.h"
@interface AtractInvestViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataSource;
    AttractInvestModelAray *model;
    NSInteger page;
}
- (IBAction)backBtn:(id)sender;
- (IBAction)detailBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *restMoneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *cashMoneyBtn;
- (IBAction)cashMoneyBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation AtractInvestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataSource = [NSMutableArray array];
    page = 1;
    [self loadData];
    [self addRefresh];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -PrivateMethod
- (void)createUI{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"AttractInvestTableViewCell" bundle:nil] forCellReuseIdentifier:ATTRACTCELLREUSEID];
   // self.restMoneyLabel.text =  @"123456789.56";
    self.tableview.sectionFooterHeight = 0;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.restMoneyLabel.text =  model.balance;
    self.cashMoneyBtn.layer.borderWidth = 1;
    self.cashMoneyBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.cashMoneyBtn.layer.cornerRadius = 9.;
    self.cashMoneyBtn.layer.masksToBounds = YES;

}
- (void)loadData{
    [[MyAPI sharedAPI] attractInvestWith:@{@"pageNum":[NSString stringWithFormat:@"%ld",page],
                                          @"pageOffset":@"10" }result:^(BOOL success, NSString *msg, id object) {
                                              
                                              if (success) {
                                                  model = (AttractInvestModelAray *)object;
                                                  [dataSource addObjectsFromArray:model.myRecommendProxyList];
                                                  [self.tableview reloadData];
                                                  [self createUI];
                                                  if (model.myRecommendProxyList.count == 0) {
                                                      [self.tableview.mj_footer endRefreshingWithNoMoreData];

                                                  }else{
                                                      [self.tableview.mj_footer endRefreshing];

                                                  }
                                                  [self.tableview.mj_header endRefreshing];
                                              }else{
                                                  [self.tableview.mj_footer endRefreshing];
                                                  [self.tableview.mj_header endRefreshing];
                                              }
                                             
                                          } errorResult:^(NSError *enginerError) {
                                              [self.tableview.mj_footer endRefreshing];
                                              [self.tableview.mj_header endRefreshing];
                                          }];
}
- (void)addRefresh{
    __weak typeof(self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (dataSource.count > 0 ) {
            [dataSource removeAllObjects];
        }
        page = 1;
        [weakSelf loadData];
    }];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [weakSelf loadData];
          }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"cashMoneySegueId"]) {
        WithDrawViewController *cashVC  = ( WithDrawViewController *)segue.destinationViewController;
        cashVC.moneyType = @[_restMoneyLabel.text,@""];
        cashVC.isInvest = YES;
    }else if ([segue.identifier isEqualToString:@"benifitDetailSegueId"]){
        UnionIncomeViewController *inconVC = (UnionIncomeViewController *)segue.destinationViewController;
        inconVC.isInvest = YES;
    }
}


- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)detailBtn:(id)sender {
  //  [self performSegueWithIdentifier:@"benifitDetailSegueId" sender:nil];
}
- (IBAction)cashMoneyBtn:(id)sender {
 //   [self performSegueWithIdentifier:@"cashMoneySegueId" sender:nil];
}

#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttractInvestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ATTRACTCELLREUSEID forIndexPath:indexPath];
    AttractInvestModel *mModel = [dataSource objectAtIndex:indexPath.row];
    [cell configWithData:mModel];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}
@end
