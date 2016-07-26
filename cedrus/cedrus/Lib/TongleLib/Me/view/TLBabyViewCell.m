//
//  TLBabyViewCell.m
//  TL11
//
//  Created by liu on 15-4-13.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLBabyViewCell.h"
#import "TLMyBaby.h"

@implementation TLBabyViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
/**
 *  取缓存中取cell
 *
 *  @param table cell 所在的tableView
 *
 *  @return 返回每行的cell
 */
+(instancetype)CellWithtable:(UITableView *)table
{
    TLBabyViewCell *cell = [table dequeueReusableCellWithIdentifier:@"baby"];

    
    return cell;
}

/**
 *  属性赋值
 *
 *  @param Baby 每行数据的对象
 */
-(void)setBaby:(TLMyBaby *)Baby
{
    _Baby = Baby;
    self.Icon.image = [UIImage imageNamed:Baby.Icon];
    self.Name.text = Baby.Name;
    self.Price.text = [NSString stringWithFormat:@"%.2f",(float)Baby.Price];
    self.Rebate.text = [NSString stringWithFormat:@"返利：%d%%",Baby.Rebate];
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
