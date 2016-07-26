//
//  TLPhotoListView.m
//  tongle
//
//  Created by liu on 15-5-5.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLPhotoListView.h"
#import "TLPhotoView.h"
#import "TLPhoto.h"
#import "MJExtension.h"
#import "TLCommon.h"

const int TLPhotoMargin = 5;

@implementation TLPhotoListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加9个imageView
        for (int i = 0; i<9; i++) {
            TLPhotoView *photoView = [[TLPhotoView alloc]init];
            photoView.tag = i;
            photoView.userInteractionEnabled = NO;
            [photoView addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)]];
            [self addSubview:photoView];
        }
    }
    return self;
}

/**
 *  点击图片
 *
 *  @param tap
 */
-(void)imageTap:(UITapGestureRecognizer *)tap
{
}

-(void)setPhotoUrls:(NSArray *)photoUrls
{
   _photoUrls = [TLPhoto objectArrayWithKeyValuesArray:photoUrls];
    int count = (int)self.photoUrls.count;
    int subCount = (int)self.subviews.count;
    
    if (count == 1) {
        TLPhotoView *child = self.subviews[0];
            //显示
        child.hidden = NO;
            
        child.photo = self.photoUrls[0];
        
        CGFloat childX = 0;
        CGFloat childY = 0;
        child.frame = CGRectMake(childX, childY, self.bounds.size.width,  self.bounds.size.height);

        child.contentMode = UIViewContentModeScaleAspectFit;
        child.clipsToBounds = NO;
        
        for (int i = 1; i<subCount; i++) {
            TLPhotoView *child = self.subviews[i];
            child.hidden = YES;
        }

    }else
    {
        CGFloat photoWH = (ScreenBounds.size.width - 2*TLCellBorderWidth-2*TLPhotoMargin)/3;
        for (int i = 0; i<subCount; i++) {
            TLPhotoView *child = self.subviews[i];
            if (i < count) {
                //显示
                child.hidden = NO;
                
                child.photo = self.photoUrls[i];
                //边框
                int divider = (count == 4)?2:3;
                int column = i%divider;
                int row = i/divider;
                CGFloat childX = column * (photoWH + TLPhotoMargin);
                CGFloat childY = row * (photoWH + TLPhotoMargin);
                child.frame = CGRectMake(childX, childY, photoWH, photoWH);
                child.clipsToBounds = YES;
                child.contentMode = UIViewContentModeScaleAspectFill;
            }else
            {
                child.hidden = YES;
            }
        }
    }
}


+(CGSize)photoListSizeWithCount:(int)count
{

    if (count <= 0) {
        return  CGSizeZero;
    }
    if (count == 1) {
        return CGSizeMake((ScreenBounds.size.width - 2*TLCellBorderWidth), (ScreenBounds.size.width - 2*TLCellBorderWidth)*9/16);
    }else
    {
        CGFloat photoWH = (ScreenBounds.size.width - 2*TLCellBorderWidth-2*TLPhotoMargin)/3;
        int row = (count + 2)/3;
        int column = (count - 1)/3 ? 3 : count;
        CGFloat width = column * photoWH + (column - 1)*TLPhotoMargin;
        CGFloat height = row * photoWH + (row - 1)*TLPhotoMargin;
        return CGSizeMake(width, height);
    }
}


@end
