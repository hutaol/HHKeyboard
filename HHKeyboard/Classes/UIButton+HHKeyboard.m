//
//  UIButton+HHKeyboard.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import "UIButton+HHKeyboard.h"

@implementation UIButton (HHKeyboard)

- (void)kb_setImage:(UIImage *)image imageHL:(UIImage *)imageHL {
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:imageHL forState:UIControlStateHighlighted];
}

@end
