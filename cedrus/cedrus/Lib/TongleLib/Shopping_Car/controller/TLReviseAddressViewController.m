//
//  TLReviseAddressViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-12.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLReviseAddressViewController.h"
#import "TLAddress.h"
#import "TLAllAddresses.h"
#import "TLPickerView.h"
#import "JSONKit.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLImageName.h"
#import "MBProgressHUD+MJ.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "TLCommon.h"

@interface TLReviseAddressViewController()<TLPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *consignee;

@property (weak, nonatomic) IBOutlet UITextField *tel;


@property (weak, nonatomic) IBOutlet UITextField *post_code;


@property (weak, nonatomic) IBOutlet UITextField *area;

@property (weak, nonatomic) IBOutlet UITextView *addressDetail;

@property (nonatomic,strong) TLPickerView *pickView;

@property (nonatomic,copy) NSString *province_id;
@property (nonatomic,copy) NSString *city_id;
@property (nonatomic,copy) NSString *area_id;

@property (nonatomic,copy) NSString *currentprovince;
@property (nonatomic,copy) NSString *currentcity;
@property (nonatomic,copy) NSString *currentarea;

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *token;


- (IBAction)delAddress:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *rigthBarButton;


- (IBAction)rigthBarButton:(UIBarButtonItem *)sender;

@end

@implementation TLReviseAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationBar];
    self.consignee.text = self.address.consignee;
    self.tel.text = self.address.tel;
    self.post_code.text = self.address.post_code;
    
    self.currentprovince =self.address.province_name;
    self.currentcity = self.address.city_name;
    self.currentarea = self.address.area_name;
    
    self.province_id = self.address.province_id;
    self.city_id = self.address.city_id;
    self.area_id = self.address.area_id;
    
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
    
    if ([self isNull:self.address.city_name])
    {
    self.area.text = [NSString stringWithFormat:@"%@ %@",self.address.province_name,self.address.area_name];
    }else if ([self isNull:self.address.area_name]) {
    self.area.text = [NSString stringWithFormat:@"%@ %@",self.address.province_name,self.address.city_name];
    }else
    {
    self.area.text = [NSString stringWithFormat:@"%@ %@ %@",self.address.province_name,self.address.city_name,self.address.area_name];
    }
    self.addressDetail.text = self.address.address;
    
    if ([self.address.default_flag isEqualToString:@"0"]) {
        self.navigationItem.title = @"默认收货地址";
    }else
    {
        self.navigationItem.title = self.address.consignee;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
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

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)isNull:(id)object
{
    // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (object==nil){
        return YES;
    }
    return NO;
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

- (IBAction)delAddress:(UIButton *)sender {
}
- (IBAction)rigthBarButton:(UIBarButtonItem *)sender
{
    if (self.consignee.text.length && self.tel.text.length && self.area.text.length && self.addressDetail.text.length) {
        if (self.tel.text.length == 11) {
            NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,address_modify_Url];
           // NSDictionary *dict = @{@"consignee":self.consignee.text,@"tel":self.tel.text,@"province_id":self.province_id,@"city_id":self.city_id,@"area_id":self.area_id,@"address":self.addressDetail.text,@"post_code":self.post_code.text};
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.consignee.text,@"consignee",self.tel.text,@"tel",self.province_id,@"province_id",self.city_id,@"city_id",self.area_id,@"area_id",self.addressDetail.text,@"address",self.post_code.text,@"post_code", nil];
            NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:dict,@"add_info", nil];
            
            NSString *addJson = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:temp options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN,self.address.address_no,@"address_no",addJson,@"add_info_json", nil];
            
            __unsafe_unretained __typeof(self) weakSelf = self;
            [TLHttpTool postWithURL:url params:param success:^(id json) {
                
                [MBProgressHUD showSuccess:TL_ADDRESS_CHANGE_SUCCESS];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
                if ([weakSelf.delegate respondsToSelector:@selector(reviseAddressViewController:withAddress:)]) {
                    weakSelf.address.consignee = weakSelf.consignee.text;
                    weakSelf.address.tel = weakSelf.tel.text;
                    weakSelf.address.province_name = weakSelf.currentprovince;
                    weakSelf.address.province_id = weakSelf.province_id;
                    weakSelf.address.city_name = weakSelf.currentcity;
                    weakSelf.address.city_id = weakSelf.city_id;
                    weakSelf.address.area_name = weakSelf.currentarea;
                    weakSelf.address.area_id = weakSelf.area_id;
                    
                    weakSelf.address.address = weakSelf.addressDetail.text;
                    if (weakSelf.post_code.text.length) {
                        weakSelf.address.post_code = weakSelf.post_code.text;
                    }
                    [weakSelf.delegate reviseAddressViewController:weakSelf withAddress:weakSelf.address];
                }
            } failure:nil];
        
        }else
        {
            [MBProgressHUD showError:TL_IPHONE_NO_FAIL];
        }
    }else
    {
            [MBProgressHUD showError:TL_MESSAGE_FAIL];
    }
    
}



-(void)pickCurrentAddress:(TLPickerView *)pickView
{
    self.area.text = [NSString stringWithFormat:@"%@ %@ %@", pickView.currentProvinces, pickView.currentCities, pickView.currentAreas];
    
    self.currentprovince =pickView.currentProvinces;
    self.currentcity = pickView.currentCities;
    self.currentarea = pickView.currentAreas;
    
    self.province_id = pickView.currentProvince_id;
    self.city_id = pickView.currentCity_id;
    self.area_id = pickView.currentArea_id;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
    if (self.pickView == nil) {
        TLPickerView *pickView = [[TLPickerView alloc]initWithdelegate:self];
        self.pickView = pickView;
        [self.pickView showPickView:self.view];
    }
    return NO;
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
