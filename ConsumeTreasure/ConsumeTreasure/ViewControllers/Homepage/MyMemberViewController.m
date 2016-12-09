//
//  MyMemberViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/9.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyMemberViewController.h"

#import "MemberTableViewCell.h"

#import <MJRefresh/MJRefresh.h>

@interface MyMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyMemberViewController

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
    [self creatUI];
    [self addRefresh];
}

- (void)addRefresh{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       // _page ++;
      //  [self loadAccountDataWithPage:_page pageNum:pageNum];
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
    return 20;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MemberTableViewCell *memCell = [tableView dequeueReusableCellWithIdentifier:@"memCellId"];
    if (memCell == nil) {
        memCell = [[[NSBundle mainBundle] loadNibNamed:@"MemberTableViewCell" owner:self options:nil] lastObject];
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
