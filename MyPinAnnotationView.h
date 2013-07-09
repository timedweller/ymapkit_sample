//
//  MyPinAnnotationView.h
//  ymapkit_sample
//
//  Created by mahibino on 2013/05/29.
//  Copyright (c) 2013年 mahibino. All rights reserved.
//

#import <YMapKit/YMapKit.h>
#import "MyAnnotation.h"

@interface MyPinAnnotationView : YMKPinAnnotationView

- (void)setSelected:(BOOL)_selected animated:(BOOL)animated;

@end
