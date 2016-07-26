//
//  TLProductViewCell.m
//  TL11
//
//  Created by liu on 15-4-15.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLProductViewCell.h"
#import "TLProduct.h"
#import "TLProductAll.h"
#import "TLImageName.h"
#import "UIImageView+Image.h"
#import "TLCommon.h"

@implementation TLProductViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)CellWithtable:(UITableView *)table
{
    /**
     *  设置缓存池中cell的标识
     */
    static NSString *ID = @"product";
    /**
     *  去缓存池中取cell
     */
    TLProductViewCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        /**
         *  如果没有就去nib中取加载
         */
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TLProductViewCell" owner:self options:nil] lastObject];
        
    }
    return cell;
}

/**
 *  设置属性
 *
 *  @param product 对象
 */
-(void)setProduct:(TLProduct *)product
{
    _product = product;
    [self.Icon setImageWithURL:product.prod_thumbnail_pic_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    self.Name.text = product.prod_name;
    self.Price.text = [NSString stringWithFormat:@"￥%@",product.prod_price];
    self.Rebate.text = product.prod_points_rule;
    self.typeProd.image = [UIImage imageNamed:TL_ICON_COUPON];
    self.typeProd.hidden = ![product.coupon_flag isEqualToString:TLYES];
}




@end
