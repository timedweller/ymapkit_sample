//
//  AppDelegate.h
//  ymapkit_sample
//
//  Created by mahibino on 2013/04/23.
//  Copyright (c) 2013年 mahibino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YMapKit/YMapKit.h> //YMapKit.frameworkのヘッダーファイルをインポート

@interface AppDelegate : NSObject <UIApplicationDelegate, YMKMapViewDelegate> {
    UIWindow *window;
    YMKMapView *map; //YMKMapViewインスタンス用ポインタ
}
//@interface AppDelegate :UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
