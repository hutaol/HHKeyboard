//
//  HHKeyboardFaceGroupCell.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import "HHKeyboardFaceGroupCell.h"
#import "HHKeyboardFaceCell.h"
#import "HHKeyboardFaceItem.h"

@interface HHKeyboardFaceGroupCell () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HHKeyboardFaceGroupCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = [NSMutableArray array];
        [self.contentView addSubview:self.collectionView];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HHKeyboardFaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HHKeyboardFaceCell" forIndexPath:indexPath];
    cell.item = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HHKeyboardFaceItem *item = self.dataArray[indexPath.row];
    if (self.didSelectCallback) {
        self.didSelectCallback(item);
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(40, 40);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces = YES;
        [_collectionView registerClass:[HHKeyboardFaceCell class] forCellWithReuseIdentifier:@"HHKeyboardFaceCell"];
    }
    return _collectionView;
}

@end
