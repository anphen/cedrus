//
//  TLPostDetailViewCell.m
//  tongle
//
//  Created by liu ruibin on 15-5-18.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLPostDetailViewCell.h"
#import "TLPostContent.h"
#import "TLPostDetailContent.h"
#include "TLCommon.h"

@interface TLPostDetailViewCell ()<TLPostDetailContentDelegate>

@end

@implementation TLPostDetailViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //1.添加view
        [self setupView];
    }
    return self;
}


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"detailCell";
    
    TLPostDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TLPostDetailViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
    
}

-(void)setPostContent:(TLPostContent *)postContent
{
    self.postView.postContent = postContent;
    self.postView.delegate = self;
    self.postView.frame = CGRectMake(0, 0, ScreenBounds.size.width, self.postView.hight);
    self.height = self.postView.hight;
}

-(void)PostDetailContent:(TLPostDetailContent *)postDetailContent
{
    if ([self.delagate respondsToSelector:@selector(postDetailViewCell:)]) {
        [self.delagate postDetailViewCell:self];
    }
}


-(void)setupView
{
    
//    self.selectedBackgroundView = [[UIView alloc]init];
//    self.backgroundColor = [UIColor clearColor];
    
    TLPostDetailContent *postView = [[TLPostDetailContent alloc]init];
    [self.contentView addSubview:postView];
    self.postView = postView;
}


@end
