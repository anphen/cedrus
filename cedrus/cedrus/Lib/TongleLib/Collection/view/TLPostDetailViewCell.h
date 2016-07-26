//
//  TLPostDetailViewCell.h
//  tongle
//
//  Created by liu ruibin on 15-5-18.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLPostContent,TLPostDetailContent,TLPostDetailViewCell;

@protocol TLPostDetailViewCellDelagate <NSObject>

@optional

-(void)postDetailViewCell:(TLPostDetailViewCell *)postDetailViewCell;

@end


@interface TLPostDetailViewCell : UITableViewCell

@property (nonatomic,strong) TLPostContent      *postContent;
@property (nonatomic,weak)  TLPostDetailContent *postView;
@property (nonatomic,assign) CGFloat            height;
@property (nonatomic,assign) id<TLPostDetailViewCellDelagate>delagate;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
