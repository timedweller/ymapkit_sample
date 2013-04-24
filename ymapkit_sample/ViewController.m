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
    map.region = YMKCoordinateRegionMake(center, YMKCoordinateSpanMake(0.015, 0.015));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
