//
//  TLChoiceToManageViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-4.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableView.h"

@class TLChoiceToManageViewController;


@protocol TLChoiceToManageViewControllerDelegate <NSObject>

@optional

-(void)choiceToManageViewControllerDelegate:(TLChoiceToManageViewController *)choiceToManageViewController;

@end

@interface TLChoiceToManageViewController : UIViewController<CustomTableViewDataSource,CustomTableViewDelegate>

@property (nonatomic,strong)    NSMutableArray  *addresses;
@property (nonatomic,strong)    CustomTableView *customTableView;
@property (nonatomic,copy)      NSString        *user_id;
@property (nonatomic,copy)      NSString        *token;
@property (nonatomic,weak)      id<TLChoiceToManageViewControllerDelegate> delegate;


@end
