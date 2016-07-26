//
//  TLPostViewCell.m
//  tongle
//
//  Created by liu on 15-4-25.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLPostViewCell.h"
#import "TLPostParam.h"
#import "TLPostFrame.h"
#import "TLPostTopView.h"
#import "TLCommon.h"
#import "Url.h"


@implementation TLPostViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //1.添加view
        [self setupTopView];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"postCell";
    
    TLPostViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TLPostViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

//-(void)awakeFromNib
//{
//    self.textLabel.preferredMaxLayoutWidth = 11;//最大文字宽度；
//}


-(void)setupTopView
{

    self.selectedBackgroundView = [[UIView alloc]init];
    self.backgroundColor = [UIColor clearColor];
    
    TLPostTopView *topView = [[TLPostTopView alloc]init];
    topView.userInteractionEnabled = YES;
    [self.contentView addSubview:topView];
    self.topView = topView;
}


-(void)setFrame:(CGRect)frame
{
//    frame.origin.y += TLTableBorderWidth;
//    frame.origin.x = TLTableBorderWidth;
//    frame.size.width -= 2*TLTableBorderWidth;
//    frame.size.height -= TLTableBorderWidth;
    [super setFrame:frame];
    
}

-(void)setPostFrame:(TLPostFrame *)postFrame
{
    _postFrame = postFrame;
    
    // 1.topView
    self.topView.frame = self.postFrame.topViewF;
    // 2.传递模型数据
    self.topView.postframe = self.postFrame;

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

@end
