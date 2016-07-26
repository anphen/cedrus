//
//  TLHead.m
//  TL11
//
//  Created by liu on 15-4-20.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLHead.h"
#import "TLHttpTool.h"
#import "UIColor+TL.h"

@implementation TLHead

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)CreateNavigationBartitleArray:(NSArray *)titleArray Controller:(id)Controller
{
    CGRect frame = [UIScreen mainScreen].bounds;
    UIImageView *navigationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, 44)];
    navigationImageView.userInteractionEnabled = YES;
    navigationImageView.backgroundColor = [UIColor clearColor];
    self.navigationImageView = navigationImageView;
    
    CGFloat btnWidth = frame.size.width/titleArray.count;
    for (int i = 0; i<titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*btnWidth, 0, btnWidth, 44);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor getColor:@"999999"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor getColor:@"72c6f7"] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        if (i == 0) {
            btn.selected = YES;
        }
        btn.tag = 1000+i;
        [navigationImageView addSubview:btn];
    }
    [Controller addSubview:navigationImageView];
}


-(void)btnClicked:(UIButton *)btn
{}


//-(void)btnAction:(UIButton *)sender
//{
//        CGRect frame = [UIScreen mainScreen].bounds;
//    
//        for (int i = 0; i< self.navigationImageView.subviews.count; i++) {
//            UIButton *btn = (UIButton *)[self.navigationImageView viewWithTag:1000+i];
//            btn.selected = NO;
//        }
//        sender.selected = YES;
//        int index = (int)(sender.tag-1000) ;
//       self.scroll.contentOffset = CGPointMake(index*frame.size.width, 0);
//}





@end
