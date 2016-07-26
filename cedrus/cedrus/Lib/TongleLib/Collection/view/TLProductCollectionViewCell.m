//
//  TLProductCollectionViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 16/1/4.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLProductCollectionViewCell.h"
#import "TLProduct.h"
#import "UIImageView+Image.h"
#import "TLImageName.h"
#import "UIColor+TL.h"
#import "TLCommon.h"

@interface TLProductCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *couponType;

@end

@implementation TLProductCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}





- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"TLProductCollectionViewCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
        _couponType.image = [UIImage imageNamed:TL_ICON_COUPON];
    }
    return self;
}

-(void)setProduct:(TLProduct *)product
{
    _product = product;
    [_productImage setImageWithURL:product.prod_thumbnail_pic_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    _productName.text = product.prod_name;
    _price.text = [NSString stringWithFormat:@"￥%@",product.prod_price];
    _couponType.hidden = [product.coupon_flag boolValue];
}


@end
