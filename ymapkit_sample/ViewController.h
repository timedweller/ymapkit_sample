//
//  ViewController.h
//  ymapkit_sample
//
//  Created by mahibino on 2013/04/23.
//  Copyright (c) 2013年 mahibino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YMapKit/YMapKit.h> //YMapKit.frameworkのヘッダーファイルをインポート

// @interface ViewController : UIViewController
@interface ViewController : UIViewController <YMKMapViewDelegate, YMKWeatherOverlayDelegate> {
    YMKMapView *map; //YMKMapViewインスタンス用ポインタ
    YMKWeatherOverlay * weatherOverlay; //YMKWeatherOverlayインスタンス用ポインタ
}

@end
