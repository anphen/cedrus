//
//  TLGroupPurchaseShopView.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/4.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupPurchaseShopView.h"
#import "TLGroupCouponStoreInfo.h"
#import "TLGroupStoreList.h"
#import "TLCommon.h"
#import "UIColor+TL.h"
#import "TLImageName.h"


@interface TLGroupPurchaseShopView ()

@property (nonatomic,weak) UIButton *shopButton;
@property (nonatomic,weak) UILabel *shopNo;
@property (nonatomic,weak) UIImageView *arrow;
@property (nonatomic,weak) UIView *segmentationLines;

@property (nonatomic,weak) UILabel *shopName;

@property (nonatomic,weak) UIButton *shopAddressButton;
@property (nonatomic,weak) UILabel *shopAddress;
@property (nonatomic,weak) UIImageView *addressImage;
@property (nonatomic,weak) UIView *verticalLine;
@property (nonatomic,weak) UIButton *telButton;
@property (nonatomic,weak) UIView *segmentationView;

@end



@implementation TLGroupPurchaseShopView


-(instancetype)init
{
    self = [super init];
    if (self) {
        
        UIButton *shopButton = [[UIButton alloc]init];
        [shopButton addTarget:self action:@selector(shopList:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shopButton];
        _shopButton = shopButton;
        
        UILabel *shopNo = [[UILabel alloc]init];
        shopNo.font = [UIFont systemFontOfSize:14];
        [shopButton addSubview:shopNo];
        _shopNo = shopNo;
        
        UIImageView *arrow = [[UIImageView alloc]init];
        arrow.image = [UIImage imageNamed:@"grey back_normal"];
        [shopButton addSubview:arrow];
        _arrow = arrow;
        
        UIView *segmentationLines = [[UIView alloc]init];
        segmentationLines.backgroundColor = [UIColor getColor:@"d9d9d9"];
        [self addSubview:segmentationLines];
        _segmentationLines = segmentationLines;
        
        UILabel *shopName = [[UILabel alloc]init];
        shopName.font = [UIFont systemFontOfSize:14];
        [self addSubview:shopName];
        _shopName = shopName;
        
        UIButton *shopAddressButton = [[UIButton alloc]init];
        [self addSubview:shopAddressButton];
        _shopAddressButton = shopAddressButton;
        
        UILabel *shopAddress = [[UILabel alloc]init];
         shopAddress.font = [UIFont systemFontOfSize:12];
        shopAddress.numberOfLines = 2;
        shopAddress.textColor = [UIColor getColor:@"b6b6b6"];
        [shopAddressButton addSubview:shopAddress];
        _shopAddress = shopAddress;
       
        UIImageView *addressImage = [[UIImageView alloc]init];
        addressImage.image = [UIImage imageNamed:@"dingdanxiangqing_icon01"];
        [shopAddressButton addSubview:addressImage];
        _addressImage = addressImage;
        
        UIView *verticalLine = [[UIView alloc]init];
        verticalLine.backgroundColor = [UIColor getColor:@"f4f4f4"];
        [self addSubview:verticalLine];
        _verticalLine = verticalLine;
        
        UIButton *telButton = [[UIButton alloc]init];
        [telButton setImage:[UIImage imageNamed:TL_ICON_CALL] forState:UIControlStateNormal];
        [telButton addTarget:self action:@selector(tel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:telButton];
        _telButton = telButton;
        
        UIView *segmentationView = [[UIView alloc]init];
        segmentationView.backgroundColor = [UIColor getColor:@"f4f4f4"];
        [self addSubview:segmentationView];
        _segmentationView = segmentationView;
    
        
    }
    return self;
}


-(void)setCoupon_store_info:(TLGroupCouponStoreInfo *)coupon_store_info
{
    _coupon_store_info = coupon_store_info;
    TLGroupStoreList *groupStore = coupon_store_info.store_list.firstObject;

    _shopNo.text =  [NSString stringWithFormat:@"适用商户 (%d)",[coupon_store_info.store_total_count intValue]];
    CGSize shopNoSize = [_shopNo.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    _shopNo.frame = CGRectMake(10, 5, shopNoSize.width, shopNoSize.height);
    _arrow.frame = CGRectMake(ScreenBounds.size.width-10-shopNoSize.height/2, 5, shopNoSize.height/2, shopNoSize.height);
    _segmentationLines.frame = CGRectMake(0, CGRectGetMaxY(_shopNo.frame)+5, ScreenBounds.size.width, 1);
    
    _shopButton.frame = CGRectMake(0, 0, ScreenBounds.size.width, CGRectGetMaxY(_segmentationLines.frame));

    
    _shopName.text = groupStore.name;
    CGSize shopNameSize = [_shopName.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    _shopName.frame = CGRectMake(10, CGRectGetMaxY(_segmentationLines.frame)+5,shopNameSize.width,shopNameSize.height);
    
    _shopAddress.text = groupStore.address;
    
    CGSize shopAddressSize = [groupStore.address boundingRectWithSize:CGSizeMake(ScreenBounds.size.width-65, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    
    _telButton.frame = CGRectMake(ScreenBounds.size.width - 30, CGRectGetMaxY(_segmentationLines.frame)+5,30,30);
    _verticalLine.frame = CGRectMake(_telButton.frame.origin.x-1, _shopName.frame.origin.y, 1, shopNameSize.height+shopAddressSize.height+5);
    
    _shopAddressButton.frame = CGRectMake(0, CGRectGetMaxY(_shopName.frame),_verticalLine.frame.origin.x,shopAddressSize.height+10);
    
    _addressImage.bounds = CGRectMake(0, 0,10,16);
    _addressImage.center = CGPointMake(15, _shopAddressButton.frame.size.height/2);
    _shopAddress.frame = CGRectMake(CGRectGetMaxX(_addressImage.frame)+5, 5,_shopAddressButton.frame.size.width-CGRectGetMaxX(_addressImage.frame)-5,shopAddressSize.height);
    
    _segmentationView.frame = CGRectMake(0, CGRectGetMaxY(_shopAddressButton.frame),ScreenBounds.size.width,10);
    self.height = CGRectGetMaxY(_segmentationView.frame);
}



-(void)shopList:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(groupPurchaseShopView:selectShopListButton:)]) {
        [self.delegate groupPurchaseShopView:self selectShopListButton:button];
    }
}


-(void)tel:(UIButton *)button
{
    TLGroupStoreList *groupStore = _coupon_store_info.store_list.firstObject;

    NSString *str = [NSString stringWithFormat:@"tel:%@",groupStore.phone];
    UIWebView *callWebView = [[UIWebView alloc]init];
    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    if (self.superview) {
        [self.superview addSubview:callWebView];
    }
}

@end
