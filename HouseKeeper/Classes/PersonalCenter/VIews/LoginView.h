//
//  LoginView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/20.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseVIew.h"

@interface ThirdPartyButton : UIButton

@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *textLabel;

@end

@protocol LoginViewDelegate <NSCoding>

- (void)loginEvent;

- (void)sendCodeEvent;

@end

@interface LoginView : BaseVIew

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton *codeButton;
@property (nonatomic ,strong) UIButton *loginButton;

@property (nonatomic, strong) UIView *divisionView;

@property (nonatomic, strong) UIButton *wechartButton;
@property (nonatomic, strong) UIButton *weiboButton;
@property (nonatomic, strong) UIButton *qqButton;

//@property (nonatomic, strong) ThirdPartyButton *wechartButton;
//@property (nonatomic, strong) ThirdPartyButton *weiboButton;
//@property (nonatomic, strong) ThirdPartyButton *qqButton;

@property (nonatomic, weak) id<LoginViewDelegate> delegate;

@end


