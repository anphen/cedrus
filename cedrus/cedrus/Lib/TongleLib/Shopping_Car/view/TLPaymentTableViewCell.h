//
//  TLPaymentTableViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/14.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLDataList;

@interface TLPaymentTableViewCell : UITableViewCell

@property (nonatomic,strong) TLDataList *data;
@property (weak, nonatomic) IBOutlet UIButton *selectPay;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
