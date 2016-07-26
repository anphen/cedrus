//
//  TLResetPswViewController.m
//  TL11
//
//  Created by liu on 15-4-10.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLResetPswViewController.h"
#import "TLFindPsw.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLCommon.h"
#import "UIColor+TL.h"
#import "TLImageName.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "MBProgressHUD+MJ.h"

@interface TLResetPswViewController ()

@property (weak, nonatomic) IBOutlet UITextField *Password;

@property (weak, nonatomic) IBOutlet UITextField *resetPassword;


@property (weak, nonatomic) IBOutlet UIButton *resetPasswordButton;

- (IBAction)resetButton:(UIButton *)sender;

@end

@implementation TLResetPswViewController

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
    
    [self initNavigationBar];
    //监听输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextChange) name:UITextFieldTextDidChangeNotification object:self.Password];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextChange) name:UITextFieldTextDidChangeNotification object:self.resetPassword];
    
    

}

-(void)setUi
{
    [self setButton:self.Password withColor:TL_BORDER_COLOR_FIELD width:1.0f radius:3.0];
    [self setButton:self.resetPassword withColor:TL_BORDER_COLOR_FIELD width:1.0f radius:3.0];
    [self setButton:self.resetPasswordButton];
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
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

-(void)TextChange
{
    self.resetPasswordButton.enabled = self.Password.text.length && self.resetPassword.text.length;
}


- (IBAction)resetButton:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.Password.text.length >= 6) {
        if ([self.Password.text isEqualToString:self.resetPassword.text]) {
            NSString *url = [NSString stringWithFormat:@"%@%@",Url,password_reset_Url];
            NSDictionary *params = [NSDictionary dictionary];
            params = @{@"phone_number":self.findPsw.tel,@"password":self.Password.text,@"confirm_password":self.resetPassword.text,@"verification_code":self.findPsw.verification};
            
            __unsafe_unretained __typeof(self) weakSelf = self;
            [TLHttpTool postWithURL:url params:params success:^(id json) {
                [MBProgressHUD showSuccess:@"密码修改成功，请使用新密码进行登录!"];
                [weakSelf performSelector:@selector(delay) withObject:nil afterDelay:0.5f];
            } failure:nil];

        }else
        {
            [MBProgressHUD showError:@"两次密码输入不同，请重新输入"];
            self.resetPasswordButton.enabled = NO;
        }
    }else
    {
        [MBProgressHUD showError:@"请设置长度不少于6位的密码"];
        self.resetPasswordButton.enabled = NO;
    }
}

//延时返回
-(void)delay
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
