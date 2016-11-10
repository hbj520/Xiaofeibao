//
//  HomepageViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 9/28/16.
//  Copyright © 2016 youyou. All rights reserved.
//

//百度
#import "AppDelegate.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#import "HomepageViewController.h"

#import "HomePageFirstTableViewCell.h"
#import "chartTableViewCell.h"
#import "BeforeChartTableViewCell.h"
#import "ImageTableViewCell.h"
#import "HotStoreTableViewCell.h"
#import "HomeListHeadView.h"

#import "TRLiveNetManager.h"

@interface HomepageViewController ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKOfflineMapDelegate>
{
    
    BMKMapView* mapView;
    BMKGeoCodeSearch* _geocodesearch;//反编码
    BMKLocationService* _locService;//定位
    
    int _oldY;
    
    NSString *longitudeStr;
    NSString *latitudeStr;
    NSString *localStr;
    
    NSMutableArray *addArr;//广告
    NSMutableArray *charArr;//走势图
    
}

@end

@implementation HomepageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    addArr = [[NSMutableArray alloc]init];
    charArr = [[NSMutableArray alloc]init];
    
    [self addNavBar];
    [self startMap];
    [self creatUI];
    [self loadIncomeAndAddsData];

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
    [mapView viewWillAppear];
    mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    

    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    
    //  _locService.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [mapView viewWillDisappear];
    mapView.delegate = nil; // 不用时，置nil
    
    //  _locService.delegate = nil;
}

#pragma mark-mapMethod

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    BMKCoordinateRegion region;
    
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0;
    region.span.longitudeDelta = 0;
    NSLog(@"当前的坐标是:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    longitudeStr = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    latitudeStr = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            if (placemark != nil) {
                NSString *city = placemark.locality;
                
                NSLog(@"当前城市名称------%@",city);
                self.locationCityName.text = city;
                localStr = city;
                BMKOfflineMap * _offlineMap = [[BMKOfflineMap alloc] init];
                NSArray* records = [_offlineMap searchCity:city];
                BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
                //城市编码如:北京为131
                NSInteger cityId = oneRecord.cityID;
                
             //   [self loadHotStoreData];根据定位加载商家
                
                [_locService stopUserLocationService];
            
            }
        }
    }];
}



#pragma mark-PrivateMethod


- (void)loadIncomeAndAddsData{
    NSDictionary *para = @{
                           
                           };
    //走势图
    [[MyAPI sharedAPI] getHomeIncomeChartDataWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            charArr = arrays[0];
            NSLog(@"=======收益权==%@",charArr);
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
    
    //广告位
    [[MyAPI sharedAPI] getHomeAddDataWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            [addArr addObjectsFromArray:arrays];

            NSLog(@"=======收益权==%@",addArr);
            [self.tableView reloadData];
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
    
}


- (void)loadHotStoreData{
  
    NSDictionary *para = @{
                           @"pageNum":@"1",
                           @"pageOffest":@"10",
                           @"cityName":localStr,
                           @"latitude":latitudeStr,
                           @"longitude":longitudeStr
                           };
    
    [[MyAPI sharedAPI]getHomeChartDataWithParameters:para resulet:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            NSArray *arrr = arrays[0];
            NSLog(@"%@",arrr);
        }else{
            
        }
        
    } errorResult:^(NSError *enginerError) {
        [self showHint:@"下载出错"];
    }];
   
}


- (void)startMap{
    _locService = [[BMKLocationService alloc]init];//定位功能的初始化
    _locService.delegate = self;//设置代理位self
    //启动LocationService
    [_locService startUserLocationService];//启动定位服务
    
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    //编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
    _geocodesearch.delegate = self;//设置代理为self
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
        
        firstCell.partnerBlock = ^{//合伙人超市
            [self performSegueWithIdentifier:@"partnerSegue" sender:nil];
        };
        firstCell.storeBlock = ^{//商户入口
            
            [self performSegueWithIdentifier:@"beStoreSegue" sender:nil];
           // [self performSegueWithIdentifier:@"unionSegue" sender:nil];
        };
        firstCell.scanBlock =^{ //扫一扫
            [self performSegueWithIdentifier:@"scanSegue" sender:nil];
        };
        firstCell.incomeBlock = ^{//收益权
            
        };
        firstCell.accountBlock =^{
            [self performSegueWithIdentifier:@"myAccountSegue" sender:nil];
        };
        firstCell.recordBlock = ^{//浏览记录
            
            [self performSegueWithIdentifier:@"historySegue" sender:nil];
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
           imageChartCell.addArray = addArr;
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
            
             [self performSegueWithIdentifier:@"incomeSegue" sender:nil];
        }
    }else if (indexPath.section == 2){
        NSLog(@"%ld-----%ld",(long)indexPath.section,(long)indexPath.row);
        
        
        
        /*
        NSDictionary *para = @{
                               @"tokenid": @"20ace013934a448887c7af6000dfa112",
                               @"platform":@"1", //0:Android ,  1:IOS
                               @"param": @{
                                       @"tradetype": @"APP",
                                       @"title": @"支付订单",
                                       @"ordertype": @"0",
                                       @"tomemid": @"4839a0d3-e758-44bf-aa51-cd7f0987b2fd" ,
                                       @"price": @"0.01",
                                       @"price_tbb": @"20",
                                       }
                               };
        
        
        [[MyAPI sharedAPI]getHomeChartDataWithParameters:para resulet:^(BOOL success, NSString *msg, NSArray *arrays) {
            if (success) {
                NSArray *arrr = arrays[0];
                NSLog(@"%@",arrr);
            }
            
        } errorResult:^(NSError *enginerError) {
            [self showHint:@"下载出错"];
        }];
       
        */
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
