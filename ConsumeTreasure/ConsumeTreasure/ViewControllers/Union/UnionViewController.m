//
//  UnionViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 9/28/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "UnionViewController.h"
#import "LianmenRightCollectionViewCell.h"
#define CollectionViewReuseId @"collectionReuseId"
#define TableViewReuseId @"unionReuseId"
@interface UnionViewController ()
<UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *rightCollectionView;

@end

@implementation UnionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavBar];
    [self configTableViewAndCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -PrivateMethod
- (void)configNavBar{
    NSString *navTitle = @"商家联盟";
    // self.navigationController.navigationBar.barTintColor = RGBACOLOR(253, 87, 54, 1);
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = attributeDict;
    self.navigationItem.title = navTitle;
}
- (void)configTableViewAndCollectionView{
    //tableView
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewReuseId];
    self.leftTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lianmenImageCell"]];
    
    //collectionview
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 25, 10, 25);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(85, 85);
    [self.rightCollectionView setCollectionViewLayout:flowLayout];
    [self.rightCollectionView registerNib:[UINib nibWithNibName:@"LianmenRightCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CollectionViewReuseId];
    self.rightCollectionView.delegate = self;
    self.rightCollectionView.dataSource = self;
    self.rightCollectionView.backgroundColor = [UIColor whiteColor];
    
}
#pragma mark - UITableVewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47.5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reusedId = TableViewReuseId;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedId forIndexPath:indexPath];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedId];
    }
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lianmenImageCell"]];
    cell.textLabel.text = @"滨湖新区";
    cell.textLabel.textColor = [UIColor darkGrayColor];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LianmenRightCollectionViewCell *cell = [self.rightCollectionView dequeueReusableCellWithReuseIdentifier:CollectionViewReuseId forIndexPath:indexPath];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
