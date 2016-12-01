//
//  BaseTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
#import "MJRefresh.h"

@protocol  BaseTableViewDelegate <NSObject>

@optional
- (void)BaseTableViewClickWithModel:(BaseModel *)baseModel;
- (void)BaseTableViewClickWithIndexPath:(NSIndexPath *)indexPath;

@end


typedef void(^getblock)(int Page);
typedef void(^getMinIdblock)(NSString *minid);

#define kActivityIndicatorViewColor color_40bd55//暂时未用到


@interface MJRefreshMyNormalHeader : MJRefreshNormalHeader

@end

@interface MJRefreshMyBackNormalFooter : MJRefreshBackNormalFooter

@end


@interface BaseTableView : UITableView

-(id)initWithFrame:(CGRect)frame;

@property(nonatomic,copy) getblock getPage;
//@property(nonatomic,copy) getMaxIdblock getMaxIdblock;
@property(nonatomic,copy) getMinIdblock getMinIdblock;

@property(nonatomic,assign) int Page;

@property (nonatomic, strong) NSString *minid;

@property(nonatomic,assign) BOOL isHeadOpen;

@property(nonatomic,assign) BOOL isFootOpen;

@property(nonatomic,assign) BOOL isMJStop;

@property (nonatomic,strong) NSString *noDataImageName;

@property (nonatomic,strong) NSString *noDataWarning;




-(void)setMorePage:(void(^)(int Page))block;

/**
 *  加载更多
 */
- (void)setMoreWithMinId:(void (^)(NSString *minid))minidBlock;

/**
 *  无数据页面
 *
 *  @param dataList tableView数据源
 *  @param img      传nil显示默认图
 *  @param _msg     传nil显示默认
 */
- (void)noDataViewByDataSource:(NSArray *)dataList warnImg:(NSString *)img warnMsg:(NSString *)_msg;

/**
 *  无数据页面显示,默认页面
 */
- (void)noDataViewShowDefaultWithDataSource:(NSArray *)dataList;

@end
