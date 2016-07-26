//
//  TLProdDetailCommentCell.m
//  tongle
//
//  Created by jixiaofei-mac on 15-8-12.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProdDetailCommentCell.h"
#import "UIColor+TL.h"
#import "TLCommon.h"
#import "TLStarView.h"

@interface TLProdDetailCommentCell ()

@property (nonatomic,weak) UILabel      *comment;
@property (nonatomic,weak) UILabel      *user_nick_name;
@property (nonatomic,weak) UILabel      *time;
@property (nonatomic,weak) UILabel      *memo;
@property (nonatomic,weak) TLStarView  *starView;

@end


@implementation TLProdDetailCommentCell


+(instancetype)cellWithTableCell:(UITableView *)tableview
{
    static NSString *ID = @"proddetailcomment";
    
    TLProdDetailCommentCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell =[[TLProdDetailCommentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor getColor:@"f3f5f7"];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

-(void)setupSubviews
{
    UILabel *comment = [[UILabel alloc]init];
    comment.font = [UIFont systemFontOfSize:14];
    comment.text = @"评价";
    comment.textColor = [UIColor getColor:@"686868"];
    _comment = comment;
    _comment.frame = (CGRect){{20,5},[comment.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}]};
    [self.contentView addSubview:_comment];
    
    UILabel *user_nick_name = [[UILabel alloc]init];
    _user_nick_name = user_nick_name;
    _user_nick_name.font = TLNameFont;
    _user_nick_name.textColor = [UIColor getColor:@"686868"];
    [self.contentView addSubview:_user_nick_name];
    
    UILabel *time = [[UILabel alloc]init];
    _time  = time;
    _time.font = TLTimeFont;
    _time.textColor = [UIColor getColor:@"686868"];
    [self.contentView addSubview:_time];
    
    UILabel *memo = [[UILabel alloc]init];
    _memo = memo;
    _memo.font = TLContentFont;
    _memo.textColor = [UIColor getColor:@"686868"];
    [self.contentView addSubview:_memo];
    
    TLStarView  *starView = [[TLStarView alloc]init];
    _starView = starView;
    [self.contentView addSubview:starView];
}

-(void)setProdProductRatingList:(TLProdProductRatingList *)prodProductRatingList
{
    _prodProductRatingList = prodProductRatingList;
    
    _user_nick_name.text = prodProductRatingList.user_nick_name;
    _user_nick_name.frame = CGRectMake(CGRectGetMaxX(_comment.frame) + 15, _comment.frame.origin.y, ScreenBounds.size.width-CGRectGetMaxX(_comment.frame)-125, 20);
    
    _starView.level = prodProductRatingList.level;
    _starView.frame = CGRectMake(ScreenBounds.size.width-110, _user_nick_name.frame.origin.y, 100, 20);
    
    _time.text = prodProductRatingList.rating_date;
    CGSize timeSize = [_time.text sizeWithAttributes:@{NSFontAttributeName : TLTimeFont}];
    _time.frame = (CGRect){{_user_nick_name.frame.origin.x,CGRectGetMaxY(_user_nick_name.frame)+5},timeSize};
    
    
    _memo.text = prodProductRatingList.memo;
    _memo.numberOfLines = 0;
    CGSize memoSize = [_memo.text boundingRectWithSize:CGSizeMake(ScreenBounds.size.width-_time.frame.origin.x-10, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : TLContentFont} context:nil].size;
    _memo.frame = (CGRect){{_time.frame.origin.x,CGRectGetMaxY(_time.frame)},memoSize};
    
    _height = CGRectGetMaxY(_memo.frame) + 10;
    
}

-(void)setCommentHide:(BOOL)commentHide
{
    _comment.hidden = commentHide;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
