//
//  TLGroupPurchaseViewShopView.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/3.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupPurchaseViewShopView.h"
#import "TLCommon.h"
#import "UIColor+TL.h"
#import "UIImageView+Image.h"
#import "TLImageName.h"
#import "TLGroupProductDetail.h"


@interface TLGroupPurchaseViewShopView ()

@property (nonatomic,weak) UILabel *prodName;
@property (nonatomic,weak) UILabel *prodPrice;
@property (nonatomic,weak) UIButton *prodDetailsBtn;
@property (nonatomic,weak) UIButton *favourable;
@property (nonatomic,weak) UIButton *shareBtn;
@property (nonatomic,weak) UIView *division;
@property (nonatomic,weak) UIView *divisionhead;
@property (nonatomic,weak) UIView *divisionfoot;
@property (nonatomic,weak) UILabel *service;


@end



@implementation TLGroupPurchaseViewShopView

-(instancetype)init
{
    self = [super init];
    if (self) {
        UIScrollView *prodImage = [[UIScrollView alloc]init];
        [self addSubview:prodImage];
        prodImage.pagingEnabled = YES;
        prodImage.showsHorizontalScrollIndicator = NO;
        self.prodImage = prodImage;
        
        UILabel *prodName = [[UILabel alloc]init];
        [self addSubview:prodName];
        self.prodName.font = TLNameFont;
        self.prodName.numberOfLines = 2;
        self.prodName = prodName;
        
        UILabel *prodPrice = [[UILabel alloc]init];
        prodPrice.font = [UIFont systemFontOfSize:20];
        [prodPrice setTextColor:[UIColor redColor]];
        [self addSubview:prodPrice];
        self.prodPrice = prodPrice;
        
        UIButton *prodDetailsBtn = [[UIButton alloc]init];
        [self addSubview:prodDetailsBtn];
        self.prodDetailsBtn = prodDetailsBtn;
        
        UIButton *favourable = [[UIButton alloc]init];
        [self addSubview:favourable];
        self.favourable = favourable;
        
        UIButton *shareBtn = [[UIButton alloc]init];
        [self addSubview:shareBtn];
        self.shareBtn = shareBtn;
        
        UIView *division = [[UIView alloc]init];
        division.backgroundColor = [UIColor getColor:@"d9d9d9"];
        [self addSubview:division];
        self.division = division;
        
        UILabel *service = [[UILabel alloc]init];
        service.font = [UIFont systemFontOfSize:14];
        service.textColor = [UIColor getColor:@"b6b6b6"];
        [self addSubview:service];
        self.service = service;
        
        
        UIView *divisionhead = [[UIView alloc]init];
        divisionhead.backgroundColor = [UIColor getColor:@"d9d9d9"];
        [self addSubview:divisionhead];
        self.divisionhead = divisionhead;
        
        UIView *divisionfoot = [[UIView alloc]init];
        divisionfoot.backgroundColor = [UIColor getColor:@"d9d9d9"];
        [self addSubview:divisionfoot];
        self.divisionfoot = divisionfoot;
    }
    return self;
}

-(void)setGroupProductDetail:(TLGroupProductDetail *)groupProductDetail
{
    _groupProductDetail = groupProductDetail;
    
    
    self.prodImage.frame = CGRectMake(0, 0, ScreenBounds.size.width, ScreenBounds.size.width*3/4);
    for (int i =0 ; i< groupProductDetail.prod_base_info.prod_pic_url_list.count; i++) {
        
        NSDictionary *urlDict = groupProductDetail.prod_base_info.prod_pic_url_list[i];
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setImageWithURL:urlDict[@"pic_url"] placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
        imageView.frame =  CGRectMake(self.prodImage.bounds.size.width*i, 0, self.prodImage.bounds.size.width, self.prodImage.bounds.size.height);
        [self.prodImage addSubview:imageView];
    }
    self.prodImage.contentSize = CGSizeMake(groupProductDetail.prod_base_info.prod_pic_url_list.count*ScreenBounds.size.width, 0);

    
    self.prodName.numberOfLines = 2;
    self.prodName.text = groupProductDetail.prod_base_info.prod_name;
    self.prodName.font = TLNameFont;
    
    CGSize prodNameSize = [self.prodName.text boundingRectWithSize:(CGSizeMake(ScreenBounds.size.width-100, 40)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TLNameFont} context:nil].size;
    self.prodName.frame = (CGRect){{10,CGRectGetMaxY(self.prodImage.frame)+13},prodNameSize};

    self.prodPrice.frame = CGRectMake(10, CGRectGetMaxY(self.prodImage.frame)+55, ScreenBounds.size.width-20, 20);
    self.prodPrice.text = [NSString stringWithFormat:@"￥%@",groupProductDetail.prod_base_info.price];
    
    
    [self.prodDetailsBtn setTitle:@"详情" forState:UIControlStateNormal];
    [self.prodDetailsBtn setTitleColor:[UIColor getColor:@"9f9f9f"] forState:UIControlStateNormal];
    self.prodDetailsBtn.frame = CGRectMake(ScreenBounds.size.width-90, CGRectGetMaxY(self.prodImage.frame)+20, 40, 30);
    [self.prodDetailsBtn addTarget:self action:@selector(prodDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    self.division.bounds = CGRectMake(0, 0, 1, 40);
    self.division.center = CGPointMake(CGRectGetMaxX(self.prodDetailsBtn.frame)+7, self.prodDetailsBtn.center.y);
    
    [self setupBtn:self.shareBtn icon_normal:TL_GREY_SHARE_NORMAL icon_press:TL_GREY_SHARE_PRESS];
    self.shareBtn.frame = CGRectMake(ScreenBounds.size.width-40, CGRectGetMaxY(self.prodImage.frame)+20, 30, 30);
    [self.shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    self.divisionhead.frame = CGRectMake(0, CGRectGetMaxY(self.prodPrice.frame), ScreenBounds.size.width, 0.5);
    
    
    self.service.text = [NSString stringWithFormat:@"服   务:%@",groupProductDetail.prod_base_info.sender];
    CGSize serviceSize = [self.service.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}];
    self.service.frame  = CGRectMake(TLCellBorderWidth, CGRectGetMaxY(self.divisionhead.frame)+5, serviceSize.width, serviceSize.height);
    
    self.divisionfoot.frame = CGRectMake(0, CGRectGetMaxY(self.service.frame)+5, ScreenBounds.size.width, 0.5);
    
    CGFloat signX = TLCellBorderWidth;
    
    if ([groupProductDetail.coupon_flag.ready_to_retire_flg isEqualToString:TLYES]) {
        UILabel *anytime = [[UILabel alloc]init];
        anytime.font = [UIFont systemFontOfSize:14];
        anytime.textColor = [UIColor getColor:@"72c6f7"];
        anytime.text = @"随时退";
        CGSize anytimeSize = [anytime.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        anytime.frame = CGRectMake(signX, CGRectGetMaxY(self.divisionfoot.frame)+5, anytimeSize.width, anytimeSize.height);
        [self addSubview:anytime];
        
        signX = CGRectGetMaxX(anytime.frame);
    }
    if ([groupProductDetail.coupon_flag.expired_refund_flg isEqualToString:TLYES]) {
        UILabel *anytime = [[UILabel alloc]init];
        anytime.font = [UIFont systemFontOfSize:14];
        anytime.textColor = [UIColor getColor:@"72c6f7"];
        anytime.text = @"过期退";
        CGSize anytimeSize = [anytime.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        anytime.frame = CGRectMake(signX+20, CGRectGetMaxY(self.divisionfoot.frame)+5, anytimeSize.width, anytimeSize.height);
        [self addSubview:anytime];
        
        signX = CGRectGetMaxX(anytime.frame);
    }
    if ([groupProductDetail.coupon_flag.non_refundable_flg isEqualToString:TLYES]) {
        UILabel *anytime = [[UILabel alloc]init];
        anytime.font = [UIFont systemFontOfSize:14];
        anytime.textColor = [UIColor getColor:@"72c6f7"];
        anytime.text = @"不可退";
        CGSize anytimeSize = [anytime.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        anytime.frame = CGRectMake(signX+20, CGRectGetMaxY(self.divisionfoot.frame)+5, anytimeSize.width, anytimeSize.height);
        [self addSubview:anytime];
    }
    
    UILabel *buyNo = [[UILabel alloc]init];
    buyNo.font = [UIFont systemFontOfSize:14];
    buyNo.textColor = [UIColor getColor:@"9f9f9f"];
    buyNo.text = [NSString stringWithFormat:@"已售%@",groupProductDetail.prod_base_info.sold_qty];
    CGSize buyNoSize = [buyNo.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    buyNo.frame = CGRectMake(ScreenBounds.size.width - buyNoSize.width - TLCellBorderWidth, CGRectGetMaxY(self.divisionfoot.frame)+5, buyNoSize.width, buyNoSize.height);
    [self addSubview:buyNo];
    
    UIView *divisionView = [[UIView alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(buyNo.frame)+5, ScreenBounds.size.width, 10)];
    [self addSubview:divisionView];
    divisionView.backgroundColor = [UIColor getColor:@"f4f4f4"];
    

    UILabel *favourable1 = [[UILabel alloc]init];
    favourable1.font = [UIFont systemFontOfSize:14];
    favourable1.text = @"好评度";
    CGSize favourable1Size = [favourable1.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    favourable1.frame = CGRectMake(TLCellBorderWidth, 5, favourable1Size.width, favourable1Size.height);

    UILabel *favourableComment = [[UILabel alloc]init];
    favourableComment.font = [UIFont systemFontOfSize:14];
    favourableComment.text = [NSString stringWithFormat:@"%@%%",groupProductDetail.prod_base_info.good_rating_percent];
    favourableComment.textColor = [UIColor redColor];
    CGSize favourableCommentSize = [favourableComment.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    favourableComment.frame = CGRectMake(CGRectGetMaxX(favourable1.frame)+5, 5, favourableCommentSize.width, favourableCommentSize.height);
    
    UIButton *CommentNo = [[UIButton alloc]init];
    CommentNo.titleLabel.font = [UIFont systemFontOfSize:14];
    [CommentNo setTitleColor:[UIColor getColor:@"9f9f9f"] forState:UIControlStateNormal];
    [CommentNo setTitle:[NSString stringWithFormat:@"共%@个消费评价",groupProductDetail.prod_base_info.good_rating_qty] forState:UIControlStateNormal];
     [CommentNo addTarget:self action:@selector(favourablebutton1111) forControlEvents:UIControlEventTouchUpInside];

    CGSize CommentNoSize = [CommentNo.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    CommentNo.frame = CGRectMake(ScreenBounds.size.width - CommentNoSize.width - 2*TLCellBorderWidth-CommentNoSize.height/2, favourableComment.frame.origin.y, CommentNoSize.width, CommentNoSize.height);
    
    
    UIImageView *addressImage = [[UIImageView alloc]init];
    addressImage.userInteractionEnabled = YES;
    addressImage.image = [UIImage imageNamed:@"grey back_normal"];
    addressImage.frame = CGRectMake(ScreenBounds.size.width-10-CommentNoSize.height/2, favourableComment.frame.origin.y, CommentNoSize.height/2, CommentNoSize.height);

     _favourable.frame = CGRectMake(0, CGRectGetMaxY(divisionView.frame), ScreenBounds.size.width, favourableCommentSize.height+10);
    [_favourable addSubview:favourableComment];
    [_favourable addSubview:CommentNo];
    [_favourable addSubview:favourable1];
    [_favourable addSubview:addressImage];

    UIView *divisionView2 = [[UIView alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(_favourable.frame), ScreenBounds.size.width, 10)];
    [self addSubview:divisionView2];
    divisionView2.backgroundColor = [UIColor getColor:@"f4f4f4"];
    
    self.height = CGRectGetMaxY(divisionView2.frame);
    
}



-(void)setupBtn:(UIButton *)btn icon_normal:(NSString *)icon_normal icon_press:(NSString *)icon_press
{
    [btn setImage:[UIImage imageNamed:icon_normal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:icon_press] forState:UIControlStateHighlighted];
}


-(void)prodDetails:(UIButton *)button
{
    self.productDetailBlack();
}

-(void)share:(UIButton *)button
{
    self.productShareBlack();
}

-(void)favourablebutton1111
{
    self.productEvaluateBlack();
}






@end
