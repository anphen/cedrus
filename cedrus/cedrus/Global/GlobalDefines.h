//
//  GlobalDefines.h
//  cedrus
//
//  Created by X Z on 16/7/20.
//  Copyright © 2016年 LT. All rights reserved.
//

#ifndef GlobalDefines_h
#define GlobalDefines_h

#define STORYBOARD  @"Tongle_Base"

#define TLYES     @"0"

//app内部编号
#define APP_INNER_NO @"01"

//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 判断是否iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kHeightIncrease  (iPhone5 ? 88 : 0)

//判断是否是IOS7系统
#define IS_IOS_7_OR_GREATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define VIEW_Y_START   ((IS_IOS_7_OR_GREATER ) ? 20 : 0)

/*  RGB     */
#define RGB(r, g, b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

/*   颜色设置  */
#define kClearColor                 [UIColor clearColor]        // clear color
#define kRedColor                   [UIColor redColor]          // red color
#define kGreenColor                 [UIColor greenColor]        // green color
#define kBlueColor                  [UIColor blueColor]         // blue color
#define kWhiteColor                 [UIColor whiteColor]        // white color
#define kBlackColor                 [UIColor blackColor]        // black color
#define kGrayColor                  [UIColor grayColor]         // gray color
#define kLightGrayColor             [UIColor lightGrayColor]    // light gray color
#define kOrangeColor                [UIColor orangeColor]       // orange color
#define kDarkTextColor              [UIColor darkTextColor]
#define kDarkGrayColor              [UIColor darkGrayColor]

#define kLoginTitleColor             [UIColor getColor:@"FF5E00"]
#define kButtonGrayColor             [UIColor getColor:@"D9D9D9"]
#define kRedExColor                  [UIColor getColor:@"c91941"]
#define kSectionColor                [UIColor getColor:@"666666"]
#define kTableViewColor              [UIColor getColor:@"606060"]
#define kGridTableViewColor          [UIColor getColor:@"F3F2F2"]
#define kTipsTitleColor              [UIColor getColor:@"aaaaaa"]
#define kCustomRedColor              [UIColor getColor:@"e50000"]
#define kCustomOrangeColor           [UIColor getColor:@"ff841e"]

#define kCustomGroundColor           [UIColor getColor:@"f5f5f5"]
#define kCustomBlackColor            [UIColor getColor:@"333333"]
#define kCustomGrayColor             [UIColor getColor:@"999999"]

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height

//
#ifdef DEBUG
#define LTLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LTLog(...)
#endif

#define LRViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#define LTIsDictionary(obj) [obj isKindOfClass:[NSDictionary class]]

#endif /* GlobalDefines_h */
