//
//  HHKeyboardView.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/12.
//

#import <UIKit/UIKit.h>
#import "HHKeyboardMoreItem.h"
#import "HHKeyboardFaceGroup.h"
#import "HHKeyboardConfiguration.h"
@class HHKeyboardView;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HHKeyboardState) {
    HHKeyboardStateNormal,      // 初始状态
    HHKeyboardStateVoice,       // 录音状态
    HHKeyboardStateFace,        // 表情状态
    HHKeyboardStateMore,        // 更多状态
    HHKeyboardStateKeyboard,    // 系统键盘弹起状态
};

typedef NS_ENUM(NSInteger, HHKeyboardVoiceState) {
    HHKeyboardVoiceNormal,      // 开始
    HHKeyboardVoiceWillCancel,  // 将取消
    HHKeyboardVoiceCancel,      // 取消
    HHKeyboardVoiceContinue,    // 继续
    HHKeyboardVoiceFinished,    // 完成
};

@protocol HHKeyboardViewDelegate <NSObject>

@optional

/// 高度改变
/// @param keyboard HHKeyboardView
/// @param height 高度
- (void)keyboard:(HHKeyboardView *)keyboard didChangeHeight:(CGFloat)height;

/// 点击更多Item
/// @param keyboard HHKeyboardView
/// @param moreItem HHKeyboardMoreItem
- (void)keyboard:(HHKeyboardView *)keyboard didSelectMoreItem:(HHKeyboardMoreItem *)moreItem;

/// 录音状态
/// @param keyboard HHKeyboardView
/// @param state 录音状态
- (void)keyboard:(HHKeyboardView *)keyboard voiceState:(HHKeyboardVoiceState)state;

/// 除含有 @ 字符的委托（比如删除 @xxx）
/// @param keyboard HHKeyboardView
/// @param text atText
- (void)keyboard:(HHKeyboardView *)keyboard didDeleteAt:(NSString *)text;

/// 输入含有 @ 字符的委托
/// @param keyboard HHKeyboardView
- (void)keyboardDidInputAt:(HHKeyboardView *)keyboard;

/// 发送文本消息时的回调委托
/// @param keyboard HHKeyboardView
/// @param text 文本消息
- (void)keyboard:(HHKeyboardView *)keyboard sendText:(NSString *)text;

@end

@interface HHKeyboardView : UIView

@property (nonatomic, weak) id<HHKeyboardViewDelegate> delegate;

/// 是否使用录音，默认显示
@property (nonatomic, assign) BOOL showVoice;
/// 是否使用表情，默认显示
@property (nonatomic, assign) BOOL showFace;
/// 是否使用更多，默认显示
@property (nonatomic, assign) BOOL showMore;

/// 文本最大长度 默认0无限制
@property (nonatomic, assign) NSInteger maxLength;
/// 最大高度
@property (nonatomic, assign) CGFloat maxHeight;

/// 当前键盘状态
@property (nonatomic, assign) HHKeyboardState currentState;

/// 赋值有效，更改属性无效
@property (nonatomic, strong) HHKeyboardConfiguration *configuration;

- (void)setText:(NSString *)text;
- (NSString *)getText;

/// 收起键盘
- (void)dismissKeyboard;

/// 配置布局，展示在底部的输入框，父视图尺寸改变时，可用于初始化设置布局，屏幕旋转
/// @param size 父视图尺寸
- (void)configLayout:(CGSize)size;

/// 设置Frame，以输入框和self.superview.frame做为标准
/// 添加后设置布局，展示在底部的输入框
- (void)setFrameToBottom;

/// 设置更多
- (void)setMoreItems:(NSMutableArray <HHKeyboardMoreItem *> *)items;
/// 设置表情
- (void)setFaceGroups:(NSMutableArray <HHKeyboardFaceGroup *> *)groups;

@end

NS_ASSUME_NONNULL_END
