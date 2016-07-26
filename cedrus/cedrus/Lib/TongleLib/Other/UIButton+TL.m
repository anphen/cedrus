//
//  UIButton+TL.m
//  tongle
//
//  Created by liu on 15-4-21.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "UIButton+TL.h"
#import "UIColor+TL.h"
#import "TLCommon.h"

@implementation UIButton (TL)

+(UIButton *)createButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor
{
    UIButton *PaymentBtn = [[UIButton alloc]init];
    [PaymentBtn setTitle:title forState:UIControlStateNormal];
    [PaymentBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [PaymentBtn setTitleColor:[UIColor getColor:@"505050"] forState:UIControlStateHighlighted];
    
    PaymentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [PaymentBtn setBackgroundImage:[UIImage imageNamed:@"common_button_red_disable@2x.png"] forState:UIControlStateNormal];
    [PaymentBtn setBackgroundImage:[UIImage imageNamed:@"common_button_big_red_os7@2x.png"] forState:UIControlStateHighlighted];
    
    [PaymentBtn.layer setMasksToBounds:YES];
    [PaymentBtn.layer setCornerRadius:2.0]; //设置矩圆角半径
    [PaymentBtn.layer setBorderWidth:1.0];   //边框宽度
   // CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    //CGColorRef colorref2 = CGColorCreate(colorSpace2,(CGFloat[]){ 1, 0, 0, 1 });
    CGColorRef colorref2 = [UIColor getColor:@"d7d7d7"].CGColor;
    [PaymentBtn.layer setBorderColor:colorref2];//边框颜色
    return  PaymentBtn;
}


+(UIButton *)buttonWithCormalImage:(NSString *)cormalImage pressImage:(NSString *)pressImage
{
    UIButton *Btn = [[UIButton alloc]init];
    
    [Btn setImage:[UIImage imageNamed:cormalImage] forState:UIControlStateNormal];
    [Btn setImage:[UIImage imageNamed:pressImage] forState:UIControlStateHighlighted];
    
    [Btn.layer setMasksToBounds:YES];
    [Btn.layer setCornerRadius:8.0]; //设置矩圆角半径
    [Btn.layer setBorderWidth:1.0];   //边框宽度
    // CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    //CGColorRef colorref2 = CGColorCreate(colorSpace2,(CGFloat[]){ 1, 0, 0, 1 });
    CGColorRef colorref2 = [UIColor getColor:@"d7d7d7"].CGColor;
    [Btn.layer setBorderColor:colorref2];//边框颜色
    return  Btn;

}

+(UIButton *)createButtonWithTitle:(NSString *)title Color:(UIColor *)titleColor
{
    UIButton *PaymentBtn = [[UIButton alloc]init];
    [PaymentBtn setTitle:title forState:UIControlStateNormal];
    [PaymentBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [PaymentBtn setTitleColor:titleColor forState:UIControlStateHighlighted];
    
    PaymentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [PaymentBtn.layer setMasksToBounds:YES];
    [PaymentBtn.layer setCornerRadius:5.0]; //设置矩圆角半径
    [PaymentBtn.layer setBorderWidth:1.0];   //边框宽度
    // CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    //CGColorRef colorref2 = CGColorCreate(colorSpace2,(CGFloat[]){ 1, 0, 0, 1 });
    CGColorRef colorref2 = titleColor.CGColor;
    [PaymentBtn.layer setBorderColor:colorref2];//边框颜色
    return  PaymentBtn;
}

-(void)ButtonDelay
{
    self.enabled = NO;
    [self performSelector:@selector(delay) withObject:nil afterDelay:0.7f];
}

//延时返回
-(void)delay
{
   self.enabled = YES;
}


@end
