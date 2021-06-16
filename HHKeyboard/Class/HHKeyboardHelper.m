//
//  HHKeyboardHelper.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/12.
//

#import "HHKeyboardHelper.h"

@implementation HHKeyboardHelper

+ (BOOL)kb_isPad {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

+ (UIWindow *)kb_window {
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

+ (BOOL)kb_isPortrait {
    UIInterfaceOrientation orientation;
    if (@available(iOS 13.0, *)) {
        orientation = [self kb_window].windowScene.interfaceOrientation;
    } else {
        orientation = [UIApplication sharedApplication].statusBarOrientation;
    }
    return UIInterfaceOrientationIsPortrait(orientation);
}

+ (CGFloat)kb_statusBarHeight {
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

+ (CGFloat)kb_navBarHeight {
    return [self kb_isPad] ? 50 : 44;
}

+ (CGFloat)kb_statusNavHeight {
    return [self kb_statusBarHeight] + ([self kb_isPad] ? 50 : 44);
}

+ (CGFloat)kb_topSafeHeight {
    return [self kb_safeAreaInset].top;
}

+ (CGFloat)kb_bottomSafeHeight {
    return [self kb_safeAreaInset].bottom;
}

+ (UIEdgeInsets)kb_safeAreaInset {
    if (@available(iOS 11.0, *)) {
        return [self kb_window].safeAreaInsets;
    } else {
        return UIEdgeInsetsMake(20, 0, 0, 0);
    }
}

@end
