//
//  HHKeyboardHelper.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/12.
//

#import "HHKeyboardHelper.h"
#import "UIWindow+HHKeyboard.h"

@implementation HHKeyboardHelper

+ (BOOL)kb_isPad {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

+ (BOOL)kb_isPortrait {
    UIInterfaceOrientation orientation;
    if (@available(iOS 13.0, *)) {
        orientation = [UIWindow kb_keyWindow].windowScene.interfaceOrientation;
    } else {
        orientation = [UIApplication sharedApplication].statusBarOrientation;
    }
    return UIInterfaceOrientationIsPortrait(orientation);
}

+ (CGFloat)kb_statusBarHeight {
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

+ (CGFloat)kb_navBarHeight {
    return [UIWindow kb_topViewController].navigationController.navigationBar.frame.size.height;
}

+ (CGFloat)kb_statusNavHeight {
    return [self kb_statusBarHeight] + [self kb_navBarHeight];
}

+ (CGFloat)kb_topSafeHeight {
    return [self kb_safeAreaInset].top;
}

+ (CGFloat)kb_bottomSafeHeight {
    return [self kb_safeAreaInset].bottom;
}

+ (UIEdgeInsets)kb_safeAreaInset {
    if (@available(iOS 11.0, *)) {
        return [UIWindow kb_keyWindow].safeAreaInsets;
    } else {
        return UIEdgeInsetsMake(20, 0, 0, 0);
    }
}

@end
