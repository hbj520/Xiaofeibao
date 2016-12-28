//
//  MyMemberViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/9.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyMemberViewController.h"

#import "MemberTableViewCell.h"

#import "NemberModel.h"

#import <MJRefresh/MJRefresh.h>

@interface MyMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_memArray;
    
    NSInteger _page;
    NSString *_pageNum;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyMemberViewController
- (IBAction)back:(id)sender {
    [self backTolastPage];
}

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
    
    
    _memArray = [NSMutableArray array];
    _page = 1;
    _pageNum = @"10";
    [self loadMemberDataWithPage:_page pageNum:_pageNum];
    
    [self creatUI];
    [self addRefresh];
}

- (void)addRefresh{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_memArray.count > 0) {
            [_memArray removeAllObjects];
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
    
    [[MyAPI sharedAPI] getMyMemberDataWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            [_memArray addObjectsFromArray:arrays[0]];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"MemberTableViewCell" bundle:nil] forCellReuseIdentifier:@"memCellId"];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _memArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MemberTableViewCell *memCell = [tableView dequeueReusableCellWithIdentifier:@"memCellId"];
    if (memCell == nil) {
        memCell = [[[NSBundle mainBundle] loadNibNamed:@"MemberTableViewCell" owner:self options:nil] lastObject];
    }
    
    if (_memArray.count > 0) {
        memCell.memModel = [_memArray objectAtIndex:indexPath.row];
    }
    memCell.selectionStyle = 0;
    
    return memCell;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return 100;
   
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
