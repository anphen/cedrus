//
//  GetVersion.h
//  korea
//
//  Created by y on 15/11/13.
//  Copyright © 2015年 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKRequest.h>

@interface GetVersion : NSObject

+(instancetype) sharedInstance;

- (void) checkVersion;

@end



@interface GetVersionApi : YTKRequest

@end
