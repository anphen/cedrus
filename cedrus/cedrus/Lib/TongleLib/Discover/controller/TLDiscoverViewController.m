//
//  TLDiscoverViewController.m
//  TL11
//
//  Created by liu on 15-4-10.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLDiscoverViewController.h"
#import "TLListenFindViewController.h"
#import "TLSanningViewController.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLSearch.h"
#import "TLSearchViewController.h"
#import "TLImageName.h"
#import "UIImage+TL.h"
#import "UIColor+TL.h"
#import "TLCommon.h"

@interface TLDiscoverViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *find;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *find_key;
@property (nonatomic,copy) NSString *style;

- (IBAction)code:(UIButton *)sender;



@end

@implementation TLDiscoverViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.navigationController.tabBarItem.selectedImage = [UIImage originalImageWithName:TL_DISCOVERY_PRESS];
    
    UIImageView *findImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:TL_SEARCH_ICON]];
    self.find.leftView = findImage;
    self.find.leftViewMode = UITextFieldViewModeAlways;
    self.find.layer.masksToBounds = YES;
    self.find.layer.borderColor = [[UIColor getColor:@"72c6f7"]CGColor];
    self.find.layer.borderWidth = 1.0f;
    self.find.delegate = self;
    
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token =[TLPersonalMegTool currentPersonalMeg].token;

}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    if (self.find.text.length) {
        self.style = @"发现";
        [self performSegueWithIdentifier:TL_SEARCH_SUGUE sender:self.find.text];
        self.find.text = nil;
    }
    return YES;
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
            switch (indexPath.row) {
                case 0:
                    self.style = @"M号";
                    break;
                case 1:
                    self.style = @"M店";
                    break;
                case 2:
                    self.style = @"M品";
                    break;
                case 3:
                    self.style = @"M帖";
                    break;
                default:
                    break;
            }
        [self performSegueWithIdentifier:TL_SEARCH_SUGUE sender:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLSearchViewController class]]) {
        TLSearchViewController *searchView = vc;
        searchView.find_key = sender;
        //searchView.searchModel = sender;
        searchView.style = self.style;
    }else if ([vc isKindOfClass:[TLSanningViewController class]])
    {
        TLSanningViewController *sanningView = vc;
        sanningView.codeType = @"发现";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (IBAction)code:(UIButton *)sender {
}


@end
