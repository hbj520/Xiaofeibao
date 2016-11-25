//
//  EvaluateViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 11/24/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "EvaluateViewController.h"
#import "PreEvaluateTableViewCell.h"
#import "ZanTableViewCell.h"
#import "starView.h"

@interface EvaluateViewController ()
<UITableViewDelegate,
UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBtn:(id)sender;
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
    [self.tableView registerNib:[UINib nibWithNibName:@"ZanTableViewCell" bundle:nil] forCellReuseIdentifier:ZanReuseId];
    _cellHeight = 120;
    
}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        PreEvaluateTableViewCell *PreCell = [tableView dequeueReusableCellWithIdentifier:PreEvaluteReuseId forIndexPath:indexPath];
        // [cell.evaluateStarView configWithStarLevel:0];
        PreCell.clickStarBlock = ^(int starLevels){
            _cellHeight = 200;
            [PreCell.evaluateStarView configWithStarLevel:starLevels];
            PreCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self.tableView reloadData];
            
        };
        return PreCell;
    }else{
        ZanTableViewCell *zanCell = [tableView dequeueReusableCellWithIdentifier:ZanReuseId forIndexPath:indexPath];
        zanCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return zanCell;
    }

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return _cellHeight;
    }
    return 45.;
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
