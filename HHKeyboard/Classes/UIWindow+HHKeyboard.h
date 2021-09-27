//
//  UIWindow+HHKeyboard.h
//  Pods
//
//  Created by Henry on 2021/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (HHKeyboard)

- (UIViewController *)kb_currentTopViewController;

+ (UIWindow *)kb_keyWindow;

+ (UIViewController *)kb_topViewController;

@end

NS_ASSUME_NONNULL_END
