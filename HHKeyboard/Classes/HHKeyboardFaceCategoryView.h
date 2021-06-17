//
//  HHKeyboardFaceCategoryView.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHKeyboardFaceCategoryView : UIView

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, copy) void(^didSelectCallback)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
