//
//  TLGroupOrderDetailFooterViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/22.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupOrderDetailFooterViewCell.h"
#import "TLGroupOrderBase.h"


@interface TLGroupOrderDetailFooterViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *order_no;
@property (weak, nonatomic) IBOutlet UILabel *order_time;

@end



@implementation TLGroupOrderDetailFooterViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TLGroupOrderDetailFooterViewCell";
    TLGroupOrderDetailFooterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil]lastObject];
    }
    return cell;
}

-(void)setGroupOrderBase:(TLGroupOrderBase *)groupOrderBase
{
    _groupOrderBase = groupOrderBase;
    
    _order_no.text = [NSString stringWithFormat:@"订单编号:%@",groupOrderBase.order_no];
    _order_time.text = [NSString stringWithFormat:@"下单时间:%@",groupOrderBase.order_create_time];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
