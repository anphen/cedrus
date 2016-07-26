//
//  TLPersonMeg.h
//  tongle
//
//  Created by liu on 15-4-24.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLPersonalMeg;

@interface TLPersonalMegTool : NSObject

+(void)savePersonalMeg:(TLPersonalMeg *)personalmeg;
+(TLPersonalMeg *)currentPersonalMeg;

@end
