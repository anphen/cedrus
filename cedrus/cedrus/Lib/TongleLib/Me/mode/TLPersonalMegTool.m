//
//  TLPersonMeg.m
//  tongle
//
//  Created by liu ruibin on 15-4-24.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#define PersonalMegFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"personalmeg.data"]

#import "TLPersonalMegTool.h"
static TLPersonalMeg *_currentPersonalMeg;

@implementation TLPersonalMegTool

+(void)savePersonalMeg:(TLPersonalMeg *)personalmeg
{
    _currentPersonalMeg = personalmeg;
    //归档
    [NSKeyedArchiver archiveRootObject:personalmeg toFile:PersonalMegFilePath];
}

+(TLPersonalMeg *)currentPersonalMeg
{
    if (_currentPersonalMeg == nil) {
        _currentPersonalMeg = [NSKeyedUnarchiver unarchiveObjectWithFile:PersonalMegFilePath];
    }
    return _currentPersonalMeg;
}


@end
