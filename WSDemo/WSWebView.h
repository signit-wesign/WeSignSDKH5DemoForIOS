//
//  WSWebView.h
//  WSDemo
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019 signit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol WSWebViewDeledate <NSObject>
@optional
- (void)signatureWithSuccess:(NSString *) envelopeWsid;
- (void)identifyWithSuccsee:(NSString * ) phone;
@end


@interface WSWebView : UIViewController
- (IBAction)onCloseWebView:(id)sender;
@property(strong, nonatomic) NSString *urlString;
@property(nonatomic, assign) id<WSWebViewDeledate> WSDelegate;
@property(nonatomic, strong) IBOutlet UIWebView *web;

@end

NS_ASSUME_NONNULL_END
