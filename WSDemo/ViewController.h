//
//  ViewController.h
//  WSDemo
//
//  Created by apple on 2019/2/14.
//  Copyright © 2019 signit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)onIdentifyOnline:(id)sender;
- (IBAction)onSignautreOnline:(id)sender;
@property(nonatomic, strong) IBOutlet UITextField *identify_url;
@property(nonatomic, strong) IBOutlet UITextField *signature_url;
@end

