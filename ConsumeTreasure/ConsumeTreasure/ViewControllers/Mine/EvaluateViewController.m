//
//  EvaluateViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 11/24/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "EvaluateViewController.h"
#import "PreEvaluateTableViewCell.h"
#import "starView.h"

@interface EvaluateViewController ()
<UITableViewDelegate,
UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) float cellHeight;
@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PrivateMethod
- (void)configTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"PreEvaluateTableViewCell" bundle:nil] forCellReuseIdentifier:PreEvaluteReuseId];
    _cellHeight = 120;
    
}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PreEvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PreEvaluteReuseId forIndexPath:indexPath];
   // [cell.evaluateStarView configWithStarLevel:0];
    cell.clickStarBlock = ^(int starLevels){
        _cellHeight = 200;
        [cell.evaluateStarView configWithStarLevel:starLevels];
        [self.tableView reloadData];
        
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellHeight;
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
