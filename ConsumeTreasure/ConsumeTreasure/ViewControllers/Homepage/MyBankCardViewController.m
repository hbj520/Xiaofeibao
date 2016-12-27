//
//  MyBankCardViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/27.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyBankCardViewController.h"


#import "BankCardTableViewCell.h"

@interface MyBankCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self creatUI];
}

- (void)creatUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BankCardTableViewCell" bundle:nil] forCellReuseIdentifier:@"bankCardCelId"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BankCardTableViewCell *bankCell = [tableView dequeueReusableCellWithIdentifier:@"bankCardCelId"];
    if (bankCell == nil) {
        bankCell = [[[NSBundle mainBundle] loadNibNamed:@"BankCardTableViewCell" owner:self options:nil] lastObject];
    }
    
//    if (_memArray.count > 0) {
//        memCell.memModel = [_memArray objectAtIndex:indexPath.row];
//    }
    bankCell.selectionStyle = 0;
    
    return bankCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 95;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self backTolastPage];
}

- (IBAction)addBank:(id)sender {
    [self performSegueWithIdentifier:@"addBankSegue" sender:nil];
    
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
