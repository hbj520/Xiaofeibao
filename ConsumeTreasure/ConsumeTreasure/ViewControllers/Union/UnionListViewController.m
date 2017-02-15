//
//  UnionListViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 10/20/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "UnionListViewController.h"
#import "UnionTitleCollectionViewCell.h"
#import "HotStoreTableViewCell.h"
#import "TuiJianTableViewCell.h"
#import "TuiJianModel.h"
#import "AdDetailViewController.h"
#import "StoreDeatilViewController.h"

#import "JPullDownMenu.h"
#import "AppDelegate.h"
#import "UnionContenModel.h"
#import "UnionCategoryModel.h"
#import "AreaModel.h"
#import <MJRefresh/MJRefresh.h>

#import "PYSearch.h"

@interface UnionListViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource>
{
    NSMutableArray * regionArray;
    NSMutableArray *classTypeArray;
    NSMutableArray *sortRuleArray;
    NSMutableArray *areaArray;
    NSMutableArray *cateArray;
    NSInteger page;
}
- (IBAction)backBtn:(id)sender;
- (IBAction)backTitleBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backTitleBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *titleCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *contentTabelView;
@property (nonatomic, strong) UITableView *titleTableView;
@property (nonatomic, strong) JPullDownMenu *menu;

@end

@implementation UnionListViewController
{
    NSMutableArray *dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 1;
    [self loadData];
    
    [self addNavBar];
    [self addCollectionViewAndTableView];
    [self addMJRefresh];
    //[self postNotification];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)search:(id)sender {
    
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:nil searchBarPlaceholder:@"搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始(点击)搜索时执行以下代码
        // 如：跳转到指定控制器
        //  [searchViewController.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
      /*
        UIViewController* vc = [[UIViewController alloc]init];
        vc.view.backgroundColor = [UIColor redColor];
        
        [searchViewController addChildViewController:vc];
        */
    }];
    
    self.hidesBottomBarWhenPushed = YES;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:YES completion:nil];
    //[self performSegueWithIdentifier:@"searchSegue" sender:nil];
    self.hidesBottomBarWhenPushed = NO;
    // 设置搜索模式为内嵌
    searchViewController.searchResultShowMode = PYSearchResultShowModeEmbed;
    // 隐藏搜索建议
    searchViewController.searchSuggestionHidden = NO;
    
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
    
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleARCBorderTag;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - PrivateMethod
- (void)addMJRefresh{
    __weak typeof(self) weakSelf = self;
    self.contentTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (dataSource.count > 0 ) {
            [dataSource removeAllObjects];
        }
        page = 1;

        [weakSelf loadData];
    }];
    self.contentTabelView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [weakSelf searchShopListWithSorting:@"" shopDistrictId:@"" categoryId:@"" latitude:ApplicationDelegate.latitude longitude:ApplicationDelegate.longitude pageNum:[NSString stringWithFormat:@"%ld",page] pageOffset:@"10" isfristTime:YES];
    }];
}
- (void)addNavBar{
    NSString *navTitle = @"联盟";
    // self.navigationController.navigationBar.barTintColor = RGBACOLOR(253, 87, 54, 1);
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = attributeDict;
    self.navigationItem.title = navTitle;
}
- (void)addTopMenu{
    self.menu = [[JPullDownMenu alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 40) menuTitleArray:@[@"区域",@"分类",@"筛选"]];
    
    //     regionArray =@[@"滨湖新区",@"包河区",@"经开区",@"庐阳区",@"高新区",@"不限"];
    //    classTypeArray=@[@"水果",@"火锅",@"生鲜",@"小吃",@"糕点"];
    sortRuleArray=@[@"距离",@"评分",@"最新",@"最热"];
    
    self.menu.menuDataArray = [NSMutableArray arrayWithObjects:areaArray, cateArray , sortRuleArray, nil];

    [self.view addSubview:self.menu];
    
    __weak typeof(self) weakSelf = self;
    [self.menu setHandleSelectDataBlock:^(NSString *selectTitle, NSUInteger selectIndex, NSUInteger selectButtonTag) {
        page = 0;
        if (selectButtonTag == 0) {
       AreaModel *areaModel =    regionArray[selectIndex];
            [weakSelf searchShopListWithSorting:@"" shopDistrictId:areaModel.districtId categoryId:@"" latitude:ApplicationDelegate.latitude longitude:ApplicationDelegate.longitude pageNum:@"1" pageOffset:@"10" isfristTime:NO];
        }else if (selectButtonTag == 1){
            UnionCategoryModel *cateModel = classTypeArray[selectIndex];
            [weakSelf searchShopListWithSorting:@"" shopDistrictId:@"" categoryId:cateModel.categoryId latitude:ApplicationDelegate.latitude longitude:ApplicationDelegate.longitude pageNum:@"1" pageOffset:@"10" isfristTime:NO];
        }else if (selectButtonTag == 2){
            [weakSelf searchShopListWithSorting:[NSString stringWithFormat:@"%ld",selectIndex] shopDistrictId:@"" categoryId:@"" latitude:ApplicationDelegate.latitude longitude:ApplicationDelegate.longitude pageNum:@"1" pageOffset:@"10" isfristTime:NO];
        }
    }];
    
    
}
- (void)loadData{
  //市下辖区县
    [[MyAPI sharedAPI] unionShopAreaWithParameters:@{@"cityCode":ApplicationDelegate.cityCode} result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            regionArray = [NSMutableArray arrayWithArray:arrays];
            areaArray = [NSMutableArray array];
            for (AreaModel *areaModel in regionArray) {
                [areaArray addObject:areaModel.name];
            }
            //[self.menu.menuDataArray addObject:areaArray];
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }
    
    } errorResult:^(NSError *enginerError) {
        [self showHint:@"城市县区出错"];
    }];
    //分类
    [[MyAPI sharedAPI] unionCategoryListWithParameters:@{} result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            classTypeArray = [NSMutableArray arrayWithArray:arrays];
            cateArray = [NSMutableArray array];
            for (UnionCategoryModel *cateModel in classTypeArray) {
                [cateArray addObject:cateModel.name];
            }
           // [self.menu.menuDataArray addObject:cateArray];
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }
        
    } errorResult:^(NSError *enginerError) {
        [self showHint:@"分类出错"];
    }];
    //商家列表
    [self searchShopListWithSorting:@"" shopDistrictId:@"" categoryId:@"" latitude:ApplicationDelegate.latitude longitude:ApplicationDelegate.longitude pageNum:[NSString stringWithFormat:@"%ld",page] pageOffset:@"10" isfristTime:YES];
}
//查询商家列表
- (void)searchShopListWithSorting:(NSString *)sorting
                   shopDistrictId:(NSString *)shopDistrictId
                       categoryId:(NSString *)categoryId
                         latitude:(NSString *)latitude
                        longitude:(NSString *)longitude
                          pageNum:(NSString *)pageNum
                       pageOffset:(NSString *)pageOffset
                      isfristTime:(BOOL)isfirstTime{
    [[MyAPI sharedAPI] unionShopSearchWithParameters:@{
                                                      @"sorting":sorting,
                                                      @"shopDistrictId":shopDistrictId,
                                                      @"categoryId":categoryId,
                                                      @"latitude":latitude,
                                                      @"longitude":longitude,
                                                      @"pageNum":pageNum,
                                                      @"pageOffest":pageOffset
                                                      } result:^(BOOL success, NSString *msg, NSArray *arrays) {
                                                          if (success) {
                                                              if (arrays.count == 0) {
                                                                  [self.contentTabelView.mj_footer endRefreshingWithNoMoreData];

                                                              }else{
                                                                  [self.contentTabelView.mj_footer endRefreshing];

                                                              }
                                                              if (page > 1) {
                                                                  
                                                                  [dataSource addObjectsFromArray:arrays];
                                                              }else{
                                                              dataSource = [NSMutableArray arrayWithArray:arrays];
                                                              }

                                                              if (isfirstTime) {
                                                                  [self addTopMenu];
                                                              }
                                                              [self.contentTabelView reloadData];
                                                          }else{
                                                              if ([msg isEqualToString:@"-1"]) {
                                                                  [self logout];
                                                              }
                                                          }
                                                          [self.contentTabelView.mj_header endRefreshing];
                                                          
                                                      } errorResult:^(NSError *enginerError) {
                                                          [self.contentTabelView.mj_header endRefreshing];
 
                                                          
                                                      }];
}
- (void)postNotificationWithIndexpath:(NSIndexPath *)indexPath{
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification postNotificationName:@"arrowNotification" object:nil userInfo:@{@"indexpath":indexPath}];
}
- (void)addCollectionViewAndTableView{
    //tableview
    self.contentTabelView.delegate = self;
    self.contentTabelView.dataSource = self;
    [self.contentTabelView registerNib:[UINib nibWithNibName:@"TuiJianTableViewCell" bundle:nil] forCellReuseIdentifier:tableViewContentReuseId];
    
    
   
//    self.titleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth/3, 100) style:UITableViewStylePlain];
//    self.titleTableView.delegate = self;
//    self.titleTableView.dataSource = self;
//    [self.titleTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewtitleReuseId"];
    //collectionview
//    self.titleCollectionView.delegate = self;
//    self.titleCollectionView.dataSource = self;
//    [self.titleCollectionView registerNib:[UINib nibWithNibName:@"UnionTitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionReuseId"];
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.minimumLineSpacing = 0;
//    flowLayout.minimumInteritemSpacing = 0;
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    flowLayout.itemSize = CGSizeMake(ScreenWidth/3, 50);
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    [self.titleCollectionView setCollectionViewLayout:flowLayout];
    
}
#pragma mark - UICollectionViewDelegate

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 3;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *reuseId = @"collectionReuseId";
//    UnionTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
//    if (indexPath.row == 0) {
//        [cell configTitleText:@"距离"];
//    }else if (indexPath.row == 1){
//        [cell configTitleText:@"折扣"];
//    }else if (indexPath.row == 2){
//        [cell configTitleText:@"评价"];
//    }
//    cell.indexPath = indexPath;
//    cell.CellIsSelected = NO;
//    return cell;
//}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGRect frame = self.titleTableView.frame;
//    frame.origin.x = ScreenWidth/3*(indexPath.row);
//    self.titleTableView.frame = frame;
//    UnionTitleCollectionViewCell *cell = (UnionTitleCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    BOOL isSelected = cell.CellIsSelected;
//    cell.CellIsSelected = !isSelected;
//    if (indexPath.row == 0) {
//        [dataSource removeAllObjects];
//        dataSource = [NSMutableArray arrayWithArray:@[@"由近到远",@"由远到近"]];
//        [self.titleTableView reloadData];
//    }
//    if (indexPath.row == 1) {
//        [dataSource removeAllObjects];
//        dataSource = [NSMutableArray arrayWithArray:@[@"由高到低",@"由低到高"]];
//        [self.titleTableView reloadData];
//    }
//    if (indexPath.row == 2) {
//        [dataSource removeAllObjects];
//        dataSource = [NSMutableArray arrayWithArray:@[@"由高到低",@"由低到高"]];
//        [self.titleTableView reloadData];
//    }
//    if (cell.CellIsSelected ) {
//        [self.view addSubview:self.titleTableView];
//        [self postNotificationWithIndexpath:indexPath];
//    }else{
//        [self.titleTableView removeFromSuperview];
//    }
//    
//}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TuiJianTableViewCell *cell;
    if (cell == nil) {
          cell = [[[NSBundle mainBundle] loadNibNamed:@"TuiJianTableViewCell" owner:self options:nil] lastObject];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:tableViewContentReuseId forIndexPath:indexPath];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UnionContenModel *model = [dataSource objectAtIndex:indexPath.row];
        [cell configWithData:model];
        return cell;

 
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.contentTabelView) {
        return 125;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.titleTableView) {
        
        
    }else if (tableView == self.contentTabelView){
        UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Hompage" bundle:nil];
        StoreDeatilViewController *deatilVC = [storybord instantiateViewControllerWithIdentifier:@"detailSB"];
        deatilVC.StoreModel = [dataSource objectAtIndex:indexPath.row];
        //self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:deatilVC animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.contentTabelView)
    {
        CGFloat sectionHeaderHeight = 10.; //sectionHeaderHeight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
- (IBAction)backBtn:(id)sender {
    self.tabBarController.selectedIndex = 0;
  //  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backTitleBtn:(id)sender {
    self.tabBarController.selectedIndex = 0;
  //  [self.navigationController popViewControllerAnimated:YES];
}
@end
