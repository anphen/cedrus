//
//  TLChange_Name_Controller.h
//  tongle
//
//  Created by jixiaofei-mac on 15-9-9.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TLChange_Name_Controller;
@protocol TLChange_Name_Controller_Delegate <NSObject>

@optional

-(void)Change_Name_Controller:(TLChange_Name_Controller *)Change_Name_Controller withType:(NSString *)type UserName:(NSString *)username ;

@end

@interface TLChange_Name_Controller : UIViewController
@property (nonatomic,copy) NSString *userNameString;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,assign) id<TLChange_Name_Controller_Delegate>delegate;

@end
