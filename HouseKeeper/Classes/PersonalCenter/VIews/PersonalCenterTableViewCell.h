//
//  PersonalCenterTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/26.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMarginLeft 10
#define kTextFont [UIFont systemFontOfSize:12]
#define kTextColor [UIColor colorWithHexString:@"323232"]
#define kHeadWidht 135


@interface PersonalCenterTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *leftIcon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightIcon;


@end

@class CustomView;
@protocol PersonalCenterTableViewCellDelegate <NSObject>

- (void)click:(NSInteger)index;

@end
@interface PersonalCenterTableViewTopCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) CustomView *balanceView;
@property (nonatomic, strong) CustomView *couponView;
@property (nonatomic, strong) CustomView *integralView;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) id<PersonalCenterTableViewCellDelegate> delegate;

+ (CGFloat)getHieght;

@end

@interface CustomView : UIButton

@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UIImage *image;

@end


@interface PersonalCenterTableViewBottomCell : UITableViewCell

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIImageView *rightIcon;

@end
