//
//  StoreControlViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/9.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StoreControlViewController.h"

#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "OrderControlTableViewCell.h"
#import "StoreControlTableViewCell.h"
#import "DetailHeadView.h"

#import "DLPickerView.h"
@interface StoreControlViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *secOne;
    NSArray *secTwo;
    NSArray *secThr;
    
    NSArray *placeOne;
    NSArray *placeTwo;
    NSArray *placeThr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StoreControlViewController

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
    secOne = @[@"店铺名称",@"门店地址",@"门店电话",@"开始经营时间",@"结束经营时间",@"商家介绍"];
    secTwo = @[@"反币比例",@"真实姓名",@"身份证号码"];
    secThr = @[@"营业执照图片",@"经营许可证图片",@"身份证正面",@"身份证反面"];
    
    placeOne = @[@"智惠返",@"具体位置",@"请填写正确的号码",@"09:00 >",@"18:00 >",@"商店详情"];
    placeTwo = @[@"10%",@"XXX",@"xxxxxxxxxxxxxx",@"xxxxx"];
    placeThr = @[@"已上传 >",@"待上传 >",@"已上传 >",@"已上传 >"];
    
    [self creatUI];
}

- (void)viewDidLayoutSubviews{
    DetailHeadView * headView = [[[NSBundle mainBundle]loadNibNamed:@"DetailHeadView" owner:self options:nil]lastObject];
    [headView.headerImage sd_setImageWithURL:[NSURL URLWithString:@"storeHead"] placeholderImage:[UIImage imageNamed:@"storeHead"]];
    headView.contentMode = UIViewContentModeScaleAspectFill;
    
    headView.frame = CGRectMake(0, 0, ScreenWidth, 170);
    self.tableView.tableHeaderView = headView;
}


- (void)creatUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 9;
    //self.tableView.backgroundColor = RGBACOLOR(235, 235, 235, 0.8);
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreControlTableViewCell" bundle:nil] forCellReuseIdentifier:@"storeConCellId"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }else if (section == 1){
        return 3;
    }else{
        return 4;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreControlTableViewCell *storeConCell = [tableView dequeueReusableCellWithIdentifier:@"storeConCellId"];
    if (storeConCell == nil) {
        storeConCell = [[[NSBundle mainBundle] loadNibNamed:@"StoreControlTableViewCell" owner:self options:nil] lastObject];
    }
    storeConCell.selectionStyle = 0;
    
    storeConCell.hideBtn.enabled = NO;
    
    __weak typeof(storeConCell) weakCell  = storeConCell;
    storeConCell.pikerBlock =^{
        DLPickerView *pickerView = [[DLPickerView alloc] initWithPlistName:@"Time" withSelectedItem:[weakCell.placetextfield.text componentsSeparatedByString:@":"] withSelectedBlock:^(id  _Nonnull item) {
            
            weakCell.placetextfield.text = [item componentsJoinedByString:@":"];
          
        }];
        
        [pickerView show];
  
    };
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 3 ||indexPath.row == 4) {
            storeConCell.hideBtn.enabled = YES;
        }else{
            storeConCell.hideBtn.enabled = NO;
        }
        
        storeConCell.storeNameLab.text = secOne[indexPath.row];
        storeConCell.placetextfield.placeholder = placeOne[indexPath.row];
    }else if (indexPath.section == 1){
        storeConCell.storeNameLab.text = secTwo[indexPath.row];
        storeConCell.placetextfield.placeholder = placeTwo[indexPath.row];
    }else{
        storeConCell.storeNameLab.text = secThr[indexPath.row];
        storeConCell.placetextfield.placeholder = placeThr[indexPath.row];
    }

    return storeConCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 52;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
    UIView *grayView = [UIView new];
    grayView.backgroundColor = RGBACOLOR(235, 235, 235, 1);
    return grayView;
}

- (IBAction)back:(id)sender {
    [self backTolastPage];
}

- (IBAction)PostData:(id)sender {
    NSLog(@"保存数据");
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
