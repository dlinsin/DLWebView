/*

    DLWebView
    Copyright (C) 2011 David Linsin <dlinsin@gmail.com>

    All rights reserved. This program and the accompanying materials
    are made available under the terms of the Eclipse Public License v1.0
    which accompanies this distribution, and is available at
    http://www.eclipse.org/legal/epl-v10.html

*/

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
