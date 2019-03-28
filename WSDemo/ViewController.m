//
//  ViewController.m
//  WSDemo
//
//  Created by apple on 2019/2/14.
//  Copyright © 2019 signit. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "WSWebView.h"

@interface ViewController ()<WSWebViewDeledate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (BOOL)isValidUrl:(NSString *) string{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:string];
}


- (IBAction)onIdentifyOnline:(id)sender {
    NSLog(@"用户点击了在线实名认证");
    NSString *url = _identify_url.text;
    if (![self isValidUrl:url]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"请输入一个合法的实名认证链接" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:^{
                
            }];
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
    else {
        WSWebView *webViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WSWebView"];
        //TODO:实名认证链接:http://10.10.9.67:61112/WSID_LINK_00000169335874b57248cd3800560001/open-flow-enterprise-identity?token=53cb635440b64e579f18be857f6c7cac
        //签署链接是调用易企签开放平台实名认证接口后系统返回的链接。该链接的作用是引导用户完成账号的实名认证
        webViewController.urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];;
        webViewController.WSDelegate = self; //注册WSDelegate协议
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

- (IBAction)onSignautreOnline:(id)sender {
    NSLog(@"用户点击了在线签署");
    NSString *url = _signature_url.text;
    if (![self isValidUrl:url]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"请输入一个合法的签署链接" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:^{
                
            }];
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
    else
    {
        //TODO:签署链接
        //签署链接是调用易企签开放平台标准签署接口后系统返回的链接。该链接的作用是引导用户完成文件的签署
        WSWebView *webViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WSWebView"];
        webViewController.urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
         webViewController.WSDelegate = self; //注册WSDelegate协议
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

#pragma mark - WSWebViewDeledate

- (void)signatureWithSuccess:(NSString *)envelopeWsid
{
    NSLog(@"签署成功");
}

- (void)identifyWithSuccsee:(NSString *)phone {
    NSLog(@"提交认证成功，请耐心等待审核。企业认证审核周期为1-2个工作日。个人实名认证无需审核");
}
@end
