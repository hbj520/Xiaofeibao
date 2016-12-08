//
//  LocationViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "LocationViewController.h"

#import "LocationTableViewCell.h"
#import "ProvinceHeadView.h"

#import <Masonry.h>

@interface LocationViewController ()<UITableViewDelegate,UITableViewDataSource>{
   
    BOOL _isExpand[3];
    
     NSArray* _sectionTitleArray;
    
     NSArray* _dataArray;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end



@implementation LocationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavi];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self configTableView];
    [self setNavi];
    _sectionTitleArray = [[NSArray alloc] initWithObjects:@"家人",@"朋友",@"同学", nil];
    
    NSArray* array0 = @[@"爸爸",@"妈妈",@"哥哥",@"姐姐",@"妹妹",@"弟弟"];
    NSArray* array1 = @[@"张三",@"李四",@"王五"];
    NSArray* array2 = @[@"艾克",@"光辉",@"aa",@"bb"];
    
    _dataArray = [[NSArray alloc] initWithObjects:array0,array1,array2, nil];
}

- (void)setNavi{
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)configTableView{
    
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@0);
//        make.left.equalTo(@0);
//        make.right.equalTo(@0);
//       // make.height.equalTo(@(self.tableView.rowHeight*[_dataArray[section] count]));
//        
//    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.rowHeight = 40;
    self.tableView.sectionHeaderHeight = 48;
    self.tableView.tableFooterView =  [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"LocationTableViewCell" bundle:nil]forCellReuseIdentifier:@"locationCellId"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isExpand[section]) {
        return [_dataArray[section] count];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LocationTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.rightImage.hidden = NO;
    if (self.locaBlock) {
        self.locaBlock(cell.cityName.text);
    }
    [self backTolastPage];
   
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    LocationTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    cell.rightImage.hidden = YES;
//}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCellId" forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LocationTableViewCell" owner:self options:nil]lastObject];
    }
    cell.cityName.text = _dataArray[indexPath.section][indexPath.row];
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ProvinceHeadView *view = [[[NSBundle mainBundle] loadNibNamed:@"ProvinceHeadView" owner:self options:nil]lastObject];
    view.provinceName.text = _sectionTitleArray[section];
    view.arrowImage.image = [UIImage imageNamed:@"ss_720"];
      __weak typeof(view) weakViewSelf = view;
    view.openBlock =^{
      _isExpand[section] = !_isExpand[section];
        [UIView animateWithDuration:0.3 animations:^{
            
            if (_isExpand[section]) {
                weakViewSelf.arrowImage.transform = CGAffineTransformMakeRotation(M_PI_2);
            } else {
                weakViewSelf.arrowImage.transform = CGAffineTransformIdentity;
            }
        }];
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section]
                 withRowAnimation:UITableViewRowAnimationFade];
    };
    view.contentView.backgroundColor = RGBACOLOR(230, 234, 235, 1);
    return view;
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
