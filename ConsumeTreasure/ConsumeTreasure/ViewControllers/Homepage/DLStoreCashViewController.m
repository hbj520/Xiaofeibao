//
//  DLStoreCashViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 17/3/14.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "DLStoreCashViewController.h"

#import <MJRefresh/MJRefresh.h>
#import "NewAccountTableViewCell.h"

#import "HMDatePickView.h"

#import "AccountDetailViewController.h"

@interface DLStoreCashViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *_incomeArray;
    
    NSInteger _page;
    NSString *_pageNum;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DLStoreCashViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
   // [self getdefaultStatTimeAndEndTime];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.navigationController setNavigationBarHidden:NO];
    ;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _incomeArray = [NSMutableArray array];
    _page = 1;
    _pageNum = @"10";
    
    
    [self creatUI];
    [self addRefresh];
    [self getdefaultStatTimeAndEndTime];

    self.startTime.delegate = self;
    self.endTime.delegate = self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField == self.startTime) {

        
        HMDatePickView *datePickVC = [[HMDatePickView alloc] initWithFrame:self.view.frame];
        //距离当前日期的年份差（设置最大可选日期）
        datePickVC.maxYear = -1;
        //设置最小可选日期(年分差)
        //    _datePickVC.minYear = 10;
        datePickVC.date = [NSDate date];
        //设置字体颜色
        datePickVC.fontColor = [UIColor redColor];
        //日期回调
        datePickVC.completeBlock = ^(NSString *selectDate) {
            self.startTime.text = selectDate;
        };
        //配置属性
        [datePickVC configuration];
        
        [self.view addSubview:datePickVC];
        
    }else{
      
        HMDatePickView *datePickVC = [[HMDatePickView alloc] initWithFrame:self.view.frame];
        //距离当前日期的年份差（设置最大可选日期）
        datePickVC.maxYear = -1;
        //设置最小可选日期(年分差)
        //    _datePickVC.minYear = 10;
        datePickVC.date = [NSDate date];
        //设置字体颜色
        datePickVC.fontColor = [UIColor redColor];
        //日期回调
        datePickVC.completeBlock = ^(NSString *selectDate) {
            self.endTime.text = selectDate;
        };
        //配置属性
        [datePickVC configuration];
        
        [self.view addSubview:datePickVC];
    }
    
    
}

- (void)getdefaultStatTimeAndEndTime{
    //得到当前的时间
    NSDate * mydate = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    self.endTime.text = currentDateStr;
 
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    [adcomps setMonth:-3];
    [adcomps setDay:0];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    //NSLog(@"---前两个月 =%@",beforDate);
    self.startTime.text = beforDate;
    
    [self loadIncomeDetailDataWithPage:_page pageNum:_pageNum];
}

- (IBAction)search:(id)sender {
    [_incomeArray removeAllObjects];
    [self.tableView.mj_header beginRefreshing];
    [self loadIncomeDetailDataWithPage:_page pageNum:_pageNum];
}

- (void)addRefresh{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_incomeArray.count > 0) {
            [_incomeArray removeAllObjects];
        }
        _page = 1;
        [weakSelf loadIncomeDetailDataWithPage:_page pageNum:_pageNum];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [weakSelf loadIncomeDetailDataWithPage:_page pageNum:_pageNum];
    }];
}

- (void)loadIncomeDetailDataWithPage:(NSInteger)page pageNum:(NSString*)pageNum{
    
    NSString *pageNow = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *para = @{
                           @"pageNum":pageNow,
                           @"pageOffset":pageNum,
                           @"starttime":self.startTime.text,
                           @"endtime":self.endTime.text,
                           @"memid":self.memId
                           };
    
    [[MyAPI sharedAPI] getDaLiStoreIncomeListsWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            if ([arrays[0] count] == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                });
                _page--;
            }
            [_incomeArray addObjectsFromArray:arrays[0]];
            [self.tableView reloadData];
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }
         [self endRefresh];
    } errorResult:^(NSError *enginerError) {
         [self endRefresh];
    }];

}

-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)creatUI{
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 65;
    self.tableView.backgroundColor = RGBACOLOR(235, 235, 235, 0.8);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"NewAccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"newAccountCellId"];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _incomeArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewAccountTableViewCell *levelCell = [tableView dequeueReusableCellWithIdentifier:@"newAccountCellId"];
    if (levelCell == nil) {
        levelCell = [[[NSBundle mainBundle] loadNibNamed:@"NewAccountTableViewCell" owner:self options:nil] lastObject];
    }
    
    if (_incomeArray.count > 0) {
        levelCell.shanghuModel = [_incomeArray objectAtIndex:indexPath.row];
    }
    levelCell.selectionStyle = 0;
    return levelCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShangHuIncomeModel *model = [_incomeArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"DLSdetailSegue" sender:model];
}

- (IBAction)back:(id)sender {
    [self backTolastPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"DLSdetailSegue"]) {
        ShangHuIncomeModel *model = (ShangHuIncomeModel*)sender;
        AccountDetailViewController *accDetailVC = segue.destinationViewController;
        accDetailVC.shanghuModel = model;
    }
}


@end
