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
#import "AdDetailViewController.h"
#import "JPullDownMenu.h"
@interface UnionListViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource>
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
    [self loadData];
      dataSource = [NSMutableArray arrayWithArray:@[@"11",@"22",@"33",@"44",@"55",@"66",@"11",@"22",@"33",@"44",@"55",@"66"]];
    [self addNavBar];
    [self addCollectionViewAndTableView];
    //[self postNotification];
   
}
- (void)addNavBar{
    NSString *navTitle = @"联盟";
    // self.navigationController.navigationBar.barTintColor = RGBACOLOR(253, 87, 54, 1);
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = attributeDict;
    self.navigationItem.title = navTitle;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
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
#pragma mark - PrivateMethod
- (void)loadData{
  //市下辖区县
    [[MyAPI sharedAPI] unionShopAreaWithParameters:@{@"cityCode":@""} result:^(BOOL success, NSString *msg, NSArray *arrays) {
        
    } errorResult:^(NSError *enginerError) {
        
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
    [self.contentTabelView registerNib:[UINib nibWithNibName:@"HotStoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"tableViewContentReuseId"];
    
    
    self.menu = [[JPullDownMenu alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 40) menuTitleArray:@[@"区域",@"分类",@"自定义"]];
    
    NSArray * regionArray =@[@"滨湖新区",@"包河区",@"经开区",@"庐阳区",@"高新区",@"不限"];
    NSArray *classTypeArray=@[@"水果",@"火锅",@"生鲜",@"小吃",@"糕点"];
    NSArray *sortRuleArray=@[@"距离",@"价格",@"评分",@"最新",@"最热"];
    
    self.menu.menuDataArray = [NSMutableArray arrayWithObjects:regionArray, classTypeArray , sortRuleArray, nil];
    
    [self.view addSubview:self.menu];
    
    __weak typeof(self) _self = self;
    [self.menu setHandleSelectDataBlock:^(NSString *selectTitle, NSUInteger selectIndex, NSUInteger selectButtonTag) {
        
    }];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"collectionReuseId";
    UnionTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell configTitleText:@"距离"];
    }else if (indexPath.row == 1){
        [cell configTitleText:@"折扣"];
    }else if (indexPath.row == 2){
        [cell configTitleText:@"评价"];
    }
    cell.indexPath = indexPath;
    cell.CellIsSelected = NO;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect frame = self.titleTableView.frame;
    frame.origin.x = ScreenWidth/3*(indexPath.row);
    self.titleTableView.frame = frame;
    UnionTitleCollectionViewCell *cell = (UnionTitleCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    BOOL isSelected = cell.CellIsSelected;
    cell.CellIsSelected = !isSelected;
    if (indexPath.row == 0) {
        [dataSource removeAllObjects];
        dataSource = [NSMutableArray arrayWithArray:@[@"由近到远",@"由远到近"]];
        [self.titleTableView reloadData];
    }
    if (indexPath.row == 1) {
        [dataSource removeAllObjects];
        dataSource = [NSMutableArray arrayWithArray:@[@"由高到低",@"由低到高"]];
        [self.titleTableView reloadData];
    }
    if (indexPath.row == 2) {
        [dataSource removeAllObjects];
        dataSource = [NSMutableArray arrayWithArray:@[@"由高到低",@"由低到高"]];
        [self.titleTableView reloadData];
    }
    if (cell.CellIsSelected ) {
        [self.view addSubview:self.titleTableView];
        [self postNotificationWithIndexpath:indexPath];
    }else{
        [self.titleTableView removeFromSuperview];
    }
    
}
#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (tableView == self.contentTabelView) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HotStoreTableViewCell" owner:self options:nil] lastObject];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;

    }
 
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.contentTabelView) {
        return 125;
    }
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.titleTableView) {
        
        
    }else if (tableView == self.contentTabelView){
        UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Hompage" bundle:nil];
        AdDetailViewController *adVC = [storybord instantiateViewControllerWithIdentifier:@"detail"];
        [self.navigationController pushViewController:adVC animated:YES];
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
