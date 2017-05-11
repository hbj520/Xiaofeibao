//
//  MapLocateViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MapLocateViewController.h"

#import "cityModel.h"
#import "KGModal.h"

@interface MapLocateViewController ()<
BMKMapViewDelegate,
BMKGeoCodeSearchDelegate
,BMKLocationServiceDelegate,
UITableViewDelegate,
UITableViewDataSource>
{
    //BMKPinAnnotationView *newAnnotation;
    
    BMKGeoCodeSearch *_geoCodeSearch;
    
    BMKReverseGeoCodeOption *_reverseGeoCodeOption;
    
    BMKLocationService *_locService;
    NSString *address;
}
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *mapPin;//大头针
@property (weak, nonatomic) IBOutlet UILabel *longtitudeLab;//经度
@property (weak, nonatomic) IBOutlet UILabel *latitudeLab;//纬度
- (IBAction)selectNearbyLocation:(id)sender;
@property (nonatomic, strong)  NSMutableArray *cityDataArr;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (nonatomic, strong) UITableView *cityTableview;
@end

@implementation MapLocateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initLocationService];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
 
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil

}


#pragma mark 初始化地图，定位
-(void)initLocationService
{
    self.cityDataArr = [NSMutableArray arrayWithCapacity:10];
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
    
    BMKCoordinateRegion region ;//表示范围的结构体
    region.center = _mapView.centerCoordinate;//中心点
    region.span.latitudeDelta = 0.004;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.004;//纬度范围
    
    [_mapView setRegion:region animated:YES];
    
}


#pragma mark BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //屏幕坐标转地图经纬度
    CLLocationCoordinate2D MapCoordinate=[_mapView convertPoint:_mapPin.center toCoordinateFromView:_mapView];
    
    //获取经纬度
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
 
}

#pragma mark BMKGeoCodeSearchDelegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //获取周边用户信息
    if (error==BMK_SEARCH_NO_ERROR) {
        address = result.address;
        self.areaLabel.text = address;
        [self.cityDataArr removeAllObjects];
        for(BMKPoiInfo *poiInfo in result.poiList)
        {
            
            
            cityModel *model=[[cityModel alloc]init];
            model.name=poiInfo.name;
            model.address=poiInfo.address;
            CLLocationCoordinate2D _pt;
         
            
           [self.cityDataArr addObject:model];
           [self.cityTableview reloadData];
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
    
    if (self.jwdBlock) {
        self.jwdBlock(@[self.latitudeLab.text,self.longtitudeLab.text,self.areaLabel.text]);
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectNearbyLocation:(id)sender {
    self.cityTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 240) style:UITableViewStylePlain];
    [self.cityTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseId"];
    self.cityTableview.delegate = self;
    self.cityTableview.dataSource = self;
    [[KGModal sharedInstance] setCloseButtonType:KGModalCloseButtonTypeNone];
    [KGModal sharedInstance].modalBackgroundColor = [UIColor whiteColor];
    [[KGModal sharedInstance] showWithContentView:self.cityTableview andAnimated:YES];
}
#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cityDataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellReuseId = @"reuseId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
    cityModel *model = self.cityDataArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",model.address,model.name];
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    cityModel *model = self.cityDataArr[indexPath.row];
    self.areaLabel.text = [NSString stringWithFormat:@"%@(%@)",model.address,model.name];
    [[KGModal sharedInstance] hideAnimated:YES];
}
@end
