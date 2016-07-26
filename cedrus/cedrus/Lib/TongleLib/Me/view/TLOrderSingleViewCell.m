
//  TLOrderSingleViewCell.m
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLOrderSingleViewCell.h"
#import "TLOrderSingle.h"
#import "TLMyOrderProdDetail.h"
#import "TLMyOrderDetailList.h"
#import "TLImageName.h"
#import "UIImageView+Image.h"
#import "TLCommon.h"


@implementation TLOrderSingleViewCell


-(void)setMyOrderProdDetail:(TLMyOrderProdDetail *)myOrderProdDetail
{
    _myOrderProdDetail = myOrderProdDetail;
    [self.Icon setImageWithURL:myOrderProdDetail.prod_pic_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    
    self.Name.text = myOrderProdDetail.prod_name;
   // self.Size.text = [NSString stringWithFormat:@"尺寸：%@",ordersingle.Size];
    if (myOrderProdDetail.prod_spec_list.count == 1) {
        TLMyOrderProdSpecList *myOrderProdSpecList = myOrderProdDetail.prod_spec_list[0];
         self.Size.text = [NSString stringWithFormat:@"%@:%@",myOrderProdSpecList.prod_spec_name,myOrderProdSpecList.spec_detail_name];
    }else if(myOrderProdDetail.prod_spec_list.count == 2)
    {
        TLMyOrderProdSpecList *myOrderProdSpecOne = myOrderProdDetail.prod_spec_list[0];
        TLMyOrderProdSpecList *myOrderProdSpecTwo = myOrderProdDetail.prod_spec_list[1];
        self.Size.text = [NSString stringWithFormat:@"%@:%@;%@:%@",myOrderProdSpecOne.prod_spec_name,myOrderProdSpecOne.spec_detail_name,myOrderProdSpecTwo.prod_spec_name,myOrderProdSpecTwo.spec_detail_name];
    }
    if ([myOrderProdDetail.import_goods_flag isEqualToString:TLYES]) {
        self.country.hidden = NO;
        self.country.text = myOrderProdDetail.import_info_desc;
    }else
    {
        self.country.hidden = YES;
    }
    self.Price.text = [NSString stringWithFormat:@"%@",myOrderProdDetail.price];
    self.Number.text = [NSString stringWithFormat:@"x%@",myOrderProdDetail.quantity];
}

-(void)setMyOrderDetailList:(TLMyOrderDetailList *)myOrderDetailList
{
    _myOrderDetailList = myOrderDetailList;
    [self.Icon setImageWithURL:myOrderDetailList.prod_pic_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    
    self.Name.text = myOrderDetailList.prod_name;
    // self.Size.text = [NSString stringWithFormat:@"尺寸：%@",ordersingle.Size];
    if (myOrderDetailList.prod_spec_list.count == 1) {
        TLMyOrderProdSpecList *myOrderProdSpecList = myOrderDetailList.prod_spec_list[0];
        self.Size.text = [NSString stringWithFormat:@"%@:%@",myOrderProdSpecList.prod_spec_name,myOrderProdSpecList.spec_detail_name];
    }else if(myOrderDetailList.prod_spec_list.count == 2)
    {
        TLMyOrderProdSpecList *myOrderProdSpecOne = myOrderDetailList.prod_spec_list[0];
        TLMyOrderProdSpecList *myOrderProdSpecTwo = myOrderDetailList.prod_spec_list[1];
        self.Size.text = [NSString stringWithFormat:@"%@:%@;%@:%@",myOrderProdSpecOne.prod_spec_name,myOrderProdSpecOne.spec_detail_name,myOrderProdSpecTwo.prod_spec_name,myOrderProdSpecTwo.spec_detail_name];
    }
    if ([myOrderDetailList.import_goods_flag isEqualToString:TLYES]) {
        self.country.hidden = NO;
        self.country.text = myOrderDetailList.import_info_desc;
    }else
    {
        self.country.hidden = YES;
    }
    self.Price.text = [NSString stringWithFormat:@"%@",myOrderDetailList.price];
    self.Number.text = [NSString stringWithFormat:@"x%@",myOrderDetailList.quantity];
}

//-(void)setOrdersingle:(TLOrderSingle *)ordersingle
//{
//    _ordersingle = ordersingle;
//    
//    self.Icon.image = [UIImage imageNamed:ordersingle.Icon];
//    self.Name.text = ordersingle.Name;
//    self.Size.text = [NSString stringWithFormat:@"尺寸：%@",ordersingle.Size];
//    self.Price.text = [NSString stringWithFormat:@"%.2f",ordersingle.Price];
//    self.Number.text = [NSString stringWithFormat:@"x%d",ordersingle.Number];
//}



+(instancetype)cellWithTableView:(UITableView *)table
{
    static NSString *ID = @"ordersingle";
    TLOrderSingleViewCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TLOrderSingleViewCell" owner:self options:nil] lastObject];
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
