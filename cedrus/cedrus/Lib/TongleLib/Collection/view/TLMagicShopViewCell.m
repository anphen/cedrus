//
//  TLMagicShopViewCell.m
//  tongle
//
//  Created by liu on 15-5-4.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLMagicShopViewCell.h"
#import "TLMagicShop.h"
#import "SDWebImageManager.h"
#import "TLImageName.h"
#import "UIImageView+Image.h"

@interface TLMagicShopViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *Name;

@end


@implementation TLMagicShopViewCell

+(instancetype)cellWithTableView:(UITableView *)table
{
    /**
     *  设置缓存池中cell的标识
     */
    static NSString *ID = @"magicshop";
    /**
     *  去缓存池中取cell
     */
    TLMagicShopViewCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        /**
         第一次要自己创建
         */
        // cell = [[TLMagicShopViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TLMagicShopViewCell" owner:self options:nil]lastObject];
    }
    
    
    
    return cell;
}


-(void)setMagicShop:(TLMagicShop *)magicShop
{
    _magicShop = magicShop;
    
    [self.headImage setImageWithURL:magicShop.mstore_pic_url placeImage:[UIImage imageNamed:TL_MOSHOP_DEFAULT]];
    self.headImage.layer.cornerRadius = 8;
    self.headImage.layer.masksToBounds = YES;
    
    self.Name.text =magicShop.mstore_name;

}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
