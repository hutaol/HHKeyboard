//
//  HHBaseKeyboard.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/12.
//

#import "HHBaseKeyboard.h"
#import "HHKeyboardHelper.h"

@implementation HHBaseKeyboard

- (void)showWithAnimation:(BOOL)animation {
    [self showInView:[UIApplication sharedApplication].keyWindow withAnimation:animation];
}

- (void)showInView:(UIView *)view withAnimation:(BOOL)animation {
    if (_isShow) {
        return;
    }
    _isShow = YES;
    
    [view addSubview:self];
    
    CGFloat keyboardHeight = [self keyboardHeight];
    
    if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardWillShow:animated:)]) {
        [self.keyboardDelegate keyboardWillShow:self animated:animation];
    }
        
    self.frame = CGRectMake(0, view.frame.size.height, view.frame.size.width, keyboardHeight);
    
    CGRect rect = self.frame;
    rect.origin.y -= keyboardHeight;

    if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboard:didChangeHeight:)]) {
        [self.keyboardDelegate keyboard:self didChangeHeight:keyboardHeight];
    }
    
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = rect;
        } completion:^(BOOL finished) {
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardDidShow:animated:)]) {
                [self.keyboardDelegate keyboardDidShow:self animated:animation];
            }
        }];
    } else {
        self.frame = rect;
        if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardDidShow:animated:)]) {
            [self.keyboardDelegate keyboardDidShow:self animated:animation];
        }
    }
}

- (void)dismissWithAnimation:(BOOL)animation {
    if (!_isShow) {
        if (!animation) {
            [self removeFromSuperview];
        }
        return;
    }
    _isShow = NO;
    
    if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardWillDismiss:animated:)]) {
        [self.keyboardDelegate keyboardWillDismiss:self animated:animation];
    }
    
    CGFloat keyboardHeight = [self keyboardHeight];

    CGRect rect = CGRectMake(0, self.superview.frame.size.height, self.superview.frame.size.width, keyboardHeight);

    if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboard:didChangeHeight:)]) {
        [self.keyboardDelegate keyboard:self didChangeHeight:-keyboardHeight];
    }
    
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = rect;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardDidDismiss:animated:)]) {
                [self.keyboardDelegate keyboardDidDismiss:self animated:animation];
            }
        }];
    } else {
        self.frame = CGRectMake(0, 0, 0, 0);
        [self removeFromSuperview];
        
        if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardDidDismiss:animated:)]) {
            [self.keyboardDelegate keyboardDidDismiss:self animated:animation];
        }
    }
}

- (void)reset {
    CGRect rect = self.frame;
    rect.size.width = self.superview.frame.size.width;
    self.frame = rect;
}

#pragma mark - HHKeyboardProtocol

- (CGFloat)keyboardHeight {
    return 220 + [HHKeyboardHelper kb_bottomSafeHeight];
}

@end
 
