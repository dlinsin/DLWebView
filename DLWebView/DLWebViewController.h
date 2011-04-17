//
//  DLWebViewController.h
//
//  Created by David Linsin on 4/13/11.
//  Copyright 2011 furryfishApps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kStartURL @"http://google.com"

@interface DLWebViewController : UIViewController<UIWebViewDelegate, UITextFieldDelegate> {
    IBOutlet UIWebView *webView;
    IBOutlet UIButton *back;
    IBOutlet UIButton *forward;    
    IBOutlet UILabel *titleLabel;
    IBOutlet UITextField *urlField;
    IBOutlet UIBarButtonItem *edit;
    
    NSString *currentUrl;
    BOOL urlFieldVisible;
    BOOL wasUrlFieldVisible;
}

- (IBAction)back:(id)sender;
- (IBAction)forward:(id)sender;

- (void)load:(NSURL*)url;

- (IBAction)showUrlField:(id)sender;

@property (retain,nonatomic) UIWebView *webView;
@property (retain,nonatomic) UIButton *back;
@property (retain,nonatomic) UIButton *forward;
@property (retain,nonatomic) UILabel *titleLabel;
@property (retain,nonatomic) UITextField *urlField;
@property (retain,nonatomic) UIBarButtonItem *edit;

@property (retain,nonatomic) NSString *currentUrl;
@property (nonatomic) BOOL urlFieldVisible;

@end
