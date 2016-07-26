//
//  CKLandViewController.m
//  ChouKe
//
//  Created by jixiaofei-mac on 16/5/26.
//  Copyright © 2016年 ilingtong. All rights reserved.
//

#import "CKLandViewController.h"
#import "TLFindPswViewController.h"
#import "TLRegisterViewController.h"
#import "TLCommon.h"
#import "TLImageName.h"
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
#import "TLValidataTool.h"
#import "UIColor+TL.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "CKImageName.h"


@interface CKLandViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNo;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic,assign) BOOL isAotoLogin;
@property (nonatomic,assign) BOOL rememPsw;

@property (nonatomic,strong) TLPersonalMeg *personmeg;
@property (nonatomic,copy) NSString *passwordmd5;



@end


static BOOL hideBool = 0;

@implementation CKLandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setButton];
    [self versionCheck];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)setButton
{
    _phoneNo.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:ICON_HEAD_IMAGE]];
    _phoneNo.leftViewMode = UITextFieldViewModeAlways;
    _phoneNo.layer.borderColor = [[UIColor getColor:TL_BORDER_COLOR_FIELD] CGColor];
    _phoneNo.layer.borderWidth = 1.0f;
    _phoneNo.delegate = self;
    
    _password.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:ICON_PASSWORD]];
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.layer.borderColor = [[UIColor getColor:TL_BORDER_COLOR_FIELD] CGColor];
    _password.layer.borderWidth = 1.0f;
    _password.delegate = self;
    
    [_loginBtn.layer setMasksToBounds:YES];
    [_loginBtn.layer setCornerRadius:3.0];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:TL_BUTTON_CORMAL] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:TL_BUTTON_DISADLE] forState:UIControlStateDisabled];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:TL_BUTTON_HEIGH_LIGHT] forState:UIControlStateHighlighted];
    
    
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
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
            if (![cancel_up_no isEqualToString:version.recently_version_no] && cancel_up_no != nil) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isquit"];
            }
        }
        [weakself startplay];
    } failure:^(NSError *error) {
        error = nil;
    } resultClass:[TLVersionParam class]];
}


-(void)startplay
{

    //本地化读取上次存储的账号，密码以及登录状态
    NSUserDefaults *defaults = TLUserDefaults;
    self.phoneNo.text = [defaults objectForKey:TLPhone_number];
    self.passwordmd5 = [defaults objectForKey:TLPassword];
    self.rememPsw = [defaults boolForKey:TLRememPsw];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isquit"]) {
        if (self.rememPsw) {
            self.password.text = [defaults objectForKey:TLPassword];
        }
    }else if (self.rememPsw&&self.passwordmd5.length&&self.phoneNo.text.length) {
        self.isAotoLogin = [defaults boolForKey:TLAutoLogin];
        if (self.isAotoLogin && ![[TLUserDefaults objectForKey:TL_USER_TYPE] isEqualToString:TL_USER_TOURIST])
        {
            self.password.text = self.passwordmd5;
            [self loginBtn:_loginBtn];
        }else
        {
            self.password.text = self.passwordmd5;
        }
    }
}


- (IBAction)loginBtn:(UIButton *)sender {
    sender.enabled = NO;
    [self performSelector:@selector(delay:) withObject:sender afterDelay:1];
    
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
                if ([TLValidataTool checkPhoneNumInput:self.phoneNo.text])
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
            if ([TLValidataTool checkPhoneNumInput:self.phoneNo.text])
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
        dict = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneNo.text,@"phone_number",self.passwordmd5,@"password",MOBILE_OS_NO_IPHONE,@"mobile_os_no", nil];
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
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            [UIApplication sharedApplication].statusBarHidden = NO;
            
            if (![personmeg.is_protocol_show intValue]) {
                [weakself performSegueWithIdentifier:@"ckProtocolView" sender:nil];
            }else
            {
                 weakself.view.window.rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"CKTabbar"];
            }
            
            NSUserDefaults *defaults = TLUserDefaults;
            [defaults setObject:self.phoneNo.text forKey:TLPhone_number];
            [defaults setObject:self.password.text forKey:TLPassword];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isquit"];
            [defaults synchronize];
        });
    } failure:^(NSError *error){
        error = nil;
        //self.btn.enabled = YES;
    }];
}




- (IBAction)findPwd:(UIButton *)sender {
    sender.enabled = NO;
    [self performSelector:@selector(delay:) withObject:sender afterDelay:1];
    TLFindPswViewController *findPsdView = [[UIStoryboard storyboardWithName:STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:@"findpsw"];
    [self.navigationController pushViewController:findPsdView animated:YES];
}
- (IBAction)registerBtn:(UIButton *)sender {
    sender.enabled = NO;
    [self performSelector:@selector(delay:) withObject:sender afterDelay:1];
    TLRegisterViewController *registerView = [[UIStoryboard storyboardWithName:STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:@"register"];
    [self.navigationController pushViewController:registerView animated:YES];
}

-(void)delay:(UIButton *)button
{
    button.enabled = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
