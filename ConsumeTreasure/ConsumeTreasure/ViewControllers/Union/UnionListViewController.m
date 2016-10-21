//
//  UnionListViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 10/20/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "UnionListViewController.h"

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
    self.contentTabelView.delegate = self;
    self.contentTabelView.dataSource = self;
    
    self.titleCollectionView.delegate = self;
    self.titleCollectionView.dataSource = self;
    
    
}
#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}











#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backTitleBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
