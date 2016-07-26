//
//  TLMyFiledTableViewCell.h
//  tongle
//
//  Created by ruibin liu on 15/6/20.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  TLProd_type_List;


@interface TLMyFiledTableViewCell : UITableViewCell

@property (nonatomic,strong) TLProd_type_List *prod_type_List;
@property (nonatomic,assign) BOOL isSelected;


+(id)cellWithTableView:(UITableView *)tableView;

@end

