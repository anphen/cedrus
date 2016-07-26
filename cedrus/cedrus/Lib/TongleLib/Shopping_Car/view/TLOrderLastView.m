//
//  TLOrderLastView.m
//  tongle
//
//  Created by jixiaofei-mac on 15-10-23.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLOrderLastView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+TL.h"
#import "UIButton+TL.h"

@interface TLOrderLastView ()

@property (nonatomic,weak) UILabel *head;
@property (nonatomic,weak) UILabel *foot;
@property (nonatomic,weak) UIButton *button;

@end

@implementation TLOrderLastView

-(instancetype)init
{
    self = [super init];
    if (self) {
        UILabel *head = [[UILabel alloc]init];
        head.font = [UIFont systemFontOfSize:14];
        head.textColor = [UIColor getColor:@"d9d9d9"];
        [self addSubview:head];
        
        self.head = head;
        UILabel *foot = [[UILabel alloc]init];
        foot.textAlignment = NSTextAlignmentRight;
        foot.font = [UIFont systemFontOfSize:14];
        foot.textColor = [UIColor getColor:@"d9d9d9"];
        [self addSubview:foot];
        self.foot = foot;
    }
    return self;
}


 -(instancetype)viewWithHeadTitle:(NSString *)headtitle withFootTitle:(NSString *)foottitle withFrame:(CGRect)frame
 {
     self.frame = frame;
     self.head.text = headtitle;
     self.head.frame = (CGRect){{15,5},[self.head.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}]};
     
     CGSize textsize = [foottitle sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}];
     if ([headtitle isEqualToString:@"运费"]&& ![foottitle floatValue]) {
         UIButton *button = [UIButton createButtonWithTitle:@"全场免运费哦" Color:[UIColor redColor]];
         button.titleLabel.font = [UIFont systemFontOfSize:12];
         button.frame = CGRectMake(frame.size.width-textsize.width-120, 5, 80, 15);
         [self addSubview:button];
     }
     if ([headtitle isEqualToString:@"关税"]) {
         UIButton *button = [UIButton createButtonWithTitle:@"关税≤50,免征哦" Color:[UIColor redColor]];
          button.titleLabel.font = [UIFont systemFontOfSize:12];
         button.frame = CGRectMake(frame.size.width-textsize.width-140, 5, 100, 15);
         [self addSubview:button];
     }
   
     self.foot.text = [NSString stringWithFormat:@"¥%@",foottitle];
     self.foot.frame = (CGRect){{frame.size.width-[self.foot.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}].width-10,5},[self.foot.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}]};
     
     UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, frame.size.width-20, 20)];
     [self addSubview:imageView1];
     
     UIGraphicsBeginImageContext(imageView1.frame.size);   //开始画线
     [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width, imageView1.frame.size.height)];
     CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
     
     
     CGFloat lengths[] = {10,5};
     CGContextRef line = UIGraphicsGetCurrentContext();
     CGContextSetStrokeColorWithColor(line, [UIColor getColor:@"d9d9d9"].CGColor);
     
     CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
     CGContextMoveToPoint(line, 0.0, 20.0);    //开始画线
     CGContextAddLineToPoint(line, frame.size.width-20, 20.0);
     CGContextStrokePath(line);
     
     imageView1.image = UIGraphicsGetImageFromCurrentImageContext();
     
     return self;
 }
 


@end

