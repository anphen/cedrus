//
//  TLLandViewController.m
//  TL11
//
//  Created by liu on 15-4-10.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLLandViewController.h"
#import "MBProgressHUD+MJ.h"
#import "TLHttpTool.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "TLPersonalMeg.h"
#import "MJExtension.h"
#import "NSString+Password.h"
#import "TLPersonalMegTool.h"
#import "TLVersionRequest.h"
#import "TLVersionParam.h"
#import "TLCommon.h"
#import "AppDelegate.h"
#import "TLFieldViewController.h"
#import "TLValidataTool.h"
#import "UIColor+TL.h"
#import "TLImageName.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "AppDelegate.h"
#import "TLTabbarTouristController.h"

@interface TLLandViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phone_number;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UIButton *findpass;

@property (weak, nonatomic) IBOutlet UIButton *registerbtn;


@property (nonatomic,assign) BOOL isAotoLogin;
@property (nonatomic,assign) BOOL rememPsw;

@property (nonatomic,strong) TLPersonalMeg *personmeg;
@property (nonatomic,copy) NSString *passwordmd5;


- (IBAction)land:(UIButton *)sender;
- (IBAction)textFiledReturnEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)touristLogin:(UIButton *)sender;


@end

static BOOL hideBool = 0;


@implementation TLLandViewController

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
    [self setBaseData];
    [self versionCheck];
}


//版本更新检查
-(void)versionCheck
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",Url,version_check_Url];
    TLVersionRequest *versionRequest = [[TLVersionRequest alloc]init];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *app_Version_Number = [app_Version stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    versionRequest.local_app_version = app_Version;

    __unsafe_unretained __typeof(self) weakself = self;
    
    [TLBaseTool postWithURL:url param:versionRequest success:^(id result) {
        TLVersionParam *version = result;
        
          NSString *array_recently_Version_Number = [version.recently_version_no stringByReplacingOccurrencesOfString:@"." withString:@""];
        if ([array_recently_Version_Number integerValue]>[app_Version_Number integerValue]) {
            NSString *cancel_up_no = [[NSUserDefaults standardUserDefaults] objectForKey:TL_CANCEL_UP_NO];
            if (![cancel_up_no isEqualToString:version.recently_version_no] && cancel_up_no != nil ) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isquit"];
            }
        }
        [weakself startplay];
    } failure:^(NSError *error) {
        error = nil;
    } resultClass:[TLVersionParam class]];
}



-(void)setBaseData
{
        int back_Image_WH = 25;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, back_Image_WH, back_Image_WH);
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:TL_NAVI_BACK_NORMAL] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:TL_NAVI_BACK_PRESS] forState:UIControlStateHighlighted];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = leftButton;
        if ([_backType isEqualToString:TLYES]) {
            btn.hidden = NO;
        }else
        {
            btn.hidden = YES;
        }
    if (!_hide.length) {
        hideBool = NO;
    }
    _touristLogin.hidden = hideBool;
    
    // Do any additional setup after loading the view.
}







-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)startplay
{
//    //监听通知，是否填入手机号和密码
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phone_number];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.password];
    //本地化读取上次存储的账号，密码以及登录状态
    NSUserDefaults *defaults = TLUserDefaults;
    self.phone_number.text = [defaults objectForKey:TLPhone_number];
    self.passwordmd5 = [defaults objectForKey:TLPassword];
    self.rememPsw = [defaults boolForKey:TLRememPsw];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isquit"]) {
        if (self.rememPsw) {
            self.password.text = [defaults objectForKey:TLPassword];
           // self.btn.enabled = YES;
        }else
        {
           // self.btn.enabled = NO;
        }
    }else if (self.rememPsw&&self.passwordmd5.length&&self.phone_number.text.length) {
        //self.passwordmd5 = [defaults objectForKey:TLPassword];
        self.isAotoLogin = [defaults boolForKey:TLAutoLogin];
        if (self.isAotoLogin && ![[TLUserDefaults objectForKey:TL_USER_TYPE] isEqualToString:TL_USER_TOURIST])
        {
            self.password.text = self.passwordmd5;
            //self.btn.enabled = YES;
            [self land:_btn];
        }else
        {
            self.password.text = self.passwordmd5;
            //self.btn.enabled = YES;
        }
    }
    [self setUi];
}


-(void)setUi
{
    self.phone_number.layer.borderColor = [[UIColor getColor:TL_BORDER_COLOR_FIELD] CGColor];
    self.phone_number.layer.borderWidth = 1.0f;
    [self.phone_number.layer setCornerRadius:3.0];
    
    self.password.layer.borderColor = [[UIColor getColor:TL_BORDER_COLOR_FIELD] CGColor];
    self.password.layer.borderWidth = 1.0f;
    [self.password.layer setCornerRadius:3.0];
    
    [self setButton:_btn];
    [self setButton:_touristLogin];
}

-(void)setButton:(UIButton *)button
{
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:3.0];
    [button setBackgroundImage:[UIImage imageNamed:TL_BUTTON_CORMAL] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:TL_BUTTON_DISADLE] forState:UIControlStateDisabled];
    [button setBackgroundImage:[UIImage imageNamed:TL_BUTTON_HEIGH_LIGHT] forState:UIControlStateHighlighted];
}




//-(void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (NSString *)myPwd
{
    return [self.password.text MD5];
}

//-(void)textChange
//{
//    self.btn.enabled = (self.phone_number.text.length && self.password.text.length);
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)touristLogin:(UIButton *)sender {
    //游客登录
    [TLUserDefaults setObject:TL_USER_TOURIST forKey:TL_USER_TYPE];
    [self getPersonMeg];
}



- (IBAction)land:(UIButton *)sender
{
    //会员登录
    [TLUserDefaults setObject:TL_USER_MEMBER forKey:TL_USER_TYPE];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isquit"];
    
    [self.view endEditing:YES];
    
    if (self.rememPsw && !self.isAotoLogin) {
        [self getPersonMeg];
    }else
    {
        if (self.isAotoLogin) {
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:TLAUTOLAND] isEqualToString:@"1"])
            {
                if ([TLValidataTool checkPhoneNumInput:self.phone_number.text])
                {
                    if (self.password.text.length >= 6) {
                        //网络请求
                        [self getPersonMeg];
                    }else
                    {
                        [MBProgressHUD showError:@"请输入长度不少于6位的密码"];
                    }
                }else
                {
                    [MBProgressHUD showError:@"请检查并填写正确的手机号"];
                   // self.btn.enabled = NO;
                }
                [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:TLAUTOLAND];
            }else
            {
                [self getPersonMeg];
            }
        }else
        {
            if ([TLValidataTool checkPhoneNumInput:self.phone_number.text])
            {
                if (self.password.text.length >= 6) {
                    //网络请求
                    [self getPersonMeg];
                }else
                {
                    [MBProgressHUD showError:@"请输入长度不少于6位的密码"];
                }
            }else
            {
                [MBProgressHUD showError:@"请检查并填写正确的手机号"];
                //self.btn.enabled = NO;
            }
        }
    }
}



-(void)getPersonMeg
{
    
    //显示一个蒙版
    [MBProgressHUD showMessage:@"正在拼命加载中...."];
    [self loginAction];
    [MBProgressHUD hideHUD];
}

-(void)loginAction
{
    NSString *user_type = [TLUserDefaults objectForKey:TL_USER_TYPE];
    //登录url
    NSString *url = [NSString string];
    //将手机号和密码放入字典
    NSDictionary *dict = [NSDictionary dictionary];
    if ([user_type isEqualToString:TL_USER_TOURIST]) {
        url = [NSString stringWithFormat:@"%@%@",Url,templogin_Url];
    }else
    {
        url= [NSString stringWithFormat:@"%@%@",Url,login_Url];
        self.passwordmd5 = self.password.text;
        dict = [NSDictionary dictionaryWithObjectsAndKeys:self.phone_number.text,@"phone_number",self.passwordmd5,@"password",MOBILE_OS_NO_IPHONE,@"mobile_os_no", nil];
    }
     __unsafe_unretained __typeof(self) weakself = self;
    //进行网络请求
    [TLHttpTool postWithURL:url params:dict success:^(id json) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //保存账户
            TLPersonalMeg *personmeg = [[TLPersonalMeg alloc]initWithDictionary:json[@"body"] error:nil];
            weakself.personmeg = personmeg;
            [TLPersonalMegTool savePersonalMeg:personmeg];
            [TLUserDefaults setObject:personmeg.user_id forKey:TLBUY_USER_ID];
            [TLUserDefaults setObject:personmeg.token forKey:@"token"];
            [TLUserDefaults setObject:personmeg.user_type forKey:TL_USER_TYPE];
            //[MBProgressHUD hideHUD];
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
            
            [UIApplication sharedApplication].statusBarHidden = NO;
            
            if ([personmeg.user_type isEqualToString:TL_USER_TOURIST]) {
                TLTabbarTouristController *TabbarTourist = [[TLTabbarTouristController alloc]init];
                weakself.view.window.rootViewController = TabbarTourist;
            }else
            {
                weakself.view.window.rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"tabbar"];
            }
            
            NSUserDefaults *defaults = TLUserDefaults;
            [defaults setObject:self.phone_number.text forKey:TLPhone_number];
            [defaults setObject:self.password.text forKey:TLPassword];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isquit"];
            [defaults synchronize];
        });
    } failure:^(NSError *error){
        error = nil;
        //self.btn.enabled = YES;
    }];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLFieldViewController class]]) {
        TLFieldViewController *FieldViewController = vc;
        FieldViewController.sign = @"登录";
    }
}


-(void)setBackType:(NSString *)backType
{
    _backType = backType;
}

-(void)setHeadtitle:(NSString *)headtitle
{
    _headtitle = headtitle;
}

-(void)setHide:(NSString *)hide
{
    _hide = hide;
    if ([hide isEqualToString:@"隐藏"]) {
        hideBool = YES;
    }else
    {
        hideBool = NO;
    }
}

@end

