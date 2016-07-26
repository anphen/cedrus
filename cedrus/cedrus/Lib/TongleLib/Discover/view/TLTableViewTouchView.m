//
//  TLTableViewTouchView.m
//  tongle
//
//  Created by jixiaofei-mac on 16/1/11.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLTableViewTouchView.h"

@implementation TLTableViewTouchView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    id view = [super hitTest:point withEvent:event];
    if ([view isKindOfClass:[UITextField class]]) {
        return view;
    }else if([view isKindOfClass:[UIButton class]])
    {
        [self endEditing:YES];
        return view;
    }else
    {
        [self endEditing:YES];
        return self;
    }
}


@end
