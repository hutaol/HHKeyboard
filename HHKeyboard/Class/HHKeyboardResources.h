//
//  HHKeyboardResources.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHKeyboardResources : NSObject

+ (NSString *)getPathWithFace:(NSString *)name;
+ (NSString *)getPathWithKeyboard:(NSString *)name;

+ (UIImage *)getImageFromKeyboard:(NSString *)name;
+ (UIImage *)getImageFromFace:(NSString *)name;

+ (NSMutableArray *)defaultFaceData;

@end

NS_ASSUME_NONNULL_END
