//
//  ViewController.m
//  ymapkit_sample
//
//  Created by mahibino on 2013/04/23.
//  Copyright (c) 2013年 mahibino. All rights reserved.
//

#import "ViewController.h"
#import "MyAnnotation.h"
#import "MyPinAnnotationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGFloat width  = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;

    //YMKMapViewのインスタンスを作成
    map = [[YMKMapView alloc] initWithFrame:CGRectMake(0, 0, width, height) appid:@"lPoz6YGxg67mRwTTBxyQ32r5pZWr_VtZxmrFoCRhPmhwHeJHN7GPngjyLzGybXBF4A--" ];
    
    //地図のタイプを指定 標準の地図を指定
    map.mapType = YMKMapTypeStandard;
    
    //YMKMapViewを追加
    [self.view addSubview:map];

    //YMKMapViewDelegateを登録
    map.delegate = self;
 
    //ロケーションマネージャを作成
    locationMgr = [[CLLocationManager alloc] init];
    locationMgr.delegate = self;
     
    //地図の位置と縮尺を設定
    /*CLLocationCoordinate2D center;
    center.latitude = 35.6657214;
    center.longitude = 139.7310058;
    //縮尺をズーム値で指定(11 = 1/1525877)
    double zoom = width * 360.0/(1<<(7+11));
    map.region = YMKCoordinateRegionMake(center, YMKCoordinateSpanMake(zoom, zoom));*/
  
    //マップ初期表示位置を設定(日本列島がすべて表示される位置に設定)
    CLLocationCoordinate2D initialCordinate = CLLocationCoordinate2DMake(38.081382, 139.766084);
    YMKCoordinateSpan span = YMKCoordinateSpanMake(18.5, 18.5);
    YMKCoordinateRegion region = YMKCoordinateRegionMake(initialCordinate, span);
    [map setRegion:region animated:NO];

    //アイコンの緯度経度を設定
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 35.665818701569016;
    coordinate.longitude = 139.73087297164147;
    //MyAnnotationの初期化
    MyAnnotation* myAnnotation = [[MyAnnotation alloc] initWithLocationCoordinate:coordinate title:@"ミッドタウン" subtitle:@"ミッドタウンです。"];
  
    //AnnotationをYMKMapViewに追加
    [map addAnnotation:myAnnotation];
  
    //YMKWeatherOverlayを作成
    //weatherOverlay = [[YMKWeatherOverlay alloc] init];
      
    //YMKWeatherOverlayをYMKMapViewに追加
    //[map addOverlay:weatherOverlay];
    
    //雨雲時刻表示用ラベル、スライダーを全面に表示
    //[self.view addSubview:_weatherLabel];
    //[self.view addSubview:_weatherSlider];
    [self.view addSubview:_zoomIn];
    [self.view addSubview:_zoomOut];
    [self.view addSubview:_goGPS];
  [self.view addSubview:_weatherButton];
}

//Annotation追加イベント
- (YMKAnnotationView*)mapView:(YMKMapView *)mapView viewForAnnotation:(MyAnnotation*)annotation{
  //追加されたAnnotationがMyAnnotationか確認
  if([annotation isKindOfClass:[MyAnnotation class]]){
    //YMKPinAnnotationViewを作成
    MyPinAnnotationView *pin = [[MyPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"Pin"];
    //吹き出しに表示するボタンを追加
    UIButton * rightAccessoryButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [rightAccessoryButton setFrame:CGRectMake(0, 0, 29, 29)];
    [rightAccessoryButton setBackgroundImage:[UIImage imageNamed:@"purple_arrow.png"] forState:UIControlStateNormal];
    [pin setRightCalloutAccessoryView:rightAccessoryButton];
    pin.animatesDrop = YES;
    return pin;
  }
  return nil;
}

//吹き出しボタンイベント
- (void)mapView:(YMKMapView*)mapView annotationView:(YMKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
  //押されたのがどのピンか判定
  NSString *title = view.annotation.title;
  NSString *msg = @"メッセージ";
  UIAlertView *alert =
	[[UIAlertView alloc]
   initWithTitle:title
   message:msg
   delegate:self
   cancelButtonTitle:@"OK"
   otherButtonTitles:nil];
  [alert show];
  //if(view==pin){
    
  //}
}

//overlay追加イベント
- (YMKOverlayView*)mapView:(YMKMapView *)mapView viewForOverlay:(id )overlay
{
    //追加されたoverlayがYMKWeatherOverlay か確認
    if([overlay isKindOfClass:[YMKWeatherOverlay class]] ){
        //YMKWeatherOverlayView作成
        YMKWeatherOverlayView *weatherOverlayView = [[YMKWeatherOverlayView alloc] initWithOverlay:overlay];
        
        //YMKWeatherOverlayDelegateの設定
        weatherOverlayView.delegate = self;
        
        //アルファ値を設定
        weatherOverlayView.alpha = 0.6;
        
        //初回雨雲時刻を取得してラベルに表示
        [self finishUpdateWeather:weatherOverlayView];
       
        return weatherOverlayView;
    }
    return nil;
}

//画面の更新が行なわれると通知されます
-(void)finishUpdateWeather:(YMKWeatherOverlayView*)weatherOverlayView
{
    // 表示中の雨雲時刻を取得してラベルに表示
    NSDate *nowDate = weatherOverlayView.nowDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *jpLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja-JP"];
    [formatter setLocale:jpLocale];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    _weatherLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:nowDate]];
    NSLog([NSString stringWithFormat:@"%@", [formatter stringFromDate:nowDate]]);
}

//雨雲レーダー情報の取得でエラーが発生したら通知
-(void)errorUpdateWeather:(YMKWeatherOverlayView*)weatherOverlayView withError:(int)error
{
    NSLog(@"errorUpdateWeather");
}

//スライダーバーの値変更の通知
- (IBAction)weatherSlider:(id)sender {
    if ((int)_weatherSlider.value % 10 == 0){
        YMKWeatherOverlayView * overlayView = (YMKWeatherOverlayView *)[map viewForOverlay: weatherOverlay];
        if([overlayView isKindOfClass:[YMKWeatherOverlayView class]] ){
            //雨雲の時刻を設定して再表示
            [overlayView updateWeatherWithMinutes: _weatherSlider.value];
            NSLog([NSString stringWithFormat:@"%.3f", _weatherSlider.value]);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"didReceiveMemoryWarning");
}

- (IBAction)zoomIn:(id)sender {
  int zoomlevel = map.getZoomlevel;
  //double z = map.frame.size.width;
  double zoom = self.view.frame.size.width*360.0/(1<<(8+(zoomlevel+1)));
  YMKCoordinateRegion region = YMKCoordinateRegionMake(map.centerCoordinate, YMKCoordinateSpanMake(zoom, zoom));
  [map setRegion:region animated:YES];
  //map.region = YMKCoordinateRegionMake(map.centerCoordinate, YMKCoordinateSpanMake(zoom, zoom));
}

- (IBAction)zoomOut:(id)sender {
  int zoomlevel = map.getZoomlevel;
  double zoom = self.view.frame.size.width*360.0/(1<<(8+(zoomlevel-1)));
  YMKCoordinateRegion region = YMKCoordinateRegionMake(map.centerCoordinate, YMKCoordinateSpanMake(zoom, zoom));
  [map setRegion:region animated:YES];
  //map.region = YMKCoordinateRegionMake(map.centerCoordinate, YMKCoordinateSpanMake(zoom, zoom));
  //[map regionThatFits:map.region];
}

- (IBAction)goGPS:(id)sender {
  //現在位置取得
  [map setShowsUserLocation:YES];
  //userLocation = map.userLocation.location.coordinate;
  //map.region = YMKCoordinateRegionMake(userLocation, YMKCoordinateSpanMake(0.005, 0.005));

  [locationMgr startUpdatingLocation];
}

//現在位置取得完了
-(void)locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
  userLocation = newLocation.coordinate;
  
  //シミュレータでは現在位置を取得できないので、開発用にデフォルトの値を設定しておく
  //userLocation.latitude  = 35.6657214;
  //userLocation.longitude = 139.7310058;
  
  //地図の中心位置・縮尺を設定
  YMKCoordinateRegion region = YMKCoordinateRegionMake(userLocation, YMKCoordinateSpanMake(0.005, 0.005));
  [map setRegion:region animated:NO];
  [map regionThatFits:region];
    
  //測位を終了させる
  [locationMgr stopUpdatingLocation];
}

- (IBAction)weatherButton:(id)sender {
  //YMKWeatherOverlayを作成
  weatherOverlay = [[YMKWeatherOverlay alloc] init];
  
  //YMKWeatherOverlayをYMKMapViewに追加
  [map addOverlay:weatherOverlay];
  
  //雨雲時刻表示用ラベル、スライダーを全面に表示
  [self.view addSubview:_weatherLabel];
  [self.view addSubview:_weatherSlider];
}
@end
