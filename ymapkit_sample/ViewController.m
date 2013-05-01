//
//  ViewController.m
//  ymapkit_sample
//
//  Created by mahibino on 2013/04/23.
//  Copyright (c) 2013年 mahibino. All rights reserved.
//

#import "ViewController.h"

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
    
    //地図の位置と縮尺を設定
    CLLocationCoordinate2D center;
    center.latitude = 35.6657214;
    center.longitude = 139.7310058;
    //縮尺をズーム値で指定(11 = 1/1525877)
    double zoom = width * 360.0/(1<<(7+11));
    map.region = YMKCoordinateRegionMake(center, YMKCoordinateSpanMake(zoom, zoom));

    //YMKWeatherOverlayを作成
    weatherOverlay = [[YMKWeatherOverlay alloc] init];
    
    //YMKWeatherOverlayをYMKMapViewに追加
    [map addOverlay:weatherOverlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//overlay追加イベント
- (YMKOverlayView*)mapView:(YMKMapView *)mapView viewForOverlay:(id )overlay
{
    //追加されたoverlayがYMKWeatherOverlay か確認
    if([overlay isKindOfClass:[YMKWeatherOverlay class]] ){
        //YMKWeatherOverlayView作成
        YMKWeatherOverlayView *weatherOverlayView = [[YMKWeatherOverlayView alloc]
                                                     initWithOverlay:overlay];
        //YMKWeatherOverlayDelegateの設定
        weatherOverlayView.delegate = self;
        //アルファ値を設定
        weatherOverlayView.alpha = 0.6;
        return weatherOverlayView ;
    }
    return nil;
}

//画面の更新が行なわれると通知されます。
-(void)finishUpdateWeather:(YMKWeatherOverlayView*)weatherOverlayView
{
    
}

//雨雲レーダー情報の取得でエラーが発生したら通知
-(void)errorUpdateWeather:(YMKWeatherOverlayView*)weatherOverlayView withError:(int)error
{
    
}

@end
