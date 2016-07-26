//
//  TLShopCarViewCell.m
//  TL11
//
//  Created by liu on 15-4-15.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLShopCarViewCell.h"
#import "TLShopCar.h"
#import "TLImageName.h"
#import "UIImageView+Image.h"
#import "TLCommon.h"
#import "UIButton+TL.h"
#import "UIColor+TL.h"
#import "TLCommon.h"
#import "TLShopCarChangeNumberRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "Url.h"
#import "TLBaseTool.h"


#define  TL_TEXT_GETCOLOR @"686868"

@interface TLShopCarViewCell ()

@property (nonatomic,weak) UIButton *decreaseBtn;
@property (nonatomic,weak) UIButton *addBtn;
@property (nonatomic,weak) UILabel *countLabel;

@end


@implementation TLShopCarViewCell



+(instancetype)cellWithTableView:(UITableView *)table
{
    static NSString *ID = @"shopcar";
    TLShopCarViewCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TLShopCarViewCell" owner:self options:nil] lastObject];
        [cell addButtonView];
    }
    return cell;
}

-(void)addButtonView
{
    UIButton *decreaseBtn = [UIButton buttonWithCormalImage:@"jianhao_normal" pressImage:@"jianhao_press"];
    [decreaseBtn addTarget:self action:@selector(decrease) forControlEvents:UIControlEventTouchUpInside];
    [decreaseBtn.layer setCornerRadius:0];
    decreaseBtn.frame = CGRectMake(CGRectGetMaxX(_Icon.frame) +20, _Icon.frame.origin.y+10, 30, 25);
    [self addSubview:decreaseBtn];
    decreaseBtn.hidden = YES;
     _decreaseBtn = decreaseBtn;
    
    UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_Icon.frame) +20+30, _Icon.frame.origin.y+10, 35, 25)];
    countLabel.textColor = [UIColor getColor:TL_TEXT_GETCOLOR];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:countLabel];
    countLabel.hidden = YES;
    self.countLabel = countLabel;
    
    [countLabel.layer setMasksToBounds:YES];
    //[PaymentBtn.layer setCornerRadius:8.0]; //设置矩圆角半径
    [countLabel.layer setBorderWidth:1.0];   //边框宽度
    CGColorRef colorref2 = [UIColor getColor:@"d7d7d7"].CGColor;
    [countLabel.layer setBorderColor:colorref2];//边框颜色
    
    UIButton *addBtn = [UIButton buttonWithCormalImage:@"jiahao_normal" pressImage:@"jiahao_press"];
    //addBtn.enabled = NO;
    [addBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [addBtn.layer setCornerRadius:0];
    addBtn.frame = CGRectMake(CGRectGetMaxX(_Icon.frame) +20 +30 +35,_Icon.frame.origin.y+10, 30, 25);
    [self addSubview:addBtn];
    addBtn.hidden = YES;
    _addBtn = addBtn;
}

-(void)decrease
{
    int number = [_shopcar.order_qty intValue];
    if (number > 1) {
        [self changeNumber:number-1];
    }
}

-(void)add
{
    [self changeNumber:[_shopcar.order_qty intValue]+1];
}

-(void)changeNumber:(int)number
{
    NSString *order_qty = [NSString stringWithFormat:@"%d",number];
    
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,item_modify_Url];
    
    TLShopCarChangeNumberRequest *request = [[TLShopCarChangeNumberRequest alloc]init];
    request.seq_no = _shopcar.seq_no;
    request.product_id = _shopcar.prod_id;
    request.order_qty = order_qty;
     __weak __typeof__(self) weakSelf = self;
    [TLBaseTool postWithURL:url param:request success:^(id json) {
        if (weakSelf.superview) {
            _shopcar.order_qty = order_qty;
            weakSelf.Paynumber.text = [NSString stringWithFormat:@"x%@",_shopcar.order_qty];
            weakSelf.countLabel.text = _shopcar.order_qty;
        }
    } failure:nil];
    
}

-(void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    [self edit:isEditing];
}


-(void)edit:(BOOL)isEditing
{
    if (isEditing) {
        _Name.hidden = YES;
        _decreaseBtn.hidden = NO;
        _countLabel.hidden = NO;
        _addBtn.hidden = NO;
    }else
    {
        _Name.hidden = NO;
        _decreaseBtn.hidden = YES;
        _countLabel.hidden = YES;
        _addBtn.hidden = YES;
    }
}




-(void)setShopcar:(TLShopCar *)shopcar
{
    _shopcar = shopcar;
    self.IsSelected.tag = 1000;
    [self.Icon setImageWithURL:shopcar.prod_pic_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    [self.IsSelected setBackgroundImage:[UIImage imageNamed:TL_CHECK_BOX_NORMAL] forState:UIControlStateNormal];
     [self.IsSelected setBackgroundImage:[UIImage imageNamed:TL_CHECK_BOX_PRESS] forState:UIControlStateSelected];
    self.IsSelected.adjustsImageWhenHighlighted = FALSE;
    self.Name.text = shopcar.prod_name;
    self.Price.text = [NSString stringWithFormat:@"￥%0.2f",[shopcar.price floatValue]];
    self.Selected = [[[NSUserDefaults standardUserDefaults] objectForKey:shopcar.seq_no] intValue];
    self.Paynumber.text = [NSString stringWithFormat:@"x%@",shopcar.order_qty];
    NSString *size  = [NSString string];
    for (TLProdSpecList_size *specList_size in shopcar.prod_spec_list) {
        size = [NSString stringWithFormat:@"%@%@:%@;",size,specList_size.prod_spec_name,specList_size.spec_detail_name];
    }
    self.Address.text = size;
    self.IsSelected.selected = self.Selected;
    self.country.text = shopcar.import_info_desc;
    self.country.hidden = [shopcar.import_goods_flag isEqualToString:TLYES]? NO : YES;
    self.countLabel.text = shopcar.order_qty;
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


- (IBAction)IsSelseced:(UIButton *)sender {
 //   sender.selected = !sender.selected;
   //[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",sender.selected] forKey:self.shopcar.seq_no];
    if ([self.delegate respondsToSelector:@selector(TLShopCarViewCellWithSelectButton:prod:)]) {
        [self.delegate TLShopCarViewCellWithSelectButton:sender prod:self.shopcar];
    }
}
@end
