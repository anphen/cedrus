//
//  TLMyOrderDetailFootTableViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TLMyOrderDetail,TLMyOrderDetailFootTableViewCell;

@protocol TLMyOrderDetailFootTableViewCellDelegate <NSObject>

@optional

-(void)MyOrderDetailFootTableViewCell:(TLMyOrderDetailFootTableViewCell *)myOrderDetailFoot;
-(void)MyOrderDetailFootTableViewCellAgainSub:(TLMyOrderDetailFootTableViewCell *)myOrderDetailFoot;
@end



@interface TLMyOrderDetailFootTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *order_no;

@property (weak, nonatomic) IBOutlet UILabel *order_time;


@property (weak, nonatomic) IBOutlet UIButton *canceButton;

@property (weak, nonatomic) IBOutlet UIView *lastRule;

@property (weak, nonatomic) IBOutlet UILabel *tariffTitle;

@property (weak, nonatomic) IBOutlet UILabel *tariffMessage;
@property (weak, nonatomic) IBOutlet UIButton *againsubmit;

@property (nonatomic,strong) TLMyOrderDetail *myOrderDetail;

@property (nonatomic,assign) id<TLMyOrderDetailFootTableViewCellDelegate>delegate;
- (IBAction)againSub:(UIButton *)sender;

- (IBAction)canceBtn:(UIButton *)sender;


+(id)cellWithTableView:(UITableView *)tableview;

@end