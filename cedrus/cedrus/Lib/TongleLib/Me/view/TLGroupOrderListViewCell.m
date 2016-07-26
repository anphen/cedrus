//
//  TLGroupOrderListViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/21.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupOrderListViewCell.h"
#import "TLGroupOrder.h"
#import "UIImageView+Image.h"
#import "TLImageName.h"
#import "UIColor+TL.h"

@interface TLGroupOrderListViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *prodImage;
@property (weak, nonatomic) IBOutlet UIImageView *unusedImage;

@property (weak, nonatomic) IBOutlet UILabel *prodName;
@property (weak, nonatomic) IBOutlet UILabel *prodPrice;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)button:(UIButton *)sender;


@end


@implementation TLGroupOrderListViewCell


+(instancetype)cellWithTableview:(UITableView *)tableView
{
    static NSString *ID = @"TLGroupOrderListViewCell";
    TLGroupOrderListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:self options:nil]lastObject];
        [cell.prodImage.layer setMasksToBounds:YES];
        [cell.prodImage.layer setCornerRadius:3.0];
        [cell.button.layer setMasksToBounds:YES];
        [cell.button.layer setCornerRadius:3.0];
        [cell.button.layer setBorderWidth:1.0];
        CGColorRef colorref = [UIColor getColor:@"d7d7d7"].CGColor;
        [cell.button.layer setBorderColor:colorref];
        
    }
    return cell;
}

-(void)setType:(NSString *)type
{
    _type  =type;
}

-(void)setGroupOrder:(TLGroupOrder *)groupOrder
{
    _groupOrder = groupOrder;
    NSDictionary *dict = groupOrder.prod_pic_url_list.firstObject;
    
    [_prodImage setImageWithURL:dict[@"pic_url"] placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    _prodName.text = groupOrder.prod_name;
    _prodPrice.text = [NSString stringWithFormat:@"%@张 | 总价:￥%@",groupOrder.order_qty,groupOrder.order_amount];
    if ([groupOrder.refunding_qty intValue]) {
        _number.text = [NSString stringWithFormat:@"可用%@张 退款中%@张",groupOrder.unused_qty,groupOrder.refunding_qty];
    }else
    {
        _number.text = [NSString stringWithFormat:@"可用%@张",groupOrder.unused_qty];
    }
    _unusedImage.hidden = [groupOrder.order_pay_info.pay_status intValue];
    
    if (![groupOrder.order_pay_info.pay_status intValue]) {
        _button.hidden = NO;
        [_button setTitle:@"立即支付" forState:UIControlStateNormal];
    }else if (![groupOrder.evaluate_flag intValue])
    {
        _button.hidden = NO;
        [_button setTitle:@"评价" forState:UIControlStateNormal];
    }else
    {
        _button.hidden = YES;
    }
}


- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)button:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(groupOrderListViewCell:button:withGroupOrder:)]) {
        [self.delegate groupOrderListViewCell:self button:sender withGroupOrder:_groupOrder];
    }
}
@end
