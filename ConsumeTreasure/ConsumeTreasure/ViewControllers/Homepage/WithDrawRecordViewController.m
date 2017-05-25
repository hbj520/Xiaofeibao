//
//  WithDrawRecordViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 17/2/14.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "WithDrawRecordViewController.h"

#import "OrderControlTableViewCell.h"

#import "AccountModel.h"
#import <MJRefresh/MJRefresh.h>
#import "CashBankRecordTableViewCell.h"

@interface WithDrawRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_recordArray;//提现记录
    NSMutableArray *applyCashRecordDataSource;//申请提现记录
    NSInteger _page;
    NSString *_pageNum;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WithDrawRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    _recordArray = [NSMutableArray array];
    applyCashRecordDataSource = [NSMutableArray array];
    _page = 1;
    _pageNum = @"10";
        [self loadMemberDataWithPage:_page pageNum:_pageNum];
    [self creatUI];
    [self addRefresh];
}

- (void)addRefresh{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_recordArray.count > 0) {
            [_recordArray removeAllObjects];
        }
        _page = 1;
        [weakSelf loadMemberDataWithPage:_page pageNum:_pageNum];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [weakSelf loadMemberDataWithPage:_page pageNum:_pageNum];
    }];
}

- (void)loadMemberDataWithPage:(NSInteger)page pageNum:(NSString*)pageNum{
    
    NSString *pageNow = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *para = @{
                           @"pageNum":pageNow,
                           @"pageOffset":pageNum
                           };
    if (self.isInvest) {
        [[MyAPI sharedAPI] applyWithDrawRecordWithWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
            if (success) {
                
                if (arrays.count == 0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    });
                    _page--;
                }
                [applyCashRecordDataSource addObjectsFromArray:arrays];
                [self.tableView reloadData];
            }else{
                if ([msg isEqualToString:@"-1"]) {
                    [self logout];
                }
            }
            [self endRefresh];
        } errorResult:^(NSError *enginerError) {
            [self endRefresh];

        }];
    }else{
        [[MyAPI sharedAPI] getWithDrawRecordWithWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
            if (success) {
                
                if (arrays.count == 0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    });
                    _page--;
                }
                [_recordArray addObjectsFromArray:arrays];
                [self.tableView reloadData];
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

    
}

-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)creatUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderControlTableViewCell" bundle:nil] forCellReuseIdentifier:@"orderCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CashBankRecordTableViewCell" bundle:nil] forCellReuseIdentifier:CashBankReuseId];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    
}
#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _recordArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isInvest) {
        OrderControlTableViewCell *orderCell = [tableView dequeueReusableCellWithIdentifier:@"orderCellId"];
//        if (orderCell == nil) {
//            orderCell = [[[NSBundle mainBundle] loadNibNamed:@"OrderControlTableViewCell" owner:self options:nil] lastObject];
//        }
        if (_recordArray.count > 0) {
            recordModel *reModel = [_recordArray objectAtIndex:indexPath.row];
            orderCell.oneLab.text = @"提现详情";
            orderCell.orderNumLab.text = reModel.record_description;
            orderCell.twoLab.text = @"提现金额";
            orderCell.moneyLab.text = reModel.money;
            orderCell.timeLabel.text = reModel.createdate;
        }
        orderCell.selectionStyle = 0;
        
        return orderCell;
    }else{
        CashBankRecordTableViewCell *cashRecordCell = [tableView dequeueReusableCellWithIdentifier:CashBankReuseId forIndexPath:indexPath];
        
        return nil;
    }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
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
