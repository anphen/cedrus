//
//  BlockDefines.h
//  korea
//
//  Created by boguang on 15/6/26.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#ifndef korea_BlockDefines_h
#define korea_BlockDefines_h


typedef void (^voidBlock)();
typedef void (^idBlock)( id content);
typedef void (^idRangeBlock)( id content1, id content2);
typedef void (^idBOOLBlock)( id content, BOOL direction);
typedef void (^idErrorBlock)( id content1, NSError *error);
typedef void (^boolBlock)(BOOL finised);
typedef void (^intBlock)(int flag);
typedef void (^intIdBlock)(int type , id content);
typedef void (^intBoolBlock)(int type , BOOL flag);
typedef void (^FloatBlock) (CGFloat content);
#endif
