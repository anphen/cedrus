//
//  TLCarOrderViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 15-7-22.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLCarOrderViewCell.h"
#import "TLShopCar.h"
#import "TLImageName.h"
#import "UIImageView+Image.h"
#import "TLCommon.h"

@implementation TLCarOrderViewCell

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)table
{
    static NSString *ID = @"carorder";
    TLCarOrderViewCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TLCarOrderViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

-(void)setShopcar:(TLShopCar *)shopcar
{
    _shopcar = shopcar;
    
    [self.ProdImage setImageWithURL:shopcar.prod_pic_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    self.ProdName.text = shopcar.prod_name;
    self.ProdPrice.text = [NSString stringWithFormat:@"￥%0.2f",[shopcar.price floatValue]];
    self.ProdPeopel.text = [NSString stringWithFormat:@"x%@",shopcar.order_qty];
    NSString *size  = [NSString string];
    for (TLProdSpecList_size *specList_size in shopcar.prod_spec_list) {
        size = [NSString stringWithFormat:@"%@%@:%@;",size,specList_size.prod_spec_name,specList_size.spec_detail_name];
    }
    self.ProdSize.text = size;
    if ([shopcar.import_goods_flag isEqualToString:TLYES]) {
        self.country.hidden = NO;
        self.country.text = shopcar.import_info_desc;
    }else
    {
        self.country.hidden = YES;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
