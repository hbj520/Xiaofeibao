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

#import <MJRefresh/MJRefresh.h>


@interface LookRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_storeArray;
    NSMutableArray *_timeLookArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LookRecordViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _storeArray = [NSMutableArray array];
    _timeLookArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
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
        if (_timeLookArray.count >0 &&_storeArray.count >0) {
            [_timeLookArray removeAllObjects];
            [_storeArray removeAllObjects];
        }
        [weakSelf loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        
    }];
}

- (void)loadData{
    NSDictionary *para = @{
                           @"pageNum":@"1",
                           @"pageOffest":@"10"
                         };
    [[MyAPI sharedAPI] getLookRecordDataWithParaMeters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            NSLog(@"=====%@====",arrays);
        }
    } errorResult:^(NSError *enginerError) {
        
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
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 1;
    }else{
        return 2;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotStoreTableViewCell *hotCell = [tableView dequeueReusableCellWithIdentifier:@"hotStoreCellId"];
    if (hotCell == nil) {
        hotCell = [[[NSBundle mainBundle] loadNibNamed:@"HotStoreTableViewCell" owner:self options:nil] lastObject];
    }
    hotCell.selectionStyle = 0;
    return hotCell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
        LookRecordHeadView *HotHeadView = [[[NSBundle mainBundle]loadNibNamed:@"LookRecordHeadView" owner:self options:nil]lastObject];

    HotHeadView.backgroundView = [[UIImageView alloc]init];
    HotHeadView.backgroundView.backgroundColor = [UIColor whiteColor];
    
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
