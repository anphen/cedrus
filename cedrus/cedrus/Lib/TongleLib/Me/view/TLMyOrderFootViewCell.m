//
//  TLMyOrderFootViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-8.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLMyOrderFootViewCell.h"
#import "TLMyOrderList.h"
#import "TLMyOrderProdDetail.h"
#import "UIColor+TL.h"
#import "TLCommon.h"
#import "UIButton+TL.h"

@implementation TLMyOrderFootViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *order_time = [[UILabel alloc]init];
        //order_time.textAlignment = NSTextAlignmentLeft;
        order_time.textColor = [UIColor getColor:@"999999"];
        [self.contentView addSubview:order_time];
        order_time.font = [UIFont systemFontOfSize:11];
        self.order_time = order_time;
        
        UILabel *amount = [[UILabel alloc]init];
        //amount.textAlignment = NSTextAlignmentLeft;
        amount.textColor = [UIColor getColor:@"3d4245"];
        [self.contentView addSubview:amount];
        amount.font = [UIFont boldSystemFontOfSize:13];
        self.amount = amount;
        
        UILabel *count = [[UILabel alloc]init];
        count.textColor = [UIColor getColor:@"3d4245"];
        [self.contentView addSubview:count];
        count.font = [UIFont systemFontOfSize:13];
        self.count = count;
        
        UILabel *freight = [[UILabel alloc]init];
        freight.textColor = [UIColor getColor:@"999999"];
        [self.contentView addSubview:freight];
        freight.font = [UIFont systemFontOfSize:13];
        self.freight = freight;
        
        UILabel *freightCount = [[UILabel alloc]init];
        freightCount.textColor = [UIColor getColor:@"3d4245"];
        [self.contentView addSubview:freightCount];
        freightCount.font = [UIFont systemFontOfSize:13];
        self.freightCount = freightCount;
        
        UILabel *shifu = [[UILabel alloc]init];
        shifu.textColor = [UIColor getColor:@"999999"];
        [self.contentView addSubview:shifu];
        shifu.font = [UIFont systemFontOfSize:13];
        self.shifu = shifu;
        
        UIButton *orderDetailsButton = [self createButtonWithTitleColor: [UIColor getColor:@"5f646e"]];
        [orderDetailsButton setTitle:@"订单详情" forState:UIControlStateNormal];
        [orderDetailsButton addTarget:self action:@selector(orderDetails:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:orderDetailsButton];
        self.orderDetailsButton = orderDetailsButton;

        
        UIButton *sureButon = [self createButtonWithTitleColor: [UIColor getColor:@"5f646e"]];
        [sureButon addTarget:self action:@selector(sureButon:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:sureButon];
        self.sureButon = sureButon;
    }
    return self;
}

-(void)orderDetails:(UIButton *)btn
{
    if ([self.detegate respondsToSelector:@selector(myOrderFootViewCellDetegate:withOrder_no:withOrderList:)]) {
        [self.detegate myOrderFootViewCellDetegate:self withOrder_no:self.order_no withOrderList:self.myOrderList];
    }
}

-(void)sureButon:(UIButton *)btn
{
    [btn ButtonDelay];
    if (([self.nameButton isEqualToString:@"订单详情"])&&([self.detegate respondsToSelector:@selector(myOrderFootViewCellDetegate:withOrder_no:withOrderList:)]))
    {
           [self.detegate myOrderFootViewCellDetegate:self withOrder_no:self.order_no withOrderList:self.myOrderList];
    }else if(([self.nameButton isEqualToString:@"评价订单"])&&([self.detegate respondsToSelector:@selector(myOrderFootViewCellEvaluation:withOrderList:)]))
    {
        [self.detegate myOrderFootViewCellEvaluation:self withOrderList:self.myOrderList];
    }else if(([self.nameButton isEqualToString:@"确认收货"])&&([self.detegate respondsToSelector:@selector(myOrderFootViewCellReceiveProd:withOrderList:)]))
    {
        [self.detegate myOrderFootViewCellReceiveProd:self withOrderList:self.myOrderList];
    }else if(([self.nameButton isEqualToString:@"立即支付"])&&([self.detegate respondsToSelector:@selector(myOrderFootViewCellPayment:withOrderList:withOrder_no:)]))
    {
        [self.detegate myOrderFootViewCellPayment:self withOrderList:self.myOrderList withOrder_no:self.order_no];
    }
}


+(id)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"orderfoot";
    TLMyOrderFootViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TLMyOrderFootViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)setMyOrderList:(TLMyOrderList *)myOrderList
{
    _myOrderList = myOrderList;
    self.order_time.text = self.myOrderList.order_time;
    int index = 0;
    for (TLMyOrderProdDetail *MyOrderProdDetail in myOrderList.prod_detail) {
        index = index+[MyOrderProdDetail.quantity intValue];
    }
    
    self.count.text = [NSString stringWithFormat:@"共%d件商品",index];
    self.shifu.text = @"实付:";
    self.freightCount.text = [NSString stringWithFormat:@"¥%.2f",[myOrderList.fee_amount doubleValue]];
    self.freight.text = @"运费:";
    self.amount.text = [NSString stringWithFormat:@"¥%.2f",[myOrderList.amount doubleValue] + [myOrderList.fee_amount doubleValue]];
    self.order_no = myOrderList.order_no;
}


-(void)setNameButton:(NSString *)nameButton
{
    _nameButton = nameButton;
    [self.sureButon setTitle:nameButton forState:UIControlStateNormal];
    if ([nameButton isEqualToString:@"立即支付"]) {
        [self.sureButon.layer setBorderColor:[UIColor getColor:@"54b3ec"].CGColor];
        [self.sureButon setTitleColor:[UIColor getColor:@"54b3ec"] forState:UIControlStateNormal];
        [self.sureButon setTitleColor:[UIColor getColor:@"3c89b7"] forState:UIControlStateHighlighted];
    }else
    {
        [self.sureButon.layer setBorderColor:[UIColor getColor:@"d0d0d0"].CGColor];
        [self.sureButon setTitleColor:[UIColor getColor:@"5f646e"] forState:UIControlStateNormal];
        [self.sureButon setTitleColor:[UIColor getColor:@"5f646e"] forState:UIControlStateHighlighted];
    }

}

-(UIButton *)createButtonWithTitleColor:(UIColor *)titleColor
{
    UIButton *PaymentBtn = [[UIButton alloc]init];
    //[PaymentBtn setTitle:title forState:UIControlStateNormal];
    [PaymentBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [PaymentBtn setTitleColor:[UIColor getColor:@"505050"] forState:UIControlStateHighlighted];
    
    PaymentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [PaymentBtn setBackgroundImage:[UIImage imageNamed:@"common_button_red_disable@2x.png"] forState:UIControlStateNormal];
    [PaymentBtn setBackgroundImage:[UIImage imageNamed:@"common_button_big_red_os7@2x.png"] forState:UIControlStateHighlighted];
    
    [PaymentBtn.layer setMasksToBounds:YES];
    [PaymentBtn.layer setCornerRadius:2.0]; //设置矩圆角半径
    [PaymentBtn.layer setBorderWidth:1.0];   //边框宽度
    CGColorRef colorref2 = [UIColor getColor:@"d0d0d0"].CGColor;
    [PaymentBtn.layer setBorderColor:colorref2];//边框颜色
    return  PaymentBtn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat order_timeX = 13;
    CGFloat order_timeY = 16;
   
    CGSize order_timeSize = [self.order_time.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    self.order_time.frame = (CGRect){{order_timeX,order_timeY},order_timeSize};
    
    UIView *splitfirst  = [[UIView alloc]initWithFrame:CGRectMake(13, CGRectGetMaxY(self.order_time.frame)+16, ScreenBounds.size.width-23, 1)];
    splitfirst.backgroundColor = [UIColor getColor:@"dddddd"];
    [self.contentView addSubview:splitfirst];
    
    
    
    CGSize amountSize = [self.amount.text sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]}];
    CGFloat amountX = self.bounds.size.width - 11 - amountSize.width;
    CGFloat amountY = order_timeY;
    self.amount.frame = (CGRect){{amountX,amountY},amountSize};

    CGSize shifuSize = [@"实付:" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    CGFloat shifuX = amountX - shifuSize.width-5;
    CGFloat shifuY = amountY;
    self.shifu.frame = (CGRect){{shifuX,shifuY},shifuSize};
    
    if ([self.myOrderList.fee_amount doubleValue]) {
        self.freight.hidden = NO;
        self.freightCount.hidden = NO;
        CGSize freightCountSize = [self.freightCount.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        CGFloat freightCountX = self.shifu.frame.origin.x - freightCountSize.width-5;
        CGFloat freightCountY = self.shifu.frame.origin.y;
        self.freightCount.frame = (CGRect){{freightCountX,freightCountY},freightCountSize};
        
        CGSize freightSize = [self.freight.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        CGFloat freightX = self.freightCount.frame.origin.x-freightSize.width;
        CGFloat freightY = self.freightCount.frame.origin.y;
        self.freight.frame = (CGRect){{freightX,freightY},freightSize};
        
        CGSize countSize = [self.count.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        CGFloat countX = freightX - countSize.width-10;
        CGFloat countY = freightY;
        self.count.frame = (CGRect){{countX,countY},countSize};
        
        
    }else
    {
        self.freight.hidden = YES;
        self.freightCount.hidden = YES;
        CGSize countSize = [self.count.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        CGFloat countX = shifuX - countSize.width-10;
        CGFloat countY = shifuY;
        self.count.frame = (CGRect){{countX,countY},countSize};
    }
    
    
    CGFloat sureButonW = 70;
    CGFloat sureButonH = 30;
    CGFloat sureButonX = self.bounds.size.width - 10 - sureButonW;
    CGFloat sureButonY = CGRectGetMaxY(self.amount.frame)+20;
    self.sureButon.frame = CGRectMake(sureButonX, sureButonY, sureButonW, sureButonH);
    
    UIView *splitsecond  = [[UIView alloc]initWithFrame:CGRectMake(0, 89, ScreenBounds.size.width, 1)];
    splitsecond.backgroundColor = [UIColor getColor:@"dddddd"];
    [self.contentView addSubview:splitsecond];
        
    CGFloat DetailsBtnW = 70;
    CGFloat DetailsBtnH = 30;
    CGFloat DetailsBtnX = sureButonX - 10-DetailsBtnW ;
    CGFloat DetailsBtnY = sureButonY;
    self.orderDetailsButton.frame = CGRectMake(DetailsBtnX, DetailsBtnY, DetailsBtnW, DetailsBtnH);
    
    if ([self.nameButton isEqualToString:@"订单详情"]) {
        self.orderDetailsButton.hidden = YES;
        self.orderDetailsButton.enabled = NO;
    }else
    {
        self.orderDetailsButton.hidden = NO;
        self.orderDetailsButton.enabled = YES;
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
