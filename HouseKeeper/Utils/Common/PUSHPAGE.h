//
//  PUSHPAGE.h
//  BoqiiMall
//
//  Created by ysw on 15-7-24.
//  Copyright (c) 2015年 BQ. All rights reserved.
//

#import <Foundation/Foundation.h>

/*  参数说明
 *  VCNAME : push的目标页 例：@“testcontroll”    ---注意不带.h
 *  ISNIB       : 目标页是否带 xib 文件
 *  HIDETABBAR      : 当前页是否隐藏 tabBar      -----注意 是当前页 非目标页
 *  ISNEEDDELEGAGE    : 是否设置委托
 *  PARAMS  :   传入参数
 */
@interface PUSHPAGE : UIViewController

@property (nonatomic, strong) NSString *VCNAME;
@property (nonatomic, assign) BOOL ISNIB;
@property (nonatomic, assign) BOOL HIDETABBAR;
@property (nonatomic, assign) BOOL ISNEEDDELEGAGE;
@property (nonatomic, strong) NSDictionary *PARAMS;


+ (PUSHPAGE *) share;

+ (PUSHPAGE *) init:(NSString *) vcname;

+ (PUSHPAGE *) init:(NSString *) vcname pms:(__kindof NSDictionary *) params;

- (PUSHPAGE *) init:(NSString *) vcname;

- (PUSHPAGE *) init:(NSString *) vcname nib:(BOOL) isnib;

- (PUSHPAGE *) init:(NSString *) vcname pms:(__kindof NSDictionary *) params;

- (PUSHPAGE *) init:(NSString *) vcname nib:(BOOL) isnib pms:(__kindof NSDictionary *) params;

- (PUSHPAGE *)init:(NSString *) vcname nib:(BOOL) isnib tabbar:(BOOL) hidetab needdelegate:(BOOL) noneed pms:(__kindof NSDictionary *) params;
@end
