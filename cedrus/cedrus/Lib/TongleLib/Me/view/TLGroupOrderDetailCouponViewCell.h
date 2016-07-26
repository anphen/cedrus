//
//  TLGroupOrderDetailCouponViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/22.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^codeButton)();
@interface TLGroupOrderDetailCouponViewCell : UITableViewCell

@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) NSDictionary *groupDetailCouponDict;
@property (nonatomic,copy) codeButton codebutton;

+(instancetype)cellWithTableview:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath;

@end
