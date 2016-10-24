//
//  ChildViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "ChildViewController.h"

#import "YZDisplayViewControllerConst.h"

#import "PartnerTableViewCell.h"


@interface ChildViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@end

@implementation ChildViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    self.view.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    
    // 设置额外滚动区域,如果全屏
    // 监听滚动完成或者点击标题
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:YZDisplayViewClickOrScrollDidFinsh object:nil];
    
    
    [self table];
    
}

- (void)table{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 7,375 , 655) style:1];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableView.separatorStyle=0;
    _tableView.rowHeight = 100;
    _tableView.sectionFooterHeight=0;
    _tableView.sectionHeaderHeight=0;
    [self.view addSubview:_tableView];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
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
    partnerCell.selectionStyle = 0;
    
    NSLog(@"哪个区%@  ====  第几行 ",self.title);
    
    //partnerCell.textLabel.text = [NSString stringWithFormat:@"%@ : %ld",self.title,indexPath.row];
    partnerCell.layer.shouldRasterize = YES;
    partnerCell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    partnerCell.phoneBlock =^{
        NSLog(@"打电话");
    };
    return partnerCell;
    
}



@end
