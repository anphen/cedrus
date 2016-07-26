//
//  TLRegisterViewController.m
//  TL11
//
//  Created by liu on 15-4-10.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLRegisterViewController.h"
#import "TLSanningViewController.h"
#import "TLRegister.h"
#import "TLValidataTool.h"
#import "TLPersonalMegTool.h"
#import "TLPersonalMeg.h"
#import "TLCommon.h"
#import "TLImageName.h"
#import "UIColor+TL.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "TLBaseTool.h"
#import "MBProgressHUD+MJ.h"

@interface TLRegisterViewController ()<TLSanningViewControllerDelagate>

@property (weak, nonatomic) IBOutlet UITextField *phone_number;

@property (weak, nonatomic) IBOutlet UIButton *verificationBtn;

@property (weak, nonatomic) IBOutlet UITextField *verificationLable;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *code;


@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;

@property (weak, nonatomic) IBOutlet UIButton *codeButton;


- (IBAction)protocolBtn:(UIButton *)sender;



- (IBAction)veriBtn;

- (IBAction)registerButton;

- (IBAction)backgroundTap:(id)sender;

- (IBAction)codeBtn:(UIButton *)sender;

@end

@implementation TLRegisterViewController

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
    //验证码不能编辑
    self.verificationLable.enabled = NO;
    self.code.enabled = NO;
    //监听输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextChange) name:UITextFieldTextDidChangeNotification object:self.phone_number];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextChange) name:UITextFieldTextDidChangeNotification object:self.verificationLable];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextChange) name:UITextFieldTextDidChangeNotification object:self.password];
    [self setUi];
}

-(void)setUi
{
    [self setButton:self.phone_number withColor:TL_BORDER_COLOR_FIELD width:1.0f radius:3.0];
    [self setButton:self.verificationLable withColor:TL_BORDER_COLOR_FIELD width:1.0f radius:3.0];
    [self setButton:self.password withColor:TL_BORDER_COLOR_FIELD width:1.0f radius:3.0];
    [self setButton:self.code withColor:TL_BORDER_COLOR_FIELD width:1.0f radius:3.0];

    [self setButton:self.verificationBtn];
    [self setButton:self.registerBtn];
    [self setButton:self.codeButton];
    
    [self.protocolBtn setBackgroundImage:[UIImage imageNamed:TL_BOX_PRESS] forState:UIControlStateSelected];
    [self.protocolBtn setBackgroundImage:[UIImage imageNamed:TL_BOX_NORMAL] forState:UIControlStateNormal];
    self.protocolBtn.adjustsImageWhenHighlighted = NO;

}
-(void)setButton:(UITextField *)btn withColor:(NSString *)color width:(CGFloat)width radius:(CGFloat)radius
{
    btn.layer.borderColor = [[UIColor getColor:color] CGColor];
    btn.layer.borderWidth = width;
    [btn.layer setCornerRadius:radius];
}

-(void)setButton:(UIButton *)btn
{
    [btn setBackgroundImage:[UIImage imageNamed:TL_BUTTON_CORMAL] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:TL_BUTTON_DISADLE] forState:UIControlStateDisabled];
    [btn setBackgroundImage:[UIImage imageNamed:TL_BUTTON_HEIGH_LIGHT] forState:UIControlStateHighlighted];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:3.0];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//自定义导航栏
- (void)initNavigationBar
{
    
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
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

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)codeBtn:(UIButton *)sender {
    [self.view endEditing:YES];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Tongle_Base" bundle:nil];
    TLSanningViewController *sanning = [storyBoard instantiateViewControllerWithIdentifier:@"sanning"];
    sanning.delegate = self;
    sanning.codeType = @"注册";
    [self.navigationController pushViewController:sanning animated:YES];
}

-(void)sanningViewControllerDelagate:(TLSanningViewController *)sanningView userPhone:(NSString *)phone
{
    self.code.text = phone;
}

-(void)TextChange
{
    self.verificationBtn.enabled = (self.phone_number.text.length && 1);
    self.registerBtn.enabled = (self.phone_number.text.length && self.verificationLable.text.length && self.password.text.length && self.protocolBtn.selected);
    if (self.registerBtn.enabled) {
        TLRegister *registerd = [[TLRegister alloc]init];
        //注册手机号
        registerd.phone_number = self.phone_number.text;
        //注册密码
        registerd.password = self.password.text;
        //注册验证码
        registerd.verification_code = self.verificationLable.text;
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app版本
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        //平台系统版本号（后续修改）
        registerd.mobile_os_version = app_Version;
        //终端设备描述名
        registerd.terminal_device = TL_DEVICE_IOS;
        
        registerd.recommend_code = self.code.text;
        self.registerd = registerd;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)protocolBtn:(UIButton *)sender {
    [self.view endEditing:YES];
    self.protocolBtn.selected = !self.protocolBtn.selected;
     self.registerBtn.enabled = (self.phone_number.text.length && self.verificationLable.text.length && self.password.text.length && self.protocolBtn.selected);
}


- (IBAction)veriBtn {
    if ([TLValidataTool checkPhoneNumInput:self.phone_number.text]) {
        //验证码网络请求
        NSString *url = [NSString stringWithFormat:@"%@%@",Url,verification_code_send_Url];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.phone_number.text,@"phone_number",nil];
        [TLHttpTool postWithURL:url params:dict success:^(id json) {
            self.verificationLable.enabled = YES;
            [MBProgressHUD showSuccess:@"验证码已发出,注意查收"];
        } failure:nil];
    }else
    {
        [MBProgressHUD showError:@"请检查并填写正确的手机号"];
    }
    
    
}

- (IBAction)registerButton {
    [self.view endEditing:YES];
    if (self.verificationLable.text.length == 6) {
        if (self.password.text.length >= 6 ) {
            //验证码网络请求
            NSString *url = [NSString stringWithFormat:@"%@%@",Url,register_Url];
            [self TextChange];
            [TLBaseTool postWithURL:url param:self.registerd success:^(id json) {
                    [MBProgressHUD showSuccess:@"注册成功，请前往登录界面开始使用通乐商城!"];
                    [self.navigationController popViewControllerAnimated:YES];
            } failure:nil];
        }else
        {
             [MBProgressHUD showError:@"请设置长度不少于6位的密码"];
            self.registerBtn.enabled = NO;
        }
            
    }else if(self.verificationLable.text.length == 0)
    {
        [MBProgressHUD showError:@"请填入通过短信获取的到的验证码"];
        self.registerBtn.enabled = NO;
    }else
    {
        [MBProgressHUD showError:@"请填入正确的验证码"];
        self.registerBtn.enabled = NO;
    }
    
}
@end
