//
//  TLShopCarViewCell.h
//  TL11
//
//  Created by liu on 15-4-15.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLShopCar,TLShopCarViewCell;


@protocol TLShopCarViewCellDelegate <NSObject>

@optional


-(void)TLShopCarViewCell:(TLShopCarViewCell *)ShopCarViewCell;
-(void)TLShopCarViewCell:(TLShopCarViewCell *)ShopCarViewCell WithSelectButton:(UIButton *)button;
-(void)TLShopCarViewCellWithSelectButton:(UIButton *)btn prod:(TLShopCar *)prod;

@end


@interface TLShopCarViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton       *IsSelected;

@property (weak, nonatomic) IBOutlet UIImageView    *Icon;

@property (weak, nonatomic) IBOutlet UILabel        *Name;

@property (weak, nonatomic) IBOutlet UILabel        *Paynumber;


@property (weak, nonatomic) IBOutlet UILabel        *Address;


@property (weak, nonatomic) IBOutlet UILabel        *Price;

@property (weak, nonatomic) IBOutlet UILabel *country;



@property (nonatomic,assign)         BOOL            Selected;

@property (nonatomic,assign)         BOOL            isEditing;

@property (nonatomic,strong)         TLShopCar       *shopcar;


@property (nonatomic,weak)id<TLShopCarViewCellDelegate> delegate;


- (IBAction)IsSelseced:(UIButton *)sender;

+(instancetype)cellWithTableView:(UITableView *)table;
-(void)edit:(BOOL)isEditing;



@end
