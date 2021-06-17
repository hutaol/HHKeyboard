//
//  HHKeyboardFaceCell.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import "HHKeyboardFaceCell.h"
#import "HHKeyboardFaceItem.h"

@implementation HHKeyboardFaceCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _faceView = [[UIImageView alloc] init];
        _faceView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_faceView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _faceView.frame = CGRectMake(5, 5, 30, 30);
}

- (void)setItem:(HHKeyboardFaceItem *)item {
    _item = item;
    
    if (item.path) {
        UIImage *image = [UIImage imageWithContentsOfFile:item.path];
        _faceView.image = image;
    }
    
}

@end
