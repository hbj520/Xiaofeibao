//
//  ApplyViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ApplyViewController.h"

#import "ApplyContentTableViewCell.h"
#import "IdentiPhotoTableViewCell.h"
#import "BusinessTableViewCell.h"
#import "OtherLicenseTableViewCell.h"

#import "ValuePickerView.h"

#import "BeUnionModel.h"



@interface ApplyViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    NSMutableArray *_nameArr;
    
  //   NSMutableArray *_cateIdArr;
    //NSMutableArray *imagesArray;
    
    //保存信息
    NSString *cateId;//类别
    NSString *_nameStr;
    NSString *_identiId;
    NSString *_storeName;
    NSString *_inviteCode;
    
    
    
    
    //保存照片
    NSString *_upId;
    NSString *_downId;
    NSString *_licenseId;
    NSString *_otherId;
    
    
}

@property (nonatomic,strong) NSMutableArray *imageArr;





@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) ValuePickerView *pickerView;
@property (nonatomic, strong) NSArray *stateArr;

@property (nonatomic, strong) NSMutableArray *cateIdArr;//经营范围id

@property (nonatomic,copy) NSString *idStr;
@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
   // imagesArray = [NSMutableArray array];
    
    self.tabBarController.tabBar.hidden = YES;
    [self configTableView];
}

- (void)setListArr:(NSArray *)listArr{
    NSLog(@"😝%@😋",listArr);
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

- (void)upPikerView{
   
    self.pickerView = [[ValuePickerView alloc]init];
    
    self.pickerView.dataSource = _nameArr;
   // self.pickerView.pickerTitle = @"百分比";
   __weak typeof(self) weakSelf = self;
    //self.pickerView.defaultStr = @"50%/5";
    self.pickerView.valueDidSelect = ^(NSString *value){
        _stateArr = [value componentsSeparatedByString:@"/"];
        ApplyContentTableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.rangeText.text = weakSelf.stateArr[0];
        
        _idStr = weakSelf.stateArr[1];
        
     cateId = [weakSelf.cateIdArr objectAtIndex:[weakSelf.idStr integerValue]];
        
        NSLog(@"+++++++");
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
}

#pragma mark -- UITabelViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ApplyContentTableViewCell *applyCell = [tableView dequeueReusableCellWithIdentifier:@"applyId"];
        if (applyCell == nil) {
            applyCell = [[[NSBundle mainBundle] loadNibNamed:@"ApplyContentTableViewCell" owner:self options:nil] lastObject];
        }
        applyCell.chooseBlock = ^{
            [self upPikerView];
            
        };
        _nameStr = applyCell.trueName.text;
        _storeName = applyCell.storeName.text;
        _inviteCode = applyCell.inviteCodeText.text;
        _identiId = applyCell.identiNum.text;
        
        
        applyCell.selectionStyle = 0;
        return applyCell;
    }else if (indexPath.section == 1){
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
    }else if (indexPath.section == 2){
        BusinessTableViewCell *BusinessCell = [tableView dequeueReusableCellWithIdentifier:@"businessId"];
        if (BusinessCell == nil) {
            BusinessCell = [[[NSBundle mainBundle] loadNibNamed:@"BusinessTableViewCell" owner:self options:nil] lastObject];
        }
        BusinessCell.licenseBlock =^{
            [self pickPhotosWithTag:333];
        };
        BusinessCell.selectionStyle = 0;
        return BusinessCell;

    }else{
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
        return 221;
    }else if (indexPath.section == 1){
        return 138;
    }else{
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
  

    }else{
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
                    [weakSelf showHint:@"错误"];
                }
            } errorResult:^(NSError *enginerError) {
                 [weakSelf showHint:@"错误"];
            }];
         
            
    
            
            
            
        }else if (actionSheet.tag == 111){
            IdentiPhotoTableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            
            
            //上传图片
            
            [[MyAPI sharedAPI] postFilesWithFormData:@[img] result:^(BOOL success, NSString *msg, id object) {
                if (success) {
                    _downId = (NSString*)object;
                   [cell.twoPhoto setImage:img forState:0];
                }else{
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
                    [weakSelf showHint:@"错误"];
                }
            } errorResult:^(NSError *enginerError) {
                [weakSelf showHint:@"错误"];
            }];
            
        }else{
            
            if (!img) {
                OtherLicenseTableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
                
                
                //上传图片
                
                [[MyAPI sharedAPI] postFilesWithFormData:@[img] result:^(BOOL success, NSString *msg, id object) {
                    if (success) {
                        _otherId = (NSString*)object;
                        [cell.otherBtn setImage:img forState:0];
                    }else{
                        [weakSelf showHint:@"错误"];
                    }
                } errorResult:^(NSError *enginerError) {
                    [weakSelf showHint:@"错误"];
                }];
            }else{
                _otherId = @"";
            }
            
         
            
        }
        
    };
}

- (IBAction)confirmUpdate:(id)sender {
   
    
    
//    _nameStr = applyCell.trueName.text;
//    _storeName = applyCell.storeName.text;
//    _inviteCode = applyCell.inviteCodeText.text;
//    _identiId = applyCell.identiNum.text;

    
    ApplyContentTableViewCell *applyCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSDictionary *para = @{
                           @"type":@"1",
                           @"member":@{
                               @"name":applyCell.trueName.text,
                               @"idcardno":applyCell.identiNum.text,
                               @"invitecode":_inviteCode
                           },
                           @"shop":@{
                               @"shopname":applyCell.storeName.text,
                               @"categoryid":cateId,
                               @"businessimg":_licenseId,
                               @"licenseimg":_otherId,
                               @"idcardnofrontimg":_upId,
                               @"idcardnobackimg":_downId
                           }
                        };
    
    [[MyAPI sharedAPI] upDateInfoForBeUnionWith:para result:^(BOOL sucess, NSString *msg) {
        
        
        
    } errorResult:^(NSError *enginerError) {
        
        
    }];
   
    SHOWALERTVIEW(@"yishenqing ");
    
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
