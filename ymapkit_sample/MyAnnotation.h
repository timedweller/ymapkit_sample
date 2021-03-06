//
//  MyAnnotation.h
//  ymapkit_sample
//
//  Created by mahibino on 2013/05/29.
//  Copyright (c) 2013年 mahibino. All rights reserved.
//

#import <YMapKit/YMapKit.h>
#import <Foundation/Foundation.h>

@interface MyAnnotation : NSObject <YMKAnnotation> {
  CLLocationCoordinate2D coordinate;
  NSString *annotationTitle;
  NSString *annotationSubtitle;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *annotationTitle;
@property (nonatomic, retain) NSString *annotationSubtitle;

- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) coord
                           title:(NSString *)annTitle subtitle:(NSString *)annSubtitle;
- (NSString *)title;
- (NSString *)subtitle;
@end
