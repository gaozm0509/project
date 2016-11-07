//
//  BaseTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView()

@property (nonatomic, strong) UIImageView *noDataImageView;
@property (nonatomic, strong) UILabel *noDataLabel;

@property (nonatomic, strong) MJRefreshGifHeader *Gifheader;
@property (nonatomic, strong) MJRefreshAutoGifFooter *Giffooter;

@end

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initTab];
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self initTab];6
    }
    
    return self;
}

- (void) initTab{
    self.isMJStop = NO;
    self.isHeadOpen = NO;
    self.isFootOpen = NO;
    self.Page = 1;
    _minid = @"";
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    _Gifheader = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerSel)];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%@.png", @(i)]];
        [idleImages addObject:image];
    }
    [_Gifheader setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%@.png",@(i)]];
        [refreshingImages addObject:image];
    }
    [_Gifheader setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [_Gifheader setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // 隐藏时间
    _Gifheader.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    _Gifheader.stateLabel.hidden = YES;
    
    
    self.mj_header = self.isHeadOpen ?  _Gifheader : nil;
    
    
    _Giffooter = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerSel)];
    
    [_Giffooter setImages:idleImages forState:MJRefreshStateIdle];
    
    [_Giffooter setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [_Giffooter setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    [_Giffooter setTitle:@"" forState:MJRefreshStateIdle];
    
    // 隐藏状态
    _Giffooter.refreshingTitleHidden = YES;
    self.mj_footer = self.isFootOpen ? _Giffooter : nil;
    // KVO
    [self addObserver:self forKeyPath:@"isMJStop" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"isHeadOpen" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"isFootOpen" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}

-(void)setMorePage:(void(^)(int Page))block {
    self.getPage =block;
}

// 加载更多
- (void)setMoreWithMinId:(void (^)(NSString *minid))minidBlock{
    self.getMinIdblock = minidBlock;
}

-(void)headerSel
{
    self.isFootOpen = YES;
    NSLog(@"刷新");
    _Page = 1 ;
    if (self.getPage) {
        self.getPage(_Page);
    }
    _minid = @"";
    if (self.getMinIdblock) {
        self.getMinIdblock(_minid);
    }
    
}
-(void)footerSel
{
    NSLog(@"加载");
    _Page +=1;
    if (self.getPage) {
        self.getPage(_Page);
    }
    if (self.getMinIdblock) {
        self.getMinIdblock(_minid);
    }
}

-(void)stopMJ
{
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keyPath:%@",keyPath);
    if ([keyPath isEqualToString:@"isHeadOpen"]) {
        if (self.isHeadOpen==NO) {
            self.mj_header = nil;
        }
        else if (self.isHeadOpen==YES) {
            self.mj_header = _Gifheader;
        }
    }
    else if ([keyPath isEqualToString:@"isFootOpen"]) {
        if (self.isFootOpen==NO) {
            self.mj_footer = nil;
        }
        else if (self.isFootOpen==YES) {
            self.mj_footer = _Giffooter;
        }
    }
    else if ([keyPath isEqualToString:@"isMJStop"]) {
        [self stopMJ];
    }
}


- (void)noDataViewByDataSource:(NSArray *)dataList warnImg:(NSString *)img warnMsg:(NSString *)_msg{
    if (dataList == nil || dataList.count == 0) {
        WS(weakSelf);
        [self addSubview:self.noDataLabel];
        _noDataLabel.text = _msg.length == 0 ? @"暂无数据" : _msg;
        [_noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
            if (self.tableHeaderView) {
                make.top.equalTo(weakSelf).offset(self.tableHeaderView.height + ((self.height - self.tableHeaderView.height) / 2));
                make.centerX.equalTo(weakSelf.mas_centerX);
            }
            make.width.lessThanOrEqualTo(@(kScreen_Width));
            make.height.offset(12);
        }];
        
        [self addSubview:self.noDataImageView];
        _noDataImageView.image = img.length == 0 ? [UIImage imageNamed:@"404"] : [UIImage imageNamed:img];
        [self addSubview:_noDataImageView];
        [_noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.bottom.equalTo(weakSelf.noDataLabel.mas_top).offset(- 15);
            make.size.mas_equalTo(weakSelf.noDataImageView.image.size);
        }];
    }
    else{
        [self.noDataImageView removeFromSuperview];
        [self.noDataLabel removeFromSuperview];
    }
}

- (void)noDataViewShowDefaultWithDataSource:(NSArray *)dataList{
    [self noDataViewByDataSource:dataList warnImg:nil warnMsg:nil];
}

- (UILabel *)noDataLabel{
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc]init];
        _noDataLabel.textColor = Color_Hex(@"999999");
        _noDataLabel.font = kFont12;
    }
    return _noDataLabel;
}

- (UIImageView *)noDataImageView{
    if (!_noDataImageView) {
        _noDataImageView = [[UIImageView alloc]init];
    }
    return _noDataImageView;
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"isMJStop"];
    [self removeObserver:self forKeyPath:@"isHeadOpen"];
    [self removeObserver:self forKeyPath:@"isFootOpen"];
}
@end

@interface MJRefreshMyNormalHeader()

@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

@end

@implementation MJRefreshMyNormalHeader

- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        //        loadingView.color = kActivityIndicatorViewColor;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

//重写父类方法，修改箭头和菊花的位置
- (void)placeSubviews{
    [super placeSubviews];
    
    // 箭头
//    CGFloat leftMargin = ScreenWidth / 2 - ([self.stateLabel.text calculateSize:CGSizeMake(MAXFLOAT, 12) font:defFont12].width / 2) - self.arrowView.image.size.width - 10;
    CGFloat arrowCenterY = self.mj_h * 0.5;
//    self.arrowView.center = CGPointMake(leftMargin, arrowCenterY);
    [self.arrowView removeFromSuperview];
    
    // 圈圈
    self.loadingView.frame = self.arrowView.frame;
    self.loadingView.center = self.stateLabel.center;
    
}

@end

@interface MJRefreshMyBackNormalFooter()

@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

@end

@implementation MJRefreshMyBackNormalFooter

- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        //        loadingView.color = kActivityIndicatorViewColor;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

//重写父类方法，修改箭头和菊花的位置
- (void)placeSubviews{
    [super placeSubviews];
    
    // 箭头
//    CGFloat leftMargin = ScreenWidth / 2 - ([self.stateLabel.text calculateSize:CGSizeMake(MAXFLOAT, 12) font:defFont12].width / 2) - self.arrowView.image.size.width - 10;
    CGFloat arrowCenterY = self.mj_h * 0.5;
//    self.arrowView.center = CGPointMake(leftMargin, arrowCenterY);
    //需求，删除箭头
    [self.arrowView removeFromSuperview];
    
    // 圈圈
    self.loadingView.frame = self.arrowView.frame;
    self.loadingView.center = self.stateLabel.center;
    
}


@end
