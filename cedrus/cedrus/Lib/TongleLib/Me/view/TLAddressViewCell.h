//
//  TLAddressViewCell.h
//  TL11
//
//  Created by liu on 15-4-14.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLAddress;

@interface TLAddressViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *IsSelected;

@property (weak, nonatomic) IBOutlet UILabel *Name;

@property (weak, nonatomic) IBOutlet UILabel *Phone;

@property (weak, nonatomic) IBOutlet UILabel *Adress;

@property (nonatomic,strong) TLAddress *address;

+(instancetype)Cellwithtable:(UITableView *)table;

@end
