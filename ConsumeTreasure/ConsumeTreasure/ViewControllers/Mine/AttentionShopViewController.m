//
//  AttentionShopViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 16/12/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AttentionShopViewController.h"
#import "AttentionShopTableViewCell.h"
@interface AttentionShopViewController ()
<UITableViewDelegate,
UITableViewDataSource>
{
    NSMutableArray *dataSource;
}
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AttentionShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    [self loadData];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PrivateMethod
- (void)configTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"AttentionShopTableViewCell" bundle:nil] forCellReuseIdentifier:AttentionReusedId];
}
- (void)loadData{
    
    [[MyAPI sharedAPI] attentionShopWithParameters:@{ @"pageNum":@"1",
                                                      @"pageOffset":@"10"} result:^(BOOL success, NSString *msg, NSArray *arrays) {
                                                          if (success) {
                                                              dataSource = [NSMutableArray arrayWithArray:arrays];
                                                              [self.tableView reloadData];
                                                          }else{
                                                              if ([msg isEqualToString:@"-1"]) {
                                                                  [self logout];
                                                              }
                                                          }
                                                      } errorResult:^(NSError *enginerError) {
                                                          
                                                      }];
}
#pragma mark - UITableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttentionShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AttentionReusedId forIndexPath:indexPath];
    return cell;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125.;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
