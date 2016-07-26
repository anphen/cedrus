//
//  TLBabyViewCell.h
//  TL11
//
//  Created by liu on 15-4-13.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMyBaby;


@interface TLBabyViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Icon;

@property (weak, nonatomic) IBOutlet UILabel *Name;

@property (weak, nonatomic) IBOutlet UILabel *Price;

@property (weak, nonatomic) IBOutlet UILabel *Rebate;

@property (nonatomic,strong) TLMyBaby *Baby;


+(instancetype)CellWithtable:(UITableView *)table;


@end
