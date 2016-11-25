//
//  MyAccountViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/19.
//  Copyright © 2016年 youyou. All rights reserved.
//
#import <MJRefresh/MJRefresh.h>
#import <Masonry.h>

#import "MyAccountViewController.h"
#import "HexColor.h"
#import "MyAccountTableViewCell.h"
#import "LevelTableViewCell.h"
#import "DetailCountHeadView.h"


@interface MyAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *levelArr;
    NSString *accountNum;
    
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
  }

- (void)addRefresh{
    self.tableView.tableHeaderView = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadAccountDataWithPage:_page pageNum:pageNum];
    }];
    
    self.tableView.tableFooterView = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
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
                          @"pageOffset":pageNum
                          };
    [[MyAPI sharedAPI] getMyAccountDataWithParameters:dic result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            accountNum = arrays[1];
            [levelArr addObjectsFromArray:arrays[0]];
        }
        [self endRefresh];
    } errorResult:^(NSError *enginerError) {
        [self endRefresh];
    }];
}

- (void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsSelection = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyAccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"accountCelleId"];
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
        MyAccountTableViewCell *accountCell = [tableView dequeueReusableCellWithIdentifier:@"accountCelleId"];
        if (accountCell == nil) {
            accountCell = [[[NSBundle mainBundle] loadNibNamed:@"MyAccountTableViewCell" owner:self options:nil] lastObject];
        }
        accountCell.backBtnBlock =^{

            
            [self backTolastPage];
            
        };
        accountCell.selectionStyle = 0;
        return accountCell;
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
        return 226;
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
        [self performSegueWithIdentifier:@"incomeDetailSegue" sender:nil];
     }
    
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    // 输出点击的view的类名
//    NSLog(@"%@", NSStringFromClass([touch.view class]));
//    
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
//    return  YES;
//}
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
