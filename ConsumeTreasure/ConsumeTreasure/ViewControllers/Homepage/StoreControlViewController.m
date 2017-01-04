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

#import "StoreMasterModel.h"

@interface StoreControlViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    DetailHeadView * headView;
    
    NSArray *secOne;
    NSArray *secTwo;
    NSArray *secThr;
    
    NSArray *placeOne;
    NSArray *placeTwo;
    NSArray *placeThr;
    
    //保存
    NSString *storeName;
    NSString *storePhone;
    NSString *realName;
    NSString *IDNum;
    
    NSString *strAddr;//保存地址文本
    NSString *latituedeStr;//纬度
    NSString *longtitudeStr;//经度
    NSString *strDescri;//保存介绍文本
    NSString *startTime;
    NSString *endTime;
    NSString *disCount;
    
    NSString *doorImg;//店铺首图
    NSString *yingyeImg;
    NSString *jingyingImg;
    NSString *IDFrontImg;
    NSString *IDBackImg;
    
    //*************************************
    NSString *doorImg2;//上传用图
    NSString *yingyeImg2;
    NSString *jingyingImg2;
    NSString *IDFrontImg2;
    NSString *IDBackImg2;
    
    
    //代替文字
    NSString *img1;
    NSString *img2;
    NSString *img3;
    NSString *img4;
    
    NSString *sTime;
    NSString *eTime;
    
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

    
    [self loadData];
  
    
    [self creatUI];
    
}

- (void)loadData{
    
    NSDictionary *para = @{
                           
                           };
    [[MyAPI sharedAPI] getStoreControlInfoDataWithParameters:para result:^(BOOL success, NSString *msg, id object) {
        if (success) {
            storeInfoModel *model = (storeInfoModel*)object;
            storeName = model.shopname;
            storePhone = model.shopPhone;
            realName = model.name;
            IDNum = model.idcardno;
            
            strAddr = model.addr;
            latituedeStr = model.latitude;
            longtitudeStr = model.longitude;
            strDescri = model.introduction;
            startTime = model.startbusinesstime;
            endTime = model.endbusinesstime;
            disCount = model.discount;
            
            yingyeImg = model.businessimg;
            jingyingImg = model.licenseimg;
            IDFrontImg = model.idcardnofrontimg;
            IDBackImg = model.idcardnobackimg;
            doorImg = model.doorimg;
            
            if (startTime.length > 0) {
                sTime = startTime;
            }else{
                sTime = @"9:00";
            }
            
            if (endTime.length > 0) {
                eTime = endTime;
            }else{
                eTime = @"18:00";
            }
            
            
            if (jingyingImg.length > 0) {
                img1 = @"已上传";
            }else{
                img1 = @"未上传";
            }
            if (yingyeImg.length > 0) {
                img2 = @"已上传";
            }else{
                img2 = @"未上传";
            }  if (IDFrontImg.length > 0) {
                img3 = @"已上传";
            }else{
                img3 = @"未上传";
            }  if (IDBackImg.length > 0) {
                img4 = @"已上传";
            }else{
                img4 = @"未上传";
            }

            secOne = @[@"店铺名称",@"门面电话",@"真实姓名",@"身份证号"];
            secTwo = @[@"门面地址",@"定位地址",@"商家介绍",@"开始经营时间",@"结束经营时间",@"反币比例"];
            secThr = @[@"营业执照图片",@"经营许可证图片",@"身份证正面",@"身份证反面"];
            
            placeOne = @[storeName,storePhone,realName,IDNum];
            placeTwo = @[strAddr,@"开始定位",strDescri,sTime,eTime,disCount];
            placeThr = @[img1,img2,img3,img4];
            
            [self head:doorImg];
          
            
            [self.tableView reloadData];
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
    

}

- (void)head:(NSString*)imgStr{
    headView = [[[NSBundle mainBundle]loadNibNamed:@"DetailHeadView" owner:self options:nil]lastObject];
    [headView.headerImage sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:DEFAULTHEADIMAGE]];
    headView.contentMode = UIViewContentModeScaleAspectFill;
    
    headView.imgBlock =^(){
        
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从照片库选取",nil];
        // action.tag = tagg;
        [action showInView:self.navigationController.view];
        
    };
    
    headView.frame = CGRectMake(0, 0, ScreenWidth, 170);
    self.tableView.tableHeaderView = headView;
}

- (void)viewDidLayoutSubviews{
 
}


#pragma mark - UIActionSheet delegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    __weak typeof(self) weakSelf = self;
    if (buttonIndex == 0) {
        [self openCamera];
        
    }else if (buttonIndex == 1){
        [self openPhoto];
        
    }
    __weak typeof(headView)weakHead = headView;
    self.imageBlock = ^(UIImage *image){
        [[MyAPI sharedAPI] postFilesWithFormData:@[image] result:^(BOOL success, NSString *msg, id object) {
            if (success) {
                weakHead.headerImage.image = image;
                doorImg = (NSString*)object;
            }else{
                if ([msg isEqualToString:@"-1"]) {
                    [weakSelf logout];
                }
                [weakSelf showHint:msg];
            }
        } errorResult:^(NSError *enginerError) {
            [weakSelf showHint:@"异常错误"];
        }];
        
    };
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

-(void)change:(UITextField*)textField{
    if (textField.tag == 8888) {
        storeName = textField.text;
    }else if (textField.tag == 7777){
        storePhone = textField.text;
    }else if (textField.tag == 6666){
        realName = textField.text;
    }else{
        IDNum = textField.text;
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
        storeConCell.placetextfield.text = placeOne[indexPath.row];
        
        
        storeConCell.placetextfield.delegate = self;
        [storeConCell.placetextfield addTarget:self action:@selector(change:) forControlEvents:UIControlEventEditingChanged];
        
        if (indexPath.row == 0) {
            storeConCell.placetextfield.tag = 8888;
        }else if(indexPath.row == 1){
            storeConCell.placetextfield.tag = 7777;
        }else if (indexPath.row == 2){
            storeConCell.placetextfield.tag = 6666;
        }else{
            storeConCell.placetextfield.tag = 5555;
        }
        
        
        
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
                        
                        if (indexPath.row == 3) {
                            sTime = [item componentsJoinedByString:@":"];
                        }else if (indexPath.row == 4){
                            eTime =  [item componentsJoinedByString:@":"];
                        }
                        
                        weakCell.detailLab.text = [item componentsJoinedByString:@":"];
                        
                    }];
                    
                    [pickerView show];
                    
                };

            }else if (indexPath.row == 0){
                labCell.pikerBlock =^{
             
                    [self performSegueWithIdentifier:@"goWriteSegue" sender:@[@"门面地址",@"1"]];
                    
                };

                labCell.detailLab.text = strAddr;
                
               // strAddr6 = labCell.detailLab.text;
                
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
            [self performSegueWithIdentifier:@"goChooseImageSegue" sender:@[yingyeImg,@"1"]];
        }else if (indexPath.row == 1) {
            [self performSegueWithIdentifier:@"goChooseImageSegue" sender:@[jingyingImg,@"2"]];
        }else if (indexPath.row == 2) {
            [self performSegueWithIdentifier:@"goChooseImageSegue" sender:@[IDFrontImg,@"3"]];
        }else{
            [self performSegueWithIdentifier:@"goChooseImageSegue" sender:@[IDBackImg,@"4"]];
        }
    }
}


- (IBAction)back:(id)sender {
    [self backTolastPage];
}

- (IBAction)PostData:(id)sender {
    NSLog(@"保存数据");
    
    
    
    NSDictionary *para = @{
                           @"type":@"2",
                           @"member":@{
                                   @"name":realName,
                                   @"idcardno":IDNum
                                   },
                           @"shop":@{
                                   @"addr":strAddr,
                                   @"shopPhone":storePhone,
                                   @"doorimg":doorImg,
                                   @"shopname":storeName,
                                   @"businessimg":yingyeImg,
                                   @"licenseimg":jingyingImg,
                                   @"idcardnofrontimg":IDFrontImg,
                                   @"idcardnobackimg":IDBackImg,
                                   @"latitude":latituedeStr,
                                   @"longitude":longtitudeStr,
                                   @"introduction":strDescri,
                                   @"endbusinesstime":eTime,
                                   @"startbusinesstime":sTime
                                   }
                           
                           };
    [[MyAPI sharedAPI] finishStoreInfoWithParameters:para resulet:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            
            [self showHint:@"上传成功"];
        }else{
            [self showHint:msg];
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
    
    
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
        
    }else if([segue.identifier isEqualToString:@"goGetLocationSegue"]){
        MapLocateViewController *locaVC = segue.destinationViewController;
        locaVC.jwdBlock =^(NSArray *locaArray){
            longtitudeStr = locaArray[1];
            latituedeStr = locaArray[0];
            
        };
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 8888 ||textField.tag == 7777||textField.tag == 6666||textField.tag == 5555) {
        [UIView animateWithDuration:0.26 animations:^{
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:1 animated:YES];
        }];
        
    }
    
    
  
}


@end
