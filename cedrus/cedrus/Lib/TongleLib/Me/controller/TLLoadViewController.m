//
//  TLLoadViewController.m
//  TL11
//
//  Created by liu on 15-4-14.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLLoadViewController.h"
#import "TLNavigationBar.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLCommon.h"
#import "TLHead.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "TLImageName.h"
#import "UIImageView+Image.h"

@interface TLLoadViewController ()<TLNavigationBarDelegate,UIScrollViewDelegate>
{
    UIScrollView *_marketScrollView;
    NSArray *_titleArray;
}

@end

@implementation TLLoadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationBar];
    [self CreatView];
    [self loadImage];
}


//自定义导航栏
- (void)initNavigationBar{
    [self.navigationController setNavigationBarHidden:YES];
    TLNavigationBar *navigationBar = [[TLNavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, 64)];
    navigationBar.Delegate = self;
    [navigationBar creatWithLeftButtonAndtitle:@"推荐下载二维码"];
    [self.view addSubview:navigationBar];
    self.navigationBar = navigationBar;
    
}
/**
 *  自定义导航栏
 */
-(void)tlNavigationBarBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)loadImage
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,app_promote_Url];
    NSDictionary *params = [NSDictionary dictionary];
    
    params = @{@"user_id":[TLPersonalMegTool currentPersonalMeg].user_id,@"mobile_os_no":TL_DEVICE_IOS,TL_USER_TOKEN:[TLPersonalMegTool currentPersonalMeg].token};
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        NSDictionary *iosJson = json[@"body"];
        self.iosUrl = iosJson[@"app_qr_code_url"];
        [self.iosImage setImageWithURL:self.iosUrl placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    } failure:nil];
}

-(void)CreatView
{
    UIImageView *blackimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 74, ScreenBounds.size.width-20, ScreenBounds.size.width-20)];
    blackimageView.image = [UIImage imageNamed:[NSString stringWithFormat:BARCODE_BG]];
    [self.view addSubview:blackimageView];
    
    
    UIImageView *IosimageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-232)/2, (self.view.bounds.size.width-232)/2+64, 232, 232)];
    [self.view addSubview:IosimageView];
    self.iosImage = IosimageView;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based TLlication, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
