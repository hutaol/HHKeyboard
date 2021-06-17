//
//  HHKeyboardView.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/12.
//

#import "HHKeyboardView.h"
#import "HHKeyboardTextView.h"
#import "HHKeyboardMoreView.h"
#import "HHKeyboardFaceView.h"
#import "HHKeyboardResources.h"
#import "HHKeyboardHelper.h"
#import "UIButton+HHKeyboard.h"
#import "UIColor+HHKeyboard.h"

#define kHorizenSpace            10.f   // 水平间隔
#define kVerticalSpace           8.f    // 垂直间隔
#define kAnimateDuration         0.25   // 动画间隔

@interface HHKeyboardView () <UITextViewDelegate, HHKeyboardDelegate, HHKeyboardFaceViewDelegate, HHKeyboardMoreViewDelegate>
{
    UIImage *kVoiceImage;
    UIImage *kVoiceImageHL;
    UIImage *kFaceImage;
    UIImage *kFaceImageHL;
    UIImage *kMoreImage;
    UIImage *kMoreImageHL;
    UIImage *kKeyboardImage;
    UIImage *kKeyboardImageHL;
    
    CGFloat _initialHeight;
    
}

@property (nonatomic, strong) UIView *topLineView;

@property (nonatomic, strong) UIButton *voiceButton;
@property (nonatomic, strong) UIButton *faceButton;
@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) HHKeyboardTextView *textView;
@property (nonatomic, strong) UIButton *recordButton;


@property (nonatomic, strong) HHKeyboardMoreView *moreView;
@property (nonatomic, strong) HHKeyboardFaceView *faceView;

// textView宽度
@property (nonatomic, assign) CGFloat textViewWidth;
@property (nonatomic, assign) CGFloat textViewHeight;

@end

@implementation HHKeyboardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_init];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_init];
    }
    return self;
}

- (void)p_initImage {
    kVoiceImage = [HHKeyboardResources getImageFromKeyboard:@"icon_keyboard_voice_nor"];
    kVoiceImageHL = [HHKeyboardResources getImageFromKeyboard:@"icon_keyboard_voice_press"];
    kFaceImage = [HHKeyboardResources getImageFromKeyboard:@"icon_keyboard_face_nor"];
    kFaceImageHL = [HHKeyboardResources getImageFromKeyboard:@"icon_keyboard_face_press"];
    kMoreImage = [HHKeyboardResources getImageFromKeyboard:@"icon_keyboard_add_nor"];
    kMoreImageHL = [HHKeyboardResources getImageFromKeyboard:@"icon_keyboard_add_press"];
    kKeyboardImage = [HHKeyboardResources getImageFromKeyboard:@"icon_keyboard_keyboard_nor"];
    kKeyboardImageHL = [HHKeyboardResources getImageFromKeyboard:@"icon_keyboard_keyboard_press"];
}

- (void)p_init {
    [self p_initImage];
    _currentState = HHKeyboardStateNormal;
    _showFace = YES;
    _showVoice = YES;
    _showMore = YES;
    _maxLength = 0;
    _maxHeight = 112.f;
    
    [self setupUI];
    
    _textViewHeight = _initialHeight;

    [self defautLayout];
    
    self.configuration = [[HHKeyboardConfiguration alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)setupUI {
    [self addSubview:self.textView];
    [self addSubview:self.recordButton];
    [self addSubview:self.voiceButton];
    [self addSubview:self.faceButton];
    [self addSubview:self.moreButton];
    [self addSubview:self.topLineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    [self defautLayout];
}

- (void)defautLayout {
    
    CGFloat width = self.frame.size.width;
    
    self.textViewWidth = width - (5 * kHorizenSpace ) - (3 * _initialHeight);
    CGFloat vHeight = self.textViewHeight;
    if (self.currentState == HHKeyboardStateVoice) {
        vHeight = _initialHeight;
    }
    
    if (self.showVoice) {
        self.voiceButton.frame = CGRectMake(kHorizenSpace, vHeight + kVerticalSpace - _initialHeight, _initialHeight, _initialHeight);
    } else {
        self.voiceButton.frame = CGRectZero;
        self.textViewWidth += (_initialHeight + kHorizenSpace);
    }

    if (self.showMore) {
        self.moreButton.frame = CGRectMake(width - kHorizenSpace - _initialHeight, vHeight + kVerticalSpace - _initialHeight, _initialHeight, _initialHeight);
    } else {
        self.moreButton.frame = CGRectZero;
        self.textViewWidth += (_initialHeight + kHorizenSpace);
    }

    if (self.showFace) {
        if (self.showMore) {
            self.faceButton.frame = CGRectMake(width - (kHorizenSpace + _initialHeight) * 2, vHeight + kVerticalSpace - _initialHeight, _initialHeight, _initialHeight);
        } else {
            self.faceButton.frame = CGRectMake(width - kHorizenSpace - _initialHeight, vHeight + kVerticalSpace - _initialHeight, _initialHeight, _initialHeight);
        }
    } else {
        self.faceButton.frame = CGRectZero;
        self.textViewWidth += (_initialHeight + kHorizenSpace);
    }
    
    self.textView.frame = CGRectMake(CGRectGetMaxX(self.voiceButton.frame) + kHorizenSpace, kVerticalSpace, self.textViewWidth, self.textViewHeight);

    self.recordButton.frame = CGRectMake(CGRectGetMinX(self.textView.frame), CGRectGetMinY(self.textView.frame), self.textView.frame.size.width, _initialHeight);
    
    self.topLineView.frame = CGRectMake(0, 0, self.frame.size.width, 1/[UIScreen mainScreen].scale);
}

#pragma mark - NSNotification

- (void)keyboardWillChange:(NSNotification *)noti {
    CGFloat height = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;

    if (noti.name == UIKeyboardWillShowNotification) {
        self.currentState = HHKeyboardStateKeyboard;
        [self p_keyboardChangeHeight:height];
    }
}

#pragma mark - Public Methods

- (NSString *)getText {
    return self.textView.text;
}

- (void)setText:(NSString *)text {
    self.textView.text = text;
    [self p_reloadTextViewWithAnimation:YES];
}

- (void)setMoreItems:(NSMutableArray<HHKeyboardMoreItem *> *)items {
    self.moreView.keyboardMoreData = items;
}

- (void)setFaceGroups:(NSMutableArray<HHKeyboardFaceGroup *> *)groups {
    self.faceView.dataArray = groups;
}

- (void)dismissKeyboard {
    if (self.currentState == HHKeyboardStateVoice) {
        return;
    }
    self.currentState = HHKeyboardStateNormal;
}

- (void)configLayout:(CGSize)size {
    CGFloat height = self.superview.frame.size.height - self.frame.origin.y;
    self.frame = CGRectMake(0, size.height - height, size.width, height);
    [self defautLayout];
    if (self.currentState == HHKeyboardStateMore) {
        [self.moreView reset];
    } else if (self.currentState == HHKeyboardStateFace) {
        [self.faceView reset];
    }
}

- (void)resetFrame {
    CGFloat height = [self p_textBarHeight] + [HHKeyboardHelper kb_bottomSafeHeight];
    self.frame = CGRectMake(0, self.superview.frame.size.height - height, self.superview.frame.size.width, height);
    [self defautLayout];
}

#pragma mark - Private Methods

- (void)p_reloadTextViewWithAnimation:(BOOL)animation {
    // 表情
    if (self.showFace) {
       [self.faceView showButton:(self.textView.text.length > 0)];
    }
    
    // 获取textView最佳高度

    CGFloat textHeight = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, MAXFLOAT)].height;
    // 向上取整
    textHeight = ceilf(textHeight);

    CGFloat height = MIN(textHeight, _maxHeight);
    [self.textView setScrollEnabled:textHeight > height];
    
    CGFloat viewHeight = ceilf(self.textView.frame.size.height);

    if (height != viewHeight) {
        if (animation) {
            [UIView animateWithDuration:0.2 animations:^{
                
                CGFloat changeHeight = height - viewHeight;
                CGRect viewRect = self.textView.frame;
                viewRect.size.height = height;
                self.textView.frame = viewRect;
                
                self.textViewHeight = height;

                [self p_changeTextViewHeight:changeHeight];

            } completion:^(BOOL finished) {
                if (textHeight > height) {
                    [self.textView setContentOffset:CGPointMake(0, textHeight - height) animated:YES];
                }
            }];
        } else {
            CGFloat changeHeight = height - viewHeight;
            CGRect viewRect = self.textView.frame;
            viewRect.size.height = height;
            self.textView.frame = viewRect;

            if (textHeight > height) {
                [self.textView setContentOffset:CGPointMake(0, textHeight - height) animated:YES];
            }
            
            [self p_changeTextViewHeight:changeHeight];
        }
    } else if (textHeight > height) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.textView setContentOffset:CGPointMake(0, self.textView.contentSize.height - self.textView.frame.size.height) animated:animation];
        });
    }
}

- (void)p_sendText {
    // TODO 最大长度
    if (_maxLength > 0 && self.textView.text.length > _maxLength) {
//        NSString *text = [NSString stringWithFormat:@"超过最大文本长度%ld", _maxLength];
//        [HHToastTool showAtTop:text];
        return;
    }
    
    if (self.textView.text.length > 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(keyboard:sendText:)]) {
            [_delegate keyboard:self sendText:self.textView.text];
        }
    }
    
    self.textView.text = @"";
    [self p_reloadTextViewWithAnimation:YES];
}

- (void)p_updateTextViewLocation:(NSInteger)location {
    self.textView.selectedRange = NSMakeRange(location, 0);
    [self p_reloadTextViewWithAnimation:YES];
}

- (BOOL)p_deleteText:(UITextView *)textView range:(NSRange)range {
    if (textView.text.length <= range.location) {
        return NO;
    }
    if ([textView.text characterAtIndex:range.location] == ']') { // 一次性删除 [微笑] 这种表情消息
        NSUInteger location = range.location;
        NSUInteger length = range.length;
        int left = 91;     // '[' 对应的ascii码
        int right = 93;    // ']' 对应的ascii码
        while (location != 0) {
            location --;
            length ++;
            // 将字符转换成ascii码，复制给int 避免越界
            int c = (int)[textView.text characterAtIndex:location];
            if (c == left) {
                // 替换会改变原有的selectedRange位置
                textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                
                [self p_updateTextViewLocation:location];
                return NO;
            } else if (c == right) {
                return YES;
            }
        }
    } else if ([textView.text characterAtIndex:range.location] == ' ') { // 一次性删除 @xxx 这种 @ 消息

        NSUInteger location = range.location;
        NSUInteger length = range.length;
        int at = 64;    // '@' 对应的ascii码
        while (location != 0) {
            location --;
            length ++ ;
            int c = (int)[textView.text characterAtIndex:location]; // 将字符转成ascii码，复制给int,避免越界
            if (c == at) {
                NSString *atText = [textView.text substringWithRange:NSMakeRange(location, length)];
                textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                
                [self p_updateTextViewLocation:location];

                if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:didDeleteAt:)]) {
                    [self.delegate keyboard:self didDeleteAt:atText];
                }
                return NO;
            }
        }
    } else {
        [textView deleteBackward];
        return NO;
    }
    return YES;
}

- (void)p_keyboardChangeHeight:(CGFloat)height {

    CGRect rect = self.frame;
    height = MAX(height, [HHKeyboardHelper kb_bottomSafeHeight]);
    CGFloat textBarHeight = [self p_textBarHeight];
    rect.size.height = textBarHeight;
    rect.origin.y = self.superview.frame.size.height - height - textBarHeight;
    
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
    }];
    
    [self p_changeHeight:height];

}

- (void)p_changeTextViewHeight:(CGFloat)height {
    
    CGRect rect = self.frame;
    rect.size.height += height;
    rect.origin.y -= height;
    self.frame = rect;
    
    [self defautLayout];
    
    if (self.currentState == HHKeyboardStateFace) {
        CGRect faceRect = self.faceView.frame;
        faceRect.origin.y += height;
        self.faceView.frame = faceRect;
    }
    
    [self p_changeHeight:height];
}

- (void)p_changeHeight:(CGFloat)height {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:didChangeHeight:)]) {
        [self.delegate keyboard:self didChangeHeight:height];
    }
}

- (CGFloat)p_textBarHeight {
    return self.textView.frame.size.height + 2 * kVerticalSpace;
}

- (void)p_resetVoice {
    CGFloat height = _initialHeight + 2 * kVerticalSpace + [HHKeyboardHelper kb_bottomSafeHeight];
    CGRect rect = self.frame;
    rect.size.height = height;
    rect.origin.y = self.superview.frame.size.height - height;
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.frame = rect;
    }];
    [self p_changeHeight:height];
}

- (void)p_reset {
    CGFloat height = [self p_textBarHeight] + [HHKeyboardHelper kb_bottomSafeHeight];
    CGRect rect = self.frame;
    rect.size.height = height;
    rect.origin.y = self.superview.frame.size.height - height;
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.frame = rect;
    }];
    [self p_changeHeight:height];
}

#pragma mark - On Action && Click

- (void)onClickVoiceButton:(UIButton *)sender {
    if (self.currentState == HHKeyboardStateVoice) {
        self.currentState = HHKeyboardStateKeyboard;
    } else {
        self.currentState = HHKeyboardStateVoice;
    }
}

- (void)onClickFaceButton:(UIButton *)sender {
    if (self.currentState == HHKeyboardStateFace) {
        self.currentState = HHKeyboardStateKeyboard;
    } else {
        self.currentState = HHKeyboardStateFace;
    }
}

- (void)onClickMoreButton:(UIButton *)sender {
    if (self.currentState == HHKeyboardStateMore) {
        self.currentState = HHKeyboardStateKeyboard;
    } else {
        self.currentState = HHKeyboardStateMore;
    }
}

- (void)onBeginRecordVoice:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:voiceState:)]) {
        [self.delegate keyboard:self voiceState:HHKeyboardVoiceNormal];
    }
}

- (void)onEndRecordVoice:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:voiceState:)]) {
        [self.delegate keyboard:self voiceState:HHKeyboardVoiceFinished];
    }
}

- (void)onCancelRecordVoice:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:voiceState:)]) {
        [self.delegate keyboard:self voiceState:HHKeyboardVoiceCancel];
    }
}

- (void)onRemindDragExit:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:voiceState:)]) {
        [self.delegate keyboard:self voiceState:HHKeyboardVoiceWillCancel];
    }
}

- (void)onRemindDragEnter:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:voiceState:)]) {
        [self.delegate keyboard:self voiceState:HHKeyboardVoiceContinue];
    }
}


#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.currentState = HHKeyboardStateKeyboard;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self p_reloadTextViewWithAnimation:YES];
}

- (void)textViewDidChange:(UITextView *)textView {
    [self p_reloadTextViewWithAnimation:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) { // 发送
        [self p_sendText];
        return NO; // 这样才不会出现换行
    } else if ([text isEqualToString:@""]) { // 删除
        return [self p_deleteText:textView range:range];
    } else if ([text isEqualToString:@"@"]) { // 监听 @ 字符的输入
        if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardDidInputAt:)]) {
            [self.delegate keyboardDidInputAt:self];
        }
    }
    return YES;
}

#pragma mark - HHKeyboardDelegate

- (void)keyboardWillShow:(HHBaseKeyboard *)keyboard animated:(BOOL)animated {
    CGFloat height = [self p_textBarHeight] + keyboard.keyboardHeight;
    CGRect rect = self.frame;
    rect.size.height = height;
    rect.origin.y = self.superview.frame.size.height - height;
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.frame = rect;
    }];
    [self p_changeHeight:height];
}

#pragma mark - HHKeyboardFaceViewDelegate

- (void)keyboardFace:(HHKeyboardFaceView *)view didSelectItem:(HHKeyboardFaceItem *)item {
    NSRange range = self.textView.selectedRange;
    
    self.textView.text = [self.textView.text stringByReplacingCharactersInRange:self.textView.selectedRange withString:item.name];
    NSInteger location = range.location + item.name.length;
    [self p_updateTextViewLocation:location];
}

- (void)keyboardFaceDelete:(HHKeyboardFaceView *)view {
    [self p_deleteText:self.textView range:NSMakeRange(self.textView.selectedRange.location - 1, 1)];
}

- (void)keyboardFaceSend:(HHKeyboardFaceView *)view {
    [self p_sendText];
}

#pragma mark - HHKeyboardMoreViewDelegate

- (void)keyboardMore:(HHKeyboardMoreView *)keyboard didSelectItem:(HHKeyboardMoreItem *)item {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:didSelectMoreItem:)]) {
        [self.delegate keyboard:self didSelectMoreItem:item];
    }
}

#pragma mark - Setters

- (void)setCurrentState:(HHKeyboardState)currentState {
    if (_currentState == currentState) {
        return;
    }
    
    switch (_currentState) {
        case HHKeyboardStateNormal:
        {

        }
            break;
        case HHKeyboardStateVoice:
        {
            [self.voiceButton kb_setImage:kVoiceImage imageHL:kVoiceImageHL];
            self.recordButton.hidden = YES;
            self.textView.hidden = NO;
        }
            break;
        case HHKeyboardStateFace:
        {
            [self.faceButton kb_setImage:kFaceImage imageHL:kFaceImageHL];
            [self.faceView dismissWithAnimation:YES];
        }
            break;
        case HHKeyboardStateMore:
        {
            [self.moreButton kb_setImage:kMoreImage imageHL:kMoreImageHL];
            [self.moreView dismissWithAnimation:YES];

        }
            break;
        case HHKeyboardStateKeyboard:
        {
            [self.textView resignFirstResponder];
        }
            break;
            
        default:
            break;
    }

    switch (currentState) {
        case HHKeyboardStateNormal:
        {
            [self p_reset];
        }
            break;
        case HHKeyboardStateVoice:
        {
            [self.voiceButton kb_setImage:kKeyboardImage imageHL:kKeyboardImageHL];
            self.recordButton.hidden = NO;
            self.textView.hidden = YES;
            [self p_resetVoice];
            
        }
            break;
        case HHKeyboardStateFace:
        {
            [self.faceButton kb_setImage:kKeyboardImage imageHL:kKeyboardImageHL];
            [self.faceView showInView:self withAnimation:YES];
        }
            break;
        case HHKeyboardStateMore:
        {
            [self.moreButton kb_setImage:kKeyboardImage imageHL:kKeyboardImageHL];
            [self.moreView showInView:self withAnimation:YES];
        }
            break;
        case HHKeyboardStateKeyboard:
        {
            self.textView.hidden = NO;
            [self.textView becomeFirstResponder];
        }
            break;
            
        default:
            break;
    }
    
    _currentState = currentState;
    
    [self defautLayout];

}

- (void)setShowFace:(BOOL)showFace {
    _showFace = showFace;
    self.faceButton.hidden = !showFace;
    [self defautLayout];
}

- (void)setShowVoice:(BOOL)showVoice {
    _showVoice = showVoice;
    self.voiceButton.hidden = !showVoice;
    [self defautLayout];
}

- (void)setShowMore:(BOOL)showMore {
    _showMore = showMore;
    self.moreButton.hidden = !showMore;
    [self defautLayout];
}

- (void)setConfiguration:(HHKeyboardConfiguration *)configuration {
    _configuration = configuration;
    self.backgroundColor = configuration.bgColor;
    
    self.topLineView.backgroundColor = configuration.borderColor;
    
    self.textView.backgroundColor = configuration.inputColor;
    self.textView.layer.borderColor = configuration.borderColor.CGColor;
    
    self.recordButton.layer.borderColor = configuration.borderColor.CGColor;
    [self.recordButton setTitleColor:configuration.textColor forState:UIControlStateNormal];
    self.recordButton.backgroundColor = configuration.inputColor;
    [self.recordButton setTitle:configuration.recordTitle forState:UIControlStateNormal];
    [self.recordButton setTitle:configuration.recordHLTitle forState:UIControlStateHighlighted];
    
    self.textView.font = configuration.textFont;
    self.recordButton.titleLabel.font = configuration.textFont;
    _initialHeight = ceilf([self.textView sizeThatFits:CGSizeMake(0, MAXFLOAT)].height);
    [self defautLayout];

}

#pragma mark - Getters

- (HHKeyboardTextView *)textView {
    if (!_textView) {
        _textView = [[HHKeyboardTextView alloc] init];
        _textView.delegate = self;
        _initialHeight = ceilf([self.textView sizeThatFits:CGSizeMake(0, MAXFLOAT)].height);
    }
    return _textView;
}

- (UIButton *)voiceButton {
    if (!_voiceButton) {
        _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceButton kb_setImage:kVoiceImage imageHL:kVoiceImageHL];
        [_voiceButton addTarget:self action:@selector(onClickVoiceButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

- (UIButton *)faceButton {
    if (!_faceButton) {
        _faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_faceButton kb_setImage:kFaceImage imageHL:kFaceImageHL];
        [_faceButton addTarget:self action:@selector(onClickFaceButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faceButton;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton kb_setImage:kMoreImage imageHL:kMoreImageHL];
        [_moreButton addTarget:self action:@selector(onClickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (UIButton *)recordButton {
    if (!_recordButton) {
        _recordButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _recordButton.hidden = YES;
        _recordButton.bounds = CGRectMake(0, 0, self.textViewWidth, _initialHeight);
        _recordButton.titleLabel.font = [UIFont systemFontOfSize:17];
        _recordButton.layer.cornerRadius = 4.f;
        _recordButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        _recordButton.layer.masksToBounds = YES;
        [_recordButton addTarget:self action:@selector(onBeginRecordVoice:) forControlEvents:UIControlEventTouchDown];
        [_recordButton addTarget:self action:@selector(onEndRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
        [_recordButton addTarget:self action:@selector(onCancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [_recordButton addTarget:self action:@selector(onRemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [_recordButton addTarget:self action:@selector(onRemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    }
    return _recordButton;
}

- (HHKeyboardFaceView *)faceView {
    if (!_faceView) {
        _faceView = [[HHKeyboardFaceView alloc] init];
        _faceView.keyboardDelegate = self;
        _faceView.delegate = self;
        _faceView.dataArray = [HHKeyboardResources defaultFaceData];
        _faceView.backgroundColor = self.backgroundColor;
    }
    return _faceView;
}

- (HHKeyboardMoreView *)moreView {
    if (!_moreView) {
        _moreView = [[HHKeyboardMoreView alloc] init];
        _moreView.keyboardDelegate = self;
        _moreView.delegate = self;
        _moreView.backgroundColor = self.backgroundColor;
    }
    return _moreView;
}

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
    }
    return _topLineView;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

@end
