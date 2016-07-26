//
//  TLsettingitem.h
//  tongle
//
//  Created by ruibin liu on 15/6/20.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLsettingitem : NSObject

@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) Class vcClass;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title vcClass:(Class) vcClass;

@end
