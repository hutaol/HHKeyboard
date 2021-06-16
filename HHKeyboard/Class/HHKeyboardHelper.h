//
//  HHKeyboardHelper.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHKeyboardHelper : NSObject

/// 是否Pad
+ (BOOL)kb_isPad;

/// 窗口
+ (UIWindow *)kb_window;

/// 是否竖屏
+ (BOOL)kb_isPortrait;

/// 状态栏高度 iPhoneX：34 其他：20
+ (CGFloat)kb_statusBarHeight;

/// 导航栏高度 iPad：50 iPhone：44
+ (CGFloat)kb_navBarHeight;

/// 状态栏高度+导航栏高度
+ (CGFloat)kb_statusNavHeight;

/// 顶部安全高度 iPhoneX：44 其他：20
+ (CGFloat)kb_topSafeHeight;

/// 底部安全高度 iPhoneX：34 其他：0
+ (CGFloat)kb_bottomSafeHeight;

/// 安全区域
+ (UIEdgeInsets)kb_safeAreaInset;


@end

NS_ASSUME_NONNULL_END
