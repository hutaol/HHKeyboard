//
//  HHKeyboardFaceView.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import "HHKeyboardFaceView.h"
#import "HHKeyboardFaceCategoryView.h"
#import "HHKeyboardFaceGroup.h"
#import "HHKeyboardFaceGroupCell.h"
#import "HHKeyboardHelper.h"
#import "HHKeyboardResources.h"
#import "UIColor+HHKeyboard.h"

@interface HHKeyboardFaceView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) HHKeyboardFaceCategoryView *categoryView;

@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation HHKeyboardFaceView

- (CGFloat)keyboardHeight {
    return 220 + [HHKeyboardHelper kb_bottomSafeHeight];
}

- (void)reset {
    [super reset];
    [self.collectionView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = [NSMutableArray array];
        [self addSubview:self.collectionView];
        [self addSubview:self.categoryView];
        [self addSubview:self.deleteButton];
        [self addSubview:self.sendButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    if (@available(iOS 11.0, *)) {
        inset = self.safeAreaInsets;
    }
    
    self.categoryView.frame = CGRectMake(inset.left, self.frame.size.height - [HHKeyboardHelper kb_bottomSafeHeight] - 50, self.frame.size.width - inset.left - inset.right, 50);
    self.collectionView.frame = CGRectMake(inset.left, 0, self.frame.size.width - inset.left - inset.right, self.categoryView.frame.origin.y);
    
    self.sendButton.frame = CGRectMake(self.frame.size.width - inset.right - 70, self.collectionView.frame.size.height + 7, 60, 36);
    self.deleteButton.frame = CGRectMake(self.frame.size.width - inset.right - 70, self.collectionView.frame.size.height - 40, 60, 36);
}

#pragma mark Public Metheds

- (void)showButton:(BOOL)show {
    if (show) {
        self.sendButton.hidden = NO;
        self.deleteButton.hidden = NO;
    } else {
        self.sendButton.hidden = YES;
        self.deleteButton.hidden = YES;
    }
}

#pragma mark - On Click

- (void)onClickDelete {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardFaceDelete:)]) {
        [self.delegate keyboardFaceDelete:self];
    }
}

- (void)onClickSend {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardFaceSend:)]) {
        [self.delegate keyboardFaceSend:self];
    }
}

#pragma mark - Delegate & DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HHKeyboardFaceGroupCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HHKeyboardFaceGroupCell" forIndexPath:indexPath];
    
    HHKeyboardFaceGroup *group = self.dataArray[indexPath.row];

    cell.dataArray = group.faces;
    
    __weak typeof(self) ws = self;
    cell.didSelectCallback = ^(HHKeyboardFaceItem * _Nonnull item) {
        if (ws.delegate && [ws.delegate respondsToSelector:@selector(keyboardFace:didSelectItem:)]) {
            [ws.delegate keyboardFace:ws didSelectItem:item];
        }
    };

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.frame.size.width, [self keyboardHeight] - 50 - [HHKeyboardHelper kb_bottomSafeHeight]);
}

- (void)setDataArray:(NSMutableArray<HHKeyboardFaceGroup *> *)dataArray {
    _dataArray = dataArray;
    self.categoryView.dataArray = dataArray;
}

#pragma mark - Getters

- (HHKeyboardFaceCategoryView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[HHKeyboardFaceCategoryView alloc] init];
        __weak typeof(self) ws = self;
        _categoryView.didSelectCallback = ^(NSInteger index) {
            [ws.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        };
    }
    return _categoryView;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = self.backgroundColor;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces = YES;
        [_collectionView registerClass:[HHKeyboardFaceGroupCell class] forCellWithReuseIdentifier:@"HHKeyboardFaceGroupCell"];
    }
    return _collectionView;
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        _sendButton.hidden = YES;
        _sendButton.backgroundColor = [UIColor kb_colorWithString:@"#0D9BF8"];
        _sendButton.layer.cornerRadius = 20;
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(onClickSend) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_deleteButton setImage:[HHKeyboardResources getImageFromFace:@"del_normal"] forState:UIControlStateNormal];
        [_deleteButton setImage:[HHKeyboardResources getImageFromFace:@"del_pressed"] forState:UIControlStateSelected];
        _deleteButton.hidden = YES;
        _deleteButton.backgroundColor = [UIColor selectColor];
        _deleteButton.layer.cornerRadius = 20;
        _deleteButton.layer.borderWidth = 1;
        _deleteButton.layer.borderColor = [UIColor kb_colorWithString:@"#EAEAEA"].CGColor;
        [_deleteButton addTarget:self action:@selector(onClickDelete) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

@end
