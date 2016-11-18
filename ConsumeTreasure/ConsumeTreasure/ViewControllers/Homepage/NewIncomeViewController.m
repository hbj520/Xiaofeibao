//
//  NewIncomeViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "NewIncomeViewController.h"

#import "IncomeTableHead.h"
#import "MyIncoSectionView.h"
#import "DetailIncomeTableViewCell.h"

@interface NewIncomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NewIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self table];
}

- (void)table{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 70;
    self.tableView.sectionFooterHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailIncomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"labelCelleId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyIncoSectionView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"secHeadId"];
}

- (void)viewDidLayoutSubviews{
    IncomeTableHead * headView = [[[NSBundle mainBundle]loadNibNamed:@"IncomeTableHead" owner:self options:nil]lastObject];
    
    headView.contentMode = UIViewContentModeScaleAspectFill;
    
    headView.frame = CGRectMake(0, 0, ScreenWidth, 301);
    self.tableView.tableHeaderView = headView;
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MyIncoSectionView *headSec = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"secHeadId"];
    if (!headSec) {
        headSec = [[MyIncoSectionView alloc]initWithReuseIdentifier:@"secHeadId"];
    }
    
    
    
    
    return headSec;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        DetailIncomeTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"labelCelleId"];
        if (detailCell == nil) {
            detailCell = [[[NSBundle mainBundle] loadNibNamed:@"DetailIncomeTableViewCell" owner:self options:nil] lastObject];
        }
        detailCell.selectionStyle = 0;
        return detailCell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
