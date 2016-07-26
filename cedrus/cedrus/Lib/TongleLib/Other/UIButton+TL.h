//
//  UIButton+TL.h
//  tongle
//
//  Created by liu on 15-4-21.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TL)
/**
 *  创建一个按键
 *
 *  @param title      按键的title
 *  @param titleColor 按键title的颜色
 *
 *  @return 返回一个创建好的带边缘线的椭圆形按键
 */
+(UIButton *)createButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;
+(UIButton *)buttonWithCormalImage:(NSString *)cormalImage pressImage:(NSString *)pressImage;
+(UIButton *)createButtonWithTitle:(NSString *)title Color:(UIColor *)titleColor;
-(void)ButtonDelay;
@end
