//
//  TLProdMeg.m
//  tongle
//
//  Created by liu ruibin on 15-5-20.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProdMeg.h"
#import "TLProdDetails.h"
#import "TLProdSpecList.h"
#import "TLSpecDetailList.h"
#import "UIColor+TL.h"
#import "UIButton+TL.h"
#import "TLCommon.h"
#import "MBProgressHUD+MJ.h"

#define  TL_TEXT_GETCOLOR @"686868"



@implementation TLProdMeg

static int amount = 0;
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor getColor:@"f3f5f7"];
        
        amount = 1;
        UILabel *prodCount = [[UILabel alloc]init];
        [prodCount setTextColor:[UIColor getColor:TL_TEXT_GETCOLOR]];
        prodCount.font = [UIFont systemFontOfSize:14];
        [self addSubview:prodCount];
        self.prodCount = prodCount;
        
        UILabel *spec_stock_qty = [[UILabel alloc]init];
        spec_stock_qty.font = [UIFont systemFontOfSize:12];
        [spec_stock_qty setTextColor:[UIColor getColor:TL_TEXT_GETCOLOR]];
        [self addSubview:spec_stock_qty];
        _spec_stock_qty = spec_stock_qty;
        
    }
    return self;
}

-(NSMutableArray *)prod_spec_list_array
{
    if (_prod_spec_list_array == nil) {
        _prod_spec_list_array = [NSMutableArray array];
    }
    return _prod_spec_list_array;
}



-(void)setProdDetails:(TLProdDetails *)prodDetails
{
    _prodDetails = prodDetails;
    self.prodSpecListArray = prodDetails.prod_spec_list;
    int index = 0;
    for (int i=0; i<self.prodSpecListArray.count; i++)
    {
        index++;
        NSDictionary *prod_spec_dict = [[NSDictionary alloc]init];
        [self.prod_spec_list_array addObject:prod_spec_dict];
        TLProdSpecList *prodSpecList = self.prodSpecListArray[i];
        UILabel *prodSpec = [[UILabel alloc]init];
        [prodSpec setTextColor:[UIColor getColor:TL_TEXT_GETCOLOR]];
        prodSpec.font = [UIFont systemFontOfSize:14];
        [self addSubview:prodSpec];
        prodSpec.text = prodSpecList.prod_spec_name;
        prodSpec.font = [UIFont systemFontOfSize:14];
        CGSize prodSpecSize = [prodSpec.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        if (index == 1) {
            prodSpec.frame = (CGRect){{20,25},prodSpecSize};
            
        }else
        {
            TLProdSpecList *prodSpecListlast = self.prodSpecListArray[i-1];
            UIButton *lastBtn = (UIButton *)[self viewWithTag:1000*(index-1)+prodSpecListlast.spec_detail_list.count-1];
            prodSpec.frame = (CGRect){{20,CGRectGetMaxY(lastBtn.frame)+10},prodSpecSize};
        }
        CGFloat length =  CGRectGetMaxX(prodSpec.frame) + 15;
        CGFloat row = 0;
        for (int i = 0; i<prodSpecList.spec_detail_list.count; i++)
        {
            TLSpecDetailList *specDetailList = prodSpecList.spec_detail_list[i];
            UIButton *prodSpecBtn = [UIButton createButtonWithTitle:specDetailList.spec_detail_name titleColor:[UIColor getColor:TL_TEXT_GETCOLOR]];
            
            CGSize prodSpecBtnSize = [specDetailList.spec_detail_name sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
            CGFloat prodSpecBtnX = length;
            if (prodSpecBtnX + prodSpecBtnSize.width > ScreenBounds.size.width-21)
            {
                length =  CGRectGetMaxX(prodSpec.frame) +15;
                prodSpecBtnX = length;
                row++;
            }
            CGFloat prodSpecBtnY = prodSpec.frame.origin.y -5 + (prodSpecBtnSize.height + 20)*row;
            prodSpecBtn.frame = CGRectMake(prodSpecBtnX, prodSpecBtnY, prodSpecBtnSize.width+20, prodSpecBtnSize.height+15);
            length += prodSpecBtnSize.width + 30;
            [prodSpecBtn addTarget:self action:@selector(Selected:) forControlEvents:UIControlEventTouchUpInside];
            prodSpecBtn.tag = 1000*index+i;
            [self addSubview:prodSpecBtn];
        }
    }
    
    self.prodCount.text = @"数量";
    self.prodCount.font = [UIFont systemFontOfSize:14];
    CGSize prodCount = [self.prodCount.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    
    TLProdSpecList *prodSpecListlast = self.prodSpecListArray.lastObject;
    UIButton *lastButton = (UIButton *)[self viewWithTag:1000*index+prodSpecListlast.spec_detail_list.count-1];
    self.prodCount.frame = (CGRect){{20,CGRectGetMaxY(lastButton.frame) + 20},prodCount};
    
    
    UIButton *decreaseBtn = [UIButton buttonWithCormalImage:@"jianhao_normal" pressImage:@"jianhao_press"];
    decreaseBtn.enabled = NO;
    [decreaseBtn addTarget:self action:@selector(decrease) forControlEvents:UIControlEventTouchUpInside];
    [decreaseBtn.layer setCornerRadius:0];
    decreaseBtn.frame = CGRectMake(CGRectGetMaxX(self.prodCount.frame) +15, CGRectGetMaxY(lastButton.frame) + 15, 34, 30);
    [self addSubview:decreaseBtn];
    _decreaseBtn = decreaseBtn;
    
    UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.prodCount.frame) +15+34, CGRectGetMaxY(lastButton.frame) + 15, 40, 30)];
    countLabel.textColor = [UIColor getColor:TL_TEXT_GETCOLOR];
    countLabel.text = [NSString stringWithFormat:@"%d",amount];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:countLabel];
    self.countLabel = countLabel;
    
    [countLabel.layer setMasksToBounds:YES];
    //[PaymentBtn.layer setCornerRadius:8.0]; //设置矩圆角半径
    [countLabel.layer setBorderWidth:1.0];   //边框宽度
    CGColorRef colorref2 = [UIColor getColor:@"d7d7d7"].CGColor;
    [countLabel.layer setBorderColor:colorref2];//边框颜色
    
    UIButton *addBtn = [UIButton buttonWithCormalImage:@"jiahao_normal" pressImage:@"jiahao_press"];
    addBtn.enabled = NO;
    [addBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [addBtn.layer setCornerRadius:0];
    addBtn.frame = CGRectMake(CGRectGetMaxX(self.prodCount.frame) +15 +34 +40, CGRectGetMaxY(lastButton.frame) + 15, 34, 30);
    [self addSubview:addBtn];
    _addBtn = addBtn;
    
    _spec_stock_qty.bounds = CGRectMake(0, 0, ScreenBounds.size.width-CGRectGetMaxX(addBtn.frame)-10, addBtn.frame.size.height);
    
    _spec_stock_qty.center = CGPointMake(CGRectGetMaxX(addBtn.frame)+(ScreenBounds.size.width-CGRectGetMaxX(addBtn.frame)-10)/2+5, addBtn.center.y);
    
    _height = CGRectGetMaxY(self.prodCount.frame) + 20;
    
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.01f];
}


-(void)getStocklist
{
    int key = 1;
    for (NSDictionary *dict in self.prod_spec_list_array) {
        key = key && [dict count];
    }
    if (key == 1) {
        if (self.prod_spec_list_array.count == 1)
        {
            NSString  *spec_detail_id = self.prod_spec_list_array.lastObject[@"spec_detail_id"];
            for (TLStock_List *stock_list in self.prodDetails.stock_list) {
                if ([spec_detail_id isEqualToString:stock_list.spec_detail_id1]) {
                    self.prod_Price = stock_list.spec_price;
                    [self specStockQty:stock_list];
                    _stock_list = stock_list;
                }
            }
        }else
        {
            NSString  *spec_detail_id1 = self.prod_spec_list_array[0][@"spec_detail_id"];
            NSString  *spec_detail_id2 = self.prod_spec_list_array[1][@"spec_detail_id"];
            for (TLStock_List *stock_list in self.prodDetails.stock_list) {
                if ([spec_detail_id1 isEqualToString:stock_list.spec_detail_id1] && [spec_detail_id2 isEqualToString:stock_list.spec_detail_id2]) {
                    self.prod_Price = stock_list.spec_price;
                    [self specStockQty:stock_list];
                    _stock_list = stock_list;
                }
            }
        }
        if ([_stock_list.spec_stock_qty intValue]) {
            _decreaseBtn.enabled = YES;
            _addBtn.enabled = YES;
            amount = 1;
            self.countLabel.text = [NSString stringWithFormat:@"%d",amount];
        }else
        {
            _decreaseBtn.enabled = NO;
            _addBtn.enabled = NO;
            amount = 0;
            self.countLabel.text = [NSString stringWithFormat:@"%d",amount];
        }
        
        if ([self.delegate respondsToSelector:@selector(ProdMeg:withMutableArray:munber:price:)])
        {
            [self.delegate ProdMeg:self withMutableArray:self.prod_spec_list_array munber:amount price:_stock_list.spec_price];
        }
    }
}


-(void)specStockQty:(TLStock_List *)stock_list
{
    if ([stock_list.spec_stock_qty intValue]) {
        self.spec_stock_qty.text = [NSString stringWithFormat:@"(库存%@)",stock_list.spec_stock_qty];
    }else
    {
        self.spec_stock_qty.text = stock_list.stock_memo;
    }
}


-(void)delayMethod
{
    if ([self.delegate respondsToSelector:@selector(ProdMegCreate: withMutableArray:)])
    {
        [self.delegate ProdMegCreate:self withMutableArray:_prod_spec_list_array];
    }
}



-(void)decrease
{
    if (amount>1)
    {
        amount--;
        self.countLabel.text = [NSString stringWithFormat:@"%d",amount];
        if ([self.delegate respondsToSelector:@selector(ProdMeg:withMutableArray:munber:price:)])
        {
            [self.delegate ProdMeg:self withMutableArray:self.prod_spec_list_array munber:amount price:_stock_list.spec_price];
        }
    }else
    {
        [MBProgressHUD showError:@"数量最少为1"];
    }
}
-(void)add
{
    if (amount < [_stock_list.spec_stock_qty intValue]) {
        amount++;
        self.countLabel.text = [NSString stringWithFormat:@"%d",amount];
        if ([self.delegate respondsToSelector:@selector(ProdMeg:withMutableArray:munber:price:)])
        {
            [self.delegate ProdMeg:self withMutableArray:self.prod_spec_list_array munber:amount price:_stock_list.spec_price];
        }
    }else
    {
        [MBProgressHUD showError:@"超过库存不能再加了"];
    }
}

-(void)Selected:(UIButton *)btn
{
    int index = (int)(btn.tag/1000);
    TLProdSpecList *prodSpecList = self.prodSpecListArray[index-1];
    int count = (int)prodSpecList.spec_detail_list.count;
    for (int i=0; i<count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:1000*index+i];
        btn.selected = NO;
        CGColorRef colorref2 = [UIColor getColor:@"d7d7d7"].CGColor;
        [btn.layer setBorderColor:colorref2];//边框颜色
        
    }
    btn.selected = YES;
    CGColorRef colorref2 = [UIColor getColor:@"f15353"].CGColor;
    [btn.layer setBorderColor:colorref2];//边框颜色
    TLSpecDetailList *specDetail = prodSpecList.spec_detail_list[(int)btn.tag%1000];

    self.prod_spec_list_array[index-1] = @{@"prod_spec_id":prodSpecList.prod_spec_id,@"prod_spec_name":prodSpecList.prod_spec_name,@"spec_detail_id":specDetail.spec_detail_id};

    [self getStocklist];
    
}



@end
