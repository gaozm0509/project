//
//  CouponTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/27.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "CouponTableView.h"


@interface CouponTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CouponTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        [self netRequest];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[CouponTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.couponType = _couponType;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [kText sizeWithFont:kFont12 Size:CGSizeMake(kBgViewWidht - kBgViewWidht / 3 - kMarginleft - kStateLabelWidth, MAXFLOAT)].height;
    return kMarginleft + 15 + 5 + 12 + height + kMarginleft;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)setCouponType:(CouponType)couponType{
    _couponType = couponType;
    [self netRequest];
    [self reloadData];
}

- (void)netRequest{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(_couponType) forKey:@"type"];
    [kApi_member_coupons httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            
        }
    }];
}


@end
