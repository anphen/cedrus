//
//  TLOrderSingleViewCell.h
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMyOrderProdDetail,TLMyOrderDetailList;


@interface TLOrderSingleViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Icon;

@property (weak, nonatomic) IBOutlet UILabel *Name;

@property (weak, nonatomic) IBOutlet UILabel *Size;

@property (weak, nonatomic) IBOutlet UILabel *Price;

@property (weak, nonatomic) IBOutlet UILabel *Number;

@property (weak, nonatomic) IBOutlet UILabel *country;

@property (nonatomic,strong) TLMyOrderProdDetail *myOrderProdDetail;
@property (nonatomic,strong) TLMyOrderDetailList *myOrderDetailList;


+(instancetype)cellWithTableView:(UITableView *)table;


@end
