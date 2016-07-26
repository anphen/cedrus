//
//  TLAddressesListViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-3.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLAddress;


@interface TLAddressesListViewCell : UITableViewCell

@property (nonatomic,strong) TLAddress *address;
@property (nonatomic,assign) BOOL rightselected;

+(id)cellWithTableView:(UITableView *)tableView;
@end
