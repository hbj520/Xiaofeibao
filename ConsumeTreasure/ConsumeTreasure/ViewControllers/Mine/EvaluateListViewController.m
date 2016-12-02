//
//  EvaluateListViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 11/22/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "EvaluateListViewController.h"
#import "EvaluateTableViewCell.h"
@interface EvaluateListViewController ()
<UITableViewDelegate,
UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EvaluateListViewController
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self configTableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    for (UIView *sbView in self.navigationController.navigationBar.subviews) {
        if (sbView.subviews.count > 0) {
            if ([sbView.subviews[0] isKindOfClass:[UILabel class]]) {
                [sbView removeFromSuperview];
            }
        }

        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -PrivateMethod
- (void)loadData{
    [[MyAPI sharedAPI] NoEvalueteListWithPara:@{@"pageNum":@"1",
                                                @"pageOffset":@"1"} result:^(BOOL success, NSString *msg, NSArray *arrays) {
                                                    
                                                } errorResult:^(NSError *enginerError) {
                                                    
                                                }];
}
- (void)configTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"EvaluateTableViewCell" bundle:nil] forCellReuseIdentifier:EvaluateReuseId];
}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EvaluateReuseId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.clickEvaluateBlock = ^(){
        [self performSegueWithIdentifier:@"evaluaSegue" sender:nil];
    };
    cell.clickOneMoreBlock = ^(){
      
        
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
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
