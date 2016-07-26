//
//  TLBadge.m
//  tongle
//
//  Created by liu on 15-4-22.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLBadge.h"
#import "TLImageName.h"
#import "UIImage+TL.h"


@implementation TLBadge

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setBackgroundImage:[UIImage resizedImage:TL_MAIN_BADGE] forState:UIControlStateNormal];
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted
{}

-(void)setValue:(NSString *)value
{
    _value = [value copy];
    //设置可见性
    if (value.length && ([value intValue] != 0)) {
        self.hidden = NO;
    //2.设置尺寸
        CGRect frame = self.frame;
        frame.size.height = self.currentBackgroundImage.size.height;
        if (value.length > 1) {
            CGSize valueSize = [value sizeWithAttributes:@{NSFontAttributeName :self.titleLabel.font}];
            frame.size.width = valueSize.width + 10;
        }else
        {
            frame.size.width = self.currentBackgroundImage.size.width;
        }
        [super setFrame:frame];
        
        //3内容
        [self setTitle:value forState:UIControlStateNormal];
        }else
        {
            self.hidden = YES;
        }
}

-(void)setFrame:(CGRect)frame
{
    frame.size = self.frame.size;
    [super setFrame:frame];
}
-(void)setBounds:(CGRect)bounds
{
    bounds.size = self.bounds.size;
    [super setBounds:bounds];
}



@end
