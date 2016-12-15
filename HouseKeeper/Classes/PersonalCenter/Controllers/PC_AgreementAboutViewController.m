//
//  PC_AgreementAboutViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/12/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PC_AgreementAboutViewController.h"

@interface PC_AgreementAboutViewController ()

@property (nonatomic, copy) NSString *plistKey;//从plist文件获取内容的key
@property (nonatomic, copy) NSString *labelText;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UITextView *textView;

@end

@implementation PC_AgreementAboutViewController

#pragma mark - life circle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.receiveParams[@"title"];
    self.plistKey = self.receiveParams[@"plistKey"];
    
    NSDictionary *dic = @{@"Agreement":kAgreenment,@"About":kAbout};
    _labelText = dic[self.plistKey];
    
    
//    [self setupSubViews];
    [self.view addSubview:self.textView];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    self.hidesBottomBarWhenPushed = YES;
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    NSDictionary *textAttributes = nil;
    textAttributes = @{
                       NSFontAttributeName: [UIFont boldSystemFontOfSize:kNavTitleFontSize],
                       NSForegroundColorAttributeName: [UIColor whiteColor],
                       };
    
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    [navigationBarAppearance setShadowImage:[UIImage imageWithColor:KMajorColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - method

- (void)setupSubViews{
    [self.view addSubview:self.scrollView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_lessThanOrEqualTo(MAXFLOAT);
    }];
}

#pragma mark - event


/**
 去除字符串中的转义字符

 @param string 原字符串
 @return 转义后的字符串
 */
- (NSString *)ecodeWithString:(NSString *)string{
    NSMutableString *responseString = [NSMutableString stringWithString:string];
    
    NSString *character = nil;
    
    for (int i = 0; i < responseString.length; i ++) {
        
        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        
        if ([character isEqualToString:@"\\"])
            
            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
        
    }
    return responseString;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

#pragma mark - getter && setter

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:kViewFrame];
        _textView.font = kFont14;
        _textView.textColor = [UIColor blackColor];
        _textView.text = _labelText;
        _textView.editable = NO;
    }
    return _textView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:kViewFrame];
//        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView addSubview:self.label];
        _scrollView.contentSize = CGSizeMake(kScreen_Width, [_labelText sizeWithFont:_label.font Size:CGSizeMake(kScreen_Width, MAXFLOAT)].height);
    }
    return _scrollView;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = kFont14;
        _label.textColor = [UIColor blackColor];
        _label.numberOfLines = 0;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        _label.backgroundColor = [UIColor whiteColor];
        _label.attributedText = [[NSAttributedString alloc] initWithString:_labelText];
    }
    return _label;
}

#pragma mark - API

#pragma mark - override

@end
