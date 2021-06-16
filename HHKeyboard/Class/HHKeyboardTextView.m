//
//  HHKeyboardTextView.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import "HHKeyboardTextView.h"
#import "UIColor+HHKeyboard.h"

@implementation HHKeyboardTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_init];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_init];
    }
    return self;
}

- (void)p_init {
    self.font = [UIFont systemFontOfSize:17];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 4.f;
    self.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    self.textContainerInset = UIEdgeInsetsMake(10.f, 9.f, 9.f, 10.f);
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.scrollEnabled = NO;
    self.returnKeyType = UIReturnKeySend;
    self.enablesReturnKeyAutomatically = YES;
}

@end
