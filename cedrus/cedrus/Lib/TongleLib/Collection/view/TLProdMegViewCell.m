//
//  TLProdMegViewCell.m
//  tongle
//
//  Created by liu ruibin on 15-5-20.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProdMegViewCell.h"
#import "TLProdMeg.h"
#import "TLCommon.h"


@implementation TLProdMegViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //1.添加view
        // [self setupView];
    }
    return self;
}

+(instancetype)cellWithTableCell:(UITableView *)tableview
{
    static NSString *ID = @"TLProdMegViewCell";
    
    TLProdMegViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell =[[TLProdMegViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}



-(void)setProdDetails:(TLProdDetails *)prodDetails
{
    _prodDetails = prodDetails;
    
    TLProdMeg *prodMegView = [[TLProdMeg alloc]init];
    prodMegView.prodDetails = prodDetails;
    
    self.prodMegView = prodMegView;
    self.prodMegView.frame = CGRectMake(0, 0, ScreenBounds.size.width, prodMegView.height);
    [self.contentView addSubview:prodMegView];
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
