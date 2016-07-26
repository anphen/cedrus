//
//  UIImageView+Image.m
//  tongle
//
//  Created by liu on 15-5-5.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "UIImageView+Image.h"
#import "UIImageView+WebCache.h"


@implementation UIImageView (Image)

-(void)setImageWithURL:(NSString *)url placeImage:(UIImage *)placeholder
{
    
    NSString* absoluteString = [NSURL URLWithString:url].absoluteString;
    
    if([[SDImageCache sharedImageCache] diskImageExistsWithKey:absoluteString])
    {
        UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if(!image)
        {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:[NSURL URLWithString:url].absoluteString];
            image = [UIImage imageWithData:data];
        }
        if(image)
        {
            self.image = image;
        }
    }else
    {
         [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:SDWebImageRetryFailed | SDWebImageLowPriority | SDWebImageRefreshCached];
    }
}


-(id)diskImageDataBySearchingAllPathsForKey:(id)key
{return nil;}

@end
