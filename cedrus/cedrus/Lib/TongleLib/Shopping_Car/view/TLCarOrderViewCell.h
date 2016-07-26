//
//  TLCarOrderViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 15-7-22.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLShopCar;


@interface TLCarOrderViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ProdImage;

@property (weak, nonatomic) IBOutlet UILabel    *ProdName;

@property (weak, nonatomic) IBOutlet UILabel    *ProdPeopel;

@property (weak, nonatomic) IBOutlet UILabel    *ProdSize;

@property (weak, nonatomic) IBOutlet UILabel    *ProdPrice;

@property (weak, nonatomic) IBOutlet UILabel    *country;

@property (nonatomic,strong) TLShopCar          *shopcar;

+(instancetype)cellWithTableView:(UITableView *)table;

@end
