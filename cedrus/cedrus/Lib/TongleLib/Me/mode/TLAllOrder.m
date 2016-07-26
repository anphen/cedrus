//
//  TLAllOrder.m
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLAllOrder.h"
#import "TLOrderGroup.h"
#import "UIButton+TL.h"

@interface TLAllOrder()

@property (nonatomic,weak) UILabel *Order_No;
@property (nonatomic,weak) UILabel *message;
@property (nonatomic,weak) UIButton *LogisticsBtn;
@property (nonatomic,weak) UIButton *DetailsBtn;
@property (nonatomic,weak) UIButton *PaymentBtn;

@end


@implementation TLAllOrder

+(instancetype)FooterViewWithTableView:(UITableView *)table
{
    static NSString *ID = @"footer";
    TLAllOrder *footer = [table dequeueReusableCellWithIdentifier:ID];
    if (footer == nil) {
        footer = [[TLAllOrder alloc]initWithReuseIdentifier:ID];
    }
    return footer;
}
/**
 *  添加子控件
 *
 *  @param reuseIdentifier
 *
 *  @return 返回自定义的wiew
 */
-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc]init];
        /**
         *  设置订单号属性
         */
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor blackColor];
        [self.contentView addSubview:label];
        label.font = [UIFont systemFontOfSize:10];
        self.Order_No = label;
        /**
         设置订单详情
         */
        UILabel *labelme = [[UILabel alloc]init];
        labelme.textAlignment = NSTextAlignmentLeft;
        labelme.textColor = [UIColor grayColor];
        [self.contentView addSubview:labelme];
        labelme.font = [UIFont systemFontOfSize:10];
        self.message = labelme;
        /**
         设置订单按键
         */
        UIButton *btn;
        btn = [UIButton createButtonWithTitle:@"查看物流" titleColor:[UIColor grayColor]];
        [self.contentView addSubview:btn];
        self.LogisticsBtn = btn;
        
        btn = [UIButton createButtonWithTitle:@"订单详情" titleColor: [UIColor grayColor]];
        [self.contentView addSubview:btn];
        self.DetailsBtn = btn;

        btn = [UIButton createButtonWithTitle:@"立即支付" titleColor: [UIColor greenColor]];
        [self.contentView addSubview:btn];
        self.PaymentBtn = btn;
    }
    return self;
}


/**
 *  设置每个子控件的frame
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat orderX = 20;
    CGFloat orderY = 5;
    CGFloat orderW = self.frame.size.width-2*orderX;
    CGFloat orderH = 20;
    self.Order_No.frame = CGRectMake(orderX, orderY, orderW, orderH);
    
    CGFloat messageX = 20;
    CGFloat messageY = CGRectGetMaxY(self.Order_No.frame) + 5;
    CGFloat messageW = self.frame.size.width-2*messageX;
    CGFloat messageH = 20;
    self.message.frame = CGRectMake(messageX, messageY, messageW, messageH);
    
    CGFloat LogisticsBtnX = 70;
    CGFloat LogisticsBtnY = 50;
    CGFloat LogisticsBtnW = 66;
    CGFloat LogisticsBtnH = 30;
    self.LogisticsBtn.frame = CGRectMake(LogisticsBtnX, LogisticsBtnY, LogisticsBtnW, LogisticsBtnH);
    
    CGFloat DetailsBtnX = 156;
    CGFloat DetailsBtnY = LogisticsBtnY;
    CGFloat DetailsBtnW = 60;
    CGFloat DetailsBtnH = 30;
    self.DetailsBtn.frame = CGRectMake(DetailsBtnX, DetailsBtnY, DetailsBtnW, DetailsBtnH);
    
    CGFloat PaymentBtnX = 236;
    CGFloat PaymentBtnY = LogisticsBtnY;
    CGFloat PaymentBtnW = 60;
    CGFloat PaymentBtnH = 30;
    self.PaymentBtn.frame = CGRectMake(PaymentBtnX, PaymentBtnY, PaymentBtnW, PaymentBtnH);
    
}



-(void)setGroup:(TLOrderGroup *)group
{
    _group = group;
    self.Order_No.text = [NSString stringWithFormat:@"订单号:%@",group.Order_No];
    self.message.text = [NSString stringWithFormat:@"共%d件商品   运费:￥%.2lf  实付:￥%.2lf",group.All_Number,group.Freight,group.All_Price];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
