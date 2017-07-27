//
//  ApplyViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ApplyViewController.h"
#import "MapLocateViewController.h"

#import "ApplyContentTableViewCell.h"
#import "IdentiPhotoTableViewCell.h"
#import "BusinessTableViewCell.h"
#import "OtherLicenseTableViewCell.h"

#import "NewAddContentTableViewCell.h"
#import "TypeChooseTableViewCell.h"

#import "ValuePickerView.h"
#import "CheckID.h"

#import "BeUnionModel.h"



@interface ApplyViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UITextFieldDelegate>
{
    NSMutableArray *_nameArr;
    NSMutableArray *_addrArr;
    NSMutableArray *_busiArr;
    NSMutableArray *_contactArr;
    
  //   NSMutableArray *_cateIdArr;
    //NSMutableArray *imagesArray;
    
    //保存信息
    NSString *cateId;//类别
    NSString *_nameStr;
    NSString *_identiId;
    NSString *_storeName;
    NSString *_inviteCode;
    
    NSString *_phoneStr;//手机号
    NSString *_storeAddr;//地址
    NSString *latituedeStr;//纬度
    NSString *longtitudeStr;//经度
    
    
    // 新增信息
    NSString *_serviceStr;
    NSString *_aliasNameStr;
    NSString *_emailStr;
    NSString *_shopreturnrateStr;
    NSString *_posrateStr;
    NSString *_businessLicenseStr;
    NSString *_cardNoStr;
    NSString *_cardNameStr;
    
    NSString *addrCateId;
    NSString *conCateId;
    NSString *busiCateId;
    
    NSString *addrCateStr;
    NSString *conCateStr;
    NSString *busiCateStr;
    NSString *storeCateStr;
   
    
    
    //保存照片
    NSString *_upId;
    NSString *_downId;
    NSString *_licenseId;
    NSString *_storeId;
    
    
}

@property (nonatomic,strong) NSMutableArray *imageArr;





@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) ValuePickerView *pickerView;
@property (nonatomic, strong) NSArray *stateArr;

@property (nonatomic, strong) NSMutableArray *cateIdArr;//经营范围id
@property (nonatomic, strong) NSMutableArray *addrIdArr;//经营范围id
@property (nonatomic, strong) NSMutableArray *busiIdArr;//经营范围id
@property (nonatomic, strong) NSMutableArray *contactIdArr;//经营范围id

@property (nonatomic,copy) NSString *idStr;
@property (nonatomic,copy) NSString *addrIdStr;
@property (nonatomic,copy) NSString *conIdStr;
@property (nonatomic,copy) NSString *busiIdStr;
@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _upId = @"";
    _downId = @"";
    _licenseId = @"";
    _storeId = @"";
    
    // Do any additional setup after loading the view.
    
   // imagesArray = [NSMutableArray array];
    
    self.tabBarController.tabBar.hidden = YES;
    [self configTableView];
}

- (void)setAddrArr:(NSArray *)addrArr{
    _addrArr = [NSMutableArray array];
    _addrIdArr = [NSMutableArray array];
    if (addrArr.count == 0) {
        NSArray *arr = @[@"暂无数据"];
        [_addrArr addObjectsFromArray:arr];
    }
    for (AddressTypeModel *model in addrArr) {
        [_addrArr addObject:model.val];
        [_addrIdArr addObject:model.addressType];
    }
    [self.tableView reloadData];
}

- (void)setBusinessArr:(NSArray *)businessArr{
    _busiArr = [NSMutableArray array];
    _busiIdArr = [NSMutableArray array];
    if (businessArr.count == 0) {
        NSArray *arr = @[@"暂无数据"];
        [_busiArr addObjectsFromArray:arr];
    }
    for (BusinessTypeModel *model in businessArr) {
        [_busiArr addObject:model.licenseName];
        [_busiIdArr addObject:model.licenseId];
    }
    [self.tableView reloadData];
}

- (void)setContactArr:(NSArray *)contactArr{
    _contactArr = [NSMutableArray array];
    _contactIdArr = [NSMutableArray array];
    if (contactArr.count == 0) {
        NSArray *arr = @[@"暂无数据"];
        [_contactArr addObjectsFromArray:arr];
    }
    for (ContactTypeModel *model in contactArr) {
        [_contactArr addObject:model.typeName];
        [_contactIdArr addObject:model.typeId];
    }
    [self.tableView reloadData];
}

- (void)setListArr:(NSArray *)listArr{
    
    _cateIdArr = [NSMutableArray array];
    _nameArr = [NSMutableArray array];
    if (listArr.count == 0) {
        NSArray *arr = @[@"暂无数据"];
        [_nameArr addObjectsFromArray:arr];
    }
    for (BeUnionModel *model in listArr) {
        [_nameArr addObject:model.name];
        [_cateIdArr addObject:model.categoryId];
    }
    [self.tableView reloadData];
}

- (void)upPikerViewWithName:(NSArray* )nameArr nameId:(NSArray* )nameIdArr AndTypeNum:(NSInteger )typeId{
   
    self.pickerView = [[ValuePickerView alloc]init];
    
    self.pickerView.dataSource = nameArr;
    // self.pickerView.pickerTitle = @"百分比";
    __weak typeof(self) weakSelf = self;
    //self.pickerView.defaultStr = @"50%/5";
    self.pickerView.valueDidSelect = ^(NSString *value){
        _stateArr = [value componentsSeparatedByString:@"/"];
        
        ApplyContentTableViewCell *applyCell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        TypeChooseTableViewCell *typeCell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];

        
        if (typeId == 0) {
            applyCell.rangeText.text = storeCateStr = weakSelf.stateArr[0];
            _idStr = weakSelf.stateArr[1];
            cateId = [nameIdArr objectAtIndex:[weakSelf.idStr integerValue]-1];
        }else if (typeId == 1){
        
            typeCell.conTf.text = conCateStr = weakSelf.stateArr[0];
            _conIdStr = weakSelf.stateArr[1];
            conCateId = [nameIdArr objectAtIndex:[weakSelf.conIdStr integerValue]-1];
        }else if (typeId == 2){
            
            typeCell.addrTf.text = addrCateStr = weakSelf.stateArr[0];
            _addrIdStr = weakSelf.stateArr[1];
            addrCateId = [nameIdArr objectAtIndex:[weakSelf.addrIdStr integerValue]-1];
        }else{
            typeCell.licenceTf.text = busiCateStr = weakSelf.stateArr[0];
            _busiIdStr = weakSelf.stateArr[1];
            busiCateId = [nameIdArr objectAtIndex:[weakSelf.busiIdStr integerValue]-1];
        }

    };
    [self.pickerView show];
}

- (void)configTableView{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = 12;
    self.tableView.sectionHeaderHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"ApplyContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"applyId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"IdentiPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"identiPhotoId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessTableViewCell" bundle:nil] forCellReuseIdentifier:@"businessId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OtherLicenseTableViewCell" bundle:nil] forCellReuseIdentifier:@"otherCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewAddContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"newAddCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TypeChooseTableViewCell" bundle:nil] forCellReuseIdentifier:@"typeCelleId"];
}

#pragma mark -- UITabelViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 55) {
        [UIView animateWithDuration:0.26 animations:^{
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:1 animated:YES];
        }];
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ApplyContentTableViewCell *applyCell = [tableView dequeueReusableCellWithIdentifier:@"applyId"];
        if (applyCell == nil) {
            applyCell = [[[NSBundle mainBundle] loadNibNamed:@"ApplyContentTableViewCell" owner:self options:nil] lastObject];
        }
        
        __weak typeof(applyCell) weakapplyCell = applyCell;
        applyCell.chooseBlock = ^{
            //
            for (UITextField *tf in weakapplyCell.contentView.subviews) {
                [tf resignFirstResponder];
            }
            [self upPikerViewWithName:_nameArr nameId:_cateIdArr AndTypeNum:0];
        };
        
        applyCell.positionBlock =^{
          [self performSegueWithIdentifier:@"getPositionSegue" sender:nil];
        };
        

        applyCell.trueNameBlock = ^(NSString *str) {
            _nameStr = str;
        };
        
        applyCell.identiNumBlock = ^(NSString *str) {
            _identiId = str;
        };
        
        applyCell.storeNameBlock = ^(NSString *str) {
            _storeName = str;
        };
        
        applyCell.phoneTextBlock = ^(NSString *str) {
            _phoneStr = str;
        };
        
        applyCell.storeAddrTextBlock = ^(NSString *str) {
            _storeAddr = str;
        };
        
        applyCell.inviteCodeTextBlock = ^(NSString *str) {
            _inviteCode = str;
        };
        
        _nameStr = applyCell.trueName.text;
        _storeName = applyCell.storeName.text;
        _inviteCode = applyCell.inviteCodeText.text;
        _identiId = applyCell.identiNum.text;
        
        _phoneStr = applyCell.phoneText.text;
        _storeAddr = applyCell.storeAddrText.text;
        
        
        
        applyCell.selectionStyle = 0;
        return applyCell;
    }else if (indexPath.section == 1){
        
        NewAddContentTableViewCell *newAddCell = [tableView dequeueReusableCellWithIdentifier:@"newAddCellId"];
        if (newAddCell == nil) {
            newAddCell = [[[NSBundle mainBundle] loadNibNamed:@"NewAddContentTableViewCell" owner:self options:nil] lastObject];
        }
        
        newAddCell.serviceBlock = ^(NSString *str) {
            _serviceStr = str;
            
        };
        
        newAddCell.aliasNameBlock = ^(NSString *str) {
            _aliasNameStr = str;
        };
        
        newAddCell.emailBlock = ^(NSString *str) {
            _emailStr = str;
            
        };
        
        newAddCell.shopreturnrateBlock = ^(NSString *str) {
            _shopreturnrateStr = str;
        };
        
        newAddCell.posrateBlock = ^(NSString *str) {
            _posrateStr = str;
            
        };
        
        newAddCell.businessLicenseBlock = ^(NSString *str) {
            _businessLicenseStr = str;
        };
        
        newAddCell.cardNoBlock = ^(NSString *str) {
            _cardNoStr = str;
            
        };
        
        newAddCell.cardNameBlock = ^(NSString *str) {
            _cardNameStr = str;
        };
        
//        for (UITextField *tf in newAddCell.contentView.subviews) {
//            tf.delegate = self;
//        }

        newAddCell.serviceTF.delegate = self;
        newAddCell.aliasNameTF.delegate = self;
        newAddCell.emailTF.delegate = self;
        newAddCell.shopreturnrateTF.delegate = self;
        newAddCell.posrateTF.delegate = self;
        newAddCell.businessLicenseTF.delegate = self;
        newAddCell.cardNoTF.delegate = self;
        newAddCell.cardNameTF.delegate = self;
        
        _serviceStr = newAddCell.serviceTF.text;
        _aliasNameStr = newAddCell.aliasNameTF.text;
        _emailStr = newAddCell.emailTF.text;
        _shopreturnrateStr = newAddCell.shopreturnrateTF.text;
        _posrateStr = newAddCell.posrateTF.text;
        _businessLicenseStr = newAddCell.businessLicenseTF.text;
        _cardNoStr = newAddCell.cardNoTF.text;
        _cardNameStr = newAddCell.cardNameTF.text;
        
        newAddCell.selectionStyle = 0;
        return newAddCell;

    }else if (indexPath.section == 2){
     
        TypeChooseTableViewCell *typeCell = [tableView dequeueReusableCellWithIdentifier:@"typeCelleId"];
        if (typeCell == nil) {
            typeCell = [[[NSBundle mainBundle] loadNibNamed:@"TypeChooseTableViewCell" owner:self options:nil] lastObject];
        }
        
        __weak typeof(typeCell) weaktypeCell = typeCell;
        weaktypeCell.addrBlock = ^{
          
            for (UITextField *tf in weaktypeCell.contentView.subviews) {
                [tf resignFirstResponder];
            }
            [self upPikerViewWithName:_addrArr nameId:_addrIdArr AndTypeNum:2];
        };
        weaktypeCell.contactBlock = ^{
            
            for (UITextField *tf in weaktypeCell.contentView.subviews) {
                [tf resignFirstResponder];
            }
            [self upPikerViewWithName:_contactArr nameId:_contactIdArr AndTypeNum:1];
        };
        weaktypeCell.licenseBlock = ^{
            
            for (UITextField *tf in weaktypeCell.contentView.subviews) {
                [tf resignFirstResponder];
            }
            [self upPikerViewWithName:_busiArr nameId:_busiIdArr AndTypeNum:3];
        };
        
        
        typeCell.selectionStyle = 0;
        return typeCell;
        
        
    }
    /*
    else if (indexPath.section == 3){
        IdentiPhotoTableViewCell *IdentiCell = [tableView dequeueReusableCellWithIdentifier:@"identiPhotoId"];
        if (IdentiCell == nil) {
            IdentiCell = [[[NSBundle mainBundle] loadNibNamed:@"IdentiPhotoTableViewCell" owner:self options:nil] lastObject];
        }
        IdentiCell.oneBlock =^{
            [self pickPhotosWithTag:000];
        };
        IdentiCell.twoBlock = ^{
             [self pickPhotosWithTag:111];
        };
        
        
        IdentiCell.selectionStyle = 0;
        return IdentiCell;
    }else if (indexPath.section == 4){
        BusinessTableViewCell *BusinessCell = [tableView dequeueReusableCellWithIdentifier:@"businessId"];
        if (BusinessCell == nil) {
            BusinessCell = [[[NSBundle mainBundle] loadNibNamed:@"BusinessTableViewCell" owner:self options:nil] lastObject];
        }
        BusinessCell.licenseBlock =^{
            [self pickPhotosWithTag:333];
        };
        BusinessCell.selectionStyle = 0;
        return BusinessCell;

    }
     */
    else{
        OtherLicenseTableViewCell *OtherCell = [tableView dequeueReusableCellWithIdentifier:@"otherCellId"];
        if (OtherCell == nil) {
            OtherCell = [[[NSBundle mainBundle] loadNibNamed:@"OtherLicenseTableViewCell" owner:self options:nil] lastObject];
        }
        OtherCell.otherBlock =^{
          [self pickPhotosWithTag:444];
        };
        OtherCell.selectionStyle = 0;
        return OtherCell;

    }
 
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 350;
    }else if (indexPath.section == 1){
        return 364;
    }else if (indexPath.section == 2)
    
        return 131;
    /*
    else if (indexPath.section == 3){
        return 138;
    }
     */
    else{
        return 185;
    }
    
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *foot = [UIView new];
    foot.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    return foot;
}


- (void)pickPhotosWithTag:(NSInteger)tagg{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从照片库选取",nil];
    action.tag = tagg;
    [action showInView:self.navigationController.view];
}

#pragma mark - UIActionSheet delegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
   
    __weak typeof(self) weakSelf = self;
    if (buttonIndex == 0) {
        [self openCamera];
    }
    else if(buttonIndex == 2){
        
    }
    
    else{
        [self openPhoto];

    }
    self.imageBlock = ^(UIImage *img){
        if (actionSheet.tag == 000) {
            IdentiPhotoTableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
     
            //上传图片
            
            [[MyAPI sharedAPI] postFilesWithFormData:@[img] result:^(BOOL success, NSString *msg, id object) {
                if (success) {
                    _upId = (NSString*)object;
                    [cell.onePhoto setImage:img forState:0];
                }else{
                    if ([msg isEqualToString:@"-1"]) {
                        [weakSelf logout];
                    }else{
                        [weakSelf showHint:msg];
                    }
                }
            } errorResult:^(NSError *enginerError) {
                 [weakSelf showHint:@"网络错误"];
            }];
            
        }else if (actionSheet.tag == 111){
            IdentiPhotoTableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];

            //上传图片
            
            [[MyAPI sharedAPI] postFilesWithFormData:@[img] result:^(BOOL success, NSString *msg, id object) {
                if (success) {
                    _downId = (NSString*)object;
                   [cell.twoPhoto setImage:img forState:0];
                }else{
                    if ([msg isEqualToString:@"-1"]) {
                        [weakSelf logout];
                    }
                    [weakSelf showHint:@"错误"];
                }
            } errorResult:^(NSError *enginerError) {
                [weakSelf showHint:@"错误"];
            }];
            
        }else if(actionSheet.tag == 333){
            BusinessTableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
            
            //上传图片
            
            [[MyAPI sharedAPI] postFilesWithFormData:@[img] result:^(BOOL success, NSString *msg, id object) {
                if (success) {
                    _licenseId = (NSString*)object;
                   [cell.licenseBtn setImage:img forState:0];
                }else{
                    if ([msg isEqualToString:@"-1"]) {
                        [weakSelf logout];
                    }
                    [weakSelf showHint:@"错误"];
                }
            } errorResult:^(NSError *enginerError) {
                [weakSelf showHint:@"错误"];
            }];
            
        }else{
            
            OtherLicenseTableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
        
            //上传图片
            
            [[MyAPI sharedAPI] postFilesWithFormData:@[img] result:^(BOOL success, NSString *msg, id object) {
                if (success) {
                    _storeId = (NSString*)object;
                    [cell.otherBtn setImage:img forState:0];
                }else{
                    if ([msg isEqualToString:@"-1"]) {
                        [weakSelf logout];
                    }
                    [weakSelf showHint:@"错误"];
                }
            } errorResult:^(NSError *enginerError) {
                [weakSelf showHint:@"错误"];
            }];
        }
        
    };
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

- (IBAction)confirmUpdate:(id)sender {
   
//    
//    ApplyContentTableViewCell *applyCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    NewAddContentTableViewCell *newAddCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
//    
//    _nameStr = applyCell.trueName.text;
//    _storeName = applyCell.storeName.text;
//    _inviteCode = applyCell.inviteCodeText.text;
//    _identiId = applyCell.identiNum.text;
//    _phoneStr = applyCell.phoneText.text;
//    _storeAddr = applyCell.storeAddrText.text;
//    
//    
//    _serviceStr = newAddCell.serviceTF.text;
//    _aliasNameStr = newAddCell.aliasNameTF.text;
//    _emailStr = newAddCell.emailTF.text;
//    _shopreturnrateStr = newAddCell.shopreturnrateTF.text;
//    _posrateStr = newAddCell.posrateTF.text;
//    _businessLicenseStr = newAddCell.businessLicenseTF.text;
//    _cardNoStr = newAddCell.cardNoTF.text;
//    _cardNameStr = newAddCell.cardNameTF.text;
    
    
    if ([storeCateStr isEqualToString:@""]||[_identiId isEqualToString:@""]||[_storeName isEqualToString:@""]||[_nameStr isEqualToString:@""]||[_identiId isEqualToString:@""]||[_phoneStr isEqualToString:@""]||[_storeAddr isEqualToString:@""]||[_serviceStr isEqualToString:@""]||[_aliasNameStr isEqualToString:@""]||[_emailStr isEqualToString:@""]) {
        showAlert(@"必填项不可为空");
    }
    

    
    
    
    
//    else if (applyCell == nil || newAddCell == nil) {
//        NSLog(@"cell出问题了");
//    }
//    
    
//    }else if ([CheckID deptNameInputShouldChineseWithStr: applyCell.trueName.text] == NO){
//        showAlert(@"姓名请输入汉字");
//    }
 
//    else if ([_storeId isEqualToString:@""]){
//        showAlert(@"请上传必须上传照片项");
//    }
// 
    else{
      
        
        NSDictionary *para = @{
                               
                               @"type":_typeStr,
                               @"member":@{
                                       @"name":_nameStr,
                                       @"idcardno":_identiId,
                                       @"email":_emailStr,
                                      
                                       //@"invitecode":_inviteCode
                                       },
                               @"shop":@{
                                       @"shopphone":_phoneStr,
                                       @"shopRefreePhone":_inviteCode,
                                       @"shopname":_storeName,
                                       @"categoryid":cateId,
                                       @"businessimg":_licenseId,
                                       @"doorimg":_storeId,
                                       @"idcardnofrontimg":_upId,
                                       @"idcardnobackimg":_downId,
                                       @"addr":_storeAddr,
                                       @"latitude":latituedeStr,
                                       @"longitude":longtitudeStr,
                                       @"servicePhone":_serviceStr,
                                       @"aliasName":_aliasNameStr,
                                       @"shopreturnrate":_shopreturnrateStr,
                                       @"posrate":_posrateStr,
                                       @"businessLicense":_businessLicenseStr,
                                       @"cardNo":_cardNoStr,
                                       @"cardName":_cardNameStr,
                                       @"contactType":conCateId,
                                       @"addressType":addrCateId,
                                       @"businessLicenseType":busiCateId,
                                       }
                               };
        
        
        [[MyAPI sharedAPI] upDateInfoForBeUnionWith:para result:^(BOOL sucess, NSString *msg) {
            if (sucess) {
                [self showHint:@"提交成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
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
    }
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
  __weak  ApplyContentTableViewCell *applyCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if([segue.identifier isEqualToString:@"getPositionSegue"]){
        MapLocateViewController *locaVC = segue.destinationViewController;
        locaVC.jwdBlock =^(NSArray *locaArray){
            longtitudeStr = locaArray[1];
            latituedeStr = locaArray[0];
            [applyCell.goPositon setTitle:locaArray[2] forState:UIControlStateNormal];
            [applyCell.goPositon setTintColor:[UIColor blackColor]];
            [applyCell.goPositon.titleLabel setFont:[UIFont systemFontOfSize:10]];
            applyCell.storeAddrText.text = locaArray[2];
        };
    }
}


@end
