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
@interface ViewController : UIViewController <YMKWeatherOverlayDelegate, YMKMapViewDelegate> {
    YMKMapView *map; //YMKMapViewインスタンス用ポインタ
    YMKWeatherOverlay *weatherOverlay; //YMKWeatherOverlayインスタンス用ポインタ
}

@property (weak, nonatomic) IBOutlet UISlider *weatherSlider;
- (IBAction)weatherSlider:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *weatherLabel2;
@end
