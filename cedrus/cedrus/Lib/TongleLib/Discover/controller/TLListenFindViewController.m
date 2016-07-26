////
////  TLListenFindViewController.m
////  tongle
////
////  Created by ruibin liu on 15/6/22.
////  Copyright (c) 2015年 com.isoftstone. All rights reserved.
////
//
//#import "TLListenFindViewController.h"
//#import "TLImageName.h"
//#import"TLCommon.h"
//#import "TLPersonalMeg.h"
//#import "TLPersonalMegTool.h"
//#import "Url.h"
//#import "MBProgressHUD+MJ.h"
//#import "TLQrdata.h"
//#import "TLHttpTool.h"
//#import "TLProdPurchaseViewController.h"
//#import "TLMasterSuperViewController.h"
//#import "TLPostDetailViewController.h"
//#import "TLMoshopViewController.h"
//#import "TLGroupPurchaseViewController.h"
//#import "TLProduct.h"
//#import "CKOrganizationViewController.h"
//
//static const char* const CODE_BOOK = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_@";
//
//#define TOKEN_COUNT 24
//
//ESVoid onSinVoiceRecognizerStart(ESInt32 type, ESVoid* cbParam) {
//    NSLog(@"onSinVoiceRecognizerStart, type:%d", type);
//    TLListenFindViewController* vc = (__bridge TLListenFindViewController*)cbParam;
//    vc->mResultCount = 0;
//}
//
//ESVoid onSinVoiceRecognizerToken(ESInt32 type, ESVoid* cbParam, ESInt32 index) {
//    NSLog(@"onSinVoiceRecognizerToken, type:%d, index:%d", type, index);
//    TLListenFindViewController* vc = (__bridge TLListenFindViewController*)cbParam;
//    vc->mResults[vc->mResultCount++] = index;
//}
//
//ESVoid onSinVoiceRecognizerEnd(ESInt32 type, ESVoid* cbParam, ESInt32 result) {
//    NSLog(@"onSinVoiceRecognizerEnd, type:%d, result:%d", type, result);
//    TLListenFindViewController* vc = (__bridge TLListenFindViewController*)cbParam;
//    [vc onRecogToken:vc];
//}
//
///*
// ESVoid onSinVoicePlayerStart(ESVoid* cbParam) {
// NSLog(@"onSinVoicePlayerStart, start");
// TLListenFindViewController* vc = (__bridge TLListenFindViewController*)cbParam;
// [vc onPlayData:vc];
// NSLog(@"onPlayData, end");
// }
// 
// ESVoid onSinVoicePlayerStop(ESVoid* cbParam) {
// NSLog(@"onSinVoicePlayerStop");
// }
// 
// SinVoicePlayerCallback gSinVoicePlayerCallback = {onSinVoicePlayerStart, onSinVoicePlayerStop};
// */
//
//SinVoiceRecognizerCallback gSinVoiceRecognizerCallback = {onSinVoiceRecognizerStart, onSinVoiceRecognizerToken, onSinVoiceRecognizerEnd};
//
//@interface TLListenFindViewController ()
//
//
//@property (weak, nonatomic) IBOutlet UIButton   *firstButton;
//
//@property (weak, nonatomic) IBOutlet UIButton   *thirdButton;
//
//@property (weak,nonatomic)  UINavigationBar     *navigationBar;
//
//@property (nonatomic,strong) NSTimer    *timer;
//
//@property (nonatomic,assign) int        index;
//
//- (IBAction)listenAction:(UIButton *)sender;
//
//- (IBAction)stopButton:(UIButton *)sender;
//
//
//@end
//
//@implementation TLListenFindViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self initNavigationBar];
//    [self setButon];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:TL_BG_IMG]];
//    self.index = 0;
//    // Do any additional setup after loading the view.
//    
//    //mSinVoicePlayer = SinVoicePlayer_create("com.sinvoice.honglitong", "", &gSinVoicePlayerCallback, (__bridge ESVoid *)(self), SINVOICE_PLAYER_TYPE1);
//    mSinVoiceRecorder = SinVoiceRecognizer_create("com.sinvoice.honglitong", "", &gSinVoiceRecognizerCallback, (__bridge ESVoid *)(self));
//    
//}
//
//
////自定义导航栏
//- (void)initNavigationBar{
//    [self.navigationController setNavigationBarHidden:YES];
//    UINavigationBar *navigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, 64)];
//    self.navigationBar = navigationBar;
//    [self creatWithLeftButtonAndtitle:@"发现"];
//    [self.view addSubview:navigationBar];
//    
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"beijin" ] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[UIImage imageNamed:@"beijin" ]];
//    
//}
//
//-(void)creatWithLeftButtonAndtitle:(NSString *)title
//{
//    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
//    left.frame = CGRectMake(0, 30, 70, 25);
//    [left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [left setImage:[UIImage imageNamed:TL_WHITE_ARROW] forState:UIControlStateNormal];
//    [left setImage:[UIImage imageNamed:TL_WHITE_ARROW] forState:UIControlStateHighlighted];
//    [self.navigationBar addSubview:left];
//    
//    UILabel *titleCenter = [[UILabel alloc]init];
//    titleCenter.text = title;
//    titleCenter.textColor = [UIColor whiteColor];
//    titleCenter.font = [UIFont systemFontOfSize:17];
//    CGSize titleSize = [titleCenter.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
//    titleCenter.bounds = (CGRect){{0,0},titleSize};
//    titleCenter.center = CGPointMake(ScreenBounds.size.width/2, 42);
//    [self.navigationBar addSubview:titleCenter];
//    
//    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(300, 20, 50, 30)];
//    //rightView.backgroundColor = [UIColor redColor];
//    [self.navigationBar addSubview:rightView];
//    
//}
//
///**
// *  自定义导航栏
// */
//-(void)back
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//}
//
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//}
//
//-(void)setButon
//{
//    [self setRoundWithButton:self.firstButton];
//    [self setRoundWithButton:self.thirdButton];
//    
//}
//
//
//-(void)setRoundWithButton:(UIButton *)button
//{
//    [button.layer setMasksToBounds:YES];
//    [button.layer setCornerRadius:button.bounds.size.height/2];
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
// #pragma mark - Navigation
// 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */
//
//- (IBAction)listenAction:(UIButton *)sender {
//  
//    [self timeOn];
//    SinVoiceRecognizer_start(mSinVoiceRecorder, TOKEN_COUNT);
//}
//
//-(void)run
//{
//    [UIView animateWithDuration:0.5 animations:^{
//        self.thirdButton.transform = CGAffineTransformRotate(self.thirdButton.transform, M_PI_4);
//        
//    }];
//}
//
//
//-(void)listenStartWithData:(NSString *)scan_data
//{
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,listen_decode_Url];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN,scan_data,@"scan_data", nil];
//    [TLHttpTool postWithURL:url params:param success:^(id json) {
//        NSDictionary *body = json[@"body"];
//        TLQrdata *qrdata = [[TLQrdata alloc]initWithDictionary:body[@"qr_data"] error:nil];
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Tongle_Base" bundle:nil];
//        switch ([qrdata.code_type intValue]) {
//            case 1:
//            {
//                TLProdPurchaseViewController *prod = [storyboard instantiateViewControllerWithIdentifier:@"prodpurchase"];
//                prod.qrdata = qrdata;
//                [self.navigationController pushViewController:prod animated:YES];
//            }
//                break;
//            case 2:
//            {
//                TLMasterSuperViewController *master = [storyboard instantiateViewControllerWithIdentifier:@"mastersuper"];
//                master.qrdata = qrdata;
//                [self.navigationController pushViewController:master animated:YES];
//            }
//                break;
//            case 3:
//            {
//                TLPostDetailViewController *post = [storyboard instantiateViewControllerWithIdentifier:@"postdetail"];
//                post.qrdata = qrdata;
//                [[NSUserDefaults standardUserDefaults] setObject:codeMaster forKey:TL_ACTION];
//                [self.navigationController pushViewController:post animated:YES];
//            }
//                break;
//            case 4:
//            {
//                TLMoshopViewController *moShopController = [storyboard instantiateViewControllerWithIdentifier:@"moshop"];
//                moShopController.qrdata = qrdata;
//                [self.navigationController pushViewController:moShopController animated:YES];
//            }
//                break;
//             case 5:
//             {
//              TLGroupPurchaseViewController *groupPurchaseViewController = [[TLGroupPurchaseViewController alloc]init];
//              TLProduct *product = [[TLProduct alloc]init];
//              product.prod_id = qrdata.prod_id;
//              product.post_id = qrdata.post_id;
//              product.mstore_id = qrdata.store_id;
//              product.relation_id = qrdata.relation_id;
//              groupPurchaseViewController.product = product;
//              groupPurchaseViewController.action = prod_code;
//              [self.navigationController pushViewController:groupPurchaseViewController animated:YES];
//              }
//              break;
//                case 6:
//                {
//                CKOrganizationViewController *organizationView = [[CKOrganizationViewController alloc]init];
//                    organizationView.qrdata = qrdata;
//                    [self.navigationController pushViewController:organizationView animated:YES];
//                }
//                break;
//            default:
//                break;
//        }
//        [MBProgressHUD showSuccess:@"语音识别成功"];
//
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:@"语音识别失败,请重试"];
//    }];
//
//}
//
//
//-(void)timeOn
//{
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(run) userInfo:nil repeats:YES];
//}
//
///**
// *  关闭定时
// */
//-(void)timeOff
//{
//    [self.timer invalidate];
//    self.timer = nil;
//}
//
//- (IBAction)stopButton:(UIButton *)sender {
//    SinVoiceRecognizer_stop(mSinVoiceRecorder);
//    [self timeOff];
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//-(void)onPlayData:(TLListenFindViewController*)data
//{
//    NSThread* curThrd =[NSThread currentThread];
//    NSLog(@"onPlayData, thread:%@",curThrd);
//    [self performSelectorOnMainThread:@selector(updateUI:) withObject:data waitUntilDone:FALSE];
//}
//
//-(void)updateUI:(TLListenFindViewController*)data
//{
//    NSThread* curThrd =[NSThread currentThread];
//    NSLog(@"updateUI, thread:%@",curThrd);
//    
//    //    NSMutableString* str = [[NSMutableString alloc]init];
//    //    for ( int i = 0; i < TOKEN_COUNT; ++i ) {
//    //        [str appendFormat:@"%c", CODE_BOOK[data->mRates[i]]];
//    //    }
//    char ch[100] = { 0 };
//    for ( int i = 0; i < mPlayCount; ++i ) {
//        ch[i] = (char)data->mRates[i];
//    }
//    
//    //    NSString* str = [NSString stringWithCString:ch encoding:NSUTF8StringEncoding];
//    
//    //    _mPlayLabel.text = str;
//}
//
//-(void)onRecogToken:(TLListenFindViewController*)data
//{
//    NSThread* curThrd =[NSThread currentThread];
//    NSMutableString* str = [[NSMutableString alloc]init];
//    for ( int i = 0; i < mResultCount; ++i ) {
//        [str appendFormat:@"%c", CODE_BOOK[data->mResults[i]]];
//    }
//    
//    if ( mResultCount >= 6) {
//        NSLog(@"onRecordData, thread:%@; str : %@",curThrd,str);
//        SinVoiceRecognizer_stop(mSinVoiceRecorder);
//        [self performSelectorOnMainThread:@selector(listenStartWithData:) withObject:str waitUntilDone:FALSE];
//    }
//}
//
//-(void)updateRecordUI:(TLListenFindViewController*)data
//{
//    NSThread* curThrd =[NSThread currentThread];
//    NSLog(@"updateUI, thread:%@",curThrd);
//    
//    //    char ch[100] = { 0 };
//    //    for ( int i = 0; i < mResultCount; ++i ) {
//    //        ch[i] = (char)data->mResults[i];
//    //    }
//    //
//    //    NSString* str = [NSString stringWithCString:ch encoding:NSUTF8StringEncoding];
//    
//    NSMutableString* str = [[NSMutableString alloc]init];
//    for ( int i = 0; i < mResultCount; ++i ) {
//        [str appendFormat:@"%c", CODE_BOOK[data->mResults[i]]];
//    }
//    
//    
//    //    _mRecognisedLable.text = str;
//}
//
//- (IBAction)startPlay:(UIButton *)sender {
//    NSLog(@"push start play");
//    /*
//     int index = 0;
//     NSString* xx = _mPlayTextField.text;
//     const char* str = [xx cStringUsingEncoding:NSUTF8StringEncoding];
//     
//     mPlayCount = (int)strlen(str);
//     int lenCodeBook = (int)strlen(CODE_BOOK);
//     int isOK = 1;
//     while ( index < mPlayCount) {
//     int i = 0;
//     for ( i = 0; i < lenCodeBook; ++i ) {
//     if ( str[index] == CODE_BOOK[i] ) {
//     mRates[index] = i;
//     break;
//     }
//     }
//     if ( i >= lenCodeBook ) {
//     isOK = 0;
//     break;
//     }
//     ++index;
//     }
//     if ( isOK ) {
//     SinVoicePlayer_play(mSinVoicePlayer, mRates, mPlayCount);
//     }
//     */
//    //    while ( index < TOKEN_COUNT) {
//    //        int rnd = rand();
//    //        mRates[index] = 60 * (double)rnd / RAND_MAX;
//    //        ++index;
//    //    }
//    //    SinVoicePlayer_play(mSinVoicePlayer, mRates, TOKEN_COUNT);
//}
//
//- (IBAction)stopPlay:(UIButton *)sender {
//    NSLog(@"push stop play");
//    //SinVoicePlayer_stop(mSinVoicePlayer);
//}
//
//- (IBAction)startRecord:(UIButton *)sender {
//    NSLog(@"push start record");
//    SinVoiceRecognizer_start(mSinVoiceRecorder, TOKEN_COUNT);
//}
//
//- (IBAction)stopRecord:(UIButton *)sender {
//    NSLog(@"push stop record");
//    SinVoiceRecognizer_stop(mSinVoiceRecorder);
//}
//
//
//
//
//@end



#import "TLListenFindViewController.h"
#import "TLImageName.h"
#import"TLCommon.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "Url.h"
#import "MBProgressHUD+MJ.h"
#import "TLQrdata.h"
#import "TLHttpTool.h"
#import "TLProdPurchaseViewController.h"
#import "TLMasterSuperViewController.h"
#import "TLPostDetailViewController.h"
#import "TLMoshopViewController.h"


@interface TLListenFindViewController ()


@property (weak, nonatomic) IBOutlet UIButton   *firstButton;

@property (weak, nonatomic) IBOutlet UIButton   *thirdButton;

@property (weak,nonatomic)  UINavigationBar     *navigationBar;

@property (nonatomic,strong) NSTimer    *timer;

@property (nonatomic,assign) int        index;

- (IBAction)listenAction:(UIButton *)sender;

- (IBAction)stopButton:(UIButton *)sender;


@end

@implementation TLListenFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self setButon];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:TL_BG_IMG]];
    self.index = 0;
    // Do any additional setup after loading the view.
}


//自定义导航栏
- (void)initNavigationBar{
    [self.navigationController setNavigationBarHidden:YES];
    UINavigationBar *navigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, 64)];
    self.navigationBar = navigationBar;
    [self creatWithLeftButtonAndtitle:@"发现"];
    [self.view addSubview:navigationBar];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"beijin" ] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage imageNamed:@"beijin" ]];
    
}

-(void)creatWithLeftButtonAndtitle:(NSString *)title
{
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 30, 70, 25);
    [left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [left setImage:[UIImage imageNamed:TL_WHITE_ARROW] forState:UIControlStateNormal];
    [left setImage:[UIImage imageNamed:TL_WHITE_ARROW] forState:UIControlStateHighlighted];
    [self.navigationBar addSubview:left];
    
    UILabel *titleCenter = [[UILabel alloc]init];
    titleCenter.text = title;
    titleCenter.textColor = [UIColor whiteColor];
    titleCenter.font = [UIFont systemFontOfSize:17];
    CGSize titleSize = [titleCenter.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    titleCenter.bounds = (CGRect){{0,0},titleSize};
    titleCenter.center = CGPointMake(ScreenBounds.size.width/2, 42);
    [self.navigationBar addSubview:titleCenter];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(300, 20, 50, 30)];
    //rightView.backgroundColor = [UIColor redColor];
    [self.navigationBar addSubview:rightView];
    
}

/**
 *  自定义导航栏
 */
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)setButon
{
    [self setRoundWithButton:self.firstButton];
    [self setRoundWithButton:self.thirdButton];
    
}


-(void)setRoundWithButton:(UIButton *)button
{
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:button.bounds.size.height/2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)listenAction:(UIButton *)sender {
    
    [self timeOn];
}

-(void)run
{
    [UIView animateWithDuration:0.5 animations:^{
        self.thirdButton.transform = CGAffineTransformRotate(self.thirdButton.transform, M_PI_4);
        
    }];
}


-(void)listenStartWithData:(NSString *)scan_data
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,listen_decode_Url];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN,scan_data,@"scan_data", nil];
    [TLHttpTool postWithURL:url params:param success:^(id json) {
        NSDictionary *body = json[@"body"];
        TLQrdata *qrdata = [[TLQrdata alloc]initWithDictionary:body[@"qr_data"] error:nil];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Tongle_Base" bundle:nil];
        switch ([qrdata.code_type intValue]) {
            case 1:
            {
                TLProdPurchaseViewController *prod = [storyboard instantiateViewControllerWithIdentifier:@"prodpurchase"];
                prod.qrdata = qrdata;
                [self.navigationController pushViewController:prod animated:YES];
            }
                break;
            case 2:
            {
                TLMasterSuperViewController *master = [storyboard instantiateViewControllerWithIdentifier:@"mastersuper"];
                master.qrdata = qrdata;
                [self.navigationController pushViewController:master animated:YES];
            }
                break;
            case 3:
            {
                TLPostDetailViewController *post = [storyboard instantiateViewControllerWithIdentifier:@"postdetail"];
                post.qrdata = qrdata;
                [[NSUserDefaults standardUserDefaults] setObject:codeMaster forKey:TL_ACTION];
                [self.navigationController pushViewController:post animated:YES];
            }
                break;
            case 4:
            {
                TLMoshopViewController *moShopController = [storyboard instantiateViewControllerWithIdentifier:@"moshop"];
                moShopController.qrdata = qrdata;
                [self.navigationController pushViewController:moShopController animated:YES];
            }
                break;
            default:
                break;
        }
        [MBProgressHUD showSuccess:TL_LISTEN_SUCCESS];
        
    } failure:^(NSError *error) {
        //[MBProgressHUD showError:@"语音识别失败,请重试"];
    }];
    
}


-(void)timeOn
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(run) userInfo:nil repeats:YES];
}

/**
 *  关闭定时
 */
-(void)timeOff
{
    [self.timer invalidate];
    self.timer = nil;
}

- (IBAction)stopButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end







