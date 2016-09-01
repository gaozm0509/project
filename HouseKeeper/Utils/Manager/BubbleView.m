//
//  BubbleView.m
//  Electricity
//
//  Created by 高泽民 on 15/8/27.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "BubbleView.h"

@implementation BubbleView
-(instancetype)init{
    self = [super init];
    if ((self)) {
        if (!_name) {
            _name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
            _name.textColor = [UIColor blackColor];
            _name.font = [UIFont systemFontOfSize:12];
            [self addSubview:_name];
        }
    }
    return self;
}
@end
