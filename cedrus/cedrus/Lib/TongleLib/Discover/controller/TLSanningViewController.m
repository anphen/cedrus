//
//  TLSanningViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-27.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLSanningViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLQrdata.h"
#import "TLProdPurchaseViewController.h"
#import "TLMasterSuperViewController.h"
#import "TLPostDetailViewController.h"
#import "TLMoshopViewController.h"
#import "TLImageName.h"
#import "TLCommon.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "UIColor+TL.h"
#import "MBProgressHUD+MJ.h"
#import "TLGroupPurchaseViewController.h"
#import "TLProduct.h"
//#import "CKOrganizationViewController.h"

@interface TLSanningViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *session;//输入输出的中间桥梁
    AVCaptureVideoPreviewLayer *layer;
    AVCaptureMetadataOutput *captureMetadataOutput;
    NSTimer *timer;
    BOOL upOrdown;
    int num;
}

@property (nonatomic, strong) UIImageView * line;

@end

@implementation TLSanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationBar];
    [self startReading];
    [self setupAction];
}

//自定义导航栏
- (void)initNavigationBar
{
    int leftButtonWH = 25;
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.frame = CGRectMake(0, 0, leftButtonWH, leftButtonWH);
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:TL_NAVI_BACK_NORMAL] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:TL_NAVI_BACK_PRESS] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}
/**
 *  重写返回按钮
 */
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setCodeType:(NSString *)codeType
{
    _codeType = codeType;
}

-(BOOL)startReading
{
    _isReading = YES;
    NSError *error;
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!input) {
        return NO;
    }
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    [session addInput:input];
    //创建输出流
    captureMetadataOutput = [[AVCaptureMetadataOutput alloc]init];
    
    CGSize size = self.view.bounds.size;
    CGRect cropRect = CGRectMake((ScreenBounds.size.width-250)/2, 90, 250, 250);
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.;  //使用了1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = self.view.bounds.size.width * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        captureMetadataOutput.rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
                                                  cropRect.origin.x/size.width,
                                                  cropRect.size.height/fixHeight,
                                                  cropRect.size.width/size.width);
    } else {
        CGFloat fixWidth = self.view.bounds.size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        captureMetadataOutput.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                                  (cropRect.origin.x + fixPadding)/fixWidth,
                                                  cropRect.size.height/size.height,
                                                  cropRect.size.width/fixWidth);
    }

    [session addOutput:captureMetadataOutput];
    //设置代理 在主线程里刷新
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置扫码支持的编码格式
    captureMetadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];

    layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [session startRunning];
    return YES;
}
-(void)stopReading
{
    [session stopRunning];
    session = nil;
    [layer removeFromSuperlayer];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection
{
    if (!_isReading) return;
    
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        [self stopReading];
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([self.codeType isEqualToString:@"发现"]) {
            NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,scan_decode_Url];
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN,metadataObj.stringValue,@"scan_data", nil];
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
                    case 5:
                    {
                        TLGroupPurchaseViewController *groupPurchaseViewController = [[TLGroupPurchaseViewController alloc]init];
                        TLProduct *product = [[TLProduct alloc]init];
                        product.prod_id = qrdata.prod_id;
                        product.post_id = qrdata.post_id;
                        product.mstore_id = qrdata.store_id;
                        product.relation_id = qrdata.relation_id;
                        groupPurchaseViewController.product = product;
                        groupPurchaseViewController.action = prod_code;
                        [self.navigationController pushViewController:groupPurchaseViewController animated:YES];
                    }
                        break;
                    case 6:
                    {
//                        CKOrganizationViewController *organizationView = [[CKOrganizationViewController alloc]init];
//                        organizationView.qrdata = qrdata;
//                        [self.navigationController pushViewController:organizationView animated:YES];
                    }
                        break;
                    default:
                        break;
                }
                [MBProgressHUD showSuccess:TL_CODE_SUCCESS];
                
            } failure:nil];
        }else if([self.codeType isEqualToString:@"注册"])
        {
             NSString *url = [NSString stringWithFormat:@"%@%@",Url,scan_user_decode_Url];
              NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:metadataObj.stringValue,@"scan_data", nil];
         __weak TLSanningViewController *weakSelf = self;
            [TLHttpTool postWithURL:url params:param success:^(id json) {
                NSDictionary *dict = json[@"body"];
                weakSelf.userData = dict[@"user_data"];
                if ([weakSelf.delegate respondsToSelector:@selector(sanningViewControllerDelagate:userPhone:)]) {
                    [weakSelf.delegate sanningViewControllerDelagate:self userPhone:self.userData[@"phone"]];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            } failure:nil];
        }else if ([self.codeType isEqualToString:@"推荐人"])
        {
            NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,scan_decode_Url];
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN,metadataObj.stringValue,@"scan_data", nil];
             __weak TLSanningViewController *weakSelf = self;
            [TLHttpTool postWithURL:url params:param success:^(id json) {
                NSDictionary *body = json[@"body"];
                TLQrdata *qrdata = [[TLQrdata alloc]initWithDictionary:body[@"qr_data"] error:nil];
                if ([qrdata.code_type intValue] == 2) {
                    if ([weakSelf.delegate respondsToSelector:@selector(sanningViewControllerDelagate:userPhone:)]) {
                        [weakSelf.delegate sanningViewControllerDelagate:self userPhone:qrdata.user_id];
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                }
            } failure:nil];
        }
    }
}

-(void)setupAction
{
    num = 0;
    upOrdown = NO;

    
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:TL_PICK_BG]];
    image.frame = CGRectMake((ScreenBounds.size.width-250)/2, 90, 250, 250);
    [self.view addSubview:image];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(image.frame.origin.x, CGRectGetMaxY(image.frame)+8, 250, 30)];
    label.text = TL_CODE_AUTO;
    label.textColor = [UIColor getColor:@"aeafae"];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UILabel * labelme = [[UILabel alloc] initWithFrame:CGRectMake(image.frame.origin.x, CGRectGetMaxY(label.frame), 250, 30)];
    labelme.text = TL_CODE_MINE;
    labelme.textColor = [UIColor greenColor];
    labelme.backgroundColor = [UIColor clearColor];
    labelme.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelme];
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 220, 2)];
    _line.image = [UIImage imageNamed:TL_LINE_UD];
    [image addSubview:_line];
    //定时器，设定时间过1.5秒，
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}

-(void)animation
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(15, 10+2*num, 220, 2);
        if (2*num == 230) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(15, 10+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
    
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

@end
