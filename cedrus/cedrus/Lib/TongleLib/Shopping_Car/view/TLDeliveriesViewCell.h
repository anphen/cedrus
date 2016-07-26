//
//  TLDeliveriesViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-5.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLDataList;


@interface TLDeliveriesViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel    *name;

@property (weak, nonatomic) IBOutlet UIButton   *sign;

@property (nonatomic,strong) TLDataList         *dataList;
@property (nonatomic,assign) BOOL               rightselected;

- (IBAction)signButton:(UIButton *)sender;

+(id)cellWithTableview:(UITableView *)tableview;

@end
