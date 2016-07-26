//
//  TLProdCommentViewCell.m
//  tongle
//
//  Created by liu ruibin on 15-5-22.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProdCommentViewCell.h"
#import "UIColor+TL.h"
#import"TLCommon.h"
#import "TLImageName.h"
#import "UIImageView+Image.h"
#import "TLStarView.h"

@interface TLProdCommentViewCell ()

@property (nonatomic,weak) UIImageView  *head_photo;
@property (nonatomic,weak) UILabel      *user_nick_name;
@property (nonatomic,weak) UILabel      *time;
@property (nonatomic,weak) UILabel      *memo;
@property (nonatomic,weak) TLStarView  *starView;

@end

@implementation TLProdCommentViewCell


+(instancetype)cellWithTableCell:(UITableView *)tableview
{
    static NSString *ID = @"prodcomment";
    
    TLProdCommentViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell =[[TLProdCommentViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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

- (void)awakeFromNib {
    // Initialization code
}

-(void)setupSubviews
{
    UIImageView *head_photo = [[UIImageView alloc]init];
    _head_photo = head_photo;
    [self.contentView addSubview:_head_photo];
    
    UILabel *user_nick_name = [[UILabel alloc]init];
    user_nick_name.textColor = [UIColor getColor:@"565A5d"];
    _user_nick_name = user_nick_name;
    _user_nick_name.font = TLNameFont;
    [self.contentView addSubview:_user_nick_name];
    
    UILabel *time = [[UILabel alloc]init];
    time.textColor = [UIColor getColor:@"999999"];
    _time  = time;
    _time.font = TLTimeFont;
    [self.contentView addSubview:_time];
    
    UILabel *memo = [[UILabel alloc]init];
    memo.textColor = [UIColor getColor:@"999999"];
    _memo = memo;
    _memo.font = TLContentFont;
    [self.contentView addSubview:_memo];
    
    TLStarView  *starView = [[TLStarView alloc]init];
    _starView = starView;
    [self.contentView addSubview:starView];
}

-(void)setProdProductRatingList:(TLProdProductRatingList *)prodProductRatingList
{
    _prodProductRatingList = prodProductRatingList;
    
    [_head_photo setImageWithURL:prodProductRatingList.head_photo_url placeImage:[UIImage imageNamed:TL_AVATAR_DEFAULT ]];
    _head_photo.frame = CGRectMake(10, 10, 30, 30);
    
    _user_nick_name.text = prodProductRatingList.user_nick_name;
    _user_nick_name.frame = CGRectMake(CGRectGetMaxX(_head_photo.frame) + 10, _head_photo.frame.origin.y, ScreenBounds.size.width-CGRectGetMaxX(_head_photo.frame)-120, 20);
    
    _starView.level = prodProductRatingList.level;
    _starView.frame = CGRectMake(ScreenBounds.size.width-110,  _user_nick_name.frame.origin.y, 100, 20);
    
    _time.text = prodProductRatingList.rating_date;
    CGSize timeSize = [_time.text sizeWithAttributes:@{NSFontAttributeName : TLTimeFont}];
    _time.frame = (CGRect){{_user_nick_name.frame.origin.x,CGRectGetMaxY(_user_nick_name.frame)+5},timeSize};
    
    
    _memo.text = prodProductRatingList.memo;
    _memo.numberOfLines = 0;
    CGSize memoSize = [_memo.text boundingRectWithSize:CGSizeMake(ScreenBounds.size.width-_time.frame.origin.x-10, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : TLContentFont} context:nil].size;
    _memo.frame = (CGRect){{_time.frame.origin.x,CGRectGetMaxY(_time.frame)},memoSize};
    
    _height = CGRectGetMaxY(_memo.frame) + 10;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
