//
//  MyAccountViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/19.
//  Copyright © 2016年 youyou. All rights reserved.
//
#import <MJRefresh/MJRefresh.h>
#import <Masonry.h>

#import "AccountDetailViewController.h"
#import "MyAccountViewController.h"
#import "HexColor.h"
#import "MyAccountTableViewCell.h"
#import "LevelTableViewCell.h"
#import "DetailCountHeadView.h"
#import "NewAccountTableViewCell.h"

#import "AccountModel.h"

@interface MyAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *levelArr;
    NSString *accountNum;
    
    NSString *pagess;
    
    NSInteger _page;
    NSString *pageNum;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyAccountViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    //self.navigationItem.titleView.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _page = 1;
    pageNum = @"10";
  
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        
    }];
    
    levelArr = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatUI];
    [self addRefresh];
    [self loadAccountDataWithPage:_page pageNum:pageNum];
  }

- (void)addRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (levelArr.count > 0) {
            [levelArr removeAllObjects];
        }
        _page = 1;
        [self loadAccountDataWithPage:_page pageNum:pageNum];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [self loadAccountDataWithPage:_page pageNum:pageNum];
    }];
}

-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)loadAccountDataWithPage:(NSInteger)page pageNum:(NSString*)pageNum{
    NSString *pageNow = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *dic = @{
                          @"pageNum":pageNow,
                          @"pageOffset":@"10"
                          };
    [[MyAPI sharedAPI] getMyAccountDataWithParameters:dic result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            
            if ([arrays[0] count] == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                });
                _page--;
            }
           
            [levelArr addObjectsFromArray:arrays[0]];
            
            accountNum = arrays[1];
            
         
            
            [self.tableView reloadData];
        }else{
            
            
            
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }
        
        
        
        [self endRefresh];
    } errorResult:^(NSError *enginerError) {
        [self endRefresh];
    }];
}

- (void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.allowsSelection = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyAccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"accountCelleId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewAccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"newAccountCellId"];
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
        return levelArr.count;
    }
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MyAccountTableViewCell *accountCell = [tableView dequeueReusableCellWithIdentifier:@"accountCelleId"];
        if (accountCell == nil) {
            accountCell = [[[NSBundle mainBundle] loadNibNamed:@"MyAccountTableViewCell" owner:self options:nil] lastObject];
        }
        accountCell.backBtnBlock =^{
            [self backTolastPage];
        };
        accountCell.moneyLab.text = [NSString stringWithFormat:@"%.2f",accountNum.floatValue];
        accountCell.explainLab.text = [NSString stringWithFormat:@"可提现金额%@元",accountNum];
        accountCell.selectionStyle = 0;
        return accountCell;
    }else{
    
            NewAccountTableViewCell *levelCell = [tableView dequeueReusableCellWithIdentifier:@"newAccountCellId"];
            if (levelCell == nil) {
                levelCell = [[[NSBundle mainBundle] loadNibNamed:@"NewAccountTableViewCell" owner:self options:nil] lastObject];
            }
        
        if (levelArr.count > 0) {
             levelCell.accountModel = [levelArr objectAtIndex:indexPath.row];
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
        return 150;
    }else{
        return 65;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0.01;
    }
}

/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat viewHeight = scrollView.frame.size.height + scrollView.contentInset.top;
    for (LevelTableViewCell *cell in [self.tableView visibleCells]) {
        CGFloat y = cell.center.y - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight / 2;
        CGFloat scale = cos(p / viewHeight * 1.5) * 0.9;
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            cell.contentView.transform = CGAffineTransformMakeScale(scale, scale);
        } completion:NULL];
    }
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        self.hidesBottomBarWhenPushed = YES;
        AccountModel *model = [levelArr objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"incomeDetailSegue" sender:model];
     }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if ([segue.identifier isEqualToString:@"incomeDetailSegue"]) {
        AccountModel *model = (AccountModel*)sender;
        AccountDetailViewController *accDetailVC = segue.destinationViewController;
        accDetailVC.model = model;
    }
}


@end
