//
//  TLPendingOrderView.m
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLPendingOrderView.h"
#import "TLOrderGroup.h"
#import "UIButton+TL.h"


@interface TLPendingOrderView()

@property (nonatomic,weak) UILabel *Order_No;
@property (nonatomic,weak) UILabel *message;
@property (nonatomic,weak) UIButton *DetailsBtn;
@property (nonatomic,weak) UIButton *PaymentBtn;

@end

@implementation TLPendingOrderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(instancetype)FooterViewWithTableView:(UITableView *)table
{
    static NSString *ID = @"footer";
    TLPendingOrderView *footer = [table dequeueReusableCellWithIdentifier:ID];
    if (footer == nil) {
        footer = [[TLPendingOrderView alloc]initWithReuseIdentifier:ID];
    }
    return footer;
}

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor blackColor];
        [self.contentView addSubview:label];
        label.font = [UIFont systemFontOfSize:10];
        self.Order_No = label;
        
        UILabel *labelme = [[UILabel alloc]init];
        labelme.textAlignment = NSTextAlignmentLeft;
        labelme.textColor = [UIColor grayColor];
        [self.contentView addSubview:labelme];
        labelme.font = [UIFont systemFontOfSize:10];
        self.message = labelme;
        
        
        
        UIButton *btn;
        
        btn = [UIButton createButtonWithTitle:@"订单详情" titleColor: [UIColor grayColor]];
        [self.contentView addSubview:btn];
        self.DetailsBtn = btn;
        
        btn = [UIButton createButtonWithTitle:@"立即支付" titleColor: [UIColor greenColor]];
        [self.contentView addSubview:btn];
        self.PaymentBtn = btn;
    }
    return self;
}
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
    
    CGFloat DetailsBtnX = 156;
    CGFloat DetailsBtnY = 50;
    CGFloat DetailsBtnW = 60;
    CGFloat DetailsBtnH = 30;
    self.DetailsBtn.frame = CGRectMake(DetailsBtnX, DetailsBtnY, DetailsBtnW, DetailsBtnH);
    
    CGFloat PaymentBtnX = 236;
    CGFloat PaymentBtnY = 50;
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
