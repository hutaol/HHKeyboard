//
//  HHKeyboardFaceCategoryView.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import "HHKeyboardFaceCategoryView.h"
#import "HHKeyboardFaceCell.h"
#import "HHKeyboardFaceGroup.h"
#import "UIColor+HHKeyboard.h"

@interface HHKeyboardFaceCategoryView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HHKeyboardFaceCategoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = [NSMutableArray array];
        self.selectIndex = 0;
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HHKeyboardFaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HHKeyboardFaceCell" forIndexPath:indexPath];
    
    HHKeyboardFaceGroup *group = self.dataArray[indexPath.row];
    if (group.menuPath) {
        UIImage *image = [UIImage imageWithContentsOfFile:group.menuPath];
        cell.faceView.image = image;
    }
    
    if (indexPath.row == self.selectIndex) {
        cell.backgroundColor = [UIColor selectColor];
    } else {
        cell.backgroundColor = nil;
    }
    
    cell.layer.cornerRadius = 8;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndex = indexPath.row;
    if (self.didSelectCallback) {
        self.didSelectCallback(indexPath.row);
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    if (selectIndex == _selectIndex) {
        return;
    }
    HHKeyboardFaceCell *oldCell = (HHKeyboardFaceCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]];
    oldCell.backgroundColor = nil;

    HHKeyboardFaceCell *cell = (HHKeyboardFaceCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]];
    cell.backgroundColor = [UIColor selectColor];
    
    _selectIndex = selectIndex;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(40, 40);
        layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = self.backgroundColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[HHKeyboardFaceCell class] forCellWithReuseIdentifier:@"HHKeyboardFaceCell"];
    }
    return _collectionView;
}

@end
