//
//  HHKeyboardMoreItem.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import "HHKeyboardMoreItem.h"

@implementation HHKeyboardMoreItem

- (instancetype)initWithType:(NSInteger)type title:(NSString *)title image:(UIImage *)image {
    self = [super init];
    if (self) {
        _type = type;
        _title = title;
        _image = image;
    }
    return self;
}

+ (instancetype)moreItemWithType:(NSInteger)type title:(NSString *)title image:(UIImage *)image {
    return [[HHKeyboardMoreItem alloc] initWithType:type title:title image:image];
}



@end
