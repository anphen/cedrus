//
//  TLMagicShopViewCell.h
//  tongle
//
//  Created by liu on 15-5-4.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMagicShop.h"

@interface TLMagicShopViewCell : UITableViewCell

@property (nonatomic,strong) TLMagicShop *magicShop;


/**
 *  返回魔店的tableViewCell
 *
 *  @param table 魔店页面的tableView
 *
 *  @return 返回魔店的tableViewCell
 */
+(instancetype)cellWithTableView:(UITableView *)table;

@end
