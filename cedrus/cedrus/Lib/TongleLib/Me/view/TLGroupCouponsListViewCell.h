//
//  TLGroupCouponsListViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/17.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>



@class TLGroupCoupons,TLGroupCouponsListViewCell,TLGroupCouponCode;

typedef void(^showBlock)();
typedef void(^showCodeBlock)();

@protocol TLGroupCouponsListViewCellDelegate <NSObject>

-(void)groupCouponsListViewCell:(TLGroupCouponsListViewCell *)groupCouponsListViewCell withCoupon:(TLGroupCouponCode *)couponCode withTLGroupCoupons:(TLGroupCoupons *)groupCoupons;

@end


@interface TLGroupCouponsListViewCell : UITableViewCell

@property (nonatomic,strong) TLGroupCoupons *groupCoupons;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,copy) showBlock     showCellBlock;
@property (nonatomic,copy) showCodeBlock showCellCodeBlock;
@property (nonatomic,copy) NSString *showType;
@property (nonatomic,assign) id<TLGroupCouponsListViewCellDelegate>delegate;

+(instancetype)cellWithTableview:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath;

@end
