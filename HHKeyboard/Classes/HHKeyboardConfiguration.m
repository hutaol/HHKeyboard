//
//  HHKeyboardConfiguration.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/16.
//

#import "HHKeyboardConfiguration.h"
#import "UIColor+HHKeyboard.h"

@implementation HHKeyboardConfiguration

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lineColor = [UIColor kb_colorWithLightColor:[UIColor kb_colorWithString:@"#EAEAEA"] darkColor:[UIColor kb_colorWithString:@"#555555"]];
        
        _bgColor = [UIColor kb_colorWithLightColor:[UIColor kb_colorWithString:@"#FAFAFA"] darkColor:[UIColor blackColor]];
        
        _borderColor = [UIColor kb_colorWithLightColor:[UIColor kb_colorWithString:@"#EAEAEA"] darkColor:[UIColor kb_colorWithString:@"#555555"]];
        
        _inputColor = [UIColor kb_colorWithLightColor:[UIColor whiteColor] darkColor:[UIColor kb_colorWithString:@"#101010"]];
        
        _textColor = [UIColor kb_colorWithLightColor:[UIColor blackColor] darkColor:[UIColor whiteColor]];
        
        _textFont = [UIFont systemFontOfSize:17];
        
        _recordTitle = @"按住 说话";
        _recordHLTitle = @"松开 结束";
        
    }
    return self;
}

@end
