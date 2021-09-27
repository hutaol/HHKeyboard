//
//  UIWindow+HHKeyboard.m
//  Pods
//
//  Created by Henry on 2021/9/27.
//

#import "UIWindow+HHKeyboard.h"

@implementation UIWindow (HHKeyboard)

+ (UIWindow *)kb_keyWindow {
    if (@available(iOS 13.0, *)) {
        UIWindow *foundWindow = nil;
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *window in windows) {
            if (window.isKeyWindow) {
                foundWindow = window;
                break;
            }
        }
        if (foundWindow == nil) {
            if (windows.count > 0) {
                foundWindow = windows[0];
            }
        }
        return foundWindow;
    }
    return [UIApplication sharedApplication].keyWindow;
}

+ (UIViewController *)kb_topViewController {
    return [self kb_keyWindow].kb_currentTopViewController;
}

- (UIViewController *)kb_topRootController {
    UIViewController *topController = [self rootViewController];
    
    while ([topController presentedViewController])
        topController = [topController presentedViewController];
    
    return topController;
}

- (UIViewController *)kb_presentedWithController:(UIViewController *)vc {
    while ([vc presentedViewController])
        vc = vc.presentedViewController;
    return vc;
}

- (UIViewController *)kb_currentTopViewController {
    UIViewController *currentViewController = [self kb_topRootController];
    if ([currentViewController isKindOfClass:[UITabBarController class]] && ((UITabBarController *)currentViewController).selectedViewController != nil ) {
        currentViewController = ((UITabBarController *)currentViewController).selectedViewController;
    }
    
    currentViewController = [self kb_presentedWithController:currentViewController];

    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController]) {
        currentViewController = [(UINavigationController*)currentViewController topViewController];
        currentViewController = [self kb_presentedWithController:currentViewController];
    }
    
    currentViewController = [self kb_presentedWithController:currentViewController];

    return currentViewController;
}

@end
