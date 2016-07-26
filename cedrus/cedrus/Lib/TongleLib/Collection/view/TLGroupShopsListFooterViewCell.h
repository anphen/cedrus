//
//  TLGroupShopsListFooterViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 16/4/18.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLGroupStoreList;

@interface TLGroupShopsListFooterViewCell : UITableViewCell

@property (nonatomic,strong) TLGroupStoreList *groupStore;

@property (nonatomic,assign) CGFloat height;

+(instancetype)cellWithTableCell:(UITableView *)tableview;

@end
