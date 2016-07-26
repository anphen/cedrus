//
//  TLChoiceCouponListViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/31.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLVoucherBase;

@interface TLChoiceCouponListViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *seleteType;
@property (nonatomic,strong) TLVoucherBase *voucherBase;


+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
