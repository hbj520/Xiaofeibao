//
//  LocationViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

//百度
#import "AppDelegate.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#import "LocationViewController.h"

#import "LocationTableViewCell.h"
#import "ProvinceHeadView.h"

#import <Masonry.h>

@interface LocationViewController ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKOfflineMapDelegate>{
   
    
    BOOL _isExpand[100];
    
     NSArray* _sectionTitleArray;
    
     NSArray* _dataArray;
    
    
    NSMutableArray *_locationArray;
    NSMutableArray *_provinceArray;
    
    
    BMKLocationService* _locService;//定位
    BMKOfflineMap * _offlineMap;
    BMKGeoCodeSearch* _geocodesearch;//反编码
    
    NSString *longitudeStr;
    NSString *latitudeStr;
    NSString *localStr;
    NSString *cityCode;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end



@implementation LocationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavi];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cityNowLab.text = [NSString stringWithFormat:@"当前城市：%@",self.locaStr];
   // [self.caityNowBtn setTitle:self.locaStr forState:0];
    
    [self configTableView];
    [self setNavi];

    [self startMap];
    [self loadLocationData];
    
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
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            if (placemark != nil) {
                NSString *city = placemark.locality;
                
                NSLog(@"当前城市名称------%@",city);
                [self.caityNowBtn setTitle:city forState:0] ;
                localStr = city;
                NSArray* records = [_offlineMap searchCity:city];
                BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
                //城市编码如:北京为131
                int cityId = oneRecord.cityID;
                
                cityCode = [NSString stringWithFormat:@"%d",oneRecord.cityID];
             
                if ([_offlineMap remove:cityId]) {
                    
                }else{
                    
                };
                
                [_locService stopUserLocationService];
            }
        }
    }];
}



- (void)loadLocationData{
    NSDictionary *para = @{
                           
                           };
    [[MyAPI sharedAPI] getdevelopCityArrWithMeters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            [_provinceArray removeAllObjects];
            [_locationArray removeAllObjects];
            
            _locationArray = arrays[1];
            _provinceArray = arrays[0];
            [self.tableView reloadData];
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (void)startMap{
    _locService = [[BMKLocationService alloc]init];//定位功能的初始化
    _locService.delegate = self;//设置代理位self
    //启动LocationService
    [_locService startUserLocationService];//启动定位服务
    
    _offlineMap = [[BMKOfflineMap alloc] init];
    
}

- (void)setNavi{
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (IBAction)locateClick:(id)sender {
    
    NSLog(@"😝%@",self.caityNowBtn.titleLabel.text);
    if (self.locaBlock) {
        self.locaBlock(@[localStr,cityCode]);
    }
    [self backTolastPage];
}


- (void)configTableView{

    
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.rowHeight = 40;
    self.tableView.sectionHeaderHeight = 48;
    self.tableView.tableFooterView =  [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"LocationTableViewCell" bundle:nil]forCellReuseIdentifier:@"locationCellId"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return _provinceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isExpand[section]) {
        return [_locationArray[section] count];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LocationTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.rightImage.hidden = NO;
    
    locationModel *model = _locationArray[indexPath.section][indexPath.row];
    
    if (model.cityCode == nil) {
        model.cityCode = @"";
    }
    
    if (self.locaBlock) {
        self.locaBlock(@[model.city,model.cityCode]);
    }
    [self backTolastPage];
   
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCellId" forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LocationTableViewCell" owner:self options:nil]lastObject];
    }
    
    if (_locationArray.count > 0) {
        cell.model = _locationArray[indexPath.section][indexPath.row];
    }
    
    
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ProvinceHeadView *view = [[[NSBundle mainBundle] loadNibNamed:@"ProvinceHeadView" owner:self options:nil]lastObject];
    view.proModel = _provinceArray[section];
    view.arrowImage.image = [UIImage imageNamed:@"ss_720"];
      __weak typeof(view) weakViewSelf = view;
    view.openBlock =^{
      _isExpand[section] = !_isExpand[section];
        [UIView animateWithDuration:0.3 animations:^{
            
            if (_isExpand[section]) {
                weakViewSelf.arrowImage.transform = CGAffineTransformMakeRotation(M_PI_2);
            } else {
                weakViewSelf.arrowImage.transform = CGAffineTransformIdentity;
            }
        }];
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section]
                 withRowAnimation:UITableViewRowAnimationFade];
    };
    view.contentView.backgroundColor = RGBACOLOR(230, 234, 235, 1);
    return view;
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
