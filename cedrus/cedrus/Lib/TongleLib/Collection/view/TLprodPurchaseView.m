//
//  TLprodPurchaseView.m
//  tongle
//
//  Created by liu ruibin on 15-5-19.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLprodPurchaseView.h"
#import <ShareSDK/ShareSDK.h>
#import "TLPersonalMegTool.h"
#import "TLPersonalMeg.h"
#import "TLCommon.h"
#import "UIColor+TL.h"
#import "TLImageName.h"
#import "UIImageView+Image.h"
#import "UIImageView+WebCache.h"
#import "UIImage+TL.h"


@interface TLprodPurchaseView ()

//@property (nonatomic,weak) UIScrollView *prodImage;
@property (nonatomic,weak) UILabel *prodName;
@property (nonatomic,weak) UILabel *prodPrice;
@property (nonatomic,weak) UIButton *prodDetailsBtn;
@property (nonatomic,weak) UIButton *shareBtn;
@property (nonatomic,weak) UIView *division;
@property (nonatomic,weak) UIImageView *country;
@property (nonatomic,weak) UILabel *sendOutCountry;
@property (nonatomic,weak) UILabel *sendPrice;
@property (nonatomic,weak) UILabel *tariff;
@property (nonatomic,weak) UIView *divisionfoot;
@property (nonatomic,weak) UIView *divisionservice;
@property (nonatomic,weak) UILabel *service;
@property (nonatomic,weak) UILabel *tip;
@property (nonatomic,weak) UIButton *btnIntegration;
@property (nonatomic,weak) UIButton *btnText;
@end

@implementation TLprodPurchaseView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIScrollView *prodImage = [[UIScrollView alloc]init];
        [self addSubview:prodImage];
        prodImage.tag = 101;
        self.prodImage = prodImage;
        
        UILabel *prodName = [[UILabel alloc]init];
        [self addSubview:prodName];
        self.prodName.font = TLNameFont;
        self.prodName.numberOfLines = 0;
        self.prodName = prodName;
        
        UILabel *prodPrice = [[UILabel alloc]init];
        [self addSubview:prodPrice];
        self.prodPrice = prodPrice;
        
        UIButton *prodDetailsBtn = [[UIButton alloc]init];
        [self addSubview:prodDetailsBtn];
        self.prodDetailsBtn = prodDetailsBtn;
        
        UIButton *shareBtn = [[UIButton alloc]init];
        [self addSubview:shareBtn];
        self.shareBtn = shareBtn;
        
        UIView *division = [[UIView alloc]init];
        division.backgroundColor = [UIColor getColor:@"d9d9d9"];
        [self addSubview:division];
        self.division = division;
        
        UIImageView *country = [[UIImageView alloc]init];
        [self addSubview:country];
        self.country = country;
        
        UILabel *sendOutCountry = [[UILabel alloc]init];
        sendOutCountry.font = [UIFont systemFontOfSize:14];
        [self addSubview:sendOutCountry];
        self.sendOutCountry = sendOutCountry;
        
        UILabel *sendPrice = [[UILabel alloc]init];
        sendPrice.font = [UIFont systemFontOfSize:14];
        [self addSubview:sendPrice];
        self.sendPrice = sendPrice;
        
        UILabel *tariff = [[UILabel alloc]init];
        tariff.numberOfLines = 0;
        tariff.font = [UIFont systemFontOfSize:14];
        [self addSubview:tariff];
        self.tariff = tariff;
        
        UIView *divisionfoot = [[UIView alloc]init];
        divisionfoot.backgroundColor = [UIColor getColor:@"d9d9d9"];
        [self addSubview:divisionfoot];
        self.divisionfoot = divisionfoot;
        
        
        UIView *divisionservice = [[UIView alloc]init];
        divisionservice.backgroundColor = [UIColor getColor:@"d9d9d9"];
        [self addSubview:divisionservice];
        self.divisionservice = divisionservice;
        
        
        UILabel *service = [[UILabel alloc]init];
        service.font = [UIFont systemFontOfSize:14];
        service.textColor = [UIColor getColor:@"b6b6b6"];
        [self addSubview:service];
        self.service = service;
        
        UILabel *tip = [[UILabel alloc]init];
        tip.font = [UIFont systemFontOfSize:14];
        tip.textColor = [UIColor getColor:@"b6b6b6"];
        [self addSubview:tip];
        self.tip = tip;
        
        UIButton *btnIntegration = [[UIButton alloc]init];
        [btnIntegration setImage:[UIImage imageNamed:@"money"] forState:UIControlStateNormal];
        [btnIntegration setImage:[UIImage imageNamed:@"money"] forState:UIControlStateHighlighted];
        [btnIntegration addTarget:self action:@selector(actionIntegrate:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnIntegration];
        self.btnIntegration = btnIntegration;
        
        UIButton *btnText = [[UIButton alloc]init];
        btnText.titleLabel.font = [UIFont systemFontOfSize:12];
        btnText.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btnText addTarget:self action:@selector(actionIntegrate:) forControlEvents:UIControlEventTouchUpInside];
        [btnText setTitleColor:[UIColor getColor:@"cbebf7"] forState:UIControlStateNormal];
        [btnText setTitle:@"点击查看商品积分规则详情。" forState:UIControlStateNormal];
        [self addSubview:btnText];
        self.btnText = btnText;
    }
    return self;
}


-(void)setProd_Price:(NSString *)prod_Price
{
    _prod_Price = prod_Price;
    self.prodPrice.text = [NSString stringWithFormat:@"￥%@",_prod_Price];
}

-(void)setProdDetails:(TLProdDetails *)prodDetails
{
    _prodDetails = prodDetails;
    
    self.prodImage.frame = CGRectMake(0, 0, ScreenBounds.size.width, ScreenBounds.size.width*3/4);
    for (int i =0 ; i<prodDetails.prod_pic_url_list.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setImageWithURL:prodDetails.prod_pic_url_list[i][@"pic_url"] placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
        imageView.frame =  CGRectMake(self.prodImage.bounds.size.width*i, 0, self.prodImage.bounds.size.width, self.prodImage.bounds.size.height);
        [self.prodImage addSubview:imageView];
    }
    self.prodImage.contentSize = CGSizeMake(prodDetails.prod_pic_url_list.count*ScreenBounds.size.width, 0);
    self.prodImage.pagingEnabled = YES;
    //self.prodImage.backgroundColor = [UIColor getColor:@"b4b4b4"];
    self.prodImage.showsHorizontalScrollIndicator = NO;
    
    self.prodName.numberOfLines = 2;
    self.prodName.text = prodDetails.prod_name;
    self.prodName.font = TLNameFont;
    
    CGSize prodNameSize = [self.prodName.text boundingRectWithSize:(CGSizeMake(ScreenBounds.size.width-100, MAXFLOAT)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TLNameFont} context:nil].size;
    self.prodName.frame = (CGRect){{10,CGRectGetMaxY(self.prodImage.frame)+13},prodNameSize};
    self.prodPrice.font = [UIFont systemFontOfSize:20];
    [self.prodPrice setTextColor:[UIColor redColor]];
    self.prodPrice.frame = CGRectMake(10, CGRectGetMaxY(self.prodImage.frame)+55, ScreenBounds.size.width-20, 20);
    
    //[self setupBtn:self.prodDetailsBtn icon_normal:TL_GREY_BACK_NORMAL icon_press:TL_GREY_BACK_PRESS];
    [self.prodDetailsBtn setTitle:@"详情" forState:UIControlStateNormal];
    [self.prodDetailsBtn setTitleColor:[UIColor getColor:@"9f9f9f"] forState:UIControlStateNormal];
    self.prodDetailsBtn.frame = CGRectMake(ScreenBounds.size.width-90, CGRectGetMaxY(self.prodImage.frame)+20, 40, 30);
    [self.prodDetailsBtn addTarget:self action:@selector(prodDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    self.division.bounds = CGRectMake(0, 0, 1, 40);
    self.division.center = CGPointMake(CGRectGetMaxX(self.prodDetailsBtn.frame)+7, self.prodDetailsBtn.center.y);
    
    [self setupBtn:self.shareBtn icon_normal:TL_GREY_SHARE_NORMAL icon_press:TL_GREY_SHARE_PRESS];
    self.shareBtn.frame = CGRectMake(ScreenBounds.size.width-40, CGRectGetMaxY(self.prodImage.frame)+20, 30, 30);
    [self.shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([prodDetails.import_goods_flag isEqualToString:TLYES]) {
        
        self.divisionfoot.frame = CGRectMake(0, CGRectGetMaxY(self.prodPrice.frame), ScreenBounds.size.width, 0.5);
        self.country.frame = CGRectMake(10, CGRectGetMaxY(self.divisionfoot.frame)+5, 30, 20);
        [self.country sd_setImageWithURL:[NSURL URLWithString:prodDetails.country_pic_url]placeholderImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG] options:SDWebImageRetryFailed|SDWebImageLowPriority|SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    self.country.image = [UIImage getEllipseImageWithImage:image];
                }
            });
        }];
        self.sendOutCountry.text = prodDetails.import_info_desc;
        CGSize sendOutCountrySize = [self.sendOutCountry.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        self.sendOutCountry.bounds = CGRectMake(0, 0, sendOutCountrySize.width, sendOutCountrySize.height);
        self.sendOutCountry.center = CGPointMake(CGRectGetMaxX(self.country.frame)+5+sendOutCountrySize.width/2, self.country.center.y);
        
        self.sendPrice.text = [NSString stringWithFormat:@"配送费:%@",prodDetails.transfer_fee_desc];
        CGSize sendPriceSize = [self.sendPrice.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}];
        self.sendPrice.frame  = CGRectMake(self.country.frame.origin.x, CGRectGetMaxY(self.country.frame)+5, sendPriceSize.width, sendPriceSize.height);
        
        UILabel *tariffTitle = [[UILabel alloc]init];
        tariffTitle.text = @"关   税:";
        tariffTitle.font = [UIFont systemFontOfSize:14];
        CGSize size = [tariffTitle.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}];
        tariffTitle.frame = CGRectMake(self.sendPrice.frame.origin.x, CGRectGetMaxY(self.sendPrice.frame)+5, size.width, size.height);
        [self addSubview:tariffTitle];
        
        self.tariff.text = prodDetails.tariff_desc;
        CGSize tariffSize = [self.tariff.text boundingRectWithSize:(CGSizeMake(ScreenBounds.size.width - 2*TLCellBorderWidth-size.width, MAXFLOAT)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        self.tariff.frame = CGRectMake(CGRectGetMaxX(tariffTitle.frame), CGRectGetMaxY(self.sendPrice.frame)+5, tariffSize.width, tariffSize.height);
        
        
        [self setserviceUi:prodDetails withfloat:CGRectGetMaxY(self.tariff.frame)];
        
    }else
    {
        
        [self setserviceUi:prodDetails withfloat:CGRectGetMaxY(self.prodPrice.frame)];
    }
    self.backgroundColor = [UIColor whiteColor];
}


-(void)setserviceUi:(TLProdDetails *)prodDetails withfloat:(CGFloat)y;
{
    self.divisionservice.frame = CGRectMake(0, y, ScreenBounds.size.width, 0.5);
    self.service.text = [NSString stringWithFormat:@"服   务:%@",prodDetails.sender];
    CGSize serviceSize = [self.service.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}];
    self.service.frame  = CGRectMake(TLCellBorderWidth, CGRectGetMaxY(self.divisionservice.frame)+5, serviceSize.width, serviceSize.height);
    
    self.tip.text = [NSString stringWithFormat:@"提   示:%@",prodDetails.goods_return_info];
    CGSize tipSize = [self.tip.text boundingRectWithSize:(CGSizeMake(ScreenBounds.size.width - 2*TLCellBorderWidth, MAXFLOAT)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    self.tip.frame = CGRectMake(TLCellBorderWidth, CGRectGetMaxY(self.service.frame)+5, tipSize.width, tipSize.height);
    
    self.btnIntegration.frame = CGRectMake(TLCellBorderWidth+5,  CGRectGetMaxY(self.tip.frame)+5, 25, 25);
    CGSize titleSize = [self.btnText.titleLabel.text sizeWithAttributes:@{NSFileSystemSize : [UIFont systemFontOfSize:12]}];
    self.btnText.frame = CGRectMake(CGRectGetMaxX(self.btnIntegration.frame)+5, CGRectGetMaxY(self.tip.frame)+5, titleSize.width, 25);
    _height = CGRectGetMaxY(self.btnIntegration.frame);
}


-(void)actionIntegrate:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(prodPurchaseViewProdIntegrateDetails)]) {
        [self.delegate prodPurchaseViewProdIntegrateDetails];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

-(void)share:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(prodPurchaseViewShare)]) {
        [self.delegate prodPurchaseViewShare];
    }
}

-(void)prodDetails:(UIButton *)btn
{
    
    if ([self.delegate respondsToSelector:@selector(prodPurchaseViewProdDetails)]) {
        [self.delegate prodPurchaseViewProdDetails];
    }
}

-(void)setupBtn:(UIButton *)btn icon_normal:(NSString *)icon_normal icon_press:(NSString *)icon_press
{
    [btn setImage:[UIImage imageNamed:icon_normal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:icon_press] forState:UIControlStateHighlighted];
}



@end
