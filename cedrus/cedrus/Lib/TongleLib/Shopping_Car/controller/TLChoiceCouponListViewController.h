//
//  TLChoiceCouponListViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/31.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLChoiceCouponListViewController,TLVoucherBase;

@protocol TLChoiceCouponListViewControllerDelegate <NSObject>

-(void)choiceCouponListViewController:(TLChoiceCouponListViewController *)choiceCouponListView withTLVoucherBase:(TLVoucherBase *)voucher_base;

@end

@interface TLChoiceCouponListViewController : UITableViewController

@property (nonatomic,strong) NSArray *goodInfoArray;
@property(nonatomic,strong) TLVoucherBase  *voucher_base;
@property (nonatomic,copy) NSString *vouchers_number_id;
@property(nonatomic,assign) id<TLChoiceCouponListViewControllerDelegate>delegate;

@end
