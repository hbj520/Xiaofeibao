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
{
    NSMutableArray *_cardList;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyBankCardViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    _cardList = [NSMutableArray array];
    
    [self creatUI];
    [self loadData];
}

- (void)loadData{
    NSDictionary *para = @{
                           
                           };
    [[MyAPI sharedAPI] getMyBankCardDataWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        [_cardList removeAllObjects];
        _cardList = arrays[0];
        [self.tableView reloadData];
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (void)creatUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BankCardTableViewCell" bundle:nil] forCellReuseIdentifier:@"bankCardCelId"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cardList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BankCardTableViewCell *bankCell = [tableView dequeueReusableCellWithIdentifier:@"bankCardCelId"];
    if (bankCell == nil) {
        bankCell = [[[NSBundle mainBundle] loadNibNamed:@"BankCardTableViewCell" owner:self options:nil] lastObject];
    }
    
    if (_cardList.count > 0) {
        bankCell.bankModel = [_cardList objectAtIndex:indexPath.row];
    }
    
    bankCell.deleteBlock =^(){
        
        [self deleteBankInfoWithIndex:indexPath.row];
    };
    
    bankCell.selectionStyle = 0;
    
    return bankCell;
    
}


- (void)deleteBankInfoWithIndex:(NSInteger)index{
    
    bankCardModel *model = [_cardList objectAtIndex:index];
   // UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndex:index]];
    NSDictionary *para = @{
                           @"id":model.bank_id
                           };
    [[MyAPI sharedAPI] deleteBankInfoWithParameters:para result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            [_cardList removeObject:[_cardList objectAtIndex:index]];
            //[self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];

            [self.tableView reloadData];
            
        }else{
            [self showHint:msg];
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.type isEqualToString:@"1"]) {
        
        bankCardModel *model = [_cardList objectAtIndex:indexPath.row];
        
        if (self.bankBlock) {
            self.bankBlock(model);
        }
    
        [self backTolastPage];
        
    }
    
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
