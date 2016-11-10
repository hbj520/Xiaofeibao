//
//  StoreDeatilViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StoreDeatilViewController.h"

#import "LPNavigationBarView.h"
#import "DetailHeadView.h"
#import "StoreDetailTableViewCell.h"
#import "StoreContentTableViewCell.h"
#import "ListHeadView.h"
#import "StoreSpecialTableViewCell.h"
#import "EstimateTableViewCell.h"
#import "BottomFootView.h"

@interface StoreDeatilViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) LPNavigationBarView *navBar;

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
     [self addNavBarView];//导航栏
    
}
- (void)viewDidLayoutSubviews{
    DetailHeadView * headView = [[[NSBundle mainBundle]loadNibNamed:@"DetailHeadView" owner:self options:nil]lastObject];
    headView.frame = CGRectMake(0, 0, ScreenWidth, 170);
    self.tableView.tableHeaderView = headView;
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _navBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64);
}
- (void)addNavBarView
{
    LPNavigationBarView *navBar = [[[NSBundle mainBundle]loadNibNamed:@"LPNavigationBarView" owner:self options:nil]lastObject];
    [self.view addSubview:navBar];
    _navBar = navBar;
    _navBar.backgroundAlpha = 0;
}

- (void)addTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"storeDetailId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"contentId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreSpecialTableViewCell" bundle:nil] forCellReuseIdentifier:@"sprcialId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EstimateTableViewCell" bundle:nil] forCellReuseIdentifier:@"esmateId"];
    [self.view insertSubview:self.tableView belowSubview:_navBar];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat headerViewHeight = 100;
    if (offsetY <= 0) {
        _navBar.backgroundAlpha = 0;
    }else if (offsetY >= headerViewHeight) {
        _navBar.backgroundAlpha = 1.0;
    }else {
        _navBar.backgroundAlpha = offsetY/headerViewHeight;
    }
}

#pragma mark -- UITableViewDelegate 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 1;
    }else if (section == 2 || section == 3){
        return 2;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
if (indexPath.section == 0) {//折线图
        StoreDetailTableViewCell *storeDetailCell = [tableView dequeueReusableCellWithIdentifier:@"storeDetailId"];
        if (storeDetailCell == nil) {
            storeDetailCell = [[[NSBundle mainBundle] loadNibNamed:@"StoreDetailTableViewCell" owner:self options:nil] lastObject];
        }
       
        storeDetailCell.selectionStyle = 0;
        return storeDetailCell;
 }

 else if (indexPath.section == 1){
     StoreContentTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"contentId"];
     if (contentCell == nil) {
         contentCell = [[[NSBundle mainBundle] loadNibNamed:@"StoreContentTableViewCell" owner:self options:nil] lastObject];
     }
     
     contentCell.selectionStyle = 0;
     return contentCell;

 }else if(indexPath.section == 2){
     StoreSpecialTableViewCell *specialCell = [tableView dequeueReusableCellWithIdentifier:@"sprcialId"];
     if (specialCell == nil) {
         specialCell = [[[NSBundle mainBundle] loadNibNamed:@"StoreSpecialTableViewCell" owner:self options:nil] lastObject];
     }
     specialCell.selectionStyle = 0;
     return specialCell;
 }else if (indexPath.section == 3){
     EstimateTableViewCell *estimateCell = [tableView dequeueReusableCellWithIdentifier:@"esmateId"];
     if (estimateCell == nil) {
         estimateCell = [[[NSBundle mainBundle] loadNibNamed:@"EstimateTableViewCell" owner:self options:nil] lastObject];
     }
     estimateCell.selectionStyle = 0;
     return estimateCell;
 }else{
     EstimateTableViewCell *estimateCell = [tableView dequeueReusableCellWithIdentifier:@"esmateId"];
     if (estimateCell == nil) {
         estimateCell = [[[NSBundle mainBundle] loadNibNamed:@"EstimateTableViewCell" owner:self options:nil] lastObject];
     }
     estimateCell.selectionStyle = 0;
     return estimateCell;
 }

}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 125;
    }else if(indexPath.section == 1 ){
        return 150;
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ||indexPath.section == 1 ||indexPath.section == 3) {
        return UITableViewAutomaticDimension;
    }else{
        return 83;
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2 ||section == 3) {
        ListHeadView *listHead = [[[NSBundle mainBundle] loadNibNamed:@"ListHeadView" owner:self options:nil]lastObject];
        if (section == 2) {
            listHead.listTitle.text = @"特色";
            listHead.listHeadImage.image = [UIImage imageNamed:@"ts"];
        }else if(section == 3){
            listHead.listTitle.text = @"评价";
            listHead.listHeadImage.image = [UIImage imageNamed:@"pj_1080"];
        }
        listHead.backgroundView = [[UIImageView alloc]init];
        listHead.backgroundView.backgroundColor = [UIColor whiteColor];
        
        return listHead;
    }
    return [UIView new];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    // return [UIView new];
   
    UIView * foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    foot.backgroundColor = RGBACOLOR(240, 241, 242, 1);
    return foot;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section ==1) {
        return 0.01;
    }else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0 || section == 1 ||section == 2 ) {
        return 15;
    }else{
        return 44;
    }
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
