//
//  HHKeyboardFaceView.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import "HHBaseKeyboard.h"
#import "HHKeyboardFaceGroup.h"
@class HHKeyboardFaceView;

NS_ASSUME_NONNULL_BEGIN

@protocol HHKeyboardFaceViewDelegate <NSObject>

@optional
- (void)keyboardFace:(HHKeyboardFaceView *)view didSelectItem:(HHKeyboardFaceItem *)item;

- (void)keyboardFaceDelete:(HHKeyboardFaceView *)view;

- (void)keyboardFaceSend:(HHKeyboardFaceView *)view;

@end

@interface HHKeyboardFaceView : HHBaseKeyboard

@property (nonatomic, weak) id<HHKeyboardFaceViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray <HHKeyboardFaceGroup *> *dataArray;

- (void)showButton:(BOOL)show;

@end

NS_ASSUME_NONNULL_END
