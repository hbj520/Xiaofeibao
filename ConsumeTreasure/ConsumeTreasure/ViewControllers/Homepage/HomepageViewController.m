//
//  HomepageViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 9/28/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#import "HomepageViewController.h"

#import "HomePageFirstTableViewCell.h"
#import "chartTableViewCell.h"
#import "BeforeChartTableViewCell.h"
#import "ImageTableViewCell.h"
#import "HotStoreTableViewCell.h"
#import "HomeListHeadView.h"

#import "TRLiveNetManager.h"

@interface HomepageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int _oldY;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (weak, nonatomic) IBOutlet UILabel *locationCityName;

@end

@implementation HomepageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [TRLiveNetManager testNetLoadWithCompletionHandler:^(id model, NSError *error) {
        
    }];
    
    [self addNavBar];
    
    
    [self creatUI];
}

- (void)creatUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomePageFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"chartTableViewCell" bundle:nil] forCellReuseIdentifier:@"chartCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BeforeChartTableViewCell" bundle:nil] forCellReuseIdentifier:@"beforeChartCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"chartImageCellId"];
     [self.tableView registerNib:[UINib nibWithNibName:@"HotStoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"hotStoreCellId"];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual: self.tableView]) {
        if (self.tableView.contentOffset.y > _oldY) {
            // 上滑
            //NSLog(@"偏移量%f",self.tableView.contentOffset.y);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"hideWay" object:self userInfo:nil];
        }
        else{
            // 下滑
            //NSLog(@"偏移量%f",self.tableView.contentOffset.y);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"showWay" object:self userInfo:nil];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 获取开始拖拽时tableview偏移量
    _oldY = self.tableView.contentOffset.y;

}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else{
        return 10;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        HomePageFirstTableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:@"FirstHomeCell"];
        if (firstCell == nil) {
            firstCell = [[[NSBundle mainBundle] loadNibNamed:@"HomePageFirstTableViewCell" owner:self options:nil] lastObject];
        }
        firstCell.selectionStyle = 0;
        
        //扫一扫
        firstCell.scanBlock =^{
          
            [self performSegueWithIdentifier:@"scanSegue" sender:nil];
        };
        
        
        return firstCell;

    }else if (indexPath.section == 1){//第二个section
        
        if (indexPath.row == 1) {//折线图
            chartTableViewCell *chartCell = [tableView dequeueReusableCellWithIdentifier:@"chartCellId"];
            if (chartCell == nil) {
                chartCell = [[[NSBundle mainBundle] loadNibNamed:@"chartTableViewCell" owner:self options:nil] lastObject];
            }
            chartCell.selectionStyle = 0;
            return chartCell;
        }else if (indexPath.row == 0){
            BeforeChartTableViewCell *bforeChartCell = [tableView dequeueReusableCellWithIdentifier:@"beforeChartCellId"];
            if (bforeChartCell == nil) {
                bforeChartCell = [[[NSBundle mainBundle] loadNibNamed:@"BeforeChartTableViewCell" owner:self options:nil] lastObject];
            }
            bforeChartCell.selectionStyle = 0;
            return bforeChartCell;
        }
        else{
            ImageTableViewCell *imageChartCell = [tableView dequeueReusableCellWithIdentifier:@"chartImageCellId"];
            if (imageChartCell == nil) {
                imageChartCell = [[[NSBundle mainBundle] loadNibNamed:@"ImageTableViewCell" owner:self options:nil] lastObject];
            }
            imageChartCell.selectionStyle = 0;
            return imageChartCell;
        }
    }else{
        HotStoreTableViewCell *hotCell = [tableView dequeueReusableCellWithIdentifier:@"hotStoreCellId"];
        if (hotCell == nil) {
            hotCell = [[[NSBundle mainBundle] loadNibNamed:@"HotStoreTableViewCell" owner:self options:nil] lastObject];
        }
        hotCell.selectionStyle = 0;
        return hotCell;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return 170;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            return 230;
        }else if (indexPath.row == 0){
            return 40;
        }else{
            return 80;
        }
    }
    else{
        return 125;
    }
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *head1 = [[UIView alloc]init];
        head1.backgroundColor = RGBACOLOR(234, 235, 236, 1);
        return head1;
    }else if (section == 2){
        HomeListHeadView *HotHeadView = [[[NSBundle mainBundle]loadNibNamed:@"HomeListHeadView" owner:self options:nil]lastObject];
      
        HotHeadView.backgroundView = [[UIImageView alloc]init];
        HotHeadView.backgroundView.backgroundColor = [UIColor whiteColor];

        
        return HotHeadView;
    }
    else{
        /*
        UIView *head0 = [[UIView alloc]init];
        head0.backgroundColor = RGBACOLOR(240, 74, 52, 1);
        return head0;
         */
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
      
        return 0;
    }else if (section == 1 ){
        return 22;
    }else{
        return 41;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSLog(@"了解详情");
        }
    }else if (indexPath.section == 2){
        NSLog(@"%ld-----%ld",(long)indexPath.section,(long)indexPath.row);
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -PrivateMethod 
- (void)addNavBar{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAct:)];
    [self.locationView addGestureRecognizer:tapGes];
    
}
- (void)TapAct:(UIGestureRecognizer *)ges{
    
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
