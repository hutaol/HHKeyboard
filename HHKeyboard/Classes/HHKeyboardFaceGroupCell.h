//
//  HHKeyboardFaceGroupCell.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import <UIKit/UIKit.h>
@class HHKeyboardFaceItem;

NS_ASSUME_NONNULL_BEGIN

@interface HHKeyboardFaceGroupCell : UICollectionViewCell

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) void(^didSelectCallback)(HHKeyboardFaceItem *item);

@end

NS_ASSUME_NONNULL_END
