//
//  UnionIncomeViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 17/1/5.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "UnionIncomeViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "OrderControlTableViewCell.h"
@interface UnionIncomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_incomeArray;
    
    NSInteger _page;
    NSString *_pageNum;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UnionIncomeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _incomeArray = [NSMutableArray array];
    _page = 1;
    _pageNum = @"10";
    
    [self loadIncomeDetailDataWithPage:_page pageNum:_pageNum];
    
    [self creatUI];
    [self addRefresh];
}
- (void)addRefresh{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_incomeArray.count > 0) {
            [_incomeArray removeAllObjects];
        }
        _page = 1;
        [weakSelf loadIncomeDetailDataWithPage:_page pageNum:_pageNum];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [weakSelf loadIncomeDetailDataWithPage:_page pageNum:_pageNum];
    }];
}

- (void)loadIncomeDetailDataWithPage:(NSInteger)page pageNum:(NSString*)pageNum{
    
    NSString *pageNow = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *para = @{
                           @"pageNum":pageNow,
                           @"pageOffset":pageNum
                           };
    
    [[MyAPI sharedAPI] getIncomeOfShangHuWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            [_incomeArray addObjectsFromArray:arrays[0]];
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

-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)creatUI{
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    self.tableView.backgroundColor = RGBACOLOR(235, 235, 235, 0.8);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderControlTableViewCell" bundle:nil] forCellReuseIdentifier:@"orderCellId"];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _incomeArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderControlTableViewCell *orderCell = [tableView dequeueReusableCellWithIdentifier:@"orderCellId"];
    if (orderCell == nil) {
        orderCell = [[[NSBundle mainBundle] loadNibNamed:@"OrderControlTableViewCell" owner:self options:nil] lastObject];
    }
    if (_incomeArray.count > 0) {
        orderCell.daliIncomeModel = [_incomeArray objectAtIndex:indexPath.row];
    }
    orderCell.selectionStyle = 0;
    
    return orderCell;
    
}

- (IBAction)back:(id)sender {
    [self backTolastPage];
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
