//
//  HHKeyboardMoreCell.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import "HHKeyboardMoreCell.h"
#import "HHKeyboardMoreItem.h"
#import "UIColor+HHKeyboard.h"

@interface HHKeyboardMoreCell ()

@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HHKeyboardMoreCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageButton];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageButton.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.width);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageButton.frame), self.contentView.frame.size.width, self.contentView.frame.size.height - CGRectGetMaxY(self.imageButton.frame));
}

- (void)setItem:(HHKeyboardMoreItem *)item {
    _item = item;
    if (item == nil) {
        self.titleLabel.hidden = YES;
        self.imageButton.hidden = YES;
        self.userInteractionEnabled = NO;
        return;
    }
    self.userInteractionEnabled = YES;
    self.titleLabel.hidden = NO;
    self.imageButton.hidden = NO;
    self.titleLabel.text = item.title;
    [self.imageButton setImage:item.image forState:UIControlStateNormal];
}

- (void)onClickButton:(UIButton *)sender  {
    if (self.delegate && [self.delegate respondsToSelector:@selector(moreClick:item:)]) {
        [self.delegate moreClick:self item:self.item];
    }
}

#pragma mark - Getters

- (UIButton *)imageButton {
    if (_imageButton == nil) {
        _imageButton = [[UIButton alloc] init];
        _imageButton.layer.masksToBounds = YES;
        _imageButton.layer.cornerRadius = 10;
        UIImage *image = [UIColor kb_imageWithColor:[UIColor lightGrayColor]];
        
        [_imageButton setBackgroundImage:image forState:UIControlStateHighlighted];
        [_imageButton addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageButton;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor textColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
