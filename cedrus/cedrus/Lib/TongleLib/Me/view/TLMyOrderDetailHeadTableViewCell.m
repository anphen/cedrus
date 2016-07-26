//
//  TLMyOrderDetailHeadTableViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLMyOrderDetailHeadTableViewCell.h"
#import "TLMyOrderDetailHead_info.h"
#import "TLMyOrderDetailAdd_info.h"
#import "TLMyOrderDetailLogistics_info.h"
#import "TLMyOrderDetail.h"
#import "TLMyOrderDetailOrder_info.h"
#import "TLImageName.h"
#import "TLCommon.h"
#import "UIColor+TL.h"
#import "UIButton+TL.h"

@interface TLMyOrderDetailHeadTableViewCell ()

@property (nonatomic,weak) UILabel *orderMoney;
@property (nonatomic,weak) UILabel *freight;
@property (nonatomic,weak) UILabel *traiff;
@property (nonatomic,weak) UILabel *consignee;
@property (nonatomic,weak) UILabel *address;
@property (nonatomic,weak) UILabel *dealSuccess;
@property (nonatomic,weak) UIButton *btn;
@property (nonatomic,weak) UILabel *logisticsName;
@property (nonatomic,weak) UIView  *splitsecond;

@property (nonatomic,strong) TLMyOrderDetailLogistics_info *MyOrderDetailLogistics_info;
@property (nonatomic,weak) UIView *splitFirst;

@end

@implementation TLMyOrderDetailHeadTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *dealSuccess = [[UILabel alloc]init];
        [self.contentView addSubview:dealSuccess];
        _dealSuccess = dealSuccess;
        
        UILabel *logisticsName = [[UILabel alloc]init];
        [self.contentView addSubview:logisticsName];
        _logisticsName = logisticsName;
        
        UIView *splitsecond = [[UIView alloc]init];
        [self.contentView addSubview:splitsecond];
        _splitsecond = splitsecond;
        
        UIButton *btn = [UIButton createButtonWithTitle:nil titleColor:[UIColor getColor:@"898989"]];
        [self.contentView addSubview:btn];
        _btn = btn;
    }
    return self;;
}


+(id)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"myorderdetail";
    TLMyOrderDetailHeadTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TLMyOrderDetailHeadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)setMyOrderDetail:(TLMyOrderDetail *)myOrderDetail
{
    if (_myOrderDetail != myOrderDetail) {

          _myOrderDetail = myOrderDetail;
        TLMyOrderDetailOrder_info *myOrderDetailOrder_info = self.myOrderDetail.order_info;
        TLMyOrderDetailHead_info *myOrderDetailHead_info =myOrderDetailOrder_info.head_info;
        TLMyOrderDetailAdd_info *myOrderDetailAdd_info = myOrderDetailOrder_info.add_info;
        TLMyOrderDetailLogistics_info *myOrderDetailLogistics_info = myOrderDetailOrder_info.logistics_info;
        self.MyOrderDetailLogistics_info = myOrderDetailLogistics_info;
        
        UIImageView *deal = [[UIImageView alloc]initWithImage:[UIImage imageNamed:TL_MYORDER_DETAIL_ICON02]];
        deal.frame = CGRectMake(17, 10, 13, 17);
        [self.contentView addSubview:deal];
        
        TLMyOrderDetailList *detailList = [[TLMyOrderDetailList alloc]init];
        
        if (myOrderDetail.order_info.order_detail.count) {
            detailList = myOrderDetail.order_info.order_detail[0];
        }
        
        if ([detailList.import_goods_flag isEqualToString:TLYES]) {
            if ([myOrderDetail.order_info.head_info.customs_flag intValue]==0) {
                _dealSuccess.text = @"订单确认，待发货";
            }else if ([myOrderDetail.order_info.head_info.customs_flag intValue]==1)
            {
                _dealSuccess.text = @"通关信息审核失败,详情请查看通关信息";
            }else{
                _dealSuccess.text = @"通关审核中";
            }
        }else
        {
            _dealSuccess.text = [self orderStatus];
        }

        _dealSuccess.font = [UIFont systemFontOfSize:13];
        [_dealSuccess setTextColor:[UIColor getColor:@"3d4245"]];
        CGSize dealSuccessSize = [_dealSuccess.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}];
        _dealSuccess.frame = (CGRect){{CGRectGetMaxX(deal.frame)+14,10},dealSuccessSize};
        
        UILabel *orderMoney = [[UILabel alloc]init];
        orderMoney.text = @"订单金额(含运费):";
        orderMoney.font = [UIFont systemFontOfSize:13];
        [orderMoney setTextColor:[UIColor getColor:@"3d4245"]];
        CGSize orderMoneySize = [orderMoney.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}];
        orderMoney.frame = (CGRect){{CGRectGetMaxX(deal.frame)+14,CGRectGetMaxY(_dealSuccess.frame)+5},orderMoneySize};
        [self.contentView addSubview:orderMoney];
        self.orderMoney = orderMoney;
        
        [_btn setTitle:[self buttonStatus] forState:UIControlStateNormal];
        [_btn.layer setBorderColor:[UIColor getColor:@"898989"].CGColor];
        [_btn setTitleColor:[UIColor getColor:@"898989"] forState:UIControlStateHighlighted];
        _btn.frame = CGRectMake(ScreenBounds.size.width-84, 16, 72, 28);
        if ([[self buttonStatus] isEqualToString:@"立即支付"]) {
            [_btn.layer setBorderColor:[UIColor getColor:@"54b3ec"].CGColor];
            [_btn setTitleColor:[UIColor getColor:@"54b3ec"] forState:UIControlStateNormal];
            [_btn setTitleColor:[UIColor getColor:@"3c89b7"] forState:UIControlStateHighlighted];
        }
        [_btn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btn];
        if ([_btn.titleLabel.text isEqualToString:@"隐藏"]) {
            _btn.hidden = YES;
           // [_btn removeFromSuperview];
        }
        
        UILabel *amount = [[UILabel alloc]init];
        amount.text = myOrderDetailHead_info.amount;
        amount.font = [UIFont systemFontOfSize:13];
        [amount setTextColor:[UIColor getColor:@"3d4245"]];
        CGSize amountSize = [amount.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}];
        amount.frame = (CGRect){{CGRectGetMaxX(self.orderMoney.frame)+5,self.orderMoney.frame.origin.y},amountSize};
        [self.contentView addSubview:amount];
        
        UILabel *freight = [[UILabel alloc]init];
        freight.text = [NSString stringWithFormat:@"运费:￥%@",myOrderDetailHead_info.fee_amount];
        freight.font = [UIFont systemFontOfSize:13];
        [freight setTextColor:[UIColor getColor:@"3d4245"]];
        CGSize freightSize = [freight.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}];
        freight.frame = (CGRect){{self.orderMoney.frame.origin.x,CGRectGetMaxY(self.orderMoney.frame)+5},freightSize};
        [self.contentView addSubview:freight];
        self.freight = freight;
        
        UILabel *traiff = [[UILabel alloc]init];
        traiff.text = [NSString stringWithFormat:@"关税:￥%@(≤50元 免征)",myOrderDetailHead_info.tariff];
        traiff.textColor = [UIColor getColor:@"3d4245"];
        traiff.font = [UIFont systemFontOfSize:14];
        CGSize traiffSize = [traiff.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        if ([detailList.import_goods_flag isEqualToString:TLYES]) {
            traiff.frame = (CGRect){{self.freight.frame.origin.x,CGRectGetMaxY(self.freight.frame)+5},traiffSize};
        }else
        {
            traiff.frame = (CGRect){{self.freight.frame.origin.x,CGRectGetMaxY(self.freight.frame)+5},0};
        }
        [self.contentView addSubview:traiff];
        self.traiff = traiff;
        
        UILabel *consignee = [[UILabel alloc]init];
        consignee.text = [NSString stringWithFormat:@"收货人:%@",myOrderDetailAdd_info.consignee];
        consignee.font = [UIFont systemFontOfSize:13];
        [consignee setTextColor:[UIColor getColor:@"3d4245"]];
        CGSize consigneeSize = [consignee.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}];
        consignee.frame = (CGRect){{self.traiff.frame.origin.x,CGRectGetMaxY(self.traiff.frame)+22},consigneeSize};
        [self.contentView addSubview:consignee];
        self.consignee = consignee;
        
        
        UIImageView *addressImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:TL_MYORDER_DETAIL_ICON01]];
        addressImage.frame = CGRectMake(17, self.consignee.frame.origin.y, 13, 17);
        [self.contentView addSubview:addressImage];
        
        UILabel *tel = [[UILabel alloc]init];
        tel.text = myOrderDetailAdd_info.tel;
        tel.font = [UIFont systemFontOfSize:13];
        [tel setTextColor:[UIColor getColor:@"3d4245"]];
        CGSize telSize = [tel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}];
        CGFloat telX = ScreenBounds.size.width - 12-telSize.width;
        CGFloat telY = self.consignee.frame.origin.y;
        tel.frame = (CGRect){{telX,telY},telSize};
        [self.contentView addSubview:tel];
        
        UILabel *address = [[UILabel alloc]init];
        address.text = @"收货地址:";
        address.font = [UIFont systemFontOfSize:12];
        [address setTextColor:[UIColor getColor:@"bbbdbf"]];
        CGSize addressSize = [address.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}];
        CGFloat addressX = self.freight.frame.origin.x;
        CGFloat addressY = CGRectGetMaxY(self.consignee.frame)+6;
        address.frame = (CGRect){{addressX,addressY},addressSize};
        [self.contentView addSubview:address];
        
        UILabel *addressText = [[UILabel alloc]init];
        addressText.text = [NSString stringWithFormat:@"%@%@%@",myOrderDetailAdd_info.province,myOrderDetailAdd_info.area,myOrderDetailAdd_info.address];
        addressText.numberOfLines = 0;
        addressText.font = [UIFont systemFontOfSize:12];
        [addressText setTextColor:[UIColor getColor:@"bbbdbf"]];
        CGSize addressTextSize = [addressText.text boundingRectWithSize:CGSizeMake(ScreenBounds.size.width-12-CGRectGetMaxX(address.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size;
        CGFloat addressTextX = CGRectGetMaxX(address.frame);
        CGFloat addressTextY = address.frame.origin.y;
        addressText.frame = (CGRect){{addressTextX,addressTextY},addressTextSize};
        [self.contentView addSubview:addressText];
        
        if (_splitFirst == nil) {
            UIView *splitFirst = [[UIView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(addressText.frame)+26, ScreenBounds.size.width-24, 1)];
            splitFirst.backgroundColor = [UIColor getColor:@"dddddd"];
            [self.contentView addSubview:splitFirst];
            self.splitFirst = splitFirst;
        }
        UILabel *logisticsMeg = [[UILabel alloc]init];
        logisticsMeg.text = @"物流信息";
        logisticsMeg.font = [UIFont systemFontOfSize:13];
        [logisticsMeg setTextColor:[UIColor getColor:@"3d4245"]];
        CGSize logisticsMegSize = [logisticsMeg.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}];
        logisticsMeg.frame = (CGRect){{addressX,CGRectGetMaxY(addressText.frame)+40},logisticsMegSize};
        [self.contentView addSubview:logisticsMeg];
        

        _logisticsName.text = [self orderLogistics_info];
        _logisticsName.font = [UIFont systemFontOfSize:12];
        [_logisticsName setTextColor:[UIColor getColor:@"4ebd7d"]];
        CGSize logisticsNameSize = [_logisticsName.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}];
        _logisticsName.frame = (CGRect){{logisticsMeg.frame.origin.x,CGRectGetMaxY(logisticsMeg.frame)+6},logisticsNameSize};
        
        UIImageView *logisticsImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:TL_MYORDER_DETAIL_ICON03]];
        logisticsImage.frame = CGRectMake(17, _logisticsName.frame.origin.y, 17, 17);
        [self.contentView addSubview:logisticsImage];
        
        UILabel *logisticsTime = [[UILabel alloc]init];
        logisticsTime.text = [self orderLogistics_infoTime];
        logisticsTime.font = [UIFont systemFontOfSize:12];
        [logisticsTime setTextColor:[UIColor getColor:@"999999"]];
        CGSize logisticsTimeSize = [logisticsTime.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}];
        logisticsTime.frame = (CGRect){{_logisticsName.frame.origin.x,CGRectGetMaxY(_logisticsName.frame)+6},logisticsTimeSize};
        [self.contentView addSubview:logisticsTime];
        
        _splitsecond.frame = CGRectMake(12,  CGRectGetMaxY(logisticsTime.frame)+12, ScreenBounds.size.width-24, 1);
        _splitsecond.backgroundColor = [UIColor getColor:@"dddddd"];
        
        
        UIView *splitH  = [[UIView alloc]initWithFrame:CGRectMake(logisticsImage.center.x,  CGRectGetMaxY(logisticsImage.frame), 1, _splitsecond.center.y-CGRectGetMaxY(logisticsImage.frame))];
        splitH.backgroundColor = [UIColor getColor:@"dddddd"];
        [self.contentView addSubview:splitH];
        
        self.height = CGRectGetMaxY(logisticsTime.frame)+13;
    }
    
}


-(NSString *)orderStatus
{
    
    switch ([self.myOrderDetail.order_info.head_info.status intValue])
    {
        case 0:
            return @"订单确认，待审核";
            break;
        case 1:
            return @"订单确认，已审核";
            break;
        case 2:
            return @"订单确认，待发货";
            break;
        case 3:
            return @"订单确认，待收货";
            break;
        case 4:
            return @"订单已完成，待评价";
            break;
        case 5:
            return @"订单已完成，已评价";
            break;
        case 6:
            return @"订单已完成，已拒收";
            break;
        case 7:
            return @"订单确认，待付款";
            break;
        default:
            return @"付款确认中";
            break;
    }
}


-(NSString *)buttonStatus
{
    
    switch ([self.myOrderDetail.order_info.head_info.status intValue])
    {
            
        case 7:
            return @"立即支付";
            break;
        case 3:
            return @"确认收货";
            break;
        case 4:
            return @"评价订单";
            break;
        case 5:
            return @"删除订单";
            break;
        default:
            return @"隐藏";
            break;
    }
}


-(NSString *)orderLogistics_info
{
    switch ([self.myOrderDetail.order_info.head_info.status intValue])
    {
        case 0:
        case 2:
        case 7:
            return @"未发货";
            break;
        case 1:
        case 3:
        case 4:
        case 5:
        case 6:
            return [NSString stringWithFormat:@"%@   %@",self.MyOrderDetailLogistics_info.shipping_company,self.MyOrderDetailLogistics_info.shipping_no];
            break;
        default:
            return @"待定";
            break;
    }
}

-(NSString *)orderLogistics_infoTime
{
    switch ([self.myOrderDetail.order_info.head_info.status intValue])
    {
        case 0:
        case 2:
        case 7:
            return nil;
            break;
        case 1:
        case 3:
        case 4:
        case 5:
        case 6:
            return self.MyOrderDetailLogistics_info.shipping_time;
            break;
        default:
            return @"待定";
            break;
    }
}

-(void)change:(UIButton *)btn
{
    [btn ButtonDelay];
    if ([self.detegate respondsToSelector:@selector(TLMyOrderDetailHeadTableViewCell:withBtn:)])
    {
        [self.detegate TLMyOrderDetailHeadTableViewCell:self withBtn:btn];
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
