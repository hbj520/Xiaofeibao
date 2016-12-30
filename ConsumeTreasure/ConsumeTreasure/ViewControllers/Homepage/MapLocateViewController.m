//
//  MapLocateViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MapLocateViewController.h"

#import "cityModel.h"

@interface MapLocateViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>
{
    BMKPinAnnotationView *newAnnotation;
    
    BMKGeoCodeSearch *_geoCodeSearch;
    
    BMKReverseGeoCodeOption *_reverseGeoCodeOption;
    
    BMKLocationService *_locService;
}
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIButton *mapPin;

@property (weak, nonatomic) IBOutlet UILabel *longtitudeLab;//经度
@property (weak, nonatomic) IBOutlet UILabel *latitudeLab;//纬度

@end

@implementation MapLocateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initLocationService];
}

#pragma mark 初始化地图，定位
-(void)initLocationService
{
    
    [_mapView setMapType:BMKMapTypeStandard];// 地图类型 ->卫星／标准、
    
    _mapView.zoomLevel=17;
    _mapView.delegate=self;
    _mapView.showsUserLocation = YES;
    
    [_mapView bringSubviewToFront:_mapPin];
    
    
    if (_locService==nil) {
        
        _locService = [[BMKLocationService alloc]init];
        
        [_locService setDesiredAccuracy:kCLLocationAccuracyBest];
    }
    
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
}



#pragma mark BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    _mapView.showsUserLocation = YES;//显示定位图层
    //设置地图中心为用户经纬度
    [_mapView updateLocationData:userLocation];
    
    
    //    _mapView.centerCoordinate = userLocation.location.coordinate;
    BMKCoordinateRegion region ;//表示范围的结构体
    region.center = _mapView.centerCoordinate;//中心点
    region.span.latitudeDelta = 0.004;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.004;//纬度范围
    
    
//    self.latitudeLab.text = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
//    self.longtitudeLab.text = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    
    [_mapView setRegion:region animated:YES];
    
}


#pragma mark BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //屏幕坐标转地图经纬度
    CLLocationCoordinate2D MapCoordinate=[_mapView convertPoint:_mapPin.center toCoordinateFromView:_mapView];
    
    self.latitudeLab.text = [NSString stringWithFormat:@"%f",MapCoordinate.latitude];
    self.longtitudeLab.text = [NSString stringWithFormat:@"%f",MapCoordinate.longitude];
    
    if (_geoCodeSearch==nil) {
        //初始化地理编码类
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;
        
    }
    if (_reverseGeoCodeOption==nil) {
        
        //初始化反地理编码类
        _reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    }
    
    //需要逆地理编码的坐标位置
    _reverseGeoCodeOption.reverseGeoPoint =MapCoordinate;
    [_geoCodeSearch reverseGeoCode:_reverseGeoCodeOption];
    
    /*
    MKCoordinateRegion region;
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    region.center= centerCoordinate;
    
    NSLog(@" regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
    
     */
     
}

#pragma mark BMKGeoCodeSearchDelegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //获取周边用户信息
    if (error==BMK_SEARCH_NO_ERROR) {
        
      //  [self.cityDataArr removeAllObjects];
        for(BMKPoiInfo *poiInfo in result.poiList)
        {
            
            
           // cityModel *model=[[cityModel alloc]init];
//            model.name=poiInfo.name;
//            model.address=poiInfo.address;
         //   CLLocationCoordinate2D _pt
         
            
          //  [self.cityDataArr addObject:model];
           // [self.cityTableview reloadData];
        }
    }else{
        
        NSLog(@"BMKSearchErrorCode: %u",error);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sure:(id)sender {
    
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
