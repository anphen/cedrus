//
//  TLSanningViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-27.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLSanningViewController;

@protocol TLSanningViewControllerDelagate <NSObject>

-(void)sanningViewControllerDelagate:(TLSanningViewController *)sanningView userPhone:(NSString *)phone;

@end

@interface TLSanningViewController : UIViewController

@property (nonatomic,assign)BOOL isReading;
@property (nonatomic,copy) NSString *codeType;
@property (nonatomic,strong) NSDictionary *userData;

@property (nonatomic,assign) id <TLSanningViewControllerDelagate>delegate;
@end
