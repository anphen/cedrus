//
//  TLAddressViewCell.m
//  TL11
//
//  Created by liu on 15-4-14.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLAddressViewCell.h"
#import "TLAddress.h"

@implementation TLAddressViewCell


-(void)setAddress:(TLAddress *)address
{
    _address = address;
    
    self.Name.text = address.consignee;
    self.Phone.text = address.tel;
    self.Adress.text = [NSString stringWithFormat:@"%@%@%@%@",address.province_name,address.city_name,address.area_name,address.address];
    //下面根据是否选中图片来给按键加不同的图片
}

+(instancetype)Cellwithtable:(UITableView *)table
{
    static NSString *ID = @"address";
    TLAddressViewCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TLAddressViewCell"owner:self options:nil] lastObject];
    }
    return cell;
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
