//
//  TLStarView.m
//  tongle
//
//  Created by jixiaofei-mac on 16/4/22.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLStarView.h"

@implementation TLStarView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i<5; i++) {
            UIImageView *starimage = [[UIImageView alloc]init];
            starimage.tag = 1000+i;
            [self addSubview:starimage];
        }
    }
    return self;
}


-(void)setLevel:(NSString *)level
{
    _level = level;
    for (int i = 0; i<[level intValue]; i++) {
        UIImageView *starimage = (UIImageView *)[self viewWithTag:1000+i];
        starimage.image = [UIImage imageNamed:@"icon_star_press_small"];
    }
    for (int i = 4; i>[level intValue]-1; i--) {
        UIImageView *starimage = (UIImageView *)[self viewWithTag:1000+i];
        starimage.image = [UIImage imageNamed:@"icon_star_nor_small"];
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width/5;
    
    for (int i = 0; i<5; i++) {
        UIImageView *starimage = (UIImageView *)[self viewWithTag:1000+i];
        starimage.frame = CGRectMake(width*i, 0, width, width);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
