//
//  MyIncomeViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/15.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyIncomeViewController.h"

#import "HexColor.h"
#import "MyIncomeTableViewCell.h"
#import "LevelTableViewCell.h"
#import "DetailCountHeadView.h"

@interface MyIncomeViewController ()<UITableViewDelegate,UITableViewDataSource>

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation MyIncomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatUI];
}



- (void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyIncomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"myIncomId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LevelTableViewCell" bundle:nil] forCellReuseIdentifier:@"levelCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SpreadTableViewCell" bundle:nil] forCellReuseIdentifier:@"tuiguangCelleId"];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 25;
    }
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MyIncomeTableViewCell *incomeCell = [tableView dequeueReusableCellWithIdentifier:@"myIncomId"];
        if (incomeCell == nil) {
            incomeCell = [[[NSBundle mainBundle] loadNibNamed:@"MyIncomeTableViewCell" owner:self options:nil] lastObject];
        }
        incomeCell.backBtnBlock =^{
            
            
            [self backTolastPage];
            
        };
        incomeCell.selectionStyle = 0;
        return incomeCell;
    }else{
        
        LevelTableViewCell *levelCell = [tableView dequeueReusableCellWithIdentifier:@"levelCellId"];
        if (levelCell == nil) {
            levelCell = [[[NSBundle mainBundle] loadNibNamed:@"LevelTableViewCell" owner:self options:nil] lastObject];
            
        }
        levelCell.selectionStyle = 0;
        return levelCell;
    }
    
}




- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        DetailCountHeadView *headView = [[[NSBundle mainBundle] loadNibNamed:@"DetailCountHeadView" owner:self options:nil]lastObject];
        return headView;
    }else{
        return [UIView new];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 45;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 258;
    }else{
        return 55;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0.01;
    }
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
