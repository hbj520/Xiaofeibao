//
//  DLStoreListViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/20.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "DLStoreListViewController.h"

#import "NemberModel.h"

#import <MJRefresh/MJRefresh.h>

#import "DaiLiShopsTableViewCell.h"

@interface DLStoreListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_shopsArr;
    
    NSInteger _page;
    NSString *_pageNum;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation DLStoreListViewController
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
    
    
    _shopsArr = [NSMutableArray array];
    _page = 1;
    _pageNum = @"10";
    [self loadShopsDataWithPage:_page pageNum:_pageNum];
    [self creatUI];
    [self addRefresh];

}

- (void)addRefresh{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_shopsArr.count > 0) {
            [_shopsArr removeAllObjects];
        }
        _page = 1;
        [weakSelf loadShopsDataWithPage:_page pageNum:_pageNum];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [weakSelf loadShopsDataWithPage:_page pageNum:_pageNum];
    }];
}

- (void)creatUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    [self.tableView registerNib:[UINib nibWithNibName:@"DaiLiShopsTableViewCell" bundle:nil] forCellReuseIdentifier:@"MYshopscellId"];
    
}

- (void)loadShopsDataWithPage:(NSInteger)page pageNum:(NSString*)pageNum{
    
    NSString *pageNow = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *para = @{
                           @"pageNum":pageNow,
                           @"pageOffset":pageNum
                           };
    
    [[MyAPI sharedAPI] getDaLiStoreListsWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            [_shopsArr addObjectsFromArray:arrays[0]];
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


#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _shopsArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DaiLiShopsTableViewCell *shopsCell = [tableView dequeueReusableCellWithIdentifier:@"MYshopscellId"];
    if (shopsCell == nil) {
        shopsCell = [[[NSBundle mainBundle] loadNibNamed:@"DaiLiShopsTableViewCell" owner:self options:nil] lastObject];
    }
    
    if (_shopsArr.count > 0) {
        shopsCell.shopMo = [_shopsArr objectAtIndex:indexPath.row];
    }
    shopsCell.selectionStyle = 0;
    
    return shopsCell;
    
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
