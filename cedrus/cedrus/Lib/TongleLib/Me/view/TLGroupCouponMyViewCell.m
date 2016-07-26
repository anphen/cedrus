//
//  TLGroupCouponMyViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/21.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupCouponMyViewCell.h"
#import "TLGroupCouponVoucher.h"
#import "UIImageView+Image.h"
#import "TLImageName.h"
#import "UIColor+TL.h"

@interface TLGroupCouponMyViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *moneyType;

@property (weak, nonatomic) IBOutlet UILabel *couponName;

@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *useConditions;
@property (weak, nonatomic) IBOutlet UILabel *useConditonsMemo;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIImageView *picUrl;
@property (weak, nonatomic) IBOutlet UIButton *status;
@property (weak, nonatomic) IBOutlet UIImageView *action;
@property (weak, nonatomic) IBOutlet UIButton *useButton;

@property (weak, nonatomic) IBOutlet UIImageView *tipsImage;

- (IBAction)useButton:(UIButton *)sender;
@end


@implementation TLGroupCouponMyViewCell


+(instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"TLGroupCouponMyViewCell";
    TLGroupCouponMyViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil]lastObject];
    }
    return cell;
}

-(void)setGroupCouponVoucher:(TLGroupCouponVoucher *)groupCouponVoucher
{
    _groupCouponVoucher = groupCouponVoucher;
    
    if ([groupCouponVoucher.voucher_base.issue_flg intValue] == 1) {
        _couponName.text = [NSString stringWithFormat:@"%@ - 全平台使用",groupCouponVoucher.voucher_base.vouchers_name];
        _money.textColor = [UIColor getColor:@"c1e8ff"];
        _moneyType.textColor = [UIColor getColor:@"c1e8ff"];
         _headImage.image = [UIImage imageNamed:COUPON_TOP_TONGLE];
    }else
    {
        _couponName.text = [NSString stringWithFormat:@"%@ - 店铺使用券",groupCouponVoucher.voucher_base.issue_store_name];
        _money.textColor = [UIColor getColor:@"ffc0c0"];
        _moneyType.textColor = [UIColor getColor:@"ffc0c0"];
         _headImage.image = [UIImage imageNamed:COUPON_TOP_DIANPU];
    }
    _time.text = [NSString stringWithFormat:@"%@-%@",groupCouponVoucher.voucher_base.expiration_date_begin,groupCouponVoucher.voucher_base.expiration_date_end];
    _money.text = groupCouponVoucher.voucher_base.money;
    _useConditions.text =   groupCouponVoucher.voucher_base.use_conditions_memo;
    [_picUrl setImageWithURL:groupCouponVoucher.voucher_link_info.pic placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    _status.titleLabel.text = groupCouponVoucher.voucher_link_info.title;
    [_picUrl setImageWithURL:groupCouponVoucher.voucher_link_info.pic placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    if (([groupCouponVoucher.voucher_base.vouchers_status intValue] == 1) || ([groupCouponVoucher.voucher_base.vouchers_status intValue] == 2)) {
        _action.hidden = NO;
        _tipsImage.hidden = YES;
    }else
    {
        _action.hidden = YES;
        _tipsImage.hidden = NO;
        _money.textColor = [UIColor getColor:@"dcdcdc"];
        _moneyType.textColor = [UIColor getColor:@"dcdcdc"];
        _headImage.image = [UIImage imageNamed:COUPON_TOP_USERD_EXPIRED];
        
        if ([groupCouponVoucher.voucher_base.vouchers_status intValue] == 3)
        {
            _tipsImage.image = [UIImage imageNamed:TL_ICON_USER];
        }else
        {
            _tipsImage.image = [UIImage imageNamed:TL_ICON_EXPIRED];
        }
    }

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)useButton:(UIButton *)sender {
    
    self.actionblock();

}
@end
