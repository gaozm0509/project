//
//  LifeServiceCollectionView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "LifeServiceCollectionView.h"



@interface LifeServiceCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray<NSString *> *cell0ImageArr;

@end

@implementation LifeServiceCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = kBackgroundColor;
        
        [self registerClass:[LifeServiceCollectionViewCell class] forCellWithReuseIdentifier:@"LifeServiceCollectionViewCellId"];
        [self registerClass:[LifeServiceCollectionViewCell1 class] forCellWithReuseIdentifier:@"LifeServiceCollectionViewCellId1"];
        [self registerClass:[LifeServiceCollectionViewCell2 class] forCellWithReuseIdentifier:@"LifeServiceCollectionViewCellId2"];
        [self registerClass:[LifeServiceCollectionViewCell3 class] forCellWithReuseIdentifier:@"LifeServiceCollectionViewCellId3"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return self;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LifeServiceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LifeServiceCollectionViewCellId" forIndexPath:indexPath];
        cell.indexRow = indexPath.row;
        return cell;
    }
    if (indexPath.section == 1) {
        LifeServiceCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LifeServiceCollectionViewCellId1" forIndexPath:indexPath];
        cell.indexRow = indexPath.row;
        return cell;
    }
    if (indexPath.section == 2) {
        LifeServiceCollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LifeServiceCollectionViewCellId2" forIndexPath:indexPath];
        cell.indexRow = indexPath.row;
        return cell;
    }
    if ((indexPath.section == 3)) {
        LifeServiceCollectionViewCell3 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LifeServiceCollectionViewCellId3" forIndexPath:indexPath];
        return cell;
    }
    
    return nil;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section > 0) {
        return  UIEdgeInsetsMake(10, 0, 0, 0);
    }
    return UIEdgeInsetsZero;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section < 3) {
        return CGSizeZero;
    }
    return CGSizeMake(kScreen_Width, 20);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < 3) {
        return nil;
    }
    NSString *CellIdentifier = @"header";
    //从缓存中获取 Headercell
    UICollectionReusableView *cellHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 15)];
    label.text = @"小区公告";
    label.textColor = KMajorYellowColor;
    label.font = kFont12;
    [cellHeader addSubview:label];
    return cellHeader;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }
    if (section == 1) {
        return 4;
    }
    if (section == 2) {
        return 2;
    }
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [LifeServiceCollectionViewCell getCellSize];
    }
    if (indexPath.section == 1) {
        return [LifeServiceCollectionViewCell1 getCellSize];
    }
    if (indexPath.section == 2) {
        return [LifeServiceCollectionViewCell2 getCellSize];
    }
    return [LifeServiceCollectionViewCell3 getCellSize];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section < 3){
        [self.clickDelegate clickItemWithIndexPath:indexPath];
    }
    
}

@end
