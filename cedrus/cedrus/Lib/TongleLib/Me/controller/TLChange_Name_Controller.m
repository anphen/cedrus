//
//  TLChange_Name_Controller.m
//  tongle
//
//  Created by jixiaofei-mac on 15-9-9.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLChange_Name_Controller.h"
#import "TLImageName.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLBaseTool.h"
#import "Url.h"
#import "TLPersonalInfo.h"
#import "MBProgressHUD+MJ.h"
#import "TLPersonalInfoModefyRequest.h"

@interface TLChange_Name_Controller ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (nonatomic,strong) TLPersonalInfo *personalInfo;

@end

@implementation TLChange_Name_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    // Do any additional setup after loading the view.
    //self.navigationController.title = @"修改昵称";
    //self.navigationController.title = [NSString stringWithFormat:@"修改%@",self.type];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(sureAction:)];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, self.userName.frame.size.height)];
    self.userName.leftView = leftView;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    self.userName.placeholder = self.userNameString;

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


-(void)setType:(NSString *)type
{
    _type = type;
    self.navigationItem.title = [NSString stringWithFormat:@"修改%@",type];
}

-(void)sureAction:(UIBarButtonItem *)button
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,personal_info_modify];
    
    TLPersonalInfoModefyRequest *personalInfoModefy = [[TLPersonalInfoModefyRequest alloc]init];
    
    if ([self.type isEqualToString:@"昵称"] || [self.type isEqualToString:@"真实姓名"]) {
        if ([self.type isEqualToString:@"昵称"]) {
            personalInfoModefy.user_nick_name = self.userName.text;
        }else if ([self.type isEqualToString:@"真实姓名"])
        {
            personalInfoModefy.user_name = self.userName.text;
        }
        [TLBaseTool postWithURL:url param:personalInfoModefy success:^(id result) {
            self.personalInfo = result;
            dispatch_async(dispatch_get_main_queue(), ^{
                TLPersonalMeg *personmeg = [TLPersonalMegTool currentPersonalMeg];
                if ([self.type isEqualToString:@"昵称"]) {
                    personmeg.user_nick_name = self.personalInfo.user_nick_name;
                }
                [TLPersonalMegTool savePersonalMeg:personmeg];
                [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@修改成功",self.type]];
                if ([self.delegate respondsToSelector:@selector(Change_Name_Controller:withType:UserName:)]) {
                    [self.delegate Change_Name_Controller:self withType:self.type UserName:self.userName.text];
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:nil resultClass:[TLPersonalInfo class]];
    }else
    {
        if ([self checkUserIdCard:self.userName.text].length) {
            personalInfoModefy.id_no = self.userName.text;
            [TLBaseTool postWithURL:url param:personalInfoModefy success:^(id result) {
                self.personalInfo = result;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@修改成功",self.type]];
                    if ([self.delegate respondsToSelector:@selector(Change_Name_Controller:withType:UserName:)]) {
                        [self.delegate Change_Name_Controller:self withType:self.type UserName:self.userName.text];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                });
            } failure:nil resultClass:[TLPersonalInfo class]];
        }
    }
}


-(NSString *)checkUserIdCard:(NSString *)idcard
{
    if (idcard.length == 15 || idcard.length == 18) {
        NSString *emailRegex = @"^[0-9]*$";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        bool sfzNo = [emailTest evaluateWithObject:[idcard stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        
        if (idcard.length == 15) {
            if (!sfzNo) {
                [MBProgressHUD showError:@"请输入正确的身份证号"];
            }else
            {
                return idcard;
            }
            
        }
        else if (idcard.length == 18) {
            bool sfz18NO = [self checkIdentityCardNo:idcard];
            if (!sfz18NO) {
                [MBProgressHUD showError:@"请输入正确的身份证号"];
            }else
            {
                return idcard;
            }
        }
    }else{
        [MBProgressHUD showError:@"请输入正确的身份证号"];
    }
    return nil;
}



#pragma mark - 身份证识别
-(BOOL)checkIdentityCardNo:(NSString*)cardNo
{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
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
