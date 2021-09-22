//
//  HHKeyboardMoreView.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/12.
//

#import "HHKeyboardMoreView.h"
#import "HHKeyboardMoreCell.h"
#import "HHKeyboardHelper.h"
#import "UIColor+HHKeyboard.h"

#define kPageControlHeight  20
#define kSpaceTop           20
#define kCellWidth          60
#define kCellHeight         80
#define kRowCell            4

@interface HHKeyboardMoreView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HHKeyboardMoreCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;

/// 键盘高度 默认220
@property (nonatomic, assign) NSInteger keyHeight;

@end

@implementation HHKeyboardMoreView

#pragma mark - HHKeyboardProtocol

- (CGFloat)keyboardHeight {
    return self.keyHeight + [HHKeyboardHelper kb_bottomSafeHeight];
}

- (void)keyboardShow {
    [self.collectionView reloadData];
}

- (void)reset:(CGFloat)width {
    [super reset:width];
    [self.collectionView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.keyHeight = 220;
        self.pageItemCount = 8;
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    if (@available(iOS 11.0, *)) {
        inset = self.safeAreaInsets;
    }
    
    self.collectionView.frame = CGRectMake(inset.left, 0, self.frame.size.width - inset.left - inset.right, self.frame.size.height - kPageControlHeight - [HHKeyboardHelper kb_bottomSafeHeight]);
    self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.frame.size.width - inset.left - inset.right, kPageControlHeight);
}

- (void)setKeyboardMoreData:(NSMutableArray<HHKeyboardMoreItem *> *)keyboardMoreData {
    if (keyboardMoreData == _keyboardMoreData) {
        return;
    }
    _keyboardMoreData = keyboardMoreData;
    
    // TODO <5
    if (keyboardMoreData.count < 5) {
        self.keyHeight = 120;
        self.pageItemCount = 4;
    } else {
        self.keyHeight = 220;
        self.pageItemCount = 8;
    }

    NSInteger page = (int)ceilf(keyboardMoreData.count / 8.f);

    self.pageControl.numberOfPages = page;

    self.pageControl.currentPage = 0;
    [self.collectionView reloadData];
    
    if (page == 1) {
        self.pageControl.hidden = YES;
    } else {
        self.pageControl.hidden = NO;
    }
}

#pragma mark - Private Methods

- (NSUInteger)p_transformIndex:(NSUInteger)index {
    if (self.pageItemCount == 4) {
        return index;
    }
    NSUInteger page = index / self.pageItemCount;
    index = index % self.pageItemCount;
    NSUInteger x = index / 2;
    NSUInteger y = index % 2;
    return self.pageItemCount / 2 * y + x + page * self.pageItemCount;
}

#pragma mark - Action

- (void)pageControlChanged:(UIPageControl *)pageControl {
    [self.collectionView scrollRectToVisible:CGRectMake(self.collectionView.frame.size.width * pageControl.currentPage, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height) animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.keyboardMoreData.count / self.pageItemCount + (self.keyboardMoreData.count % self.pageItemCount == 0 ? 0 : 1);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pageItemCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HHKeyboardMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HHKeyboardMoreCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    
    NSUInteger index = indexPath.section * self.pageItemCount + indexPath.row;
    NSUInteger tIndex = [self p_transformIndex:index];  // 矩阵坐标转置
    if (tIndex >= self.keyboardMoreData.count) {
        [cell setItem:nil];
    } else {
        [cell setItem:self.keyboardMoreData[tIndex]];
    }

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kCellWidth, kCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (collectionView.frame.size.width - kCellWidth * kRowCell) / (kRowCell + 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kSpaceTop;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat space = (collectionView.frame.size.width - kCellWidth * kRowCell) / (kRowCell + 1);
    return UIEdgeInsetsMake(kSpaceTop, space, 0, space);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / self.frame.size.width);
}

#pragma mark - HHKeyboardMoreCellDelegate

- (void)moreClick:(HHKeyboardMoreCell *)cell item:(HHKeyboardMoreItem *)item {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardMore:didSelectItem:)]) {
        [self.delegate keyboardMore:self didSelectItem:item];
    }
}

#pragma mark - Getters

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces = YES;
        [_collectionView registerClass:[HHKeyboardMoreCell class] forCellWithReuseIdentifier:NSStringFromClass([HHKeyboardMoreCell class])];
        
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor selectPageColor];
        _pageControl.pageIndicatorTintColor = [UIColor pageColor];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}


@end
