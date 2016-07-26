//
//  TLMyorderEvaViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-17.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMyOrderProdDetail,TLMyorderEvaViewCell;


@protocol TLMyorderEvaViewCellDelegate <NSObject>

@optional

-(void)MyorderEvaViewCell:(TLMyorderEvaViewCell *)myorderEvaViewCell withOrderProd:(TLMyOrderProdDetail *)myOrderProdDetail withBtn:(UIButton *)btn;

@end

@interface TLMyorderEvaViewCell : UITableViewCell

@property (nonatomic,strong) TLMyOrderProdDetail *OrderProdDetail;
@property (nonatomic,weak) id<TLMyorderEvaViewCellDelegate>delegate;

+(id)cellWithTableView:(UITableView *)tableview;

@end
