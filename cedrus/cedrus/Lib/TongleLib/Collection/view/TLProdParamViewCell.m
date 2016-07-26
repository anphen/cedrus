//
//  TLProdParamViewCell.m
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProdParamViewCell.h"
#import "TLProdParameters.h"
#import "TLCommon.h"
#import "UIColor+TL.h"

@interface TLProdParamViewCell ()

@property (nonatomic,weak)      UILabel *title;
@property (nonatomic,strong)    NSArray *prodParamArray;
@property (nonatomic,weak)      UILabel *last;
@end


@implementation TLProdParamViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

-(void)setProdParamsterList:(TLProdParamsterList *)prodParamsterList
{
    _prodParamsterList = prodParamsterList;
    
    UILabel *title = [[UILabel alloc]init];
    self.title = title;
    self.title.text = prodParamsterList.module_name;
    self.title.font = TLNameFont;
    CGSize titleSize = [self.title.text sizeWithAttributes:@{NSFontAttributeName:TLNameFont}];
    self.title.frame = (CGRect){{10,10},titleSize};
    //self.title.center = CGPointMake(20, 20);
    [self.contentView addSubview:self.title];
    
    self.prodParamArray = prodParamsterList.parameters;
    
    int nameY = CGRectGetMaxY(self.title.frame)+15;
    
    for (int i = 0; i<self.prodParamArray.count; i++) {
        TLProdParameters *prodParam = self.prodParamArray[i];
        UILabel *name=[[UILabel alloc]init];
        name.text = prodParam.item_name;
        name.textColor = [UIColor getColor:@"4c4c4c"];
        name.font = TLTimeFont;
        name.numberOfLines = 0;
        CGSize nameSize = [name.text boundingRectWithSize:(CGSizeMake(ScreenBounds.size.width*2/5, MAXFLOAT)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TLTimeFont} context:nil].size;
        
        name.frame = CGRectMake(10, nameY, nameSize.width, nameSize.height);
        [self.contentView addSubview:name];
        
        
        UILabel *value=[[UILabel alloc]init];
        value.text = prodParam.item_value;
        value.textColor = [UIColor getColor:@"4c4c4c"];
        value.font = TLTimeFont;
        value.numberOfLines = 0;
        CGSize valueSize = [value.text boundingRectWithSize:(CGSizeMake(ScreenBounds.size.width*3/5-20, MAXFLOAT)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TLTimeFont} context:nil].size;
        value.frame = CGRectMake(ScreenBounds.size.width*2/5+10, nameY, valueSize.width, valueSize.height);
        [self.contentView addSubview:value];
        
        nameY = (CGRectGetMaxY(value.frame)-CGRectGetMaxY(name.frame))? (CGRectGetMaxY(value.frame)+10) : (CGRectGetMaxY(name.frame)+10);
        if (i==(self.prodParamArray.count-1)) {
            self.last = value;
        }
    }
    _height = CGRectGetMaxY(self.last.frame);
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ProdParamView";
    
    TLProdParamViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TLProdParamViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
