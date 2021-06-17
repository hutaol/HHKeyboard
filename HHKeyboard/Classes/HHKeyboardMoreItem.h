//
//  HHKeyboardMoreItem.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHKeyboardMoreItem : NSObject

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithType:(NSInteger)type title:(nullable NSString *)title image:(nullable UIImage *)image;
+ (instancetype)moreItemWithType:(NSInteger)type title:(nullable NSString *)title image:(nullable UIImage *)image;

@end

NS_ASSUME_NONNULL_END
