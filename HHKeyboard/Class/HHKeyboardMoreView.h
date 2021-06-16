//
//  HHKeyboardMoreView.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/12.
//

#import "HHBaseKeyboard.h"
#import "HHKeyboardMoreItem.h"
@class HHKeyboardMoreView;

NS_ASSUME_NONNULL_BEGIN

@protocol HHKeyboardMoreViewDelegate <NSObject>

- (void)keyboardMore:(HHKeyboardMoreView *)keyboard didSelectItem:(HHKeyboardMoreItem *)item;

@end

@interface HHKeyboardMoreView : HHBaseKeyboard

@property (nonatomic, weak) id<HHKeyboardMoreViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray <HHKeyboardMoreItem *> *keyboardMoreData;

@property (nonatomic, assign) NSInteger pageItemCount;

@end

NS_ASSUME_NONNULL_END
