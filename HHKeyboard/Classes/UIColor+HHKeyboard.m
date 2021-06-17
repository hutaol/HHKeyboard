//
//  UIColor+HHKeyboard.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/14.
//

#import "UIColor+HHKeyboard.h"

CGFloat kb_colorComponentFrom(NSString *string, NSUInteger start, NSUInteger length) {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@implementation UIColor (HHKeyboard)

+ (UIColor *)kb_colorWithString:(NSString *)string {
    if (string == nil || string.length == 0) {
        return nil;
    }
    
    if ([string hasPrefix:@"rgb("] && [string hasSuffix:@")"]) {
        string = [string substringWithRange:NSMakeRange(4, string.length - 5)];
        if (string && string.length) {
            NSArray *elems = [string componentsSeparatedByString:@","];
            if (elems && elems.count == 3) {
                NSInteger r = [[elems objectAtIndex:0] integerValue];
                NSInteger g = [[elems objectAtIndex:1] integerValue];
                NSInteger b = [[elems objectAtIndex:2] integerValue];
                return [UIColor colorWithRed:(r * 1.0f / 255.0f) green:(g * 1.0f / 255.0f) blue:(b * 1.0f / 255.0f) alpha:1.0f];
            }

        }
    }
    
    if ([string hasPrefix:@"#"] || [string hasPrefix:@"0x"] || [string hasPrefix:@"0X"] ) {
        CGFloat alpha, red, blue, green;

        NSString *colorString = [[string stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
        colorString = [[colorString stringByReplacingOccurrencesOfString:@"0x" withString:@""] uppercaseString];
        colorString = [[colorString stringByReplacingOccurrencesOfString:@"0X" withString:@""] uppercaseString];

        switch ([colorString length]) {
            case 3: // #RGB
                alpha = 1.0f;
                red   = kb_colorComponentFrom(colorString, 0, 1);
                green = kb_colorComponentFrom(colorString, 1, 1);
                blue  = kb_colorComponentFrom(colorString, 2, 1);
                break;
                
            case 4: // #ARGB
                alpha = kb_colorComponentFrom(colorString, 0, 1);
                red   = kb_colorComponentFrom(colorString, 1, 1);
                green = kb_colorComponentFrom(colorString, 2, 1);
                blue  = kb_colorComponentFrom(colorString, 3, 1);
                break;
                
            case 6: // #RRGGBB
                alpha = 1.0f;
                red   = kb_colorComponentFrom(colorString, 0, 2);
                green = kb_colorComponentFrom(colorString, 2, 2);
                blue  = kb_colorComponentFrom(colorString, 4, 2);
                break;
                
            case 8: // #AARRGGBB
                alpha = kb_colorComponentFrom(colorString, 0, 2);
                red   = kb_colorComponentFrom(colorString, 2, 2);
                green = kb_colorComponentFrom(colorString, 4, 2);
                blue  = kb_colorComponentFrom(colorString, 6, 2);
                break;
                
            default:
                return nil;
        }
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
    
    return nil;
}

+ (UIColor *)kb_colorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if ( traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight ) {
                return lightColor;
            } else if ( traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ) {
                return darkColor;
            } else {
                return lightColor;
            }
        }];
    } else {
        return lightColor;
    }
}

+ (UIImage *)kb_imageWithColor:(UIColor *)color {
    return [self kb_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)kb_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIColor *)textColor {
    return [self kb_colorWithLightColor:[UIColor blackColor] darkColor:[UIColor whiteColor]];
}

+ (UIColor *)selectColor {
    return [self kb_colorWithLightColor:[UIColor whiteColor] darkColor:[UIColor kb_colorWithString:@"#222222"]];
}

+ (UIColor *)selectPageColor {
    return [self kb_colorWithLightColor:[UIColor darkGrayColor] darkColor:[UIColor lightGrayColor]];
}

+ (UIColor *)pageColor {
    return [self kb_colorWithLightColor:[UIColor lightGrayColor] darkColor:[UIColor darkGrayColor]];
}

@end
