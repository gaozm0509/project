//
//  BQIWebViewController.m
//  BoqiiPlant
//
//  Created by admin on 16/8/9.
//
//

#import "WebViewController.h"
#import <objc/runtime.h>

@interface WebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation WebViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.receiveParams[@"title"];
    
    NSString *url = self.receiveParams[@"url"];
    
    NSString *htmlString = self.receiveParams[@"htmlString"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.view addSubview:self.webView];
    if (htmlString) {
        [_webView loadHTMLString:htmlString baseURL:nil];
    }
    else{
        [_webView loadRequest:request];
    }
    [self.view addSubview:self.progressView];
    [self load];
    
//    UINavigationController *nav = self.navigationController;
//    UIBarButtonItem *bar = nav.navigationBar.backItem.backBarButtonItem;
////    bar.action = @selector(click);
////    bar.target = nil;
////    bar.title = @"123";
    
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
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

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - Get and set

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:kViewFrame];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

-(UIProgressView *)progressView{
    if (!_progressView ) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 2)];
        _progressView.progressTintColor = KMajorColor;
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progress = 0;
    }
    return _progressView;
}

#pragma mark - Deleaget

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{

}


#pragma mark - Event

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [UIView animateWithDuration:0.3 animations:^{
            
            [_progressView setProgress:_webView.estimatedProgress];
            [_progressView layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
            if (_progressView.progress == 1) {
                [_progressView removeFromSuperview];
            };
            
        }];
    }
}

+ (void)backClick{
    NSLog(@"click");
}

#pragma mark - NetApi




#pragma mark - Pravit method


- (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        UINavigationController *nav = self.navigationController;
        UIBarButtonItem *bar = nav.navigationBar.backItem.backBarButtonItem;
        
        Class selfClass = object_getClass([self class]);
        Class barClass = object_getClass([bar class]);
        
        SEL oriSEL = bar.action;
        Method oriMethod = class_getInstanceMethod(barClass, oriSEL);
        
        SEL cusSEL = @selector(backClick);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
        
        BOOL addSucc = class_addMethod(barClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }
        
    });
}

@end
