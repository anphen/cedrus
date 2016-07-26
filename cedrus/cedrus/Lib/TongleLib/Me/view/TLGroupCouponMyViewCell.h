//
//  TLGroupCouponMyViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/21.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^actionBlock)();

@class TLGroupCouponVoucher;

@interface TLGroupCouponMyViewCell : UITableViewCell

@property (nonatomic,strong) TLGroupCouponVoucher *groupCouponVoucher;
@property (nonatomic,copy) actionBlock actionblock;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@end