//
//  TLMeMainViewController.m
//  TL11
//
//  Created by liu on 15-4-10.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLMeViewController.h"
#import "TLMe.h"
#import "TLMeRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLMyAccountViewController.h"
#import "TLFunctionViewController.h"
#import "TLImageName.h"
#import "UIImage+TL.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "UIImageView+WebCache.h"
#import "TLMy_Account_Controller.h"
#import "UIImageView+Image.h"
#import "TLGroupCouponsListViewController.h"
#import "TLGroupCouponsListMineViewController.h"


@interface TLMeViewController ()<UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *headViewCell;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;


@property (weak, nonatomic) IBOutlet UILabel *rebate;

@property (weak, nonatomic) IBOutlet UILabel *account_balance;

@property (weak, nonatomic) IBOutlet UILabel *coupons;

@property (weak, nonatomic) IBOutlet UILabel *nick_name;

@property (weak, nonatomic) IBOutlet UILabel *user_id;

@property (weak,nonatomic) UIImageView *qrcodeImage;

@property (weak,nonatomic) UIImageView *backImagebg;

@property (weak,nonatomic) UIView *backView;

@property (weak,nonatomic) UIButton *backButton;

@property (nonatomic,strong) TLMe *meMeg;

@property (weak, nonatomic) IBOutlet UIButton *myAccountButton;

- (IBAction)myAccountBtn:(UIButton *)sender;

@end

@implementation TLMeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(TLMe *)meMeg
{
    if (_meMeg == nil) {
        _meMeg = [[TLMe alloc]init];
    }
    return _meMeg;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.headViewCell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:TL_ME_BACKGROUND_IMAGE]];
    self.headViewCell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:TL_ME_BACKGROUND_IMAGE]];
    self.navigationController.delegate = self;
    self.navigationController.tabBarItem.selectedImage = [UIImage originalImageWithName:TL_ME_PRESS];
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
     [self loadMeMeg];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


/**
 *  加载显示个人数据
 */
-(void)loadMeMeg
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,personal_info_show_Url];
    
    TLMeRequest *request = [[TLMeRequest alloc]init];
    [TLBaseTool postWithURL:url param:request success:^(id result) {
            self.meMeg = result;
        self.rebate.text = [NSString stringWithFormat:@"积分:%@",[self comparisonWithString:self.meMeg.user_rebate_point]];
        self.account_balance.text = [NSString stringWithFormat:@"账户余额:%@",[self comparisonWithString:self.meMeg.user_account_balance]];
        self.coupons.text = [NSString stringWithFormat:@"优惠券:%@张",[self comparisonWithString:self.meMeg.user_coupons]];
        self.nick_name.text = self.meMeg.user_nick_name;
        self.user_id.text = [NSString stringWithFormat:@"通乐号:%@",self.meMeg.user_id];
        
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:[TLPersonalMegTool currentPersonalMeg].user_head_photo_url] placeholderImage:[UIImage getEllipseImageWithImage:[UIImage imageNamed:TL_AVATAR_DEFAULT]] options:SDWebImageRefreshCached | SDWebImageLowPriority | SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                self.headImage.image = [UIImage getEllipseImageWithImage:image];
            }
        }];
    } failure:nil resultClass:[TLMe class]];
}
/**
 *  数据显示设置
 *
 *  @param number 实际数据
 *
 *  @return ui显示的数据
 */
-(NSString *)comparisonWithString:(NSString *)number
{
    NSString *maxNumber = @"999";
    NSString *result = nil;
    if ([number compare:maxNumber options:NSNumericSearch] == NSOrderedDescending) {
        result = @"999+";
    }else
    {
        result = number;
    }
    return result;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLMyAccountViewController class]]) {
        TLMyAccountViewController *myAccount = vc;
        myAccount.meMeg = self.meMeg;
    }else  if ([vc isKindOfClass:[TLMy_Account_Controller class]])
    {
        TLMy_Account_Controller *my_Account = vc;
        my_Account.meMeg = self.meMeg;
    }else if([segue.identifier isEqualToString:@"server"])
    {
        TLFunctionViewController *function = vc;
        function.style = @"服务管家";
    }else if ([segue.identifier isEqualToString:@"idera"])
    {
        TLFunctionViewController *function = vc;
        function.style = @"意见反馈";
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 2:
            {
                TLGroupCouponsListViewController *groupCouponsListView = [[TLGroupCouponsListViewController alloc]init];
                [self.navigationController pushViewController:groupCouponsListView animated:YES];
            }
            break;
        case 3:
            {
                TLGroupCouponsListMineViewController *groupCouponsListMineView = [[TLGroupCouponsListMineViewController alloc]init];
                groupCouponsListMineView.homeblack = ^{
                    [self jump];
                };
                 [self.navigationController pushViewController:groupCouponsListMineView animated:YES];
            }
            break;
        case 8:
            {
                [self qrcode];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }
            break;
        default:
            break;
    }
}

-(void)jump
{
    self.tabBarController.selectedIndex = 0;
}

-(void)qrcode
{
    UIView *blackView = [[UIApplication sharedApplication].windows lastObject];
    self.backView = blackView;
    UIButton *cover = [[UIButton alloc]init];
    cover.frame = blackView.bounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(smallimg) forControlEvents:UIControlEventTouchUpInside];
    [blackView addSubview:cover];
    self.backButton = cover;
    
    UIImageView *backImagebg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:BARCODE_BG]];
    [blackView addSubview:backImagebg];
    self.backImagebg = backImagebg;
    backImagebg.center = CGPointMake(cover.frame.size.width/2, cover.frame.size.height/2);
    
    UIImageView *qrcode = [[UIImageView alloc]init];
    [qrcode setImageWithURL:self.meMeg.user_qr_code_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    qrcode.center = CGPointMake(cover.frame.size.width/2, cover.frame.size.height/2);
    [blackView addSubview:qrcode];
    self.qrcodeImage = qrcode;
    [blackView bringSubviewToFront:qrcode];
    
    [UIView animateWithDuration:0.25 animations:^{
        cover.alpha = 0.5;
        CGFloat iconWH = TL_QRCODE_WH;
        
        CGFloat iconX = (blackView.frame.size.width - iconWH)/2;
        CGFloat iconY = (blackView.frame.size.height - iconWH)/2;
        qrcode.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
        
        backImagebg.bounds = CGRectMake(0, 0, cover.frame.size.width-20, cover.frame.size.width-20);
        backImagebg.center = qrcode.center;
    }];
    
    
}

-(void)smallimg
{
    [UIView animateWithDuration:0.25 animations:^{
        self.backButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.backButton removeFromSuperview];
        [self.qrcodeImage removeFromSuperview];
        [self.backImagebg removeFromSuperview];
    }];
}



- (void)didReceiveMemoryWarning
{
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

- (IBAction)myAccountBtn:(UIButton *)sender {
    
    
}
@end

