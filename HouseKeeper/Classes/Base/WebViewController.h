//
//  BQIWebViewController.h
//  BoqiiPlant
//
//  Created by admin on 16/8/9.
//
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController : BaseViewController

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) UIWebView *uiWebView;

@end
