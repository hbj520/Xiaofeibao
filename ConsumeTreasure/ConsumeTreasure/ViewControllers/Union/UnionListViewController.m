//
//  UnionListViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 10/20/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "UnionListViewController.h"
#import "CLMainSelectedView.h"

@interface UnionListViewController ()

@end

@implementation UnionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableView];
    
    CLMainSelectedView *mainView = [[[NSBundle mainBundle] loadNibNamed:@"CLMainSelectedView" owner:self options:nil]lastObject];
    mainView.backgroundColor = [UIColor greenColor];
    mainView.leftMenuSubViewHeight = 50;
    mainView.middleMenuSubViewHeight = 50;
    mainView.rightMenuSubViewHeight = 50;
    mainView.leftMenuArrray = @[@"热门",@"经典",@"儿童专区",@"成人专区"];
    mainView.middleMenuArray = @[@"定位",@"热门",@"上海",@"北京"];
    mainView.rightMenuArray = @[@"价格由低到高",@"价格由高到低",@"销量",@"好评"];
    mainView.frame = CGRectMake(0, 20, self.view.frame.size.width, 50);
    [self.view addSubview:mainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *const ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"123";
    return cell;
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
