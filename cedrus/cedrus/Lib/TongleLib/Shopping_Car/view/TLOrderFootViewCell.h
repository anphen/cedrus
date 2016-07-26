//
//  TLOrderFootViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-2.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLBasicData,TLOrderMode,TLOrderFootViewCell,TLOrderDetailMeg;


@protocol TLOrderFootViewCellDelegate <NSObject>

@optional

-(void)orderFootViewCell:(TLOrderFootViewCell *)orderFootViewCell withOrderMode:(TLOrderMode *)orderMode;

@end

@interface TLOrderFootViewCell : UITableViewCell
@property (nonatomic,strong) TLBasicData    *baseData;
@property (nonatomic,strong) TLOrderMode    *orderMode;
@property (nonatomic,strong)  TLOrderDetailMeg    *orderDetailMeg;
@property (nonatomic,copy)  NSString        *weight;
@property (nonatomic,copy)  NSString        *couponmoney;
//@property (nonatomic,copy)  NSString        *account_price;
//@property (nonatomic,copy)  NSString        *freight;
//@property (nonatomic,copy)  NSString        *tariff;
//@property (nonatomic,copy)  NSString        *total_amount;
@property (nonatomic,weak) id<TLOrderFootViewCellDelegate>delegate;


+(instancetype)cellWithTableView:(UITableView *)table;
@end
