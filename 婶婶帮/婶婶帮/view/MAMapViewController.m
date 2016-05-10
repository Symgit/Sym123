//
//  MAMapViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/21.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "MAMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "AddressViewController.h"
@interface MAMapViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;//搜索
    AMapReGeocodeSearchRequest *regeo;//构造AMapReGeocodeSearchRequest对象
    NSMutableArray * dataSource;//数据源
    NSString * cityStr;//当前城市
    NSString * areaStr;//用户所在城市的那个区
    CGFloat latitude;
    CGFloat longitude;
    NSString * aStr;
    AddressViewController * add;
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong)AMapLocationManager * locationManager;
@end

@implementation MAMapViewController
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MAMapServices sharedServices].apiKey = @"44fd27cd9783509b615dede053f0d22a";
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 350)];
    _mapView.delegate = self;
    _mapView.language = MAMapLanguageZhCN;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    [_mapView setZoomLevel:16.1 animated:YES];
    [self.view addSubview:_mapView];
    //配置用户Key
    [self uitableV];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    add = [[AddressViewController alloc]init];
    //[self uitableV];
    _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    //单次定位
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [self MALocation];
    [self uitableV];
}
- (void)CloudPOIAroundSearch{
    //构造AMapCloudPOIAroundSearchRequest对象，设置云周边检索请求参数
    AMapCloudPOIAroundSearchRequest *request = [[AMapCloudPOIAroundSearchRequest alloc] init];
    request.tableID = @"id";//在数据管理台中取得
    request.center = [AMapGeoPoint locationWithLatitude:latitude longitude:longitude];
    request.radius = 1000;
    request.keywords = @"街道";
    
    //发起云周边搜索
    [_search AMapCloudPOIAroundSearch: request];
}
- (void)onCloudSearchDone:(AMapCloudSearchBaseRequest *)request response:(AMapCloudPOISearchResponse *)response
{
    if(response.POIs.count == 0)
    {
        return;
    }
    //获取云图数据并显示
    
}
//通过关键字查找
- (void)MAPPOIAround{
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:latitude longitude:longitude];
    //request.keywords = @"津门";
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    request.types = @"道路附属设施|商务住宅";
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [_search AMapPOIAroundSearch: request];
}
//实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
    
    //通过 AMapPOISearchResponse 对象处理搜索结果
    //    NSString *strCount = [NSString stringWithFormat:@"count: %ld",(long)response.count];
    //    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion.keywords];
    NSString *strPoi = @"";
    dataSource = [NSMutableArray array];
    
    for (AMapPOI *p in response.pois) {
        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.name];
        [dataSource addObject:p.name];
    }
    [self.tableView reloadData];
    //    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
}


//通过经纬度查找
- (void)MapSearchServices{
    [AMapSearchServices sharedServices].apiKey = @"44fd27cd9783509b615dede053f0d22a";
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
    //构造AMapReGeocodeSearchRequest对象
    regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:latitude     longitude:longitude];
    regeo.radius = 10000;
    regeo.requireExtension = YES;
    //发起逆地理编码
    [_search AMapReGoecodeSearch: regeo];
//    NSLog(@"132123= %f",longitude);//维度
//    NSLog(@"123123= %f",latitude);//精度
}
//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        //NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode];
       // NSLog(@"province----%@,dis---- %@",response.regeocode.addressComponent.province,response.regeocode.addressComponent.district);
        cityStr = response.regeocode.addressComponent.province;
        //获取当前城市名称
       // NSLog(@"ReGeo: %@",cityStr);
    }
}

//定位获取当前的位置信息
- (void)MALocation{
    //   定位超时时间，可修改，最小2s
    self.locationManager.locationTimeout = 3;
    //   逆地理请求超时时间，可修改，最小2s
    self.locationManager.reGeocodeTimeout = 3;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
       // NSLog(@"location:%@", location);
        if (regeocode)
        {
            areaStr = [NSString stringWithFormat:@"%@",regeocode.district];
            NSLog(@"reGeocode:%@", regeocode.district);
        }
    }];
}

//定位的代理方法
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        //NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        latitude = userLocation.coordinate.latitude;
        longitude = userLocation.coordinate.longitude;
        [self MapSearchServices];
        [self MAPPOIAround];
    }
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image = [UIImage imageNamed:@"location.png"];
        pre.lineWidth = 3;
        pre.lineDashPattern = @[@6, @3];
        
        [_mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    }
}
- (void)uitableV{
    UITableView *  tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 350, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-350) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataSource.count == 0) {
        return 6;
    }
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (dataSource.count == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.item];
    }else{
        cell.textLabel.text = dataSource[indexPath.item];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (dataSource.count == 0) {
        if (_cityBlock != nil) {
            _cityBlock(@"无可用地址");
        }
    }else{
        NSString * str = [NSString stringWithFormat:@"%@%@%@",cityStr,areaStr,dataSource[indexPath.item]];
        if (_cityBlock != nil) {
            _cityBlock(str);
        }
    }
    //add.textField.text = dataSource[indexPath.item];
    NSLog(@"data= %@",add.cellStr);
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (void)setLoctionIsCity:(CustomCity)city{
    _cityBlock = city;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
