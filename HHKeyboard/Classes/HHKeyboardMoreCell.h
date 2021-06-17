//
//  HHKeyboardMoreCell.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import <UIKit/UIKit.h>
@class HHKeyboardMoreItem;
@class HHKeyboardMoreCell;

NS_ASSUME_NONNULL_BEGIN

@protocol HHKeyboardMoreCellDelegate <NSObject>

- (void)moreClick:(HHKeyboardMoreCell *)cell item:(HHKeyboardMoreItem *)item;

@end

@interface HHKeyboardMoreCell : UICollectionViewCell

@property (nonatomic, strong, nullable) HHKeyboardMoreItem *item;

@property (nonatomic, weak) id <HHKeyboardMoreCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
