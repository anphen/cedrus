//
//  TLFindPsw.h
//  tongle
//
//  Created by liu on 15-4-23.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface TLFindPsw : JSONModel

@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *verification;

@end
