//
//  MyRecommendViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 17/4/13.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "MyRecommendViewController.h"
#import "RecommendTableViewCell.h"

@interface MyRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *allbenifitLabel;
@property (weak, nonatomic) IBOutlet UILabel *invitemenLabel;
@property (weak, nonatomic) IBOutlet UITableView *benifitTableView;
@property (weak, nonatomic) IBOutlet UILabel *checkrulesLabel;
- (IBAction)backBtn:(id)sender;

@end

@implementation MyRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -PrivateMethod
- (void)configTableView{
    self.benifitTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.benifitTableView.frame = CGRectMake(0, 97, ScreenWidth, ScreenHeight - 480);
    self.benifitTableView.delegate = self;
    self.benifitTableView.dataSource = self;
    [self.benifitTableView registerNib:[UINib nibWithNibName:@"RecommendTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RecommendReuseId];
}
- (IBAction)weixinChatBtn:(id)sender {
}
- (IBAction)weixinCircleBtn:(id)sender {
}
- (IBAction)facetofaceBtn:(id)sender {
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendTableViewCell *recommendCell = [tableView dequeueReusableCellWithIdentifier:RecommendReuseId forIndexPath:indexPath];
    return recommendCell;
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
