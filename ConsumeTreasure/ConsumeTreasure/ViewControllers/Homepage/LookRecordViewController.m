//
//  LookRecordViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "LookRecordViewController.h"
#import "HotStoreTableViewCell.h"
#import "LookRecordHeadView.h"

#import "LookTimeMode.h"
#import "LookStoreModel.h"
#import <MJRefresh/MJRefresh.h>

#import <SDWebImage/UIImageView+WebCache.h>

@interface LookRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_storeArray;
    NSMutableArray *_timeLookArray;
    
    NSString *_pageNum;
    NSInteger _page;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LookRecordViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
   // [self loadDataWithPageNum:_pageNum page:_page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _storeArray = [NSMutableArray array];
    _timeLookArray = [NSMutableArray array];
    _pageNum = @"10";
    _page = 1;
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadDataWithPageNum:_pageNum page:_page];
    [self creatUI];
   
    [self addRefresh];
}

-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)addRefresh{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        _page = 1;
        [weakSelf loadDataWithPageNum:_pageNum page:_page];
    }];
    /*
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [weakSelf loadDataWithPageNum:_pageNum page:_page];
        
    }];*/
}

- (void)loadDataWithPageNum:(NSString*)pageNum page:(NSInteger)page{
    NSString *nowPage = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *para = @{
                           @"pageNum":nowPage,
                           @"pageOffset":pageNum
                         };
    [[MyAPI sharedAPI] getLookRecordDataWithParaMeters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            NSLog(@"=====%@====",arrays);
            if (page == 1) {
                [_storeArray removeAllObjects];
                [_timeLookArray removeAllObjects];
            }
            [_timeLookArray addObjectsFromArray:arrays[0]];
            [_storeArray addObjectsFromArray:arrays[1]];
            [self.tableView reloadData];
            
        }
        [self endRefresh];
    } errorResult:^(NSError *enginerError) {
        [self endRefresh];
    }];
    
    
}

- (void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 125;
    self.tableView.sectionHeaderHeight = 40;
    self.tableView.sectionFooterHeight = 12;
    [self.tableView registerNib:[UINib nibWithNibName:@"HotStoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"hotStoreCellId"];
    
    
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _timeLookArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_storeArray[section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotStoreTableViewCell *hotCell = [tableView dequeueReusableCellWithIdentifier:@"hotStoreCellId"];
    if (hotCell == nil) {
        hotCell = [[[NSBundle mainBundle] loadNibNamed:@"HotStoreTableViewCell" owner:self options:nil] lastObject];
    }
    hotCell.selectionStyle = 0;
    
    LookStoreModel *model = _storeArray[indexPath.section][indexPath.row];
    [hotCell.storeImage sd_setImageWithURL:[NSURL URLWithString:model.doorImage] placeholderImage:[UIImage imageNamed:@"foodImage"]];
    hotCell.storeName.text = model.shopName;
    hotCell.storeAddress.text = model.addr2;
  //  hotCell.storeLikeNum.text = model.collectsnum;
    hotCell.distance.hidden = YES;
    return hotCell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    LookRecordHeadView *HotHeadView = [[[NSBundle mainBundle]loadNibNamed:@"LookRecordHeadView" owner:self options:nil]lastObject];
    
    //HotHeadView.backgroundView = [[UIImageView alloc]init];
    //HotHeadView.backgroundView.backgroundColor = [UIColor whiteColor];
   LookTimeMode *model = [_timeLookArray objectAtIndex:section];
   HotHeadView.lookTimeLab.text = model.time;
    
    HotHeadView.contentView.backgroundColor = [UIColor whiteColor];
    return HotHeadView;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footer = [[UIView alloc]init];
    footer.backgroundColor = RGBACOLOR(235, 235, 235, 1);
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"=====%ld_______%ld",indexPath.section,indexPath.row);
    
    
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
