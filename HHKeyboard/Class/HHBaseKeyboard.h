//
//  HHBaseKeyboard.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/12.
//

#import <UIKit/UIKit.h>
@class HHBaseKeyboard;

NS_ASSUME_NONNULL_BEGIN

@protocol HHKeyboardProtocol <NSObject>

@required
- (CGFloat)keyboardHeight;

@end

@protocol HHKeyboardDelegate <NSObject>

@optional
- (void)keyboardWillShow:(HHBaseKeyboard *)keyboard animated:(BOOL)animated;

- (void)keyboardDidShow:(HHBaseKeyboard *)keyboard animated:(BOOL)animated;

- (void)keyboardWillDismiss:(HHBaseKeyboard *)keyboard animated:(BOOL)animated;

- (void)keyboardDidDismiss:(HHBaseKeyboard *)keyboard animated:(BOOL)animated;

- (void)keyboard:(HHBaseKeyboard *)keyboard didChangeHeight:(CGFloat)height;

@end

@interface HHBaseKeyboard : UIView <HHKeyboardProtocol>

/// 是否正在展示
@property (nonatomic, assign, readonly) BOOL isShow;

/// 事件回调
@property (nonatomic, weak) id<HHKeyboardDelegate> keyboardDelegate;

/// 显示键盘(在keyWindow上)
/// @param animation 是否显示动画
- (void)showWithAnimation:(BOOL)animation;

/// 显示键盘
/// @param view 父view
/// @param animation 是否显示动画
- (void)showInView:(UIView *)view withAnimation:(BOOL)animation;

/// 键盘消失
/// @param animation 是否显示消失动画
- (void)dismissWithAnimation:(BOOL)animation;

/// 重置键盘
- (void)reset;

@end

NS_ASSUME_NONNULL_END
