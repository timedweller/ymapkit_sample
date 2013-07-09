//
//  ViewController.h
//  ymapkit_sample
//
//  Created by mahibino on 2013/04/23.
//  Copyright (c) 2013年 mahibino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YMapKit/YMapKit.h> //YMapKit.frameworkのヘッダーファイルをインポート
#import <CoreLocation/CoreLocation.h> // CoreLocationを読み込む

// @interface ViewController : UIViewController
@interface ViewController : UIViewController <YMKWeatherOverlayDelegate, YMKMapViewDelegate, CLLocationManagerDelegate> {
    YMKMapView *map; //YMKMapViewインスタンス用ポインタ
    YMKWeatherOverlay *weatherOverlay; //YMKWeatherOverlayインスタンス用ポインタ
    CLLocationManager *locationMgr;  //ロケーションマネージャ
    CLLocationCoordinate2D userLocation;  //ユーザの位置（緯度経度）
}

@property (weak, nonatomic) IBOutlet UISlider *weatherSlider;
- (IBAction)weatherSlider:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;

@property (weak, nonatomic) IBOutlet UIButton *zoomIn;
- (IBAction)zoomIn:(id)sender;
- (IBAction)zoomOut:(id)sender;
- (IBAction)goGPS:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *zoomOut;
@property (weak, nonatomic) IBOutlet UIButton *goGPS;
@property (weak, nonatomic) IBOutlet UIButton *weatherButton;
- (IBAction)weatherButton:(id)sender;

@end
