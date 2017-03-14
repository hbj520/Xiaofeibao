//
//  CollectionViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 17/3/14.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "CollectionViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "CollectionTableViewCell.h"

@interface CollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_shopsArr;
    
    NSInteger _page;
    NSString *_pageNum;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CollectionViewController

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

- (void)loadShopsDataWithPage:(NSInteger)page pageNum:(NSString*)pageNum{
    
    NSString *pageNow = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *para = @{
                           @"pageNum":pageNow,
                           @"pageOffset":pageNum
                           };
    
    [[MyAPI sharedAPI] attentionShopWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            if ([arrays count] == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                });
                _page--;
            }
            [_shopsArr addObjectsFromArray:arrays];
            [self.tableView reloadData];
        }
        else{
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
    self.tableView.rowHeight = 80;
    //self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"collectionCellId"];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _shopsArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionTableViewCell *shopsCell = [tableView dequeueReusableCellWithIdentifier:@"collectionCellId"];
    if (shopsCell == nil) {
        shopsCell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionTableViewCell" owner:self options:nil] lastObject];
    }
    
    if (_shopsArr.count > 0) {
        shopsCell.collectShopMo = [_shopsArr objectAtIndex:indexPath.row];
    }
    shopsCell.deleteBlock =^(){
        [self deleteBankInfoWithIndex:indexPath.row];
    };
    
    shopsCell.selectionStyle = 0;
    
    return shopsCell;
    
}

- (void)deleteBankInfoWithIndex:(NSInteger)index{
    
    CollectShopListModel *model = [_shopsArr objectAtIndex:index];
    // UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndex:index]];
    NSDictionary *para = @{
                           @"objectId":model.memid,
                           @"type":@"0"
                           };
    [[MyAPI sharedAPI] collectStoreOrNotWithParameters:para result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            [self showHint:@"取消收藏成功"];
            [_shopsArr removeObject:[_shopsArr objectAtIndex:index]];
            [self.tableView reloadData];
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
}


@end
