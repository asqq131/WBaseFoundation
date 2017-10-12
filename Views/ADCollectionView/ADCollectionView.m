//
//  ADCollectionView.m
//  YoLo
//
//  Created by ZWu H on 2017/1/10.
//  Copyright © 2017年 wu. All rights reserved.
//

#import "ADCollectionView.h"
#import "WConstants.h"

#define kADCount 3
#define kCollectionCellId @"collectionCellId"
#define kCollectionItemSize CGSizeMake(kScreenSize.width, kScreenSize.height)

@interface ADCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ADCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kCollectionItemSize.width, kCollectionItemSize.height)];
        [self.contentView addSubview:self.imageView];
    }
    
    return self;
}

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface ADCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (copy, nonatomic) ADCallBack callBack;

@end

@implementation ADCollectionView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        self.collectionView.pagingEnabled = YES;
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[ADCollectionViewCell class] forCellWithReuseIdentifier:kCollectionCellId];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenSize.height - 2*kScale(10), kScreenSize.width, kScale(10))];
        self.pageControl.numberOfPages = kADCount;
        self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [self addSubview:self.pageControl];
    }
    
    return self;
}

- (void)showAdWithCompletion:(ADCallBack)callBack {
    self.callBack = callBack;
}

#pragma mark - Delegate and DataSource
#pragma mark UICollectionViewDelegate and UICollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kADCount + 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellId forIndexPath:indexPath];
    
    if (indexPath.row < kADCount) {
        cell.imageView.hidden = NO;
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ad_bg_%ld", (indexPath.row + 1)]];
    } else {
        cell.imageView.hidden = YES;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return kCollectionItemSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / kScreenSize.width;
    
    if (page == kADCount) {
        self.callBack();
    } else {
        self.pageControl.currentPage = page;
    }
}

@end
