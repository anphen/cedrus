//
//  TLMyorderEvaViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-17.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLMyorderEvaViewCell.h"
#import "TLMyOrderProdDetail.h"
#import "TLImageName.h"
#import "UIImageView+Image.h"
#import "UIColor+TL.h"

@interface TLMyorderEvaViewCell ()


@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UIButton *evaButton;

@property (weak, nonatomic) IBOutlet UILabel *name;



- (IBAction)button:(UIButton *)sender;


@end

@implementation TLMyorderEvaViewCell




+(id)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"myorderEvaView";
    TLMyorderEvaViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TLMyorderEvaViewCell" owner:self options:nil]lastObject];
    }
    return cell;
}

-(void)setOrderProdDetail:(TLMyOrderProdDetail *)OrderProdDetail
{
    _OrderProdDetail = OrderProdDetail;
    
    [self.image setImageWithURL:OrderProdDetail.prod_pic_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    self.name.text = OrderProdDetail.prod_name;

}

- (void)awakeFromNib {
    // Initialization code
    [self.evaButton setTitleColor:[UIColor getColor:@"5f646e"] forState:UIControlStateHighlighted];
    [self.evaButton setTitleColor:[UIColor getColor:@"d0d0d0"] forState:UIControlStateNormal];
    [self.evaButton.layer setMasksToBounds:YES];
    [self.evaButton.layer setCornerRadius:2.0];
    [self.evaButton.layer setBorderWidth:1.0];
    CGColorRef colorref = [UIColor getColor:@"d0d0d0"].CGColor;
    [self.evaButton.layer setBorderColor:colorref];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)button:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(MyorderEvaViewCell:withOrderProd:withBtn:)]) {
        [self.delegate MyorderEvaViewCell:self withOrderProd:self.OrderProdDetail withBtn:sender];
    }
}
@end
