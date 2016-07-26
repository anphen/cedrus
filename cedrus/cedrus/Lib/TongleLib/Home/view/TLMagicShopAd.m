//
//  TLMagicShopAd.m
//  tongle
//
//  Created by liu ruibin on 15-5-6.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLMagicShopAd.h"
#import "TLMagicShop.h"
#import "TLCommon.h"
#import "UIColor+TL.h"
#import "TLImageName.h"
#import "UIImageView+Image.h"


@implementation TLMagicShopAd
//首页展示的魔店数量
int TL_SHOP_COUNT = 4;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        }
    return self;
}
/**
 *  付值对象数组
 *
 *  @param magicShop
 */
-(void)setMagicShop:(NSArray *)magicShop
{
    _magicShop = magicShop;
}

/**
 *  自定义按键
 *
 *  @param button   按键
 *  @param title    按键文字
 *  @param imageUrl 按键图片
 */
-(void)setButton:(UIButton *)button  title:(NSString *)title image:(NSString *)imageUrl
{
    
    [button.layer setMasksToBounds:YES];
   // [button.layer setCornerRadius:8.0]; //设置矩圆角半径
    [button.layer setBorderWidth:1.0];   //边框宽度
    //CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1 , 0, 1, 1 });
    [button.layer setBorderColor:[UIColor getColor:TL_BORDER_COLOR].CGColor];//边框颜色
    
    
    UILabel *name = [[UILabel alloc]init];
    name.text = title;
    if (ScreenBounds.size.width==320) {
       name.font = TL_Shop_Font_320;
    }else
    {
        name.font = TLShopFont;
    }
    name.frame = CGRectMake(0, 2,button.bounds.size.width , 14);
    name.textAlignment = UIBaselineAdjustmentAlignCenters;
    [name setTextColor:[UIColor getColor:TL_TEXT_COLOR]];
    [button addSubview:name];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setImageWithURL:imageUrl placeImage:[UIImage imageNamed:TL_MOSHOP_DEFAULT]];
    //imageView.frame = CGRectMake(0, CGRectGetMaxY(name.frame), button.bounds.size.width, button.bounds.size.height-CGRectGetMaxY(name.frame));
   // CGFloat height = button.bounds.size.height-CGRectGetMaxY(name.frame)-4;
   // CGFloat width = button.bounds.size.width- height>0? height : button.bounds.size.width;
    imageView.frame = CGRectMake(0, CGRectGetMaxY(name.frame), button.bounds.size.width, button.bounds.size.width);
    //imageView.center = CGPointMake(button.bounds.size.width/2, (button.bounds.size.height-CGRectGetMaxY(name.frame))/2+CGRectGetMaxY(name.frame)-5);
    [button addSubview:imageView];
}

/**
 *  初始化子控件
 */

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.bounds;
    CGFloat edge = 10;
    CGFloat moreWH = 24;
    //我的魔店
    UILabel *title = [[UILabel alloc]init];
    title.text = @"我的魔店";
    title.font = TLNameFont;
    [title setTextColor:[UIColor getColor:TL_MY_SHOP_TEXT_COLOR]];
    CGSize titleSize = [title.text sizeWithAttributes:@{NSFontAttributeName:TLNameFont}];
    CGFloat titleX = edge;
    CGFloat titleY = edge;
    title.frame = (CGRect){{titleX,titleY},titleSize};
    [self addSubview:title];
    //更多按键
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake((rect.size.width-13-24), 8, moreWH, moreWH)];
    [moreBtn setBackgroundImage:[UIImage imageNamed:TL_MORE_ARROW_NORMAL] forState:UIControlStateNormal];
    [moreBtn setBackgroundImage:[UIImage imageNamed:TL_MORE_ARROW_PRESS] forState:UIControlStateHighlighted];
    [moreBtn addTarget:self action:@selector(jumpController) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreBtn];
    //更多
    UILabel *more = [[UILabel alloc] init];
    more.text = @"更多";
    more.font = TL_MORE_TEXT_FONT;
    [more setTextColor:[UIColor getColor:TL_TEXT_COLOR]];
    CGSize moreSize = [more.text sizeWithAttributes:@{NSFontAttributeName:TLNameFont}];
    CGFloat moreX = moreBtn.frame.origin.x - moreSize.width;
    CGFloat moreY = 10;
    more.frame = (CGRect){{moreX,moreY},moreSize};
    [self addSubview:more];
    
    CGFloat magicH = 0;
    if (ScreenBounds.size.width==320) {
        magicH = 100;
    }else
    {
        magicH = 125;
    }
    CGFloat magicY = CGRectGetMaxY(moreBtn.frame)+3;
    CGFloat magicEdge = 13;
    CGFloat magicMargin = 11;
    CGFloat magicW = (rect.size.width - 2*magicEdge-3*magicMargin)/TL_SHOP_COUNT;
    //三个魔店图标按键
    
    if (self.magicShop.count <= TL_SHOP_COUNT) {
        for (int i = 0; i<self.magicShop.count; i++) {
            UIButton *btn = [[UIButton alloc]init];
            CGFloat magicX = i*(magicMargin + magicW) + magicEdge;
            
            btn.tag = 1000+i;
            btn.frame = CGRectMake(magicX, magicY, magicW, magicW+16);
            [btn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
            
            TLMagicShop *magic =  self.magicShop[i];
            [self setButton:btn title:magic.mstore_name image:magic.mstore_pic_url];
            [self addSubview:btn];
        }
    }else
    {
        for (int i = 0; i<TL_SHOP_COUNT; i++) {
            UIButton *btn = [[UIButton alloc]init];
            CGFloat magicX = i*(magicMargin + magicW) + magicEdge;
            
            btn.tag = 1000+i;
            btn.frame = CGRectMake(magicX, magicY, magicW,   magicW+16);
            [btn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
            TLMagicShop *magic =  self.magicShop[i];
            [self setButton:btn title:magic.mstore_name image:magic.mstore_pic_url];
            [self addSubview:btn];
        }
    }
    
    
}

-(void)jump:(UIButton *)button
{
    [self.delegate JumpControllerWithMagicImageWithButton:button];
}

-(void)jumpController
{
    if ([self.delegate performSelector:@selector(JumpControllerWithMagicShopAd)]) {
        [self.delegate JumpControllerWithMagicShopAd];
    }
}



@end
