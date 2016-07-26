//
//  TLCreateAddressViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-6.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLCreateAddressViewController.h"
#import "TLAddress.h"
#import "TLAllAddresses.h"
#import "TLPickerView.h"
#import "JSONKit.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLValidataTool.h"
#import "TLImageName.h"
#import "Url.h"
#import "MBProgressHUD+MJ.h"
#import "TLHttpTool.h"
#import "TLCommon.h"
#import "MJExtension.h"


@interface TLCreateAddressViewController ()<TLPickerViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) TLPickerView *pickView;

@property (nonatomic,copy) NSString *province_id;
@property (nonatomic,copy) NSString *city_id;
@property (nonatomic,copy) NSString *currentarea_id;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *token;

@property (nonatomic,strong) TLAddress *addressmodel;

@end


@implementation TLCreateAddressViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
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

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pickCurrentAddress:(TLPickerView *)pickView
{
    self.prov_city_area.text = [NSString stringWithFormat:@"%@ %@ %@", pickView.currentProvinces, pickView.currentCities, pickView.currentAreas];
    self.province_id = pickView.currentProvince_id;
    self.city_id = pickView.currentCity_id;
    self.currentarea_id = pickView.currentArea_id;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
    if (self.pickView == nil) {
        TLPickerView *pickView = [[TLPickerView alloc]initWithdelegate:self];
        self.pickView = pickView;
        [self.pickView showPickView:self.view];
        [self pickCurrentAddress:self.pickView];
    }
    return NO;
}

- (IBAction)save:(UIBarButtonItem *)sender {
    if (self.consignee.text.length && self.tel.text.length && self.address.text.length && self.prov_city_area.text.length) {
        if ([TLValidataTool checkPhoneNumInput:self.tel.text]) {
            if ([TLValidataTool isValidZipcode:self.area_id.text] && self.area_id.text.length) {
                NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,address_create_Url];
                NSDictionary *dict = [NSDictionary dictionary];
                dict = @{@"consignee":self.consignee.text,@"tel":self.tel.text,@"province_id":self.province_id,@"city_id":self.city_id,@"area_id":self.currentarea_id,@"address":self.address.text,@"post_code":self.area_id.text};

                NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:dict,@"add_info", nil];
                
                NSString *addJson = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:temp options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
                
                NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN,addJson,@"add_info_json", nil];
                __unsafe_unretained __typeof(self) weakSelf = self;
                [TLHttpTool postWithURL:url params:param success:^(id json) {
                    TLAllAddresses *addresslist = [TLAllAddresses objectWithKeyValues:json[@"body"]];
                    [NSKeyedArchiver archiveRootObject:addresslist.my_address_list toFile:TLAddressDataFilePath];
                    
                    [MBProgressHUD showSuccess:TL_ADDRESS_CREATE_SUCCESS];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    
                    if ([weakSelf.delegate respondsToSelector:@selector(createAddressViewController:WithAddress:)]) {
                        [weakSelf.delegate createAddressViewController:weakSelf WithAddress:addresslist.my_address_list];
                    }
                } failure:nil];
                

            }else if(self.area_id.text.length == 0)
            {
                
                NSString *url= [NSString stringWithFormat:@"%@,%@,%@",Url,[TLPersonalMegTool currentPersonalMeg].token,address_create_Url];
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.consignee.text,@"consignee",self.tel.text,@"tel",self.province_id,@"province_id",self.city_id,@"city_id",self.currentarea_id,@"area_id",self.address.text,@"address",@"",@"post_code",nil];
                NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:dict,@"add_info", nil];
                
                 NSString *addJson = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:temp options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
                
                NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN,addJson,@"add_info_json", nil];
                __unsafe_unretained __typeof(self) weakSelf = self;
                [TLHttpTool postWithURL:url params:param success:^(id json) {
                    TLAllAddresses *addresslist = [TLAllAddresses objectWithKeyValues:json[@"body"]];
                    [NSKeyedArchiver archiveRootObject:addresslist.my_address_list toFile:TLAddressDataFilePath];
                    
                    [MBProgressHUD showSuccess:TL_ADDRESS_CREATE_SUCCESS];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    
                    if ([weakSelf.delegate respondsToSelector:@selector(createAddressViewController:WithAddress:)]) {
                        [weakSelf.delegate createAddressViewController:weakSelf WithAddress:addresslist.my_address_list];
                    }
                } failure:nil];

            }else
            {
                 [MBProgressHUD showError:TL_ADDRESS_CODE_FAIL];
            }
        }else
        {
            [MBProgressHUD showError:TL_IPHONE_NO_FAIL];
        }
    }else
    {
        [MBProgressHUD showError:TL_MESSAGE_FAIL];
    }

    
}

-(void)keyboardWillShow
{
    [self cancelLocatePicker];
}

-(void)cancelLocatePicker
{
    [self.pickView hidePickView:self.view];
    self.pickView.delegate = nil;
    self.pickView = nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
     [self.view endEditing:YES];
    [self cancelLocatePicker];
}

@end
