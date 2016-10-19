//
//  IncomeViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "IncomeViewController.h"

#import "IncomeContentTableViewCell.h"
#import "SYQMoneyTableViewCell.h"
#import "chartTableViewCell.h"
#import "BeforeChartTableViewCell.h"

@interface IncomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger a;
    float b;
    float c;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation IncomeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    self.navigationController.navigationBarHidden = NO;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = RGBACOLOR(255, 87, 59, 1);
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatUI];
    
    
}

- (void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = RGBACOLOR(231, 232, 233, 1);
    [self.tableView registerNib:[UINib nibWithNibName:@"IncomeContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"contentCellId"];
     [self.tableView registerNib:[UINib nibWithNibName:@"SYQMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:@"countCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"chartTableViewCell" bundle:nil] forCellReuseIdentifier:@"chartCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BeforeChartTableViewCell" bundle:nil] forCellReuseIdentifier:@"beforeChartCellId"];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return 2;
    
    }else{
        return 1;
    }
}

//重置价格
- (void)resetCount{
    SYQMoneyTableViewCell *countCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    countCell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)a];
   // b = [countCell.moneyLabel.text integerValue];
    c = a * b;
    countCell.moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",c];
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        SYQMoneyTableViewCell *countCell = [tableView dequeueReusableCellWithIdentifier:@"countCellId"];
        if (countCell == nil) {
            countCell = [[[NSBundle mainBundle] loadNibNamed:@"SYQMoneyTableViewCell" owner:self options:nil] lastObject];
        }
        countCell.moneyLabel.text = @"500000.00";
        countCell.numLabel.text = @"1";
        b = [countCell.moneyLabel.text floatValue];
        a = [countCell.numLabel.text integerValue];
        countCell.reduceBlock =^{
            if (a <2) {
                return ;
            }else{
                a --;
            }
            [self resetCount];
        };
        countCell.plusBlock =^{
            a = a + 1;
            [self resetCount];
        };
        
        countCell.sureBlock =^{
          
            NSLog(@"申请购买");
        };
        
        
        
        countCell.selectionStyle = 0;
        return countCell;
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            BeforeChartTableViewCell *bforeChartCell = [tableView dequeueReusableCellWithIdentifier:@"beforeChartCellId"];
            if (bforeChartCell == nil) {
                bforeChartCell = [[[NSBundle mainBundle] loadNibNamed:@"BeforeChartTableViewCell" owner:self options:nil] lastObject];
            }
            bforeChartCell.selectionStyle = 0;
            bforeChartCell.conlabel.hidden = YES;
            bforeChartCell.arrowImage.hidden = YES;
            return bforeChartCell;
            
        }else{
            chartTableViewCell *chartCell = [tableView dequeueReusableCellWithIdentifier:@"chartCellId"];
            if (chartCell == nil) {
                chartCell = [[[NSBundle mainBundle] loadNibNamed:@"chartTableViewCell" owner:self options:nil] lastObject];
            }
            chartCell.selectionStyle = 0;
            return chartCell;
            
        }
    }else{
        IncomeContentTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"contentCellId"];
        if (contentCell == nil) {
            contentCell = [[[NSBundle mainBundle] loadNibNamed:@"IncomeContentTableViewCell" owner:self options:nil] lastObject];
        }

        contentCell.selectionStyle = 0;
        return contentCell;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head1 = [[UIView alloc]init];
    head1.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    return head1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 107;
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            return 47;
        }else{
            return 240;
        }
    }else{
        return UITableViewAutomaticDimension;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
