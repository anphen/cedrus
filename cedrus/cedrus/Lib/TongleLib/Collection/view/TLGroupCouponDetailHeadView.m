//
//  TLGroupCouponDetailHeadView.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/18.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupCouponDetailHeadView.h"
#import "TLGroupCouponDetail.h"
#import "UIImageView+Image.h"
#import "TLImageName.h"
#import "UIColor+TL.h"

@interface TLGroupCouponDetailHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *prodImage;
@property (weak, nonatomic) IBOutlet UILabel *prodName;
@property (weak, nonatomic) IBOutlet UIButton *prodDetailButton;
@property (weak, nonatomic) IBOutlet UILabel *couponCode;

@property (weak, nonatomic) IBOutlet UIButton *qrcode;
@property (weak, nonatomic) IBOutlet UILabel *expiredData;

@property (weak, nonatomic) IBOutlet UIButton *rebackButton;

@property (weak, nonatomic) IBOutlet UIButton *tel;
- (IBAction)prodDetailButton:(UIButton *)sender;

- (IBAction)qrcode:(UIButton *)sender;

- (IBAction)rebackButton:(UIButton *)sender;

- (IBAction)tel:(UIButton *)sender;

@end


@implementation TLGroupCouponDetailHeadView


+(instancetype)createView
{
    TLGroupCouponDetailHeadView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil]lastObject];
    [view.rebackButton.layer setMasksToBounds:YES];
    [view.rebackButton.layer setCornerRadius:3.0];
    [view.rebackButton.layer setBorderWidth:1.0];
    CGColorRef colorref2 = [UIColor getColor:@"d7d7d7"].CGColor;
    [view.rebackButton.layer setBorderColor:colorref2];//边框颜色
    return view;
}

-(void)setGroupCouponDetail:(TLGroupCouponDetail *)groupCouponDetail
{
    _groupCouponDetail = groupCouponDetail;
    
    NSDictionary *urlDict = groupCouponDetail.prod_base_info.prod_pic_url_list[0];
    [self.prodImage setImageWithURL:urlDict[@"pic_url"] placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    self.prodName.text = groupCouponDetail.prod_base_info.prod_name;
    
    NSString *code1 = [groupCouponDetail.prod_base_info.coupon_code substringToIndex:4];
    NSString *code2 = [groupCouponDetail.prod_base_info.coupon_code substringWithRange:NSMakeRange(4, 4)];
    NSString *code3 = [groupCouponDetail.prod_base_info.coupon_code substringFromIndex:8];
    
    
    NSString *couponCodeString=[NSString stringWithFormat:@"%@ %@ %@",code1,code2,code3];
    
    self.couponCode.text = couponCodeString;
    self.expiredData.text = [NSString stringWithFormat:@"有效期至 %@",groupCouponDetail.prod_base_info.expired_date];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)prodDetailButton:(UIButton *)sender {
    self.couponDetail();
}

- (IBAction)qrcode:(UIButton *)sender {
    self.codeblack();
}

- (IBAction)rebackButton:(UIButton *)sender {
    self.rebackProduct();
}

- (IBAction)tel:(UIButton *)sender {
    NSString *message = [NSString stringWithFormat:@"商品名称:%@;团购券号:%@",_groupCouponDetail.prod_base_info.prod_name,self.couponCode.text];
    self.tendmessage(message);
}
@end
