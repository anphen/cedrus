//
//  TLMyOrderFootViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-8.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMyOrderList,TLMyOrderFootViewCell;


@protocol TLMyOrderFootViewCellDetegate <NSObject>

@optional

-(void)myOrderFootViewCellDetegate:(TLMyOrderFootViewCell *)myOrderFootViewCell withOrder_no:(NSString *)order_no withOrderList:(TLMyOrderList *)myOrderList;

-(void)myOrderFootViewCellEvaluation:(TLMyOrderFootViewCell *)myOrderFootViewCell withOrderList:(TLMyOrderList *)myOrderList;

-(void)myOrderFootViewCellReceiveProd:(TLMyOrderFootViewCell *)myOrderFootViewCell withOrderList:(TLMyOrderList *)myOrderList;

-(void)myOrderFootViewCellPayment:(TLMyOrderFootViewCell *)myOrderFootViewCell withOrderList:(TLMyOrderList *)myOrderList withOrder_no:(NSString *)order_no;

@end



@interface TLMyOrderFootViewCell : UITableViewCell

@property (nonatomic,weak) UILabel *order_time;
@property (nonatomic,weak) UILabel *count;
@property (nonatomic,weak) UILabel *shifu;
@property (nonatomic,weak) UILabel *amount;
@property (nonatomic,weak) UIButton *orderDetailsButton;
@property (nonatomic,weak) UIButton *sureButon;
@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,weak) UILabel *freight;
@property (nonatomic,weak) UILabel *freightCount;

@property (nonatomic,copy) NSString *nameButton;
@property (nonatomic,strong) TLMyOrderList *myOrderList;
@property (nonatomic,weak) id<TLMyOrderFootViewCellDetegate> detegate;

+(id)cellWithTableView:(UITableView *)tableview;

@end
