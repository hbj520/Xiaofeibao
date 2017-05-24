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
@interface AtractInvestViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataSource;
    AttractInvestModelAray *model;
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
    self.restMoneyLabel.text =  [NSString stringWithFormat:@"余额:%@",model.balance];
    self.cashMoneyBtn.layer.borderWidth = 1;
    self.cashMoneyBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.cashMoneyBtn.layer.cornerRadius = 9.;
    self.cashMoneyBtn.layer.masksToBounds = YES;

}
- (void)loadData{
    if (dataSource) {
        [dataSource removeAllObjects];
    }else{
        dataSource = [NSMutableArray array];
    }
    [[MyAPI sharedAPI] attractInvestWith:@{@"pageNum":@"1",
                                          @"pageOffset":@"10" }result:^(BOOL success, NSString *msg, id object) {
                                              
                                              if (success) {
                                                  model = (AttractInvestModelAray *)object;
                                                  [dataSource addObjectsFromArray:model.myRecommendProxyList];
                                                  [self.tableview reloadData];
                                                  [self createUI];

                                              }
                                          } errorResult:^(NSError *enginerError) {
                                              
                                          }];
}
- (void)addRefresh{
    
}
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

- (IBAction)detailBtn:(id)sender {
    [self performSegueWithIdentifier:@"benifitDetailSegueId" sender:nil];
}
- (IBAction)cashMoneyBtn:(id)sender {
    [self performSegueWithIdentifier:@"cashMoneySegueId" sender:nil];
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
