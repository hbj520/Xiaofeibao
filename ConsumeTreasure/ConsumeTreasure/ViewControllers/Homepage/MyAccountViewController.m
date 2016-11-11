//
//  MyAccountViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyAccountViewController.h"
#import "HexColor.h"
#import "MyAccountTableViewCell.h"
#import "LevelTableViewCell.h"
#import "ExplainTableViewCell.h"
#import "SpreadTableViewCell.h"

@interface MyAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *levelArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyAccountViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    self.navigationController.navigationBarHidden = YES;
   // self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatUI];
  //  UIImageView * navBarHairlineImageView= [self findHairlineImageViewUnder:self.navigationController.navigationBar];
   // navBarHairlineImageView.hidden = YES;
   //self.navigationController.navigationBar.translucent = YES;
}

/*
- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    
        if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
                return(UIImageView*)view;
            }
        for(UIView*subview in view.subviews) {
                UIImageView*imageView = [self findHairlineImageViewUnder:subview];
                if(imageView) {
                       return imageView;
                }
    }
       return nil;
}

 */
 
- (void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyAccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"accountCelleId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LevelTableViewCell" bundle:nil] forCellReuseIdentifier:@"levelCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExplainTableViewCell" bundle:nil] forCellReuseIdentifier:@"explainCellId"];
      [self.tableView registerNib:[UINib nibWithNibName:@"SpreadTableViewCell" bundle:nil] forCellReuseIdentifier:@"tuiguangCelleId"];
    levelArr = @[@"一级",@"二级",@"三级",@"四至十级",@"我的上级"];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 6;
    }else{
        return 1;
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
    }else if (indexPath.section == 2){
        ExplainTableViewCell *explainCell = [tableView dequeueReusableCellWithIdentifier:@"explainCellId"];
        if (explainCell == nil) {
            explainCell = [[[NSBundle mainBundle] loadNibNamed:@"ExplainTableViewCell" owner:self options:nil] lastObject];
        }
        explainCell.selectionStyle = 0;
        return explainCell;
        
        
    }else{
        
        if (indexPath.row == 0) {
            SpreadTableViewCell *spreadCell = [tableView dequeueReusableCellWithIdentifier:@"tuiguangCelleId"];
            if (spreadCell == nil) {
                spreadCell = [[[NSBundle mainBundle] loadNibNamed:@"SpreadTableViewCell" owner:self options:nil] lastObject];
            }
            spreadCell.selectionStyle = 0;
            return spreadCell;
        }else{
            LevelTableViewCell *levelCell = [tableView dequeueReusableCellWithIdentifier:@"levelCellId"];
            if (levelCell == nil) {
                levelCell = [[[NSBundle mainBundle] loadNibNamed:@"LevelTableViewCell" owner:self options:nil] lastObject];
            }
            
            NSString *str = [levelArr objectAtIndex:indexPath.row-1];
            levelCell.levelLab.text = str;
            
            
            levelCell.selectionStyle = 0;
            return levelCell;
        }
        
       
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 226;
    }else if (indexPath.section == 2){
        return 68;
    }else{
        return 45;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        return 10;
    }else{
        return 100;
    }
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

@end
