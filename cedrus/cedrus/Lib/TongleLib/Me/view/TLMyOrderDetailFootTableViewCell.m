//
//  TLMyOrderDetailFootTableViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLMyOrderDetailFootTableViewCell.h"
#import "TLMyOrderDetailHead_info.h"
#import "TLMyOrderDetail.h"
#import "TLCommon.h"
#import "UIColor+TL.h"

@implementation TLMyOrderDetailFootTableViewCell


+(id)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"MyOrderDetailFootTableViewCell";
    TLMyOrderDetailFootTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TLMyOrderDetailFootTableViewCell" owner:self options:nil]lastObject];

        [cell.canceButton.layer setMasksToBounds:YES];
        [cell.canceButton.layer setBorderWidth:1.0];
        CGColorRef colorref2 = [UIColor getColor:@"d9d9d9"].CGColor;
        [cell.canceButton.layer setBorderColor:colorref2];//边框颜色
        
        [cell.againsubmit setTitleColor:[UIColor getColor:@"d9d9d9"] forState:UIControlStateNormal];
        [cell.againsubmit setTitleColor:[UIColor getColor:@"d9d9d9"] forState:UIControlStateHighlighted];
        [cell.againsubmit.layer setMasksToBounds:YES];
        [cell.againsubmit.layer setBorderWidth:1.0];
        [cell.againsubmit.layer setBorderColor:colorref2];//边框颜色
    }
    return cell;
}

-(void)setMyOrderDetail:(TLMyOrderDetail *)myOrderDetail
{
    _myOrderDetail = myOrderDetail;
    TLMyOrderDetailHead_info *myOrderDetailHead_info = myOrderDetail.order_info.head_info;
    
    self.order_no.text = [NSString stringWithFormat:@"订单号: %@",myOrderDetailHead_info.order_no];
    self.order_time.text = [NSString stringWithFormat:@"成交时间: %@",myOrderDetailHead_info.order_time];
    
    TLMyOrderDetailList *detailList = [[TLMyOrderDetailList alloc]init];
    
    if (myOrderDetail.order_info.order_detail.count) {
        detailList = myOrderDetail.order_info.order_detail[0];
    }
    
    
    if ([detailList.import_goods_flag isEqualToString:TLYES]) {
        if ([myOrderDetail.order_info.head_info.customs_flag intValue]==0) {
            self.tariffTitle.hidden = NO;
            self.againsubmit.hidden = YES;
            self.againsubmit.enabled = NO;
            self.tariffMessage.hidden = NO;
            self.tariffMessage.text = @"通关信息审核已通过";
            self.lastRule.hidden = NO;
        }else if ([myOrderDetail.order_info.head_info.customs_flag intValue]==1)
        {
            self.tariffTitle.hidden = NO;
            self.againsubmit.hidden = NO;
            self.againsubmit.enabled = YES;
            self.tariffMessage.hidden = NO;
            self.tariffMessage.text = myOrderDetailHead_info.customs_fail_reason;
            self.tariffMessage.textColor = [UIColor redColor];
            self.lastRule.hidden = NO;}
        else{
            self.tariffTitle.hidden = NO;
            self.againsubmit.hidden = YES;
            self.againsubmit.enabled = YES;
            self.tariffMessage.hidden = NO;
            self.tariffMessage.text = @"通关审核中";
            self.lastRule.hidden = NO;
            }
    }else
    {
        self.tariffTitle.hidden = YES;
        self.againsubmit.hidden = YES;
        self.againsubmit.enabled = NO;
        self.tariffMessage.hidden = YES;
    }
 
    if ([myOrderDetail.order_info.head_info.status isEqualToString:TL_OBLIGATION]||[myOrderDetail.order_info.head_info.status isEqualToString:TL_NEW_ORDER]) {
            self.canceButton.hidden = NO;
            self.canceButton.enabled = YES;
            self.lastRule.hidden = NO;
        }else
        {
            self.canceButton.hidden = YES;
            self.canceButton.enabled = NO;
            self.lastRule.hidden = YES;
        }

}


- (IBAction)againSub:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(MyOrderDetailFootTableViewCellAgainSub:)]) {
        [self.delegate MyOrderDetailFootTableViewCellAgainSub:self];
    }
}

- (IBAction)canceBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(MyOrderDetailFootTableViewCell:)]) {
        [self.delegate MyOrderDetailFootTableViewCell:self];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
