//
//  UIColor+HHKeyboard.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HHKeyboard)

+ (UIColor *)kb_colorWithString:(NSString *)string;

+ (UIColor *)kb_colorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

+ (UIImage *)kb_imageWithColor:(UIColor *)color;
+ (UIImage *)kb_imageWithColor:(UIColor *)color size:(CGSize)size;


+ (UIColor *)textColor;
+ (UIColor *)selectColor;

+ (UIColor *)selectPageColor;
+ (UIColor *)pageColor;

@end

NS_ASSUME_NONNULL_END
