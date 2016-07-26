//
//  TLGroupProdPruchaseNoticeView.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/10.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupProdPruchaseNoticeView.h"
#import "TLGroupCouponPurchaseNotice.h"
#import "TLGroupProductDetail.h"
#import "TLCommon.h"
#import "UIColor+TL.h"

@interface TLGroupProdPruchaseNoticeView ()

@property (nonatomic,weak) UILabel *notice;
@property (nonatomic,weak) UIView *separationLinehead;
@property (nonatomic,weak) UIView *separationLinefoot;


@end


@implementation TLGroupProdPruchaseNoticeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)init
{
    self = [super init];
    if (self) {
        UILabel *notice = [[UILabel alloc]init];
        notice.text = @"购买须知";
        notice.font = TLSignaFont;
        [self addSubview:notice];
        _notice = notice;
        
        UIView *separationLinehead = [[UIView alloc]init];
        separationLinehead.backgroundColor = [UIColor getColor:@"d9d9d9"];
        [self addSubview:separationLinehead];
        _separationLinehead = separationLinehead;
        
        UIView *separationLinefoot = [[UIView alloc]init];
         separationLinefoot.backgroundColor = [UIColor getColor:@"f4f4f4"];
        [self addSubview:separationLinefoot];
        _separationLinefoot = separationLinefoot;
    }
    return self;
}


-(void)setGroupProductDetail:(TLGroupProductDetail *)groupProductDetail
{
    _groupProductDetail = groupProductDetail;
    
    
    
    CGSize noticeSize = [_notice.text sizeWithAttributes:@{NSFontAttributeName : TLSignaFont}];
    _notice.frame = CGRectMake(10, 10, noticeSize.width, noticeSize.height);
    
    _separationLinehead.frame = CGRectMake(10, CGRectGetMaxY(_notice.frame)+10,ScreenBounds.size.width-10, 1);
    
    CGFloat y = CGRectGetMaxY(_separationLinehead.frame)+10;
    
    for (TLGroupCouponPurchaseNotice *groupCouponPurchaseNotice in groupProductDetail.coupon_purchase_notice_list) {
        
        
        UILabel *title = [[UILabel alloc]init];
        title.text = groupCouponPurchaseNotice.title;
        title.font = TLTimeFont;
        title.textColor = [UIColor getColor:@"b6b6b6"];
        CGSize titleSize = [title.text sizeWithAttributes:@{NSFontAttributeName : TLTimeFont}];
        title.frame = CGRectMake(10, y, titleSize.width, titleSize.height);
        [self addSubview:title];
        
        UILabel *desc = [[UILabel alloc]init];
        desc.numberOfLines = 0;
        desc.text = groupCouponPurchaseNotice.desc;
        desc.font = TLTimeFont;
        CGSize descSize = [desc.text boundingRectWithSize:(CGSizeMake(ScreenBounds.size.width - 20, MAXFLOAT)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TLTimeFont} context:nil].size;
        desc.frame = CGRectMake(20, CGRectGetMaxY(title.frame)+10, descSize.width, descSize.height);
        [self addSubview:desc];
        y = CGRectGetMaxY(desc.frame)+10;
    }
    
    _separationLinefoot.frame = CGRectMake(0, y, ScreenBounds.size.width, 10);
    _height = CGRectGetMaxY(_separationLinefoot.frame);
    
}

@end
