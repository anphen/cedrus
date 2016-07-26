//
//  TLPendingOrderView.h
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLOrderGroup;


@interface TLPendingOrderView : UITableViewHeaderFooterView

+(instancetype)FooterViewWithTableView:(UITableView *)table;

@property (nonatomic,strong) TLOrderGroup *group;

@end
