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
#import "ValuePickerView.h"

#import "StoreMasterModel.h"
#import "BeUnionModel.h"

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
    
    
    // 新增
    NSString *servicephoneStr;//客服电话
    NSString *aliasnameStr;//商户简称
    NSString *emailStr;// 联系人邮箱
    NSString *cardnoStr;//银行卡号
    NSString *cardnameStr;//银行卡持卡人姓名
    NSString *businessLicenseStr;//营业执照编号
    

    
    NSArray *catelistArr;
    NSArray *addrlistArr;
    NSArray *businesslistArr;
    NSArray *contactlistArr;
    
    NSMutableArray *_cateArr;
    NSMutableArray *_addrArr;
    NSMutableArray *_busiArr;
    NSMutableArray *_contactArr;
    
    NSString *cateStr;// "经营类型名称
    NSString *contactStr;//联系人类型名称
    NSString *addressStr;//地址类型名称
    NSString *businesslicenseStr;//营业执照类型名称
    
    NSString *cateId;//经营分类id
    NSString *contactId;//联系人类型id
    NSString *addressId;//地址类型id
    NSString *businesslicenseId;//营业执照类型id
    
    
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

@property (nonatomic, strong) ValuePickerView *pickerView;
@property (nonatomic, strong) NSArray *stateArr;



@property (nonatomic, strong) NSMutableArray *cateIdArr;//经营范围id
@property (nonatomic, strong) NSMutableArray *addrIdArr;//地址类型id
@property (nonatomic, strong) NSMutableArray *busiIdArr;//营业执照类型id
@property (nonatomic, strong) NSMutableArray *contactIdArr;//联系人类型id


@property (nonatomic,copy) NSString *cateIdStr;
@property (nonatomic,copy) NSString *addrIdStr;
@property (nonatomic,copy) NSString *conIdStr;
@property (nonatomic,copy) NSString *busiIdStr;

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
    
    
   
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
    dispatch_group_async(group, q, ^{
        [[MyAPI sharedAPI] getStoreControlInfoDataWithParameters:para result:^(BOOL success, NSString *msg, id object) {
            if (success) {
                storeInfoModel *model = (storeInfoModel*)object;
                
                servicephoneStr = model.servicephone;
                aliasnameStr = model.aliasname;
                emailStr = model.email;
                cardnoStr = model.cardno;
                cardnameStr = model.cardname;
                businessLicenseStr = model.businessLicense;
                
                cateStr = model.categorynanme;
                contactStr = model.contactname;
                addressStr = model.addressname;
                businesslicenseStr = model.businesslicensename;
                
                cateId = model.categoryid;
                contactId = model.contacttype;
                addressId = model.addresstype;
                businesslicenseId = model.businesslicensetype;
                
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
                
                secOne = @[@"店铺名称",@"门面电话",@"真实姓名",@"身份证号",@"客服电话",@"商户简称",@"联系人邮箱",@"银行卡号",@"银行卡持卡人姓名",@"营业执照编号"];
                secTwo = @[@"门面地址",@"定位地址",@"商家介绍",@"开始经营时间",@"结束经营时间",@"反币比例",@"经营类型",@"联系人类型",@"地址类型",@"营业执照类型"];
                secThr = @[@"营业执照图片",@"经营许可证图片",@"身份证正面",@"身份证反面"];
                
                placeOne = @[storeName,storePhone,realName,IDNum,servicephoneStr,aliasnameStr,emailStr,cardnoStr,cardnameStr,businessLicenseStr,];
                placeTwo = @[strAddr,@"开始定位",strDescri,sTime,eTime,disCount,cateStr,contactStr,addressStr,businesslicenseStr];
                placeThr = @[img1,img2,img3,img4];
                
                [self head:doorImg];
                
                
                //[self.tableView reloadData];
            }
            
        } errorResult:^(NSError *enginerError) {
            
        }];
    });
    
    dispatch_group_async(group, q, ^{
        [[MyAPI sharedAPI] getShangHuRequestDataWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
            if (success) {

                
                _addrArr = [NSMutableArray array];
                _addrIdArr = [NSMutableArray array];
                _busiArr = [NSMutableArray array];
                _busiIdArr = [NSMutableArray array];
                _contactArr = [NSMutableArray array];
                _contactIdArr = [NSMutableArray array];
                _cateArr = [NSMutableArray array];
                _cateIdArr = [NSMutableArray array];
                
                for (AddressTypeModel *model in arrays[1]) {
                    [_addrArr addObject:model.val];
                    [_addrIdArr addObject:model.addressType];
                }
                for (BusinessTypeModel *model in arrays[2]) {
                    [_busiArr addObject:model.licenseName];
                    [_busiIdArr addObject:model.licenseId];
                }
                for (ContactTypeModel *model in arrays[3]) {
                    [_contactArr addObject:model.typeName];
                    [_contactIdArr addObject:model.typeId];
                }
                for (BeUnionModel *model in arrays[0]) {
                    [_cateArr addObject:model.name];
                    [_cateIdArr addObject:model.categoryId];
                }
                
            }else{
                if ([msg isEqualToString:@"-1"]) {
                    [self logout];
                }else{
                    [self showHint:msg];
                }
            }
            
        } errorResult:^(NSError *enginerError) {
            [self showHint:@"网络出错"];
        }];

    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    
        [self.tableView reloadData];
    });
    
    
   
    

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
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else if (section == 1){
        return 10;
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
        storeConCell.placetextfield.text = placeOne[indexPath.row];
        
        
        storeConCell.placetextfield.delegate = self;
        [storeConCell.placetextfield addTarget:self action:@selector(change:) forControlEvents:UIControlEventEditingChanged];
        
        if (indexPath.row == 0) {
            storeConCell.placetextfield.tag = 8888;
        }else if(indexPath.row == 1){
            storeConCell.placetextfield.tag = 7777;
        }else if (indexPath.row == 2){
            storeConCell.placetextfield.tag = 6666;
        }else if (indexPath.row == 3){
            storeConCell.placetextfield.tag = 5555;
        }else if (indexPath.row == 4){
            storeConCell.placetextfield.tag = 4444;
        }else if (indexPath.row == 5){
            storeConCell.placetextfield.tag = 3333;
        }else if (indexPath.row == 6){
            storeConCell.placetextfield.tag = 2222;
        }else if (indexPath.row == 7){
            storeConCell.placetextfield.tag = 1111;
        }else if (indexPath.row == 8){
            storeConCell.placetextfield.tag = 0000;
        }else{
            storeConCell.placetextfield.tag = 9999;
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
            if (indexPath.row == 6) {
                labCell.cateBlock = ^{
                    [self upPikerViewWithName:_cateArr nameId:_cateIdArr AndTypeNum:0];
                };
                
            }else if (indexPath.row == 7) {
                labCell.contactBlock = ^{
                    [self upPikerViewWithName:_contactArr nameId:_contactIdArr AndTypeNum:1];
                };
            }else if (indexPath.row == 8) {
                labCell.addrBlock = ^{
                    [self upPikerViewWithName:_addrArr nameId:_addrIdArr AndTypeNum:2];
                };
            }else if (indexPath.row == 9) {
                labCell.licenseBlock = ^{
                    [self upPikerViewWithName:_busiArr nameId:_busiIdArr AndTypeNum:3];
                };
            }else if (indexPath.row == 3 ||indexPath.row == 4) {
              
                
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

- (void)upPikerViewWithName:(NSArray* )nameArr nameId:(NSArray* )nameIdArr AndTypeNum:(NSInteger )typeId{
    
    self.pickerView = [[ValuePickerView alloc]init];
    self.pickerView.dataSource = nameArr;
    __weak typeof(self) weakSelf = self;

    self.pickerView.valueDidSelect = ^(NSString *value){
        _stateArr = [value componentsSeparatedByString:@"/"];
        
        StoreConLabTableViewCell *cateCell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:1]];
        StoreConLabTableViewCell *contactCell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:1]];
        StoreConLabTableViewCell *addrCell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:1]];
        StoreConLabTableViewCell *busiCell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:1]];

        
        
        if (typeId == 0) {
            cateCell.detailLab.text = cateStr = weakSelf.stateArr[0];
            _cateIdStr = weakSelf.stateArr[1];
            cateId = [nameIdArr objectAtIndex:[weakSelf.cateIdStr integerValue]-1];
        }else if (typeId == 1){
            
            contactCell.detailLab.text = contactStr = weakSelf.stateArr[0];
            _conIdStr = weakSelf.stateArr[1];
            contactId = [nameIdArr objectAtIndex:[weakSelf.conIdStr integerValue]-1];
        }else if (typeId == 2){
            
            addrCell.detailLab.text = addressStr = weakSelf.stateArr[0];
            _addrIdStr = weakSelf.stateArr[1];
            addressId = [nameIdArr objectAtIndex:[weakSelf.addrIdStr integerValue]-1];
        }else{
            busiCell.detailLab.text = businessLicenseStr = weakSelf.stateArr[0];
            _busiIdStr = weakSelf.stateArr[1];
            businesslicenseId = [nameIdArr objectAtIndex:[weakSelf.busiIdStr integerValue]-1];
        }
        
    };
    [self.pickerView show];
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
            if (yingyeImg) {
                [self performSegueWithIdentifier:@"goChooseImageSegue" sender:@[yingyeImg,@"1"]];

            }
        }else if (indexPath.row == 1) {
            if (jingyingImg) {
                [self performSegueWithIdentifier:@"goChooseImageSegue" sender:@[jingyingImg,@"2"]];

            }
        }else if (indexPath.row == 2) {
            if (IDFrontImg) {
                [self performSegueWithIdentifier:@"goChooseImageSegue" sender:@[IDFrontImg,@"3"]];

            }
        }else{
            if (IDBackImg) {
                [self performSegueWithIdentifier:@"goChooseImageSegue" sender:@[IDBackImg,@"4"]];

            }
        }
    }
}
#pragma mark -PrivateMethod
- (void)verifyImage{
    if ([doorImg hasPrefix:@"http"]) {
        doorImg = @"";
    }
    if ([jingyingImg hasPrefix:@"http"]) {
        jingyingImg = @"";
    }
    if ([yingyeImg hasPrefix:@"http"]) {
        yingyeImg = @"";
    }
    if ([IDFrontImg hasPrefix:@"http"]) {
        IDFrontImg = @"";
    }
    if ([IDBackImg hasPrefix:@"http"]) {
        IDBackImg = @"";
    }
    
}
-(void)change:(UITextField*)textField{
    if (textField.tag == 8888) {
        storeName = textField.text;
    }else if (textField.tag == 7777){
        storePhone = textField.text;
    }else if (textField.tag == 6666){
        realName = textField.text;
    }else if (textField.tag == 5555){
        IDNum = textField.text;
    }else if (textField.tag == 4444){
        servicephoneStr = textField.text;
    }else if (textField.tag == 3333){
        aliasnameStr = textField.text;
    }else if (textField.tag == 2222){
        emailStr = textField.text;
    }else if (textField.tag == 1111){
        cardnoStr = textField.text;
    }else if (textField.tag == 0000){
        cardnameStr = textField.text;
    }else if (textField.tag == 9999){
        businessLicenseStr = textField.text;
    }





    
}

- (IBAction)back:(id)sender {
    [self backTolastPage];
}

- (IBAction)PostData:(id)sender {
    
    if ([realName isEqualToString:@""]||[strAddr isEqualToString:@""]||[storePhone isEqualToString:@""]||[storeName isEqualToString:@""]) {
        showAlert(@"商家姓名、手机号、店铺名称、店铺首图、地址不可为空");
    }else{
        [self verifyImage];
    NSDictionary *para = @{
                           
                           @"type":@"2",
                           @"member":@{
                                   @"name":realName,
                                   @"idcardno":IDNum
                                   },
                           @"shop":@{
                                   @"categoryid":cateId,
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
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showHint:msg];
        }
        
    } errorResult:^(NSError *enginerError) {
        [self showHint:@"网络请求出错"];
    }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 */
#pragma mark -SegueDelegate
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
