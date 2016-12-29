//
//  StoreControlViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/9.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StoreControlViewController.h"
#import "ImageViewController.h"
#import "TextViewController.h"
#import "MapLocateViewController.h"


#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "OrderControlTableViewCell.h"
#import "StoreControlTableViewCell.h"
#import "StoreConLabTableViewCell.h"
#import "DetailHeadView.h"

#import "DLPickerView.h"
@interface StoreControlViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *secOne;
    NSArray *secTwo;
    NSArray *secThr;
    
    NSArray *placeOne;
    NSArray *placeTwo;
    NSArray *placeThr;
    
    NSString *strAddr;//保存地址文本
    NSString *strDescri;//保存介绍文本
    
    NSString *yingyeImg;
    NSString *jingyingImg;
    NSString *IDFrontImg;
    NSString *IDBackImg;
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StoreControlViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;


    secOne = @[@"店铺名称",@"门面电话",@"真实姓名",@"身份证号"];
    secTwo = @[@"门面地址",@"定位地址",@"商家介绍",@"开始经营时间",@"结束经营时间",@"反币比例"];
    secThr = @[@"营业执照图片",@"经营许可证图片",@"身份证正面",@"身份证反面"];
    
    placeOne = @[@"智惠返",@"请填写正确的号码",@"XXX",@"xxxxxxxxxxxxxx"];
    placeTwo = @[@"具体位置",@"具体位置",@"商店详情",@"09:00 >",@"18:00 >",@"10%"];
    placeThr = @[@"已上传 >",@"待上传 >",@"已上传 >",@"已上传 >"];
    
    [self creatUI];
}

- (void)viewDidLayoutSubviews{
    DetailHeadView * headView = [[[NSBundle mainBundle]loadNibNamed:@"DetailHeadView" owner:self options:nil]lastObject];
    [headView.headerImage sd_setImageWithURL:[NSURL URLWithString:@"storeHead"] placeholderImage:[UIImage imageNamed:@"storeHead"]];
    headView.contentMode = UIViewContentModeScaleAspectFill;
    
    headView.frame = CGRectMake(0, 0, ScreenWidth, 170);
    self.tableView.tableHeaderView = headView;
}


- (void)creatUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 9;
    //self.tableView.backgroundColor = RGBACOLOR(235, 235, 235, 0.8);
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreControlTableViewCell" bundle:nil] forCellReuseIdentifier:@"storeConCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreConLabTableViewCell" bundle:nil] forCellReuseIdentifier:@"labelCellId"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 6;
    }else{
        return 4;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        StoreControlTableViewCell *storeConCell = [tableView dequeueReusableCellWithIdentifier:@"storeConCellId"];
        if (storeConCell == nil) {
            storeConCell = [[[NSBundle mainBundle] loadNibNamed:@"StoreControlTableViewCell" owner:self options:nil] lastObject];
        }
        storeConCell.selectionStyle = 0;
        
        storeConCell.storeNameLab.text = secOne[indexPath.row];
        storeConCell.placetextfield.placeholder = placeOne[indexPath.row];
        return storeConCell;
        
    }else{
        
        StoreConLabTableViewCell *labCell = [tableView dequeueReusableCellWithIdentifier:@"labelCellId"];
        if (labCell == nil) {
            labCell = [[[NSBundle mainBundle]loadNibNamed:@"StoreConLabTableViewCell" owner:self options:nil]lastObject];
        }
        
        labCell.selectionStyle = 0;
        
        if (indexPath.section == 1) {
            labCell.leftLab.text = secTwo[indexPath.row];
            labCell.detailLab.text = placeTwo[indexPath.row];
            if (indexPath.row == 3 ||indexPath.row == 4) {
              
                
                __weak typeof(labCell) weakCell  = labCell;
                labCell.pikerBlock =^{
                    DLPickerView *pickerView = [[DLPickerView alloc] initWithPlistName:@"Time" withSelectedItem:[weakCell.detailLab.text componentsSeparatedByString:@":"] withSelectedBlock:^(id  _Nonnull item) {
                        
                        weakCell.detailLab.text = [item componentsJoinedByString:@":"];
                        
                    }];
                    
                    [pickerView show];
                    
                };

            }else if (indexPath.row == 0){
                labCell.pikerBlock =^{
             
                    [self performSegueWithIdentifier:@"goWriteSegue" sender:@[@"门面地址",@"1"]];
                    
                };

                labCell.detailLab.text = strAddr;
                
            }else if (indexPath.row == 2){
                labCell.pikerBlock =^{
                    
                    [self performSegueWithIdentifier:@"goWriteSegue" sender:@[@"商家介绍",@"2"]];
                    
                };
                labCell.detailLab.text = strDescri;
            }
            
            else if (indexPath.row == 1){
                labCell.pikerBlock =^{
                    
                   [self performSegueWithIdentifier:@"goGetLocationSegue" sender:nil];
                    
                };
                
               
            }
            
        }else{
            labCell.btn.enabled = NO;
            labCell.leftLab.text = secThr[indexPath.row];
            labCell.detailLab.text = placeThr[indexPath.row];
            
            
            
            
        }
        
        return labCell;
    }
    
  
    /*
  
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 3 ||indexPath.row == 4) {
            storeConCell.hideBtn.enabled = YES;
            
            __weak typeof(storeConCell) weakCell  = storeConCell;
            storeConCell.pikerBlock =^{
                DLPickerView *pickerView = [[DLPickerView alloc] initWithPlistName:@"Time" withSelectedItem:[weakCell.placetextfield.text componentsSeparatedByString:@":"] withSelectedBlock:^(id  _Nonnull item) {
                    
                    weakCell.placetextfield.text = [item componentsJoinedByString:@":"];
                    
                }];
                
                [pickerView show];
                
            };
        }else if (indexPath.row == 1){
            storeConCell.hideBtn.enabled = YES;
           // __weak typeof(storeConCell) weakStoreCell = storeConCell;
            storeConCell.textBlock =^(){
                [self performSegueWithIdentifier:@"goWriteSegue" sender:@[@"带入",@"1"]];
                
            };
            storeConCell.placetextfield.text = strAddr;
            
        }else if (indexPath.row == 6){
            storeConCell.hideBtn.enabled = YES;
            // __weak typeof(storeConCell) weakStoreCell = storeConCell;
            
            storeConCell.textBlock =^(){
                [self performSegueWithIdentifier:@"goWriteSegue" sender:@[@"带入",@"2"]];
                
            };
            storeConCell.placetextfield.text = strDescri;

        }
        
        
        else if(indexPath.row == 2){
            
            
            storeConCell.hideBtn.enabled = YES;
            storeConCell.textBlock =^(){
                [self performSegueWithIdentifier:@"goGetLocationSegue" sender:nil];
                
            };
        }
        
        else{
            storeConCell.hideBtn.enabled = NO;
        }
        
        storeConCell.storeNameLab.text = secOne[indexPath.row];
        storeConCell.placetextfield.placeholder = placeOne[indexPath.row];
    }else if (indexPath.section == 1){
        storeConCell.storeNameLab.text = secTwo[indexPath.row];
        storeConCell.placetextfield.placeholder = placeTwo[indexPath.row];
    }else{
     
        storeConCell.storeNameLab.text = secThr[indexPath.row];
        storeConCell.placetextfield.placeholder = placeThr[indexPath.row];
    }

    return storeConCell;
     
     */
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 52;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
    UIView *grayView = [UIView new];
    grayView.backgroundColor = RGBACOLOR(235, 235, 235, 1);
    return grayView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            [self performSegueWithIdentifier:@"goChooseImageSegue" sender:@[@"营业执照",@"1"]];
        }else if (indexPath.row == 1) {
            [self performSegueWithIdentifier:@"goChooseImageSegue" sender:@[@"经营许可",@"2"]];
        }else if (indexPath.row == 2) {
            [self performSegueWithIdentifier:@"goChooseImageSegue" sender:@[@"身份正面",@"3"]];
        }else{
            [self performSegueWithIdentifier:@"goChooseImageSegue" sender:@[@"身份反面",@"4"]];
        }
        
        
    
    }
}


- (IBAction)back:(id)sender {
    [self backTolastPage];
}

- (IBAction)PostData:(id)sender {
    NSLog(@"保存数据");
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"goWriteSegue"]) {
        NSArray *strArr = (NSArray *)sender;
        TextViewController *teVC = segue.destinationViewController;
        teVC.arr = strArr;
        teVC.textBlock =^(NSString *str){
            
            if ([strArr[1] isEqualToString:@"1"]) {
                strAddr = str;
            }else{
                strDescri = str;
            }
            [self.tableView reloadData];
        };
    }else if ([segue.identifier isEqualToString:@"goChooseImageSegue"]){
        NSArray *imageArr = (NSArray *)sender;
        ImageViewController *imgVC = segue.destinationViewController;
        imgVC.imageArray = imageArr;
        imgVC.imgBlock =^(NSString *imageStr){
            if ([imageArr[1] isEqualToString:@"1"]) {
                yingyeImg = imageStr;
            }else if ([imageArr[1] isEqualToString:@"2"]){
                jingyingImg = imageStr;
            }else if ([imageArr[1] isEqualToString:@"3"]){
                IDFrontImg = imageStr;
            }else{
                IDBackImg = imageStr;
            }
        };
        
    }
    
    
    
}



@end
