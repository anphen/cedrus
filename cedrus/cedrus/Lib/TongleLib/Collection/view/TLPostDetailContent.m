//
//  TLPostDetailContent.m
//  tongle
//
//  Created by liu ruibin on 15-5-18.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLPostDetailContent.h"
#import "TLPostDetail.h"
#import "TLPostContent.h"
#import "TLCommon.h"
#import "TLImageName.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+Image.h"

@interface TLPostDetailContent ()

@property (nonatomic,weak) UIImageView *lastImage;

@end

@implementation TLPostDetailContent

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
      //  self.backgroundColor = [UIColor greenColor];
        //帖子图片
        UIImageView *pic = [[UIImageView alloc]init];
        [self addSubview:pic];
        self.pic = pic;
        //帖子图片说明
        UILabel *pic_memo = [[UILabel alloc]init];
        [self addSubview:pic_memo];
        pic_memo.font = [UIFont systemFontOfSize:16];
        self.pic_memo = pic_memo;
    }
    return self;
}


-(void)setPostContent:(TLPostContent *)postContent
{
    _postContent = postContent;
    
    _pic.image = nil;
    _pic_memo.text = nil;
  
    if (postContent.pic_url.length) {
        CGFloat picX = TLCellBorderWidth;
        CGFloat picY = 0;
        CGFloat picW = ScreenBounds.size.width - 2*TLCellBorderWidth;
        CGSize imageSize = [self setImageSize:self.pic WithURL:postContent.pic_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
        CGFloat picH = imageSize.height*picW/imageSize.width;
        self.pic.frame = CGRectMake(picX, picY, picW, picH);
        self.pic.contentMode = UIViewContentModeScaleAspectFill;
        
        if (postContent.pic_memo.length) {
            //帖子图片说明
            //self.pic_memo.text = postContent.pic_memo;
            self.pic_memo.numberOfLines = 0;
            CGFloat pic_memoX = TLCellBorderWidth;
            CGFloat pic_memoY = CGRectGetMaxY(self.pic.frame) + 4;
            CGRect rect = [self rectWithString:postContent.pic_memo label:self.pic_memo];
            self.pic_memo.frame = CGRectMake(pic_memoX, pic_memoY, rect.size.width, rect.size.height);
            _hight = CGRectGetMaxY(self.pic_memo.frame) + 4;
        }else
        {
            _hight = CGRectGetMaxY(self.pic.frame);
        }
    }else if(postContent.pic_memo.length)
    {
        //帖子图片说明
        self.pic_memo.numberOfLines = 0;
        CGFloat pic_memoX = TLCellBorderWidth;
        CGFloat pic_memoY = 4;

        CGRect rect = [self rectWithString:postContent.pic_memo label:self.pic_memo];
        self.pic_memo.frame = CGRectMake(pic_memoX, pic_memoY, rect.size.width, rect.size.height);
        _hight = CGRectGetMaxY(self.pic_memo.frame) + 4;
    }else
    {
        _hight = 0;
    }

}


-(CGRect )rectWithString:(NSString *)string label:(UILabel *)label
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange allRange = [string rangeOfString:string];
    
    [attributedString addAttribute:NSFontAttributeName
     
                             value:[UIFont systemFontOfSize:16.0]
     
                             range:allRange];
    
    [attributedString addAttribute:NSForegroundColorAttributeName
     
                             value:[UIColor blackColor]
     
                             range:allRange];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:allRange];
    [label setAttributedText:attributedString];
    [label sizeToFit];
    
    
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(ScreenBounds.size.width - 2*(TLCellBorderWidth+TLTableBorderWidth), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil];
    return rect;
}


-(CGSize)setImageSize:(UIImageView *)imageView WithURL:(NSString *)url placeImage:(UIImage *)placeholder
{
    __block CGSize size = placeholder.size;
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
            imageView.image = image;
            size = image.size;
        }
    }
    else
    {
        __weak __typeof__(self) weakSelf = self;
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:SDWebImageRetryFailed | SDWebImageLowPriority | SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                        if (self.superview) {
                            
                            if (weakSelf.delegate&&[weakSelf.delegate respondsToSelector:@selector(PostDetailContent:)]) {
                                [weakSelf.delegate PostDetailContent:weakSelf];
                            }
                        }
                }
            });
        }];
    }
    return size;

}

-(id)diskImageDataBySearchingAllPathsForKey:(id)key
{return nil;}

-(void)setUpImage
{
    if (![_postContent.pic_url isEqualToString:@""]) {
         [self.lastImage setImageWithURL:_postContent.pic_url placeImage:nil];
    }
}



@end
