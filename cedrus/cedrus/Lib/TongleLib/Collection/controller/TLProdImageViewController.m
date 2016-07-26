//
//  TLProdImageViewController.m
//  tongle
//  
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProdImageViewController.h"
#import "TLProdImageViewCell.h"
#import "TLProdImageList.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "TLCommon.h"
#import "UIImageView+WebCache.h"
#import "TLImageName.h"

#define ZoomScale 2.5

@interface TLProdImageViewController ()<TLProdImageViewCellDelegate>

@property (nonatomic,copy)      NSString    *user_id;
@property (nonatomic,copy)      NSString    *product_id;
@property (nonatomic,copy)      NSString    *token;
@property (nonatomic,strong)    NSArray     *proPicTextListArray;
@property (nonatomic,assign)    CGFloat     height;
@property (nonatomic,weak)      UIImageView    *bigImageView;
@property (nonatomic,weak)      UIScrollView   *scrollView;

@end

@implementation TLProdImageViewController

- (void)viewDidLoad {
    self.height = 44;
    [super viewDidLoad];
    [self loadData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setscrollView];
}

-(void)loadData
{
    self.product_id = [[NSUserDefaults standardUserDefaults] objectForKey:TL_PROD_DETAILS_PROD_ID];
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
    
    
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,image_text_show_Url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id, @"user_id",self.token, TL_USER_TOKEN,self.product_id,@"product_id", nil];
    __unsafe_unretained __typeof(self) weakself = self;
    //发送请求
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        TLProdImageList *result = [[TLProdImageList alloc]initWithDictionary:json[@"body"] error:nil];
        weakself.proPicTextListArray = result.prod_pic_text_list;
        [weakself.tableView reloadData];
    } failure:nil];
    
}


-(void)setscrollView
{
    UIView *blackView = [[UIApplication sharedApplication].windows lastObject];
    
    //添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = self;
    scrollView.minimumZoomScale = 1;
    scrollView.maximumZoomScale = ZoomScale;
    scrollView.contentSize = CGSizeMake(ScreenBounds.size.width, ScreenBounds.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor blackColor];
    [blackView addSubview:scrollView];
    
    UIImageView *bigImageView = [[UIImageView alloc]init];
    bigImageView.contentMode = UIViewContentModeScaleAspectFit;
    bigImageView.userInteractionEnabled = YES;
    [_scrollView setZoomScale:1];
    
    //添加手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    doubleTap.numberOfTapsRequired = 2;//需要点两下
    twoFingerTap.numberOfTouchesRequired = 2;//需要两个手指touch
    
    [bigImageView addGestureRecognizer:singleTap];
    [bigImageView addGestureRecognizer:doubleTap];
    [bigImageView addGestureRecognizer:twoFingerTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];//如果双击了，则不响应单击事件
    
    
    scrollView.center = blackView.center;
    bigImageView.center = blackView.center;
    [scrollView addSubview:bigImageView];
    [scrollView setZoomScale:1];
    _scrollView = scrollView;
    _bigImageView = bigImageView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self.view window] == nil)
    {
        // Add code to preserve data stored in the views that might be
        // needed later.
        
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        self.view = nil;
        // Dispose of any resources that can be recreated.
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.proPicTextListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLProdImageViewCell *cell = [TLProdImageViewCell cellWithTableView:tableView];
    
    cell.prodImageDetails = self.proPicTextListArray[indexPath.row];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.height = (CGFloat)cell.height;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return self.height;
}


-(void)prodImageViewCell:(TLProdImageViewCell *)prodImageViewCell
{
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLProdImageDetails *prodImageDetails  = self.proPicTextListArray[indexPath.row];
    [self setImage:_bigImageView WithURL:prodImageDetails.pic_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    
    [UIView animateWithDuration:0.25 animations:^{
        _scrollView.frame = [[UIApplication sharedApplication].windows lastObject].bounds;
        _bigImageView.frame = _scrollView.bounds;
    }];
}


//1.返回要缩放的图片
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _bigImageView;
}
//2.重新确定缩放完后的缩放倍数
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    // [scrollView setZoomScale:scale+0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}



//单击
-(void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer.numberOfTapsRequired == 1) {
        [UIView animateWithDuration:0.25 animations:^{
            _scrollView.bounds = CGRectMake(0, 0, 0, 0);
            [_scrollView setZoomScale:1];
        }];
    }
}


-(void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer.numberOfTapsRequired == 2) {
        if(_scrollView.zoomScale == 1){
            float newScale = [_scrollView zoomScale] *ZoomScale;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [_scrollView zoomToRect:zoomRect animated:YES];
        }else{
            float newScale = [_scrollView zoomScale]/ZoomScale;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [_scrollView zoomToRect:zoomRect animated:YES];
        }
    }
}

-(void)handleTwoFingerTap:(UITapGestureRecognizer *)gestureRecongnizer{
    
}

#pragma mark - 缩放大小获取方法
-(CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    //大小
    zoomRect.size.height = [_scrollView frame].size.height/scale;
    zoomRect.size.width = [_scrollView frame].size.width/scale;
    //原点
    zoomRect.origin.x = center.x - zoomRect.size.width/2;
    zoomRect.origin.y = center.y - zoomRect.size.height/2;
    return zoomRect;
}


-(void)setImage:(UIImageView *)imageView WithURL:(NSString *)url placeImage:(UIImage *)placeholder
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
            imageView.image = image;
        }
    }else
    {
        __weak __typeof__(self) weakSelf = self;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:SDWebImageRetryFailed | SDWebImageLowPriority | SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    weakSelf.bigImageView.image = image;
                }
            });
        }];
    }
}

-(id)diskImageDataBySearchingAllPathsForKey:(id)key
{return nil;}

@end
