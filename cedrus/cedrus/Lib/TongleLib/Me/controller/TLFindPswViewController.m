//
//  TLFindPswViewController.m
//  TL11
//
//  Created by liu on 15-4-10.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLFindPswViewController.h"
#import "TLHttpTool.h"
#import "TLFindPsw.h"
#import "TLResetPswViewController.h"
#import "TLValidataTool.h"
#import "TLPersonalMegTool.h"
#import "TLPersonalMeg.h"
#import "TLCommon.h"
#import "UIColor+TL.h"
#import "TLImageName.h"
#import "Url.h"
#import "MBProgressHUD+MJ.h"


@interface TLFindPswViewController ()

//手机号
@property (weak, nonatomic) IBOutlet UITextField *phone_number;

//验证码
@property (weak, nonatomic) IBOutlet UITextField *verification;

//验证码按键
@property (weak, nonatomic) IBOutlet UIButton *verificationBtn;
//最后找回密码按键
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;


- (IBAction)veriBtn:(UIButton *)sender;

- (IBAction)submitButton:(UIButton *)sender;



@end

@implementation TLFindPswViewController

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
    //监听textfield的输入情况
    [self initNavigationBar];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextChange) name:UITextFieldTextDidChangeNotification object:self.phone_number];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextChange) name:UITextFieldTextDidChangeNotification object:self.verification];
    [self setUi];
}


-(void)setUi
{
    self.phone_number.layer.borderWidth = 1.0;
    self.phone_number.layer.borderColor = [[UIColor getColor:TL_BORDER_COLOR_FIELD]CGColor];
    [self.phone_number.layer setCornerRadius:3.0];
    
    self.verification.layer.borderWidth = 1.0;
    self.verification.layer.borderColor = [[UIColor getColor:TL_BORDER_COLOR_FIELD]CGColor];
    [self.verification.layer setCornerRadius:3.0];
    //验证码初始时不能编辑
    self.verification.enabled = NO;
    
    [self.submitBtn setBackgroundImage:[UIImage imageNamed:TL_BUTTON_CORMAL] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[UIImage imageNamed:TL_BUTTON_DISADLE] forState:UIControlStateDisabled];
    [self.submitBtn setBackgroundImage:[UIImage imageNamed:TL_BUTTON_HEIGH_LIGHT] forState:UIControlStateHighlighted];

    [self.submitBtn.layer setMasksToBounds:YES];
    [self.submitBtn.layer setCornerRadius:3.0];
    
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)TextChange
{
    //使能按键
    self.verificationBtn.enabled = (self.phone_number.text.length && 1);
    self.submitBtn.enabled = (self.phone_number.text && self.verification.text);
    
}


- (IBAction)veriBtn:(UIButton *)sender {
    
    if ([TLValidataTool checkPhoneNumInput:self.phone_number.text]) {
        //验证码网络请求
        NSString *url = [NSString stringWithFormat:@"%@%@",Url,verification_code_send_Url];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.phone_number.text,@"phone_number",nil];
        [TLHttpTool postWithURL:url params:dict success:^(id json) {
            self.verification.enabled = YES;
            [MBProgressHUD showSuccess:@"验证码已发出,请注意查收"];
        } failure:nil];
    }else
    {
        [MBProgressHUD showError:@"请检查并填写正确的手机号"];
    }
}

- (IBAction)submitButton:(UIButton *)sender {
    //推出键盘
    [self.view endEditing:YES];
    if (self.verification.text.length == 6) {
        //最后找回密码网络请求
        NSString *url = [NSString stringWithFormat:@"%@%@",Url,password_retrieve_Url];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.phone_number.text,@"phone_number",self.verification.text,@"verification_code",nil];
        [TLHttpTool postWithURL:url params:dict success:^(id json) {
            NSDictionary *jsondict = json[@"body"];
            TLFindPsw *findPsw = [[TLFindPsw alloc]init];
            findPsw.tel = self.phone_number.text;
            findPsw.token = jsondict[@"token"];
            findPsw.verification = self.verification.text;
            [self performSegueWithIdentifier:@"ResetPsw" sender:findPsw];
        } failure:nil];
    }else if(self.verification.text.length == 0)
    {
        [MBProgressHUD showError:@"请填入通过短信获取的到的验证码"];
        self.submitBtn.enabled = NO;
    }else
    {
        [MBProgressHUD showError:@"请填入正确的验证码"];
         self.submitBtn.enabled = NO;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLResetPswViewController class]]) {
        TLResetPswViewController *resetpsw = vc;
        resetpsw.findPsw = sender;
    }
}



@end
