#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HHBaseKeyboard.h"
#import "HHKeyboard.h"
#import "HHKeyboardConfiguration.h"
#import "HHKeyboardFaceCategoryView.h"
#import "HHKeyboardFaceCell.h"
#import "HHKeyboardFaceGroup.h"
#import "HHKeyboardFaceGroupCell.h"
#import "HHKeyboardFaceItem.h"
#import "HHKeyboardFaceView.h"
#import "HHKeyboardHelper.h"
#import "HHKeyboardMoreCell.h"
#import "HHKeyboardMoreItem.h"
#import "HHKeyboardMoreView.h"
#import "HHKeyboardResources.h"
#import "HHKeyboardTextView.h"
#import "HHKeyboardView.h"
#import "UIButton+HHKeyboard.h"
#import "UIColor+HHKeyboard.h"
#import "UIWindow+HHKeyboard.h"

FOUNDATION_EXPORT double HHKeyboardVersionNumber;
FOUNDATION_EXPORT const unsigned char HHKeyboardVersionString[];

