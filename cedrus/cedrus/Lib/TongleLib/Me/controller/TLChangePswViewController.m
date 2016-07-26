//
//  TLChangePswViewController.m
//  TL11
//
//  Created by liu on 15-4-10.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLChangePswViewController.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLImageName.h"
#import "MJRefresh.h"
#import "TLCommon.h"
#import "UIColor+TL.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "MBProgressHUD+MJ.h"


@interface TLChangePswViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldPassword;

@property (weak, nonatomic) IBOutlet UITextField *changePassword;

@property (weak, nonatomic) IBOutlet UITextField *reChangePassword;

@property (weak, nonatomic) IBOutlet UIButton *button;

- (IBAction)button:(UIButton *)sender;




@end

@implementation TLChangePswViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextChange) name:UITextFieldTextDidChangeNotification object:self.oldPassword];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextChange) name:UITextFieldTextDidChangeNotification object:self.changePassword];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextChange) name:UITextFieldTextDidChangeNotification object:self.reChangePassword];
    
    [self setUi];
    self.button.enabled = NO;
    [self initNavigationBar];
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

-(void)setUi
{
    [self setButton:self.oldPassword withColor:TL_BORDER_COLOR_FIELD width:1.0f radius:3.0];
    [self setButton:self.changePassword withColor:TL_BORDER_COLOR_FIELD width:1.0f radius:3.0];
    [self setButton:self.reChangePassword withColor:TL_BORDER_COLOR_FIELD width:1.0f radius:3.0];
    [self setButton:self.button];
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


-(void)TextChange
{
    self.button.enabled = self.oldPassword.text.length && self.changePassword.text.length && self.reChangePassword.text.length;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)button:(UIButton *)sender {
    if (self.oldPassword.text.length >= 6) {
        if ([self.changePassword.text isEqualToString: self.reChangePassword.text]) {
            if (self.changePassword.text.length >= 6) {
                NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,password_modify_Url];
                
                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"phone_number"],@"phone_number",self.oldPassword.text,@"old_password",self.changePassword.text,@"latest_password",self.reChangePassword.text,@"confirm_password",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN,nil];

                [TLHttpTool postWithURL:url params:params success:^(id json) {
                        [MBProgressHUD showSuccess:@"修改密码成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                } failure:nil];
            }else
            {
                [MBProgressHUD showError:@"请设置长度不少于6位的新密码"];
                 self.button.enabled = NO;
            }
        }else
        {
            [MBProgressHUD showError:@"新密码与确认密码不一致,请重新输入"];
             self.button.enabled = NO;

        }
    }else
    {
        [MBProgressHUD showError:@"请输入正确的原始密码"];
         self.button.enabled = NO;
    }
    
}
@end
