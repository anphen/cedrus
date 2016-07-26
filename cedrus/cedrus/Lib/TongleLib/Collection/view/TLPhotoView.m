//
//  TLPhotoView.m
//  tongle
//
//  Created by liu on 15-5-5.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLPhotoView.h"
#import "UIImageView+Image.h"
#import "TLPhoto.h"
#import "TLImageName.h"

@interface TLPhotoView ()
@property (nonatomic,weak) UIImageView *gifIndicator;

@end

@implementation TLPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifIndicator = gifView;

    }
    return self;
}





-(void)setPhoto:(TLPhoto *)photo
{
    _photo = photo;
    
    self.gifIndicator.hidden = ![photo.pic_url hasSuffix:@"gif"];
    
    [self setImageWithURL:photo.pic_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifIndicator.layer.anchorPoint = CGPointMake(1, 1);
    self.gifIndicator.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}

@end
