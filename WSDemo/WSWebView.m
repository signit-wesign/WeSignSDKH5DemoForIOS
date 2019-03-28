//
//  WSWebView.m
//  WSDemo
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019 signit. All rights reserved.
//

#import "WSWebView.h"
#import <WebKit/WebKit.h>
@interface WSWebView ()<UIWebViewDelegate, WKNavigationDelegate>

@end

@implementation WSWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCloseUI];
    [self loadWeb];
}

- (void)loadWeb {
    _web.delegate = self;
    _web.allowsPictureInPictureMediaPlayback = true;
    NSURL *url = [NSURL URLWithString:_urlString];
    [_web loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - WKNavigationDelegate
//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"页面开始加载时调用。   2");
}
//内容返回时调用，得到请求内容时调用(内容开始加载) -> view的过渡动画可在此方法中加载
- (void)webView:(WKWebView *)webView didCommitNavigation:( WKNavigation *)navigation
{
    NSLog(@"内容返回时调用，得到请求内容时调用。 4");
}
//页面加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:( WKNavigation *)navigation
{
    NSLog(@"页面加载完成时调用。 %@", webView.URL.absoluteString);
}
//请求失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"error1:%@",error);
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"error2:%@",error);
}
//在请求发送之前，决定是否跳转 -> 该方法如果不实现，系统默认跳转。如果实现该方法，则需要设置允许跳转，不设置则报错。
//该方法执行在加载界面之前
//Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Completion handler passed to -[ViewController webView:decidePolicyForNavigationAction:decisionHandler:] was not called'
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    
    //不允许跳转
    //    decisionHandler(WKNavigationActionPolicyCancel);
    NSLog(@"在请求发送之前，决定是否跳转。  1");
}
//在收到响应后，决定是否跳转（同上）
//该方法执行在内容返回之前
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //    decisionHandler(WKNavigationResponsePolicyCancel);
    NSLog(@"在收到响应后，决定是否跳转。 3");
    
}

//接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"接收到服务器跳转请求之后调用");
}
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    NSLog(@"webViewWebContentProcessDidTerminate");
}


#pragma mark - UIWebViewDelegate

//是否允许加载网页，也可获取js要打开的url，通过截取此url可与js交互
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"是否允许加载:%@", request.URL.absoluteString);
    return TRUE;
}
//开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

//网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

//网页加载错误
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"error:%@", error);
}

//添加一个关闭按钮用于关闭页面
- (void)setupCloseUI {
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(onCloseWebView:)];
    self.navigationItem.rightBarButtonItem = closeBtn;
}

- (IBAction)onCloseWebView:(id)sender {
    NSLog(@"点击了关闭页面");
    [self.navigationController popViewControllerAnimated:YES];
}


@end
