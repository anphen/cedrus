//
//  UIBarButtonItem+TL.m
//  tongle
//
//  Created by jixiaofei-mac on 15-5-18.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "UIBarButtonItem+TL.h"
#import "TLImageName.h"
@implementation UIBarButtonItem (TL)



+(UIBarButtonItem *)rigthButtonItemWithCollectBool:(int)collectBool
{
    UIView *rigthBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30*2+20, 30)];
    
    UIButton *collect = [UIButton buttonWithType:UIButtonTypeCustom];
    collect.frame = CGRectMake(0, 0, 30, 30);
    NSString *image = collectBool==0? TL_COLLECT_COLLECT : TL_COLLECT__NORMAL;
    [collect setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [collect setImage:[UIImage imageNamed:TL_COLLECT__PRESS] forState:UIControlStateHighlighted];
    collect.tag = 100;
    [rigthBarView addSubview:collect];
    
    UIButton *qrcode = [UIButton buttonWithType:UIButtonTypeCustom];
    qrcode.frame  = CGRectMake(30+20, 0, 30, 30);
    [qrcode setImage:[UIImage imageNamed:TL_QR_CODE_NORMAL] forState:UIControlStateNormal];
    [qrcode setImage:[UIImage imageNamed:TL_QR_CODE_PRESS] forState:UIControlStateHighlighted];
    qrcode.tag = 101;
    [rigthBarView addSubview:qrcode];
    
    rigthBarView.backgroundColor = [UIColor clearColor];
    
    return [[UIBarButtonItem alloc]initWithCustomView:rigthBarView];
}

@end
