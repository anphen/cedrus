//
//  TLChoiceToManageViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-5.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "SlideTableViewCell.h"

@class TLAddress;

@interface TLChoiceToManageViewCell : SlideTableViewCell

@property (nonatomic,strong) TLAddress  *address;
@property (nonatomic,assign) float      height;
@property(nonatomic,weak)   UILabel     *name;
@property(nonatomic,weak)   UILabel     *addressU;
@property(nonatomic,weak)   UILabel     *tel;
@property (nonatomic,weak)  UIImageView *defaultImage;

+(id)cellWithTableview:(UITableView *)tableview;

@end
