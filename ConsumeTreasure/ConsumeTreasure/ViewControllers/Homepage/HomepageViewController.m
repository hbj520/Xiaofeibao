//
//  HomepageViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 9/28/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

//百度
#import "AppDelegate.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#import "HomepageViewController.h"
#import "AdDetailViewController.h"
#import "StoreDeatilViewController.h"

#import "HomePageFirstTableViewCell.h"
#import "chartTableViewCell.h"
#import "BeforeChartTableViewCell.h"
#import "ImageTableViewCell.h"
#import "HotStoreTableViewCell.h"
#import "TuiJianTableViewCell.h"
#import "HomeListHeadView.h"

#import "ChangeRecStoreTableViewCell.h"
#import "ChangeRecommendTableViewCell.h"

#import "TRLiveNetManager.h"

#import "TuiJianModel.h"
#import "AddModel.h"
#import "HomeStoreModel.h"
#import "PersonInfoModel.h"

#import "JFCityViewController.h"
#import "LocationViewController.h"

#import "CHSocialService.h"

#import "TobeUnionViewController.h"

@interface HomepageViewController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKOfflineMapDelegate>
{
    
   // BMKMapView* mapView;
    //BMKGeoCodeSearch* _geocodesearch;//反编码
    BMKLocationService* _locService;//定位
    BMKOfflineMap * _offlineMap;
    int _oldY;
    
    NSString *longitudeStr;
    NSString *latitudeStr;
    NSString *localStr;
    NSString *cityCode;
    
    NSMutableArray *addArr;//广告
    NSMutableArray *charArr;//走势图
    NSMutableArray *TuiJianArr;
    NSMutableArray *HotStoreArr;//热门商家
    
    HomeStoreModel *Smodel;
    TuiJianModel *Tmodel;
    PersonInfoModel *infoModel;
}
@end

@implementation HomepageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    addArr = [[NSMutableArray alloc]init];
    charArr = [[NSMutableArray alloc]init];
    TuiJianArr = [[NSMutableArray alloc]init];
    HotStoreArr = [[NSMutableArray alloc]init];
    [self loadIncomeAndAddsData];
    [self addRefresh];
    [self addNavBar];
    [self startMap];
    [self creatUI];
    [self addLocationGes];
    //[self loadHotStoreData];
     //localStr = @"模拟定位";//后   需删除
    [self loadHotStoreAndTuiJianStoreData];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self loadHotStoreAndTuiJianStoreData];
}


#pragma mark-mapMethod

- (void)addLocationGes{
    UITapGestureRecognizer *locaGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseLoca)];
    [self.locationView addGestureRecognizer:locaGes];
}

- (void)chooseLoca{
   
    
    [self pushToNextWithIdentiField:@"chooseLocationSegue" sender:localStr];
    /*
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.title = @"城市";
    __weak typeof(self) weakSelf = self;
    [cityViewController choseCityBlock:^(NSString *cityName) {
        weakSelf.locationCityName.text = cityName;
    }];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    navigationController.navigationBar.barTintColor=RGBACOLOR(253,87,54,1);//背景色
    [self presentViewController:navigationController animated:YES completion:nil];
*/
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    BMKCoordinateRegion region;
    
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0;
    region.span.longitudeDelta = 0;
    NSLog(@"当前的坐标是:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    longitudeStr = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    latitudeStr = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
   // ApplicationDelegate
    ApplicationDelegate.latitude = latitudeStr;
    ApplicationDelegate.longitude = longitudeStr;
 
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            if (placemark != nil) {
                NSString *city = placemark.locality;
                
                NSLog(@"当前城市名称------%@",city);
                self.locationCityName.text = city;
                localStr = city;
                NSArray* records = [_offlineMap searchCity:city];
                BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
                //城市编码如:北京为131
                int cityId = oneRecord.cityID;
                
                cityCode = [NSString stringWithFormat:@"%d",oneRecord.cityID];
                ApplicationDelegate.cityCode = cityCode;//全局保存地理
                
                [[XFBConfig Instance] saveCityCode:cityCode];
                if ([_offlineMap remove:cityId]) {
                 
                    
                }else{
                    
                };
                [self loadHotStoreAndTuiJianStoreData];//根据定位加载商家
                
                [_locService stopUserLocationService];
            }
        }
    }];
}

#pragma mark-PrivateMethod


- (void)addRefresh{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (TuiJianArr.count > 0 || addArr.count > 0) {
            [TuiJianArr removeAllObjects];
            [addArr removeAllObjects];
        }
        [weakSelf loadIncomeAndAddsData];
        [weakSelf loadHotStoreAndTuiJianStoreData];
    }];
    
}
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)loadIncomeAndAddsData{
    NSDictionary *para = @{
                           
                           };
    

    
    /*
    //走势图
    [[MyAPI sharedAPI] getHomeIncomeChartDataWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            
            NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"createtime" ascending:YES];
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sorter count:1];
            [charArr addObjectsFromArray:[arrays sortedArrayUsingDescriptors:sortDescriptors]] ;
            NSLog(@"%@", charArr);
            
            NSLog(@"=======收益权==%@",charArr);
            [self.tableView reloadData];
        }
         [self endRefresh];
    } errorResult:^(NSError *enginerError) {
         [self endRefresh];
    }];
    */
   // [BQActivityView showActiviTy];

    //广告位
    [[MyAPI sharedAPI] getHomeAddDataWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            [BQActivityView hideActiviTy];
            [addArr addObjectsFromArray:arrays];

            NSLog(@"=======收益权==%@",addArr);
            [self.tableView reloadData];
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }
         [self endRefresh];
    } errorResult:^(NSError *enginerError) {
         [self endRefresh];
    }];
    
   
    
}

- (void)loadHotStoreAndTuiJianStoreData{
  
    NSDictionary *para = @{
                           @"cityCode":ApplicationDelegate.cityCode,//cityCode
                           @"latitude":ApplicationDelegate.latitude,//latitudeStr
                           @"longitude":ApplicationDelegate.longitude//longitudeStr
                           };
    // [BQActivityView showActiviTy];
    [[MyAPI sharedAPI]getHomeChartDataWithParameters:para resulet:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            [BQActivityView hideActiviTy];
            [HotStoreArr removeAllObjects];
            [HotStoreArr addObjectsFromArray:arrays];
            [self.tableView reloadData];
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }
        
    } errorResult:^(NSError *enginerError) {
       // [self showHint:@"下载出错"];
    }];
   
    //推荐
    [[MyAPI sharedAPI] getTuiJianStoreWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            [TuiJianArr removeAllObjects];
            [TuiJianArr addObjectsFromArray:arrays];
            [self.tableView reloadData];
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }
        
        [self endRefresh];
    } errorResult:^(NSError *enginerError) {
        [self endRefresh];
    }];
    
    
}

- (void)startMap{
    _locService = [[BMKLocationService alloc]init];//定位功能的初始化
    _locService.delegate = self;//设置代理位self
    //启动LocationService
    [_locService startUserLocationService];//启动定位服务
    
//    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
//    //编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
//    _geocodesearch.delegate = self;//设置代理为self
    _offlineMap = [[BMKOfflineMap alloc] init];

}

- (void)creatUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomePageFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChangeRecStoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"changeStoreId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChangeRecommendTableViewCell" bundle:nil] forCellReuseIdentifier:@"recomandId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"chartImageCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HotStoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"hotStoreCellId"];
     [self.tableView registerNib:[UINib nibWithNibName:@"TuiJianTableViewCell" bundle:nil] forCellReuseIdentifier:@"tuijianCelleId"];
    
}
#pragma mark - UIScrollviewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"scrollview offsety %f",scrollView.contentOffset.y);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    HomePageFirstTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    float alphafix = scrollView.contentOffset.y;
    if (scrollView.contentOffset.y >0 && scrollView.contentOffset.y > _oldY) {
        for (UIView *subView in cell.scanView.subviews) {
            subView.alpha = ((60 -alphafix))/60;
        }
        for (UIView *subView in cell.accountView.subviews) {
            subView.alpha = ((60 -alphafix))/60;
        }
        for (UIView *subView in cell.recordView.subviews) {
            subView.alpha = ((60 -alphafix))/60;
        }
        for (UIView *subView in cell.incomeView.subviews) {
            subView.alpha = ((60 -alphafix))/60;
        }

    }else if (scrollView.contentOffset.y < _oldY){
        for (UIView *subView in cell.scanView.subviews) {
            subView.alpha = (104.5 -alphafix)*3/2/104.5;
        }
        for (UIView *subView in cell.accountView.subviews) {
            subView.alpha = (104.5 -alphafix)*3/2/104.5;
        }
        for (UIView *subView in cell.recordView.subviews) {
            subView.alpha = (104.5 -alphafix)*3/2/104.5;
        }
        for (UIView *subView in cell.incomeView.subviews) {
            subView.alpha = (104.5 -alphafix)*3/2/104.5;
        }
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 获取开始拖拽时tableview偏移量
    _oldY = self.tableView.contentOffset.y;

}

- (void)pushToNextWithIdentiField:(NSString*)identi sender:(id)sender{
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:identi sender:sender];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return TuiJianArr.count+1;
    }else{
        return HotStoreArr.count;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        HomePageFirstTableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:@"FirstHomeCell"];
        if (firstCell == nil) {
            firstCell = [[[NSBundle mainBundle] loadNibNamed:@"HomePageFirstTableViewCell" owner:self options:nil] lastObject];
        }
        firstCell.selectionStyle = 0;
        
        firstCell.partnerBlock = ^{//合伙人超市partnerSegue
            [[MyAPI sharedAPI] getInfoPersonalWithParameters:@{} resulet:^(BOOL success, NSString *msg, id object) {
                    if (success) {
                        infoModel = (PersonInfoModel*)object;
                        if ([infoModel.isproxychecked isEqualToString:@"1"]) {
                            [self pushToNextWithIdentiField:@"DaiLiSegue" sender:nil];
                        }else{
                            [self pushToNextWithIdentiField:@"AgencydesSegue" sender:infoModel.isproxychecked];
                        }
                    }else{
                        if ([msg isEqualToString:@"-1"]) {
                            [self logout];
                        }else{
                            [self showHint:msg];
                        }
 
                    }
                } errorResult:^(NSError *enginerError) {
                    [self showHint:@"出错"];
                }];

        };
        firstCell.storeBlock = ^{//商户入口
            
                [[MyAPI sharedAPI] getInfoPersonalWithParameters:@{} resulet:^(BOOL success, NSString *msg, id object) {
                if (success) {
                    infoModel = (PersonInfoModel*)object;
                    [[XFBConfig Instance] saveloginName:infoModel.name];
                    if ([infoModel.isshopchecked isEqualToString:@"1"]) {
                        [self pushToNextWithIdentiField:@"beStoreSegue" sender:nil];
                    }else{
                        
                        [self pushToNextWithIdentiField:@"unionSegue" sender:infoModel.isshopchecked];
                        
                    }
                }else{
                    if ([msg isEqualToString:@"-1"]) {
                        [self logout];
                    }else{
                        [self showHint:msg];
                    }
                    
                }
            } errorResult:^(NSError *enginerError) {
                [self showHint:@"出错"];
            }];
        };
        
        firstCell.scanBlock =^{ //扫一扫
            [self pushToNextWithIdentiField:@"scanSegue" sender:nil];
        };
        firstCell.incomeBlock = ^{
        [self pushToNextWithIdentiField:@"collectionSegue" sender:nil];
         

           // showAlert(@"敬请期待！");
        };
        firstCell.accountBlock =^{
            [self pushToNextWithIdentiField:@"myAccountSegue" sender:nil];
           
        };
        firstCell.recordBlock = ^{//浏览记录
             [self pushToNextWithIdentiField:@"historySegue" sender:nil];
          
        };

        return firstCell;

    }else if (indexPath.section == 1){//第二个section
        
        if (indexPath.row == TuiJianArr.count) {
            ImageTableViewCell *imageChartCell = [tableView dequeueReusableCellWithIdentifier:@"chartImageCellId"];
            if (imageChartCell == nil) {
                imageChartCell = [[[NSBundle mainBundle] loadNibNamed:@"ImageTableViewCell" owner:self options:nil] lastObject];
            }
            imageChartCell.selectionStyle = 0;
            
            if (addArr.count > 0) {
                imageChartCell.addArray = addArr;
            }
            
            
            imageChartCell.indexBlock = ^(NSInteger index){
                NSLog(@"----------------------------");
                AddModel *model = addArr[index];
                [self pushToNextWithIdentiField:@"adDetailSegue" sender:model];
            };
            
            return imageChartCell;
        
        }else{
         
            TuiJianTableViewCell *tuijianCell = [tableView dequeueReusableCellWithIdentifier:@"tuijianCelleId"];
            if (tuijianCell == nil) {
                tuijianCell = [[[NSBundle mainBundle] loadNibNamed:@"TuiJianTableViewCell" owner:self options:nil] lastObject];
            }
            if (TuiJianArr.count > 0) {
                TuiJianModel *model = [TuiJianArr objectAtIndex:indexPath.row];
                tuijianCell.tuiModel = model;
            }
            
            tuijianCell.selectionStyle = 0;
            return tuijianCell;

            
            
        }
    }else{
        HotStoreTableViewCell *hotCell = [tableView dequeueReusableCellWithIdentifier:@"hotStoreCellId"];
        if (hotCell == nil) {
            hotCell = [[[NSBundle mainBundle] loadNibNamed:@"HotStoreTableViewCell" owner:self options:nil] lastObject];
        }
        if (HotStoreArr.count > 0) {
            HomeStoreModel *model = [HotStoreArr objectAtIndex:indexPath.row];
            hotCell.storeModel = model;
        }
        
        hotCell.selectionStyle = 0;
        return hotCell;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return 170;
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 3) {
            return 145;
        }else{
            return 125;
        }
    }
    else{
        return 125;
    }
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    if (section == 1) {
        HomeListHeadView *HotHeadView = [[[NSBundle mainBundle]loadNibNamed:@"HomeListHeadView" owner:self options:nil]lastObject];
        HotHeadView.titleImg.image = [UIImage imageNamed:@"crown_1080"];
        HotHeadView.titleLab.textColor = [UIColor orangeColor];
        HotHeadView.titleLab.text = @"推荐商家";
        HotHeadView.backgroundView = [[UIImageView alloc]init];
        HotHeadView.backgroundView.backgroundColor = [UIColor whiteColor];
        
        HotHeadView.goBlock =^(){
            self.tabBarController.selectedIndex = 1;
        };
        
        return HotHeadView;
        
    }else if (section == 2){
        HomeListHeadView *HotHeadView = [[[NSBundle mainBundle]loadNibNamed:@"HomeListHeadView" owner:self options:nil]lastObject];
      
        HotHeadView.backgroundView = [[UIImageView alloc]init];
        HotHeadView.backgroundView.backgroundColor = [UIColor whiteColor];

        HotHeadView.goBlock =^(){
            self.tabBarController.selectedIndex = 1;
        };
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
        return 41;
    }else{
        return 41;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *head1 = [[UIView alloc]init];
        head1.backgroundColor = RGBACOLOR(234, 235, 236, 1);
        return head1;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0.01;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    if (indexPath.section == 1) {
        
        if (indexPath.row != 3) {
            
            if (TuiJianArr.count > 0) {
                Tmodel = [TuiJianArr objectAtIndex:indexPath.row];
                [self pushToNextWithIdentiField:@"detailSegue" sender:Tmodel];
            }
        }
        
    }else if (indexPath.section == 2){
        NSLog(@"%ld-----%ld",(long)indexPath.section,(long)indexPath.row);
        
        if (HotStoreArr.count > 0) {
            Smodel = [HotStoreArr objectAtIndex:indexPath.row];
        }
        [self pushToNextWithIdentiField:@"detailSegue" sender:Smodel];
        
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
 */
#pragma  mark  -SegueDelegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //[segue.destinationViewController setHidesBottomBarWhenPushed:YES];

    
    if ([segue.identifier isEqualToString:@"adDetailSegue"]) {
        AddModel *model = (AddModel*)sender;
        AdDetailViewController *adVC = segue.destinationViewController;
        adVC.admodel = model;
    }else if ([segue.identifier isEqualToString:@"detailSegue"]){
       
        TuiJianModel *model = (TuiJianModel*)sender;
        StoreDeatilViewController *storeDetailVC = segue.destinationViewController;
        storeDetailVC.StoreModel = model;
    
    }else if ([segue.identifier isEqualToString:@"chooseLocationSegue"]){
        
        NSString *locaCity = (NSString*)sender;
        LocationViewController *locaVC = segue.destinationViewController;
        
        locaVC.locaStr = locaCity;
        
        locaVC.locaBlock =^(NSArray *arr){
            
            localStr = arr[0];
            self.locationCityName.text = arr[0];
            ApplicationDelegate.cityCode = arr[1];
        };
    }else if ([segue.identifier isEqualToString:@"AgencydesSegue"]){
        
        
    }else if ([segue.identifier isEqualToString:@"unionSegue"]){
        NSString *verifyStaus = (NSString *)sender;
        TobeUnionViewController *tobeUnionVC = segue.destinationViewController;
        tobeUnionVC.status = verifyStaus;
    }
}
//分享app
/*
- (IBAction)shareappBtn:(id)sender {
    [[CHSocialServiceCenter shareInstance]shareTitle:@"智惠返邀您一起享优惠" content:@"赶快来一起加入吧" imageURL:@"http://p2pguide.sudaotech.com/platform/image/1/20160318/3c896c87-65b6-481d-81ca-1b4a0b6d8dd4/" image:[UIImage imageNamed:@"qrImg"] urlResource:@"http://www.xftb168.com/web/toWxRegister?merchantMemId=7a9e5e98-d0c4-11e6-ad4a-6c92bf2cdbd1" controller:self completion:^(BOOL successful) {
        
    }];
}
*/

@end
