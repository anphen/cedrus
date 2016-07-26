//
//  TLMyOrderDetailHeadTableViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMyOrderDetail,TLMyOrderDetailHeadTableViewCell;


@protocol TLMyOrderDetailHeadTableViewCellDetegate <NSObject>

@optional

-(void)TLMyOrderDetailHeadTableViewCell:(TLMyOrderDetailHeadTableViewCell *)myOrderDetailHeadTableViewCell withBtn:(UIButton *)btn;

@end


@interface TLMyOrderDetailHeadTableViewCell : UITableViewCell

@property (nonatomic,strong) TLMyOrderDetail *myOrderDetail;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) id<TLMyOrderDetailHeadTableViewCellDetegate> detegate;

+(id)cellWithTableView:(UITableView *)tableview;

@end
