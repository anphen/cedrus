//
//  TLpostDetailScrollView.h
//  tongle
//
//  Created by liu ruibin on 15-5-18.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLpostDetailFrame,TLpostDetailScrollView;

@protocol postDetailScrollViewdelegate <NSObject>

@optional

-(void)postDetailScrollView:(TLpostDetailScrollView *)postDetailScrollView withcode:(UIButton *)button;

-(void)postDetailScrollView:(TLpostDetailScrollView *)postDetailScrollView withGesture:(UITapGestureRecognizer *)Gesture;

@end


@interface TLpostDetailScrollView : UIView

@property (nonatomic,strong) TLpostDetailFrame *postDetailFrame;
@property (nonatomic,assign) id <postDetailScrollViewdelegate>delegate;

@end
