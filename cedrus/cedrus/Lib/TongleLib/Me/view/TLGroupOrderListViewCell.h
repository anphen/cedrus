//
//  TLGroupOrderListViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/21.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLGroupOrder,TLGroupOrderListViewCell;

@protocol TLGroupOrderListViewCellDelagate <NSObject>

-(void)groupOrderListViewCell:(TLGroupOrderListViewCell *)groupOrderListViewCell button:(UIButton *)button withGroupOrder:(TLGroupOrder *)groupOrder;

@end

@interface TLGroupOrderListViewCell : UITableViewCell

@property (nonatomic,strong) TLGroupOrder *groupOrder;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,assign) id<TLGroupOrderListViewCellDelagate>delegate;

+(instancetype)cellWithTableview:(UITableView *)tableView;

@end
