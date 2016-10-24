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

@end

@implementation UnionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addCollectionViewAndTableView];
   
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
- (void)addCollectionViewAndTableView{
    //tableview
    self.contentTabelView.delegate = self;
    self.contentTabelView.dataSource = self;
//    [self.contentTabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewContentReuseId"];
    [self.contentTabelView registerNib:[UINib nibWithNibName:@"HotStoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"tableViewContentReuseId"];
    
    self.titleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-300) style:UITableViewStylePlain];
    self.titleTableView.delegate = self;
    self.titleTableView.dataSource = self;
    [self.titleTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewtitleReuseId"];
    
    //collectionview
    self.titleCollectionView.delegate = self;
    self.titleCollectionView.dataSource = self;
    [self.titleCollectionView registerNib:[UINib nibWithNibName:@"UnionTitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionReuseId"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(ScreenWidth/3, 50);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.titleCollectionView setCollectionViewLayout:flowLayout];
    
}
#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"collectionReuseId";
    UnionTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.CellIsSelected = NO;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UnionTitleCollectionViewCell *cell = (UnionTitleCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    BOOL isSelected = cell.CellIsSelected;
    cell.CellIsSelected = !isSelected;
    if (cell.CellIsSelected ) {
        [self.view addSubview:self.titleTableView];
     
    }else{
        [self.titleTableView removeFromSuperview];
    }
    
}
#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (tableView == self.contentTabelView) {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewContentReuseId" forIndexPath:indexPath];
//        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HotStoreTableViewCell" owner:self options:nil] lastObject];
        //}
        //cell.textLabel.text = @"111";
    }else if (tableView == self.titleTableView){
        cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewtitleReuseId" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewtitleReuseId"];
        }
        cell.textLabel.text = @"分类内容";
    }
 
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.contentTabelView) {
        return 125;
    }
    return 30;
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backTitleBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
