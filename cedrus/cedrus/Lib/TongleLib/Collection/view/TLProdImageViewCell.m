//
//  TLProdImageViewCell.m
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProdImageViewCell.h"
#import "TLProdImageDetails.h"
#import "TLCommon.h"
#import "TLImageName.h"
#import "UIImageView+WebCache.h"

@implementation TLProdImageViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //帖子图片
        UIImageView *pic = [[UIImageView alloc]init];
        [self.contentView addSubview:pic];
        self.pic = pic;
        //帖子图片说明
        UILabel *pic_memo = [[UILabel alloc]init];
        [self.contentView addSubview:pic_memo];
        pic_memo.font = TLContentFont;
        self.pic_memo = pic_memo;
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"prodImage";
    
    TLProdImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TLProdImageViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(void)setProdImageDetails:(TLProdImageDetails *)prodImageDetails
{
    _prodImageDetails = prodImageDetails;
    
    
    _pic.image = nil;
    _pic_memo.text = nil;
    
    if (prodImageDetails.pic_url.length) {
        CGFloat picX = TLCellBorderWidth;
        CGFloat picY = 0;
        CGFloat picW = ScreenBounds.size.width - 2*TLCellBorderWidth;
        CGSize imageSize = [self setImageSize:self.pic WithURL:prodImageDetails.pic_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
        CGFloat picH = imageSize.height*picW/imageSize.width;
        self.pic.frame = CGRectMake(picX, picY, picW, picH);
        self.pic.contentMode = UIViewContentModeScaleAspectFill;
        
        if (prodImageDetails.pic_memo.length) {
            //帖子图片说明
            self.pic_memo.text = prodImageDetails.pic_memo;
            self.pic_memo.numberOfLines = 0;
            CGFloat pic_memoX = TLCellBorderWidth;
            CGFloat pic_memoY = CGRectGetMaxY(self.pic.frame) + 4;
            CGSize pic_memoSize = [prodImageDetails.pic_memo boundingRectWithSize:(CGSizeMake(ScreenBounds.size.width - 2*(TLCellBorderWidth+TLTableBorderWidth), MAXFLOAT)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TLContentFont} context:nil].size;
            
            
            self.pic_memo.frame = CGRectMake(pic_memoX, pic_memoY, pic_memoSize.width, pic_memoSize.height);
            _height = (CGFloat)CGRectGetMaxY(self.pic_memo.frame) + 4;
        }else
        {
            _height = (CGFloat)CGRectGetMaxY(self.pic.frame);
        }
    }else if(prodImageDetails.pic_memo.length)
    {
        //帖子图片说明
        self.pic_memo.text = prodImageDetails.pic_memo;
        self.pic_memo.numberOfLines = 0;
        CGFloat pic_memoX = TLCellBorderWidth;
        CGFloat pic_memoY =  + 4;
        CGSize pic_memoSize = [prodImageDetails.pic_memo boundingRectWithSize:(CGSizeMake(ScreenBounds.size.width - 2*(TLCellBorderWidth+TLTableBorderWidth), MAXFLOAT)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TLContentFont} context:nil].size;
        
        
        self.pic_memo.frame = CGRectMake(pic_memoX, pic_memoY, pic_memoSize.width, pic_memoSize.height);
        _height = (CGFloat)CGRectGetMaxY(self.pic_memo.frame) + 4;
    }else
    {
        _height = 0;
    }
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
    }else
    {
        __weak __typeof__(self) weakSelf = self;
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:SDWebImageRetryFailed | SDWebImageLowPriority | SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (self.superview) {
                            
                            if (weakSelf.delegate&&[weakSelf.delegate respondsToSelector:@selector(prodImageViewCell:)]) {
                                [weakSelf.delegate prodImageViewCell:weakSelf];
                            }
                        }
                    });
                }
            });
        }];

    }
    return size;
}

-(id)diskImageDataBySearchingAllPathsForKey:(id)key
{return nil;}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
