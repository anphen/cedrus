//
//  CustomErrorView.h
//  bang5maiWap
//
//  Created by boguang on 15/4/22.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomErrorView : UIView
@property (nonatomic, copy) voidBlock block;

- (id) parentView:(UIView *) view;

- (id) appear;

- (id) appearWithTitle:(NSString *) title;

- (id) disappear;

- (BOOL) isAppear;
@end
