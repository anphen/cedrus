//
//  TLDeliveriesViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-5.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLDeliveriesViewCell.h"
#import "TLDataList.h"

@implementation TLDeliveriesViewCell


+(id)cellWithTableview:(UITableView *)tableview
{
    static NSString *ID = @"deliveriesView";
    TLDeliveriesViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TLDeliveriesViewCell" owner:self options:nil]lastObject];
    }
    return cell;
}

-(void)setRightselected:(BOOL)rightselected
{
    _rightselected = rightselected;
    self.sign.hidden = !rightselected;
}


-(void)setDataList:(TLDataList *)dataList
{
    _dataList = dataList;
    self.name.text = dataList.name;
    if ([dataList.code isEqualToString:@"001"]) {
        self.sign.hidden = NO;
    }else
    {
        self.sign.hidden = YES;
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)signButton:(UIButton *)sender {
}
@end
