//
//  UIColor+TL.m
//  tongle
//
//  Created by ruibin liu on 15/5/11.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "UIColor+TL.h"
#import <Foundation/NSScanner.h>

@implementation UIColor (TL)


+(UIColor *)getColor:(NSString *)hexColor
{
    UIColor *result = nil;
    
    unsigned int colorCode = 0;
    
    unsigned char redByte, greenByte, blueByte;
    
    
    
    if (nil != hexColor)
        
    {
        
        NSScanner *scanner = [NSScanner scannerWithString:hexColor];
        
        (void) [scanner scanHexInt:&colorCode];
        
    }
    
    redByte = (unsigned char) (colorCode >> 16);
    
    greenByte = (unsigned char) (colorCode >> 8);
    
    blueByte = (unsigned char) (colorCode);
    
    result = [UIColor
              
              colorWithRed: (float)redByte / 0xff
              
              green: (float)greenByte/ 0xff
              
              blue: (float)blueByte / 0xff
              
              alpha:1.0];
    
    return result;
}

@end
