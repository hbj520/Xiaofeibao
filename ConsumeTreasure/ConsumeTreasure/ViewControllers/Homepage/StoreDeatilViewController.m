//
//  StoreDeatilViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StoreDeatilViewController.h"

#import "StoreDetailModel.h"

#import "LPNavigationBarView.h"
#import "DetailHeadView.h"
#import "StoreDetailTableViewCell.h"
#import "StoreContentTableViewCell.h"
#import "ListHeadView.h"
#import "StoreSpecialTableViewCell.h"
#import "EstimateTableViewCell.h"
#import "BottomFootView.h"
#import "PromptTableViewCell.h"

#import <Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface StoreDeatilViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    StoreDetailModel *_deModel;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomBarView;

@property (nonatomic, weak) LPNavigationBarView *navBar;

@end

@implementation StoreDeatilViewController

- (void)viewWillDisappear:(BOOL)animated{
    //[self.navigationController setNavigationBarHidden: NO animated: animated];

    [super viewWillDisappear:animated];
    }

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
  //  self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    [self.bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@44);
        
        
    }];
    
    [self addTableView];
    [self addNavBarView];//导航栏
    [self addRefresh];
}

- (void)setStoreModel:(HomeStoreModel *)StoreModel{
    NSLog(@"😝%@😋",StoreModel);
    [self loadDataWithMemId:StoreModel.memid];
}

- (void)addRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           }];
    
  
}

- (void)loadDataWithMemId:(NSString *)memid{
    NSDictionary *para = @{
                           @"memid":memid
                           };
    [[MyAPI sharedAPI] getDetailStoreWithParameters:para result:^(BOOL success, NSString *msg, id object) {
        if (success) {
            
            _deModel = object;
            [self.tableView reloadData];
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
    
    
}

- (void)viewDidLayoutSubviews{
    DetailHeadView * headView = [[[NSBundle mainBundle]loadNibNamed:@"DetailHeadView" owner:self options:nil]lastObject];
    [headView.headerImage sd_setImageWithURL:[NSURL URLWithString:_deModel.doorImg] placeholderImage:[UIImage imageNamed:@"storeHead"]];
     headView.contentMode = UIViewContentModeScaleAspectFill;
    
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
    _navBar.title = @"预约商户";
    _navBar.backgroundAlpha = 0;
}

- (void)addTableView{

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"storeDetailId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"contentId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreSpecialTableViewCell" bundle:nil] forCellReuseIdentifier:@"sprcialId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EstimateTableViewCell" bundle:nil] forCellReuseIdentifier:@"esmateId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PromptTableViewCell" bundle:nil] forCellReuseIdentifier:@"PromptId"];

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
        storeDetailCell.deModel = _deModel;
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
     PromptTableViewCell *promptCell = [tableView dequeueReusableCellWithIdentifier:@"PromptId"];
     if (promptCell == nil) {
         promptCell = [[[NSBundle mainBundle] loadNibNamed:@"PromptTableViewCell" owner:self options:nil] lastObject];
     }
     promptCell.selectionStyle = 0;
     return promptCell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"================");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ||indexPath.section == 1 ||indexPath.section == 3) {
        return UITableViewAutomaticDimension;
    }else if (indexPath.section == 4){
        return 100;
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
      //  listHead.backgroundView = [[UIImageView alloc]init];
        listHead.contentView.backgroundColor = [UIColor whiteColor];
        
        return listHead;
    }else{
        UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
        head.backgroundColor = RGBACOLOR(240, 241, 242, 1);
        return head;
    }
    
   // return [UIView new];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    // return [UIView new];
   
    if (section == 3) {
        BottomFootView *footView = [[[NSBundle mainBundle]loadNibNamed:@"BottomFootView" owner:self options:nil]lastObject];
        return footView;
    }else{
    
    
    UIView * foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    foot.backgroundColor = RGBACOLOR(240, 241, 242, 1);
    return foot;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section ==1) {
        return 0.01;
    }else if (section == 4){
        
        return 15;
    }
    
    else {
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
