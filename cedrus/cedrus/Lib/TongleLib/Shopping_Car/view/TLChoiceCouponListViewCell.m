//
//  TLChoiceCouponListViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/31.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLChoiceCouponListViewCell.h"
#import "TLVoucherBase.h"


@interface TLChoiceCouponListViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *couponName;

@end



@implementation TLChoiceCouponListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TLChoiceCouponListViewCell";
    
    TLChoiceCouponListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil]lastObject];
    }
    return cell;
}

-(void)setVoucherBase:(TLVoucherBase *)voucherBase
{
    _voucherBase = voucherBase;
    _couponName.text = voucherBase.vouchers_name;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
