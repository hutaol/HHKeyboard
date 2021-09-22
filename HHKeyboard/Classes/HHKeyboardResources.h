//
//  HHKeyboardResources.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import <UIKit/UIKit.h>
#import "HHKeyboardFaceItem.h"
#import "HHKeyboardFaceGroup.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHKeyboardResources : NSObject

+ (NSString *)getPathWithFace:(NSString *)name;

+ (UIImage *)getImageFromFace:(NSString *)name;

+ (NSMutableArray *)defaultFaceData;

@end

NS_ASSUME_NONNULL_END
