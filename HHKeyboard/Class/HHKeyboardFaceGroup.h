//
//  HHKeyboardFaceGroup.h
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import <Foundation/Foundation.h>
#import "HHKeyboardFaceItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHKeyboardFaceGroup : NSObject

@property (nonatomic, assign) int groupIndex;
@property (nonatomic, strong) NSString *groupPath;
@property (nonatomic, strong) NSMutableArray <HHKeyboardFaceItem *> *faces;
@property (nonatomic, assign) BOOL needBackDelete;
@property (nonatomic, strong) NSString *menuPath;

@end

NS_ASSUME_NONNULL_END
