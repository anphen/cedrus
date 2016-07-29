//
//  BaseViewController+Error.h
//  bang5mai
//
//  Created by y on 15/9/23.
//  Copyright © 2015年 xiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Error)
/**
 *  errorView
 *
 *  @param imageName imagename
 *  @param title     title
 *  @param tips      tips
 *  @param block     buttonAction
 */
- (UIView *) showErrorImage:(NSString *) imageName title:(NSString *)title tips:(NSString *) tips block:(voidBlock) block;

- (id) hideErrorView;
@end
