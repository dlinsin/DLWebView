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
    UIBarButtonItem *edit;
    
    NSString *currentUrl;
    BOOL urlFieldVisible;
    BOOL wasUrlFieldVisible;
}

- (IBAction)refresh:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)forward:(id)sender;

- (void)load:(NSURL*)url;

- (IBAction)showUrlField:(id)sender;

@property (retain,nonatomic) UIWebView *webView;
@property (retain,nonatomic) UIButton *refresh;
@property (retain,nonatomic) UIButton *back;
@property (retain,nonatomic) UIButton *forward;
@property (retain,nonatomic) UILabel *titleLabel;
@property (retain,nonatomic) UITextField *urlField;
@property (retain,nonatomic) UIBarButtonItem *edit;

@property (retain,nonatomic) NSString *currentUrl;
@property (nonatomic) BOOL urlFieldVisible;

@end
