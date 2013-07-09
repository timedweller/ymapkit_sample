//
//  MyPinAnnotationView.m
//  ymapkit_sample
//
//  Created by mahibino on 2013/05/29.
//  Copyright (c) 2013年 mahibino. All rights reserved.
//

#import "MyPinAnnotationView.h"

@implementation MyPinAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setSelected:(BOOL)_selected animated:(BOOL)animated
{
  [super setSelected:_selected animated:animated];
  self.canShowCallout = NO;
  if(_selected ==YES){
    //ピンが選択された場合
    NSString *title = self.annotation.title;
    NSString *msg = @"メッセージ";
    UIAlertView *alert =
    [[UIAlertView alloc]
     initWithTitle:title
     message:msg
     delegate:self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
    [alert show];
  }else{
    //ピンが非選択になった場合
    NSString *title = self.annotation.subtitle;
  }
}

@end
