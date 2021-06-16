//
//  HHKeyboardConfiguration.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHKeyboardConfiguration : NSObject

@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, strong) UIColor *inputColor;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *textFont;

@property (nonatomic, copy) NSString *recordTitle;
@property (nonatomic, copy) NSString *recordHLTitle;

@end

NS_ASSUME_NONNULL_END
