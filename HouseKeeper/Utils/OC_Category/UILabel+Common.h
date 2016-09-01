//
//  UILabel+Common.h
//  IOSFramework
//
//  Created king on 15-3-25.
//  Copyright (c) 2015年 IOSFramework. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Common)

- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width;
- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight;
- (void) setLongString:(NSString *)str withVariableWidth:(CGFloat)maxWidth;

@end
