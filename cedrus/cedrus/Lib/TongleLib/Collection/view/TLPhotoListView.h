//
//  TLPhotoListView.h
//  tongle
//
//  Created by liu on 15-5-5.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLPhotoListView : UIView

@property (nonatomic,strong) NSArray *photoUrls;
/**
 *  根据图片算出图片整体尺寸
 *
 *  @param count 图片数量
 *
 *  @return图片整体尺寸
 */
+(CGSize)photoListSizeWithCount:(int)count;

@end
