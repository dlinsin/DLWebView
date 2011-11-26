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
