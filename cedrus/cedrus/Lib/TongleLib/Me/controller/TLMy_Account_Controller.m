//
//  TL_Community_My_Account.m
//  tlcommunity
//
//  Created by jixiaofei-mac on 15-9-1.
//  Copyright (c) 2015年 ilingtong. All rights reserved.
//

#import "TLMy_Account_Controller.h"
#import "TLChange_Name_Controller.h"
#import "TLDatePicker.h"
#import "MLImageCrop.h"
#import "TLImageName.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "UIImageView+Image.h"
#import "TLImageName.h"
#import "TLCommon.h"
#import "TLPersonalInfoModefyRequest.h"
#import "TLBaseTool.h"
#import "Url.h"
#import "TLPersonalInfo.h"
#import "MBProgressHUD+MJ.h"
#import "UIImage+TL.h"
#import "UIImageView+WebCache.h"
#import "TLMe.h"

#define  ScreenBounds [UIScreen mainScreen].bounds
@interface TLMy_Account_Controller ()<UIAlertViewDelegate,UIActionSheetDelegate,TLDatePicker_Delegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MLImageCropDelegate,TLChange_Name_Controller_Delegate>


@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *sex;

@property (weak, nonatomic) IBOutlet UILabel *id_no;

@property (weak, nonatomic) IBOutlet UILabel *changeName;

@property (weak, nonatomic) IBOutlet UISwitch *customs_flag;

- (IBAction)customs_flag_action:(UISwitch *)sender;

@property (nonatomic,weak) TLDatePicker *datepicker;
@property (nonatomic,weak) UIView *coverView;
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,copy) NSString *sign;
@property (nonatomic,weak) UIImageView *groundView;
@property (nonatomic,strong) TLPersonalInfo *personalInfo;

@end

@implementation TLMy_Account_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];

    UIView *blackView = [[UIApplication sharedApplication].windows lastObject];

    
    UIView *coverView = [[UIView alloc]init];
    coverView.backgroundColor =  [UIColor blackColor];
    coverView.frame = blackView.bounds;
    coverView.alpha = 0.0;
    [blackView addSubview:coverView];
    
    
    TLDatePicker *datepicker = [TLDatePicker init];
    datepicker.delegate = self;
    [blackView addSubview:datepicker];
    //[blackView bringSubviewToFront:datepicker];
    
    self.coverView = coverView;
    self.datepicker = datepicker;
    self.datepicker.hidden = YES;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[TLPersonalMegTool currentPersonalMeg].user_head_photo_url] placeholderImage:[UIImage getEllipseImageWithImage:[UIImage imageNamed:TL_AVATAR_DEFAULT]] options:SDWebImageRefreshCached | SDWebImageLowPriority | SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.headImage.image = [UIImage getEllipseImageWithImage:image];
            });
        }
    }];
    _changeName.text = [TLPersonalMegTool currentPersonalMeg].user_nick_name;
    
    if ([[TLPersonalMegTool currentPersonalMeg].user_sex isEqualToString:BOY]) {
        _sex.text = @"男";
    }else
    {
        _sex.text = @"女";
    }
    _userName.text = self.meMeg.user_name;
    if (self.meMeg.user_id_no.length) {
        NSString *id_no = self.meMeg.user_id_no;
        NSString *head_no = [id_no substringToIndex:4];
        NSString *foot_no = [id_no substringFromIndex:id_no.length-4];
        _id_no.text = [NSString stringWithFormat:@"%@********%@",head_no,foot_no];
    }else
    {
        _id_no.text = self.meMeg.user_id_no;
    }
    _customs_flag.on = [self.meMeg.user_customs_flag isEqualToString:@"1"]? YES : NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


-(void)setMeMeg:(TLMe *)meMeg
{
    _meMeg = meMeg;
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            self.sign = @"头像设置";
            UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"我的相册", nil];
            [action showInView:self.tableView];
        }
        break;
        case 1:
        {
            [self performSegueWithIdentifier:@"changeName" sender:@"昵称"];
        }
        break;
        case 2:
        {
            UIAlertView *sex = [[UIAlertView alloc]initWithTitle:@"性别" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
            [sex show];
        }
        break;
        case 3:
        {
             [self performSegueWithIdentifier:@"changeName" sender:@"真实姓名"];
        }
        break;
        case 4:
        {
             [self performSegueWithIdentifier:@"changeName" sender:@"有效证件号"];
        }
        break;
        default:
            break;
    }
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
                self.imagePicker = imagePicker;
                imagePicker.delegate = self;
                imagePicker.sourceType = sourceType;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
        }
        break;
        case 1:
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            self.imagePicker = imagePicker;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    MLImageCrop *imageCrop = [[MLImageCrop alloc]init];
    imageCrop.delegate = self;
    if ([self.sign isEqualToString:@"头像设置"]) {
        imageCrop.ratioOfWidthAndHeight = 280.0f/280.0f;
    }else
    {
        imageCrop.ratioOfWidthAndHeight = 180.0f/320.0f;
    }
    imageCrop.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageCrop showWithAnimation:YES];
}
- (void)cropImage:(UIImage*)cropImage forOriginalImage:(UIImage*)originalImage
{
    if ([self.sign isEqualToString:@"头像设置"]) {
        NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,personal_info_modify];
        
        TLPersonalInfoModefyRequest *personalInfoModefy = [[TLPersonalInfoModefyRequest alloc]init];
        personalInfoModefy.head_photo_binary_data = [self UIImageToBase64Str:cropImage];
        [TLBaseTool postWithURL:url param:personalInfoModefy success:^(id result) {
            self.personalInfo = result;
            dispatch_async(dispatch_get_main_queue(), ^{
                TLPersonalMeg *personmeg = [TLPersonalMegTool currentPersonalMeg];
                personmeg.user_head_photo_url = self.personalInfo.user_photo_url;
                [TLPersonalMegTool savePersonalMeg:personmeg];
                self.headImage.image = [UIImage getEllipseImageWithImage:cropImage];
                [MBProgressHUD showSuccess:@"修改成功"];
            });
        } failure:nil resultClass:[TLPersonalInfo class]];
    }else
    {
        self.groundView.image = cropImage;
    }
    [self imagePickerControllerDidCancel:self.imagePicker];
}

//图片转字符串
-(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 0.7f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,personal_info_modify];
    
    TLPersonalInfoModefyRequest *personalInfoModefy = [[TLPersonalInfoModefyRequest alloc]init];
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"男"]) {
        personalInfoModefy.sex = BOY;
    }else
    {
        personalInfoModefy.sex = GIRL;
    }
    
    [TLBaseTool postWithURL:url param:personalInfoModefy success:^(id result) {
        self.personalInfo = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            TLPersonalMeg *personmeg = [TLPersonalMegTool currentPersonalMeg];
            personmeg.user_sex = self.personalInfo.user_sex;
            [TLPersonalMegTool savePersonalMeg:personmeg];
            self.sex.text = [alertView buttonTitleAtIndex:buttonIndex];
            [MBProgressHUD showSuccess:@"修改成功"];
        });
    } failure:nil resultClass:[TLPersonalInfo class]];
}

-(void)DatePicker:(TLDatePicker *)TLDatePicker withBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    if ([barButtonItem.title isEqualToString:@"确定"]) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
       // self.birthday.text = [dateFormat stringFromDate:[NSDate date]];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.datepicker.frame = CGRectMake(0,ScreenBounds.size.height,ScreenBounds.size.width, 208);
        self.coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.datepicker.hidden = YES;
    }];
}

-(void)Change_Name_Controller:(TLChange_Name_Controller *)Change_Name_Controller withType:(NSString *)type UserName:(NSString *)username
{
    if ([type isEqualToString:@"昵称"]) {
        self.changeName.text = username;
    }else if ([type isEqualToString:@"真实姓名"])
    {
        self.userName.text = username;
    }else{
        NSString *id_no = username;
        NSString *head_no = [id_no substringToIndex:4];
        NSString *foot_no = [id_no substringFromIndex:id_no.length-4];
        self.id_no.text = [NSString stringWithFormat:@"%@********%@",head_no,foot_no];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc  isKindOfClass: [TLChange_Name_Controller class]]) {
        TLChange_Name_Controller *changeName = vc;
        changeName.delegate  = self;
        changeName.userNameString = [self stringWithType:sender];
        changeName.type = sender;
    }
}

-(NSString *)stringWithType:(NSString *)type
{
    NSString *string = nil;
    if ([type isEqualToString:@"昵称"]) {
        string = self.changeName.text;
    }else if ([type isEqualToString:@"真实姓名"])
    {
        string = self.userName.text;
    }else{
        string = self.id_no.text;
    }
    return string;
}


- (IBAction)customs_flag_action:(UISwitch *)sender {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,personal_info_modify];
    TLPersonalInfoModefyRequest *personalInfoModefy = [[TLPersonalInfoModefyRequest alloc]init];
    personalInfoModefy.customs_flag = [sender isOn]? @"1" : @"2";

    [TLBaseTool postWithURL:url param:personalInfoModefy success:^(id result) {
        [MBProgressHUD showSuccess:@"修改成功"];
    } failure:nil resultClass:[TLPersonalInfo class]];
}
@end
