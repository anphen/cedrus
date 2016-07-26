//
//  TLChoiceToManageViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-5.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLChoiceToManageViewCell.h"
#import "TLAddress.h"
#import "TLCommon.h"
#import "UIColor+TL.h"
#import "TLImageName.h"

@interface TLChoiceToManageViewCell ()

@end

@implementation TLChoiceToManageViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *name = [[UILabel alloc]init];
        name.font = TLNameFont;
        [name setTextColor:[UIColor getColor:@"3d4245"]];
        [self.moveContentView addSubview:name];
        self.name = name;
        
        UILabel *address = [[UILabel alloc]init];
        address.font = TLTimeFont;
        address.numberOfLines = 0;
        [address setTextColor:[UIColor getColor:@"3e4346"]];
        [self.moveContentView addSubview:address];
        self.addressU = address;
        
        
        UILabel *tel = [[UILabel alloc]init];
        tel.font = [UIFont systemFontOfSize:13];
        tel.text = self.address.tel;
        [tel setTextColor:[UIColor getColor:@"3d4245"]];
        [self.moveContentView addSubview:tel];
        self.tel = tel;
        
        UIImageView *defaultImage = [[UIImageView alloc]init];
        [self.moveContentView addSubview:defaultImage];
        self.defaultImage = defaultImage;
    
    }
    return self;
}


+(id)cellWithTableview:(UITableView *)tableview
{
    static NSString *ID = @"addressesList";
    TLChoiceToManageViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TLChoiceToManageViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)setAddress:(TLAddress *)address
{
    _address = address;
    self.name.text = address.consignee;
    self.tel.text = address.tel;
    self.addressU.text = [NSString stringWithFormat:@"%@%@%@%@",address.province_name,address.city_name,address.area_name,address.address];
}

//-(void)addControl{
//    [super addControl];
//    UILabel *name = [[UILabel alloc]init];
//    name.font = TLNameFont;
//    name.text = self.address.consignee;
//    [name setTextColor:[UIColor getColor:@"3d4245"]];
//    CGFloat nameX = 12;
//    CGFloat nameY = 18;
//    CGSize nameSize = [name.text sizeWithAttributes:@{NSFontAttributeName:TLNameFont}];
//    name.frame = (CGRect){{nameX,nameY},nameSize};
//    
//    UILabel *address = [[UILabel alloc]init];
//    address.font = TLTimeFont;
//    address.text = self.address.address;
//    address.numberOfLines = 0;
//    [address setTextColor:[UIColor getColor:@"3e4346"]];
//    CGFloat addressX = nameX;
//    CGFloat addressY = CGRectGetMaxY(name.frame)+7;
//    CGSize addressSize = [address.text boundingRectWithSize:CGSizeMake(ScreenBounds.size.width-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TLTimeFont} context:nil].size;
//    address.frame = (CGRect){{addressX ,addressY},addressSize};
//
//    
//    UILabel *tel = [[UILabel alloc]init];
//    tel.font = TLNameFont;
//    tel.text = self.address.tel;
//    [tel setTextColor:[UIColor getColor:@"3d4245"]];
//    CGSize telSize = [tel.text sizeWithAttributes:@{NSFontAttributeName:TLNameFont}];
//    CGFloat telX = ScreenBounds.size.width - 20- telSize.width;
//    CGFloat telY = nameY;
//    tel.frame = (CGRect){{telX ,telY},telSize};
//    
//    
//    [self.moveContentView addSubview:name];
//    [self.moveContentView addSubview:address];
//    [self.moveContentView addSubview:tel];
//    self.height = CGRectGetMaxY(address.frame)+18;
//
//    
//
//}
-(void)layoutSubviews
{
    [super layoutSubviews];

    self.name.text = self.address.consignee;
    CGFloat nameX = 12;
    CGFloat nameY = 18;
    CGSize nameSize = [self.name.text sizeWithAttributes:@{NSFontAttributeName:TLNameFont}];
    self.name.frame = (CGRect){{nameX,nameY},nameSize};
    
    self.addressU.text = [NSString stringWithFormat:@"%@%@%@%@",self.address.province_name,self.address.city_name,self.address.area_name,self.address.address];
    self.addressU.numberOfLines = 0;
    CGFloat addressX = nameX;
    CGFloat addressY = CGRectGetMaxY(self.name.frame)+7;
    CGSize addressUSize = [self.addressU.text boundingRectWithSize:CGSizeMake(ScreenBounds.size.width-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TLTimeFont} context:nil].size;
    self.addressU.frame = (CGRect){{addressX ,addressY},addressUSize};
    
    self.height = CGRectGetMaxY(self.addressU.frame)+18;

    self.tel.text = self.address.tel;
    [self.tel setTextColor:[UIColor getColor:@"3d4245"]];
    CGSize telSize = [self.tel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    CGFloat telX = ScreenBounds.size.width - 40- telSize.width;
    CGFloat telY = nameY;
    self.tel.frame = (CGRect){{telX ,telY},telSize};
    
    self.defaultImage.bounds = CGRectMake(0, 0, 10, 10);
    self.defaultImage.center = CGPointMake(ScreenBounds.size.width - 20, self.height/2);
    [self.defaultImage setImage:[UIImage imageNamed:TL_PAY_ICON_NORMAL]];
    
    UIView *last = [[UIView alloc]init];
    last.backgroundColor = [UIColor getColor:@"dddddd"];
    last.frame = CGRectMake(0, self.height-1, ScreenBounds.size.width, 1);
     [self.moveContentView addSubview:last];
}

-(void)testButtonClicked:(id)sender{
}

@end
