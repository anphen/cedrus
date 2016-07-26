//
//  TLButton.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-15.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLButton.h"
#import "UIColor+TL.h"
@implementation TLButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        self.imageView.contentMode = UIViewContentModeRight;
        
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:2.0]; //设置矩圆角半径
        [self.layer setBorderWidth:1.0];   //边框宽度
        CGColorRef colorref2 = [UIColor getColor:@"d7d7d7"].CGColor;
        [self.layer setBorderColor:colorref2];//边框颜色
        
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.height/2;
    CGFloat imageH = contentRect.size.height/2;
    contentRect  = (CGRect){{imageW,imageW/2},{imageW,imageH}};
    return contentRect;
}


-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width-contentRect.size.height;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = contentRect.size.height;
    CGFloat imageY = 0;
    contentRect = (CGRect){{imageX,imageY},{imageW,imageH}};
    return contentRect;

}

@end
