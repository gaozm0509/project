//
//  AddressManagementTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AddressManagementTableView.h"
#import "AddressManagementCell.h"

@interface AddressManagementTableView()<UITableViewDelegate,UITableViewDataSource>{}

@end
@implementation AddressManagementTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"AddressManagementCell";
    AddressManagementCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[AddressManagementCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kMarginLeft];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMarginTop + kNameHeight + kMarginTop + kAdreeHeight + kMarginTop;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor clearColor];
//    if (section == 9) {
//    }else{
//        view.frame = CGRectMake(kMarginLeft, 0, 0.5, kScreen_Width - kMarginLeft);
//    }
//    return view;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.clickCell cliclCellWithIndexPath:indexPath];
}


@end
