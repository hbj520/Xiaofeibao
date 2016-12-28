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
    
    
    NSMutableArray *_locationArray;
    NSMutableArray *_provinceArray;
    
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
    
    self.cityNowLab.text = self.locaStr;
    [self.caityNowBtn setTitle:self.locaStr forState:0];
    
    [self configTableView];
    [self setNavi];

    
    [self loadLocationData];
    
}

- (void)loadLocationData{
    NSDictionary *para = @{
                           
                           };
    [[MyAPI sharedAPI] getdevelopCityArrWithMeters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            [_provinceArray removeAllObjects];
            [_locationArray removeAllObjects];
            
            _locationArray = arrays[1];
            _provinceArray = arrays[0];
            [self.tableView reloadData];
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (void)setNavi{
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (IBAction)locateClick:(id)sender {
    
    NSLog(@"😝%@",self.caityNowBtn.titleLabel.text);
    if (self.locaBlock) {
        self.locaBlock(self.caityNowBtn.titleLabel.text);
    }
    [self backTolastPage];
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
   return _provinceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isExpand[section]) {
        return [_locationArray[section] count];
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
    
    if (_locationArray.count > 0) {
        cell.model = _locationArray[indexPath.section][indexPath.row];
    }
    
    
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ProvinceHeadView *view = [[[NSBundle mainBundle] loadNibNamed:@"ProvinceHeadView" owner:self options:nil]lastObject];
    view.proModel = _provinceArray[section];
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
