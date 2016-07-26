//
//  TLNavigationBar.m
//  tongle
//
//  Created by jixiaofei-mac on 15-5-26.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLNavigationBar.h"
#import "TLCommon.h"
#import "TLImageName.h"

@implementation TLNavigationBar

int TL_NAVI_RIGHT_IMAGE_YWH = 30;


-(void)creatWithTitle:(NSString *)title
{
    
    UILabel *titleCenter = [[UILabel alloc]init];
    titleCenter.text = title;
    titleCenter.font = TL_NAVI_TITLE_FONT;
    CGSize titleSize = [titleCenter.text sizeWithAttributes:@{NSFontAttributeName:TL_NAVI_TITLE_FONT}];
    titleCenter.bounds = (CGRect){{0,0},titleSize};
    titleCenter.center = CGPointMake(ScreenBounds.size.width/2, TL_NAVI_TITLE_CENTER_Y);
    [self addSubview:titleCenter];
    self.titleCenter = titleCenter;

}


-(void)creatWithLeftButtonAndtitle:(NSString *)title
{
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 30, 70, 25);
    [left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [left setImage:[UIImage imageNamed:TL_NAVI_BACK_NORMAL] forState:UIControlStateNormal];
    [left setImage:[UIImage imageNamed:TL_NAVI_BACK_PRESS] forState:UIControlStateHighlighted];
    [self addSubview:left];
    
    UILabel *titleCenter = [[UILabel alloc]init];
    titleCenter.text = title;
    titleCenter.tag = 1111;
    titleCenter.font = TL_NAVI_TITLE_FONT;
    CGSize titleSize = [titleCenter.text sizeWithAttributes:@{NSFontAttributeName:TL_NAVI_TITLE_FONT}];
    titleCenter.bounds = (CGRect){{0,0},titleSize};
    titleCenter.center = CGPointMake(ScreenBounds.size.width/2, TL_NAVI_TITLE_CENTER_Y);
    [self addSubview:titleCenter];
    self.titleCenter = titleCenter;
    
}

-(void)creatWithLeftAndRightButtonAndtitle:(NSString *)title  collectBool:(int)collectBool
{
    [self creatWithLeftButtonAndtitle:title];
    UIButton *collect = [UIButton buttonWithType:UIButtonTypeCustom];
    collect.frame = CGRectMake(ScreenBounds.size.width-2*TL_NAVI_RIGHT_IMAGE_YWH-20-10, TL_NAVI_RIGHT_IMAGE_YWH, TL_NAVI_RIGHT_IMAGE_YWH, TL_NAVI_RIGHT_IMAGE_YWH);
    NSString *image = collectBool==0? TL_COLLECT_COLLECT : TL_COLLECT__NORMAL;
    [collect setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [collect setImage:[UIImage imageNamed:TL_COLLECT__PRESS] forState:UIControlStateHighlighted];
    collect.tag = 100;
    [self addSubview:collect];
    
    UIButton *qrcode = [UIButton buttonWithType:UIButtonTypeCustom];
    qrcode.frame  = CGRectMake(ScreenBounds.size.width-TL_NAVI_RIGHT_IMAGE_YWH-10, TL_NAVI_RIGHT_IMAGE_YWH, TL_NAVI_RIGHT_IMAGE_YWH, TL_NAVI_RIGHT_IMAGE_YWH);
    [qrcode setImage:[UIImage imageNamed:TL_QR_CODE_NORMAL] forState:UIControlStateNormal];
    [qrcode setImage:[UIImage imageNamed:TL_QR_CODE_PRESS] forState:UIControlStateHighlighted];
    qrcode.tag = 101;
    [self addSubview:qrcode];
}

-(void)creatWithLeftButtonAndtitle:(NSString *)title barButton:(UIBarButtonItem *)barButtonItem;
{
    [self creatWithLeftButtonAndtitle:title];
   // UIBarButtonItem *bar = [[UIBarButtonItem alloc]init];
    
}


-(void)back
{
    if ([self.Delegate respondsToSelector:@selector(tlNavigationBarBack)]) {
        [self.Delegate tlNavigationBarBack];
    }
}

-(void)setCenterTitle:(NSString *)title
{
    UILabel *centerTitle = [self viewWithTag:1111];
    centerTitle.text = title;
    CGSize titleSize = [centerTitle.text sizeWithAttributes:@{NSFontAttributeName:TL_NAVI_TITLE_FONT}];
    centerTitle.bounds = (CGRect){{0,0},titleSize};
    centerTitle.center = CGPointMake(ScreenBounds.size.width/2, TL_NAVI_TITLE_CENTER_Y);
}


@end
