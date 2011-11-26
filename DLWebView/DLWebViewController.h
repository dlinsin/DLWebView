//
//  DLWebViewController.h
//
//  Created by David Linsin on 4/13/11.
//  Copyright 2011 furryfishApps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kStartURL @"http://google.com"

@interface DLWebViewController : UIViewController<UIWebViewDelegate, UITextFieldDelegate> {
    UIWebView *webView;
    UIButton *refresh;
    UIButton *back;
    UIButton *forward;    
    UILabel *titleLabel;
    UITextField *urlField;
    IBOutlet UIBarButtonItem *edit;
    
    NSString *currentUrl;
    BOOL urlFieldVisible;
    BOOL wasUrlFieldVisible;
}

- (IBAction)refresh:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)forward:(id)sender;

- (void)load:(NSURL*)url;

- (IBAction)showUrlField:(id)sender;

@property (strong,nonatomic) UIWebView *webView;
@property (strong,nonatomic) UIButton *refresh;
@property (strong,nonatomic) UIButton *back;
@property (strong,nonatomic) UIButton *forward;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UITextField *urlField;
@property (strong,nonatomic) UIBarButtonItem *edit;

@property (strong,nonatomic) NSString *currentUrl;
@property (nonatomic) BOOL urlFieldVisible;

@end
