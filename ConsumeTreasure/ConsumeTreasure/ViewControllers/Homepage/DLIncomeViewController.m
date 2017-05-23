//
//  DLIncomeViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/20.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "DLIncomeViewController.h"

#import <MJRefresh/MJRefresh.h>
#import "OrderControlTableViewCell.h"
#import "AccountNewFixTableViewCell.h"

#import "NewAccountTableViewCell.h"
#import "AccountDetailViewController.h"
@interface DLIncomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_incomeArray;
    
    NSInteger _page;
    NSString *_pageNum;

}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DLIncomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.navigationController setNavigationBarHidden:NO];
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
    
    [[MyAPI sharedAPI] getDaLiIncomeListsWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            
            
            if ([arrays[0] count] == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                });
                _page--;
            }
            
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
    self.tableView.rowHeight = 65;
    self.tableView.backgroundColor = RGBACOLOR(235, 235, 235, 0.8);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountNewFixTableViewCell" bundle:nil] forCellReuseIdentifier:@"newFixAccountCellId"];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _incomeArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountNewFixTableViewCell *levelCell = [tableView dequeueReusableCellWithIdentifier:@"newFixAccountCellId"];
    if (levelCell == nil) {
        levelCell = [[[NSBundle mainBundle] loadNibNamed:@"AccountNewFixTableViewCell" owner:self options:nil] lastObject];
    }
    
    if (_incomeArray.count > 0) {
        levelCell.daliModel = [_incomeArray objectAtIndex:indexPath.row];
    }
    levelCell.selectionStyle = 0;
    return levelCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        self.hidesBottomBarWhenPushed = YES;
        DaLiIncomeModel *model = [_incomeArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"daliIncomeSegue" sender:model];
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
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"daliIncomeSegue"]) {
        DaLiIncomeModel *model = (DaLiIncomeModel*)sender;
        AccountDetailViewController *accDetailVC = segue.destinationViewController;
        accDetailVC.daliModel = model;
    }
}


@end
