//
//  ChildViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//
#import "StoreDeatilViewController.h"
#import "ChildViewController.h"

#import "YZDisplayViewControllerConst.h"

#import "PartnerTableViewCell.h"
#import "starView.h"
#import <Masonry.h>

@interface ChildViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@end

@implementation ChildViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    self.view.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    
    // 设置额外滚动区域,如果全屏
    // 监听滚动完成或者点击标题
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:YZDisplayViewClickOrScrollDidFinsh object:nil];
    
    
    [self table];
    [_tableView reloadData];
    
}

- (void)table{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight-64-45) style:0];
    _tableView.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    //self.edgesForExtendedLayout=UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableView.separatorStyle=0;
    _tableView.rowHeight = 275;
    //_tableView.sectionFooterHeight=7;
    _tableView.sectionHeaderHeight = 10;
    //[_tableView registerNib:[UINib nibWithNibName:@"PartnerTableViewCell" bundle:nil] forCellReuseIdentifier:@"partnerCellId"];
    
//    UIImageView *ima = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pizza"]];
//    ima.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-45-64);
//    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    colorView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:ima];
//    [ima mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@(0));
//        make.left.equalTo(@(0));
//        make.right.equalTo(@(0));
//        make.height.equalTo(@(ScreenHeight));
//    }];
    [self.view addSubview:_tableView];
    //[self.view sendSubviewToBack:ima];
    
}


// 加载数据
- (void)loadData
{
    
    //NSLog(@"展示那个界面======%@=====请求数据",self.title);
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %ld",self.title,indexPath.row];
 
    return cell;
    */
    
    
    PartnerTableViewCell *partnerCell = [tableView dequeueReusableCellWithIdentifier:@"partnerCellId"];
    if (partnerCell == nil) {
        partnerCell = [[[NSBundle mainBundle] loadNibNamed:@"PartnerTableViewCell" owner:self options:nil] lastObject];
    }
        [partnerCell configWithModel:[NSNumber numberWithFloat:5.]];
    

        partnerCell.selectionStyle = 0;
    
    NSLog(@"哪个区%@  ====  第几行 ",self.title);
    
    //partnerCell.textLabel.text = [NSString stringWithFormat:@"%@ : %ld",self.title,indexPath.row];
//    partnerCell.layer.shouldRasterize = YES;
//    partnerCell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    
    
    
    partnerCell.phoneBlock =^{
        NSLog(@"打电话");
    };
    

    return partnerCell;
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
   // grayView.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    return grayView;
}

- (void)changeTohom{
    self.mStorybord = [UIStoryboard storyboardWithName:@"Hompage" bundle:nil];
    StoreDeatilViewController *deVC = [self.mStorybord instantiateViewControllerWithIdentifier:@"detail"];
  //  [self.navigationController didAnimateFirstHalfOfRotationToInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    [self.navigationController pushViewController:deVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self changeTohom];
}


@end
