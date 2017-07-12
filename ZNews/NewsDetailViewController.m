//
//  NewsDetailViewController.m
//  ZNews
//
//  Created by wei zhao on 2017/7/7.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController () <WKNavigationDelegate>{
    WKWebView *_newsWebView;
    MBProgressHUD *_progressHUD;
}
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _requestURLString = self.param[@"url"];
    [self addNewsWebView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    NSLog(@"willapear");
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"didappear,%d",_newsWebView.loading);
}


- (void) addNewsWebView {
    _newsWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    _newsWebView.allowsLinkPreview = YES;
    _newsWebView.navigationDelegate = self;
    [self.view addSubview:_newsWebView];
    [_newsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.requestURLString]]];
    _progressHUD = [MBProgressHUD showHUDAddedTo:_newsWebView animated:YES];
    _progressHUD.label.text = @"努力加载中...";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*! @abstract Decides whether to allow or cancel a navigation.
 @param webView The web view invoking the delegate method.
 @param navigationAction Descriptive information about the action
 triggering the navigation request.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationActionPolicy.
 @discussion If you do not implement this method, the web view will load the request or, if appropriate, forward it to another application.
 */
//1 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"decidePolicyForNavigationAction");
    decisionHandler(WKNavigationActionPolicyAllow);

}

/*! @abstract Decides whether to allow or cancel a navigation after its
 response is known.
 @param webView The web view invoking the delegate method.
 @param navigationResponse Descriptive information about the navigation
 response.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationResponsePolicy.
 @discussion If you do not implement this method, the web view will allow the response, if the web view can show it.
 */

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"decidePolicyForNavigationResponse");
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/*! @abstract Invoked when a main frame navigation starts.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */

// 2 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"didStartProvisionalNavigation");

}

/*! @abstract Invoked when a server redirect is received for the main
 frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");

}

/*! @abstract Invoked when an error occurs while starting to load data for
 the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"didFailProvisionalNavigation");

}

/*! @abstract Invoked when content starts arriving for the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"didCommitNavigation");
    
}

/*! @abstract Invoked when a main frame navigation completes.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"didFinishNavigation");
    _progressHUD.hidden = YES;
    [_progressHUD removeFromSuperViewOnHide];
    //去掉遮罩
}

/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"didFailNavigation");
}

/*! @abstract Invoked when the web view needs to respond to an authentication challenge.
 @param webView The web view that received the authentication challenge.
 @param challenge The authentication challenge.
 @param completionHandler The completion handler you must invoke to respond to the challenge. The
 disposition argument is one of the constants of the enumerated type
 NSURLSessionAuthChallengeDisposition. When disposition is NSURLSessionAuthChallengeUseCredential,
 the credential argument is the credential to use, or nil to indicate continuing without a
 credential.
 @discussion If you do not implement this method, the web view will respond to the authentication challenge with the NSURLSessionAuthChallengeRejectProtectionSpace disposition.
 */
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
//    
//    NSLog(@"didReceiveAuthenticationChallenge");
//    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling,);
//
//}

/*! @abstract Invoked when the web view's web content process is terminated.
 @param webView The web view whose underlying web content process was terminated.
 */
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0)){
    NSLog(@"webViewWebContentProcessDidTerminate");
}


- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    // setup a list of preview actions
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"删除" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"删除");
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"标记已读" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"标记已读");
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"不感兴趣" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"不感兴趣");
    }];
    
    NSArray *actions = @[action1,action2,action3];
    
    // and return them (return the array of actions instead to see all items ungrouped)
    return actions;
}

@end
