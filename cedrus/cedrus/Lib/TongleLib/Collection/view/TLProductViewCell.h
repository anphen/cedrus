//
//  TLProductViewCell.h
//  TL11
//
//  Created by liu on 15-4-15.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TLProduct;

@interface TLProductViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Icon;

@property (weak, nonatomic) IBOutlet UILabel *Name;

@property (weak, nonatomic) IBOutlet UILabel *Price;

@property (weak, nonatomic) IBOutlet UILabel *Rebate;

@property (weak, nonatomic) IBOutlet UIImageView *typeProd;

@property (nonatomic,strong) TLProduct *product;


/**
 *  返回魔店的tableViewCell
 *
 *  @param table 魔店页面的tableView
 *
 *  @return 返回魔店的tableViewCell
 */
+(instancetype)CellWithtable:(UITableView *)table;


@end
