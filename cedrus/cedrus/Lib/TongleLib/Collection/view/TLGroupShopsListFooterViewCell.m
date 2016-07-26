//
//  TLGroupShopsListFooterViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 16/4/18.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupShopsListFooterViewCell.h"
#import "TLImageName.h"
#import "TLGroupStoreList.h"
#import "UIColor+TL.h"
#import "TLCommon.h"


@interface TLGroupShopsListFooterViewCell ()

@property (nonatomic,weak) UIImageView *addressImage;
@property (nonatomic,weak) UILabel *address;
@property (nonatomic,weak) UIImageView *telImage;
@property (nonatomic,weak) UILabel *tel;
@property (nonatomic,weak) UIImageView *Image1;
@property (nonatomic,weak) UIImageView *Image2;
@property (nonatomic,weak) UIButton *addressButton;
@property (nonatomic,weak) UIButton *telButton;
@property (nonatomic,weak) UIView *footer;
@property (nonatomic,weak) UIView *centerview;

@end

@implementation TLGroupShopsListFooterViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIButton *addressButton = [[UIButton alloc]init];
        [self.contentView addSubview:addressButton];
        _addressButton = addressButton;
        
        UIButton *telButton = [[UIButton alloc]init];
        [self.contentView addSubview:telButton];
        [telButton addTarget:self action:@selector(tel:) forControlEvents:UIControlEventTouchUpInside];
        _telButton = telButton;
        
        
        UIImageView *addressImage = [[UIImageView alloc]init];
        addressImage.image = [UIImage imageNamed:@"dingdanxiangqing_icon01"];
        [self.addressButton addSubview:addressImage];
        _addressImage = addressImage;
        
        UILabel *address = [[UILabel alloc]init];
        address.numberOfLines = 2;
        address.textColor = [UIColor getColor:@"666666"];
        address.font = [UIFont systemFontOfSize:12];
        [self.addressButton addSubview:address];
        _address = address;
        
        UIImageView *telImage = [[UIImageView alloc]init];
        telImage.image = [UIImage imageNamed:TL_SHAPE];
        [self.telButton addSubview:telImage];
        _telImage = telImage;
        
        UILabel *tel = [[UILabel alloc]init];
        tel.font = [UIFont systemFontOfSize:12];
        tel.textColor = [UIColor getColor:@"666666"];
        [self.telButton addSubview:tel];
        _tel = tel;
        
        UIImageView *Image1 = [[UIImageView alloc]init];
        [self.addressButton addSubview:Image1];
        Image1.image = [UIImage imageNamed:TL_GREY_BACK_NORMAL];
        _Image1 = Image1;
        
        UIImageView *Image2 = [[UIImageView alloc]init];
        [self.telButton addSubview:Image2];
        Image2.image = [UIImage imageNamed:TL_GREY_BACK_NORMAL];
        _Image2 = Image2;
        
        UIView *footer = [[UIView alloc]init];
        footer.backgroundColor = [UIColor getColor:@"f4f4f4"];
        [self.contentView addSubview:footer];
        _footer = footer;
        
        UIView *centerview = [[UIView alloc]init];
        centerview.backgroundColor = [UIColor getColor:@"f4f4f4"];
        [self.contentView addSubview:centerview];
        _centerview = centerview;

    }
    return self;
}

+(instancetype)cellWithTableCell:(UITableView *)tableview
{
    static NSString *ID = @"TLGroupShopsListFooterViewCell";
    
    TLGroupShopsListFooterViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell =[[TLGroupShopsListFooterViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)setGroupStore:(TLGroupStoreList *)groupStore
{
    _groupStore = groupStore;
    
    _addressImage.frame = CGRectMake(20, 10, 10, 15);
    _address.text = groupStore.address;
    CGSize addressSize = [groupStore.address boundingRectWithSize:CGSizeMake(ScreenBounds.size.width-80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    _address.frame = CGRectMake(50, 10, addressSize.width, addressSize.height);
    _Image1.frame = CGRectMake(ScreenBounds.size.width-20, 10, 10, 20);
    _addressButton.frame = CGRectMake(0, 0, ScreenBounds.size.width, addressSize.height+20);
    
    _centerview.frame = CGRectMake(20, CGRectGetMaxY(_addressButton.frame), ScreenBounds.size.width-20, 1);
    
    
    _telImage.frame = CGRectMake(20, 10, 15, 15);
    CGSize telSize = [groupStore.phone sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    _tel.text = groupStore.phone;
    _tel.frame = CGRectMake(50, 10, telSize.width, telSize.height);
    _Image2.frame = CGRectMake(ScreenBounds.size.width-20, 10, 10, 20);
    _telButton.frame = CGRectMake(0, CGRectGetMaxY(_centerview.frame), ScreenBounds.size.width, telSize.height+20);
    
    _footer.frame = CGRectMake(0, CGRectGetMaxY(_telButton.frame), ScreenBounds.size.width, 10);
    
    _height = CGRectGetMaxY(_footer.frame);
}

-(void)tel:(UIButton *)btn
{
    NSString *str = [NSString stringWithFormat:@"tel:%@",_groupStore.phone];
    UIWebView *callWebView = [[UIWebView alloc]init];
    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    if (self.superview) {
        [self.superview addSubview:callWebView];
    }
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
