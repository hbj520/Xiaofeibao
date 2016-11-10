//
//  StoreDeatilViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StoreDeatilViewController.h"

#import "DetailHeadView.h"
#import "StoreDetailTableViewCell.h"
#import "StoreContentTableViewCell.h"
#import "ListHeadView.h"
#import "StoreSpecialTableViewCell.h"
#import "EstimateTableViewCell.h"
#import "BottomFootView.h"

@interface StoreDeatilViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StoreDeatilViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTableView];
    [self addTableViewHeadView];
    
}

- (void)addTableViewHeadView{
    
    DetailHeadView * headView = [[[NSBundle mainBundle]loadNibNamed:@"DetailHeadView" owner:self options:nil]lastObject];
    headView.frame = CGRectMake(0, 0, ScreenWidth, 170);
    self.tableView.tableHeaderView = headView;
}

- (void)addTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"storeDetailId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"contentId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreSpecialTableViewCell" bundle:nil] forCellReuseIdentifier:@"sprcialId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EstimateTableViewCell" bundle:nil] forCellReuseIdentifier:@"esmateId"];
}

#pragma mark -- UITableViewDelegate 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 && section == 1) {
        return 1;
    }else if (section == 2 && section == 3){
        return 2;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   // if (indexPath.section == 0) {//折线图
        StoreDetailTableViewCell *storeDetailCell = [tableView dequeueReusableCellWithIdentifier:@"storeDetailId"];
        if (storeDetailCell == nil) {
            storeDetailCell = [[[NSBundle mainBundle] loadNibNamed:@"StoreDetailTableViewCell" owner:self options:nil] lastObject];
        }
       
        storeDetailCell.selectionStyle = 0;
        return storeDetailCell;
   // }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 44;
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
