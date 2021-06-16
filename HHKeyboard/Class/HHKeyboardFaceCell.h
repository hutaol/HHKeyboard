//
//  HHKeyboardFaceCell.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import <UIKit/UIKit.h>
@class HHKeyboardFaceItem;

NS_ASSUME_NONNULL_BEGIN

@interface HHKeyboardFaceCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *faceView;

@property (nonatomic, strong) HHKeyboardFaceItem *item;

@end

NS_ASSUME_NONNULL_END
