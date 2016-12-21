//
//  OrderControlViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/9.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "OrderControlViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "OrderControlTableViewCell.h"

@interface OrderControlViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_orderArray;
    
    NSInteger _page;
    NSString *_pageNum;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OrderControlViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    _orderArray = [NSMutableArray array];
    _page = 1;
    _pageNum = @"10";
    [self loadOrderDataWithPage:_page pageNum:_pageNum];
    
    [self creatUI];
    [self addRefresh];

}

- (void)addRefresh{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_orderArray.count > 0) {
            [_orderArray removeAllObjects];
        }
        _page = 1;
        [weakSelf loadOrderDataWithPage:_page pageNum:_pageNum];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [weakSelf loadOrderDataWithPage:_page pageNum:_pageNum];
    }];
}


- (void)loadOrderDataWithPage:(NSInteger)page pageNum:(NSString*)pageNum{
    
    NSString *pageNow = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *para = @{
                           @"pageNum":pageNow,
                           @"pageOffset":pageNum
                           };
    
    [[MyAPI sharedAPI] orderDataWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            [_orderArray addObjectsFromArray:arrays[0]];
            [self.tableView reloadData];
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
    self.tableView.backgroundColor = RGBACOLOR(235, 235, 235, 0.8);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderControlTableViewCell" bundle:nil] forCellReuseIdentifier:@"orderCellId"];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _orderArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderControlTableViewCell *orderCell = [tableView dequeueReusableCellWithIdentifier:@"orderCellId"];
    if (orderCell == nil) {
        orderCell = [[[NSBundle mainBundle] loadNibNamed:@"OrderControlTableViewCell" owner:self options:nil] lastObject];
    }
    if (_orderArray.count > 0) {
        orderCell.orderModel = [_orderArray objectAtIndex:indexPath.row];
    }
    orderCell.selectionStyle = 0;
    
    return orderCell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
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
