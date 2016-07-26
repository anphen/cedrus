//
//  TLGroupProdDetailView.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/10.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupProdDetailView.h"
#import "TLGroupCouponPurchaseInfo.h"
#import "TLGroupContent.h"
#import "TLImageName.h"
#import "UIColor+TL.h"
#import "TLCommon.h"

@interface TLGroupProdDetailView ()

@property (nonatomic,weak) UIButton *prodImageDetailButton;
@property (nonatomic,weak) UILabel *detail1;
@property (nonatomic,weak) UILabel *detail2;
@property (nonatomic,weak) UIImageView *imageArrrow;
@property (nonatomic,weak) UIView *separationLinehead;
@property (nonatomic,weak) UIView *separationLinefoot;
@property (nonatomic,weak) UILabel *couponPurchaseInfoHead;
@property (nonatomic,weak) UILabel *allPrice;
@property (nonatomic,weak) UILabel *allPriceNumber;
@property (nonatomic,weak) UILabel *groupPrice;
@property (nonatomic,weak) UILabel *groupPriceNumber;
@property (nonatomic,weak) UILabel *footer;

@end


@implementation TLGroupProdDetailView

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        UIButton *prodImageDetailButton = [[UIButton alloc]init];
        [prodImageDetailButton addTarget:self action:@selector(productDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:prodImageDetailButton];
        _prodImageDetailButton = prodImageDetailButton;
        
        UILabel *detail1 = [[UILabel alloc]init];
        detail1.font = TLSignaFont;
        detail1.text = @"团购详情";
        [prodImageDetailButton addSubview:detail1];
        _detail1 = detail1;
        
        UILabel *detail2 = [[UILabel alloc]init];
        detail2.text = @"图文详情";
        detail2.textColor = [UIColor getColor:@"9f9f9f"];
        detail2.font = TLSignaFont;
        [prodImageDetailButton addSubview:detail2];
        _detail2 = detail2;
        
        UIImageView *imageArrrow = [[UIImageView alloc]init];
        imageArrrow.image = [UIImage imageNamed:TL_GREY_BACK_NORMAL];
        [prodImageDetailButton addSubview:imageArrrow];
        _imageArrrow = imageArrrow;
        
        UIView *separationLinehead = [[UIView alloc]init];
        separationLinehead.backgroundColor = [UIColor getColor:@"d9d9d9"];
        [self addSubview:separationLinehead];
        _separationLinehead = separationLinehead;
        
        UIView *separationLinefoot = [[UIView alloc]init];
        separationLinefoot.backgroundColor = [UIColor getColor:@"f4f4f4"];
        [self addSubview:separationLinefoot];
        _separationLinefoot = separationLinefoot;
        
        UILabel *couponPurchaseInfoHead = [[UILabel alloc]init];
        couponPurchaseInfoHead.font = TLTimeFont;
        [self addSubview:couponPurchaseInfoHead];
        _couponPurchaseInfoHead = couponPurchaseInfoHead;
        
        UILabel *allPrice = [[UILabel alloc]init];
        allPrice.font = TLTimeFont;
        allPrice.textAlignment = NSTextAlignmentRight;
        allPrice.text = @"价值";
        [self addSubview:allPrice];
        _allPrice = allPrice;
        
        UILabel *allPriceNumber = [[UILabel alloc]init];
        allPriceNumber.font = TLTimeFont;
        allPriceNumber.textAlignment = NSTextAlignmentRight;
        [self addSubview:allPriceNumber];
        _allPriceNumber = allPriceNumber;
        
        UILabel *groupPrice = [[UILabel alloc]init];
        groupPrice.font = TLTimeFont;
        groupPrice.textAlignment = NSTextAlignmentRight;
        groupPrice.text = @"团购价";
        [self addSubview:groupPrice];
        _groupPrice = groupPrice;
        
        UILabel *groupPriceNumber = [[UILabel alloc]init];
        groupPriceNumber.font = TLTimeFont;
        groupPriceNumber.textAlignment = NSTextAlignmentRight;
        groupPriceNumber.textColor = [UIColor redColor];
        [self addSubview:groupPriceNumber];
        _groupPriceNumber = groupPriceNumber;
        
        UILabel *footer = [[UILabel alloc]init];
        footer.font = TLTimeFont;
        [self addSubview:footer];
        _footer = footer;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setGroupCouponPurchaseInfo:(TLGroupCouponPurchaseInfo *)groupCouponPurchaseInfo
{
    _groupCouponPurchaseInfo = groupCouponPurchaseInfo;
    
    CGSize detailSize = [_detail1.text sizeWithAttributes:@{NSFontAttributeName :TLSignaFont}];
    
    _detail1.frame = CGRectMake(10, 10, detailSize.width, detailSize.height);
    
    _imageArrrow.frame = CGRectMake(ScreenBounds.size.width-10-detailSize.height/2, 10, detailSize.height/2, detailSize.height);
    _detail2.frame = CGRectMake(ScreenBounds.size.width-15-detailSize.height/2-detailSize.width, 10, detailSize.width, detailSize.height);
    _prodImageDetailButton.frame = CGRectMake(0, 0, ScreenBounds.size.width, detailSize.height+20);
    _separationLinehead.frame = CGRectMake(10, CGRectGetMaxY(_prodImageDetailButton.frame), ScreenBounds.size.width-10, 1);
    
    _couponPurchaseInfoHead.text = groupCouponPurchaseInfo.head;
    CGSize headSize = [_couponPurchaseInfoHead.text sizeWithAttributes:@{NSFontAttributeName : TLTimeFont}];
    _couponPurchaseInfoHead.frame = CGRectMake(10, CGRectGetMaxY( _separationLinehead.frame)+10, headSize.width, headSize.height);
    
    CGFloat y = CGRectGetMaxY(_couponPurchaseInfoHead.frame)+10;
    
    for (TLGroupContent *content in groupCouponPurchaseInfo.content_list) {
        
        UILabel *price = [[UILabel alloc]init];
        price.text = [NSString stringWithFormat:@"%@元",content.price];
        price.font = TLTimeFont;
        price.textAlignment = NSTextAlignmentRight;
        price.frame = CGRectMake(ScreenBounds.size.width-80, y, 70, 21);
        [self addSubview:price];
        
        UILabel *qty = [[UILabel alloc]init];
        qty.text = content.qty;
        qty.textAlignment = NSTextAlignmentRight;
        qty.font = TLTimeFont;
        qty.frame = CGRectMake(ScreenBounds.size.width-125, y, 52, 21);
        [self addSubview:qty];
        
        UILabel *item = [[UILabel alloc]init];
        item.font = TLTimeFont;
        item.textAlignment = NSTextAlignmentLeft;
        item.frame = CGRectMake(10, y,ScreenBounds.size.width-130 , 21);
        item.text = content.item;
        [self addSubview:item];
        
        y = y+31;
    }
    
    _allPrice.frame = CGRectMake(ScreenBounds.size.width-125, y, 52, 21);
    _allPriceNumber.text = [NSString stringWithFormat:@"%@元",groupCouponPurchaseInfo.content_total_price];
    _allPriceNumber.frame = CGRectMake(ScreenBounds.size.width-80, y, 70, 21);
    
    _groupPrice.frame = CGRectMake(ScreenBounds.size.width-125, CGRectGetMaxY(_allPrice.frame)+10, 52, 21);
    _groupPriceNumber.text = [NSString stringWithFormat:@"%@元",groupCouponPurchaseInfo.content_actually_price];
    _groupPriceNumber.frame = CGRectMake(ScreenBounds.size.width-80, CGRectGetMaxY(_allPrice.frame)+10, 70, 21);
    
    CGSize footerSize = [groupCouponPurchaseInfo.footer boundingRectWithSize:(CGSizeMake(ScreenBounds.size.width - 20, MAXFLOAT)) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:TLTimeFont} context:nil].size;
    _footer.frame = (CGRect){{10,CGRectGetMaxY(_groupPriceNumber.frame)+10},footerSize};
    _separationLinefoot.frame = CGRectMake(0, CGRectGetMaxY(_footer.frame)+10, ScreenBounds.size.width, 10);
    
    _height = CGRectGetMaxY(_separationLinefoot.frame);
}


-(void)productDetail:(UIButton *)button
{
    self.productDetailBlack();
}



@end
