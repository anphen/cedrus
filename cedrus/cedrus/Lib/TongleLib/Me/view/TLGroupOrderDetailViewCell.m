//
//  TLGroupOrderDetailViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/22.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupOrderDetailViewCell.h"
#import "TLGroupOrderBase.h"
#import "UIImageView+Image.h"
#import "TLImageName.h"

@interface TLGroupOrderDetailViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *prodImage;

@property (weak, nonatomic) IBOutlet UILabel *prodName;

@property (weak, nonatomic) IBOutlet UILabel *couponNumber;

@property (weak, nonatomic) IBOutlet UILabel *priceNow;

//@property (weak, nonatomic) IBOutlet UILabel *priceOld;
//
//@property (weak, nonatomic) IBOutlet UILabel *couponMessae;

@end


@implementation TLGroupOrderDetailViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TLGroupOrderDetailViewCell";
    TLGroupOrderDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil]lastObject];
    }
    return cell;
}


-(void)setGroupOrderBase:(TLGroupOrderBase *)groupOrderBase
{
    _groupOrderBase = groupOrderBase;
    NSDictionary *dict = groupOrderBase.prod_pic_url_list.firstObject;
    [_prodImage setImageWithURL:dict[@"pic_url"] placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    _prodName.text = groupOrderBase.prod_name;
    _couponNumber.text = [NSString stringWithFormat:@"%@张",groupOrderBase.order_qty];
    _priceNow.text = [NSString stringWithFormat:@"总价:￥%@",groupOrderBase.order_amount];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
