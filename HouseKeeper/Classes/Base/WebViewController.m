//
//  BQIWebViewController.m
//  BoqiiPlant
//
//  Created by admin on 16/8/9.
//
//

#import "WebViewController.h"
#import "UIWebView+AFNetworking.h"
#import "WXApiObject.h"
#import "WXApi.h"

@interface WebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UIWebViewDelegate>

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
//    [self.view addSubview:self.webView];
    [self.view addSubview:self.uiWebView];
    if (htmlString) {
        [_webView loadHTMLString:htmlString baseURL:nil];
    }
    else{
//        [_webView loadRequest:request];
        [_uiWebView loadRequest:request];
    }
//    [self.view addSubview:self.progressView];
    
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
        WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc]init];
        
        config.preferences = [[WKPreferences alloc] init];
        // 默认为0
        config.preferences.minimumFontSize = 10;
        // 默认认为YES
        config.preferences.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
        
        _webView = [[WKWebView alloc]initWithFrame:kViewFrame configuration:config];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (UIWebView *)uiWebView{
    if (!_uiWebView) {
        _uiWebView = [[UIWebView alloc] initWithFrame:kViewFrame];
        _uiWebView.delegate = self;
    }
    return _uiWebView;
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


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSURL *url = [NSURL URLWithString:@"http://120.24.217.250:8001/service/advertisement/buy"];
    if ([url isEqual:webView.request.URL]) {
        NSLog(@"%@", webView.request.URL);
        NSString *jsonString = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
        
        jsonString = [NSString filterHTML:jsonString];
        
        NSDictionary *dic = [NSString dictionaryWithJsonString:jsonString];
        [webView goBack];
        if ([dic[@"code"] integerValue] == 1) {
            [self creatWxPayReq:dic];
        }
        
    }
    
}


#pragma mark - Deleaget

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{

}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSString *jsonString = message.body;
    NSLog(@"%@", jsonString);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    [webView evaluateJavaScript:@"javascript:history.back()" completionHandler:^(id item, NSError * _Nullable error) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
    
    NSURL *url = [NSURL URLWithString:@"http://120.24.217.250:8001/service/advertisement/buy"];
    if ([url isEqual:webView.URL]) {
        NSLog(@"%@", webView.URL);
        
    }
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo{
    NSLog(@"%@", elementInfo.linkURL);
    return YES;
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    //判断是否是单击
//    if (navigationType == UIWebViewNavigationTypeLinkClicked)
//    {
//        NSURL *url = [request URL];
//        if([[UIApplication sharedApplication]canOpenURL:url])
//        {
//            [[UIApplication sharedApplication]openURL:url];
//        }
//        return NO;
//    }
//    return YES;
//}

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

//微信支付创建PayReq对象

- (void)creatWxPayReq:(NSDictionary *)data{
    
    NSDictionary *result = data[@"data"][@"result"];
    
    // 调起微信支付
    PayReq *payReq = [[PayReq alloc] init];
    payReq.prepayId = result[@"prepay_id"];
    payReq.openID = result[@"appid"];
    payReq.partnerId = result[@"mch_id"];
    //商家根据财付通文档填写的数据和签名 <暂填写固定值Sign=WXPay>
    payReq.package = @"Sign=WXPay";
    // 随机串，防重发
    payReq.nonceStr = result[@"nonce_str"];
    //时间戳，防重发
    payReq.timeStamp = (int32_t)[data[@"data"][@"timestamp"] doubleValue];
    // 商家根据微信开放平台文档对数据做的签名
    
    payReq.sign = result[@"sign"];
    
    payReq.sign = [self createMD5SingWithPayReq:payReq];
    //发送支付请求
    BOOL  isScusess = [WXApi sendReq:payReq];
    if (isScusess) {
        NSLog(@"[WXApi sendReq:payReq] 成功");
    }
    else{
        NSLog(@"[WXApi sendReq:payReq] 出错");
    }
    
}
//创建发起支付时的sige签名

-(NSString *)createMD5SingWithPayReq:(PayReq *)payReq{
    
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject:payReq.openID forKey:@"appid"];
    [signParams setObject:payReq.nonceStr forKey:@"noncestr"];
    [signParams setObject:payReq.package forKey:@"package"];
    [signParams setObject:payReq.partnerId forKey:@"partnerid"];
    [signParams setObject:payReq.prepayId forKey:@"prepayid"];
    [signParams setObject:[NSString stringWithFormat:@"%u",(unsigned int)payReq.timeStamp] forKey:@"timestamp"];
    
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [signParams allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[signParams objectForKey:categoryId] isEqualToString:@""]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [signParams objectForKey:categoryId]];
        }
    }
    //添加商户密钥key字段 kWXBusinessSecretKey是宏定义的商户秘钥
    [contentString appendFormat:@"key=%@", kWXBusinessSecretKey];
    NSString *result = [contentString md5Str];
    
    NSLog(@"result = %@",result);
    return result;
}


@end
