/*

    DLWebView
    Copyright (C) 2011 David Linsin <dlinsin@gmail.com>

    All rights reserved. This program and the accompanying materials
    are made available under the terms of the Eclipse Public License v1.0
    which accompanies this distribution, and is available at
    http://www.eclipse.org/legal/epl-v10.html

*/

#import "DLWebViewController.h"


@implementation DLWebViewController

@synthesize webView, refresh, back, forward, titleLabel, urlField, edit, currentUrl, urlFieldVisible;

- (void)load:(NSURL*)url {
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)buttonState {
    if (![self.webView canGoBack]) {
        self.back.enabled = NO;
    } else {
        self.back.enabled = YES;
    }
    
    if (![self.webView canGoForward]) {
        self.forward.enabled = NO;
    } else {
        self.forward.enabled = YES;
    }
}

#pragma mark - Button handling

- (IBAction)refresh:(id)sender {
    [self.webView stopLoading]; 
    [self load:[NSURL URLWithString:self.currentUrl]];
}

- (IBAction)back:(id)sender {
    [self.webView goBack]; 
    [self buttonState];
}

- (IBAction)forward:(id)sender {
    [self.webView goForward];
    [self buttonState];
}

- (void)hideUrlField {
    if (urlFieldVisible) {
        float yPos = 6.0;
        if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            yPos = 0.0;
        }
        
        self.edit.title = @"Edit";
        [self.urlField resignFirstResponder];
        CGRect target = CGRectMake(-260, yPos, self.urlField.frame.size.width, self.urlField.frame.size.height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.urlField.frame = target;
        [UIView commitAnimations];
        self.urlFieldVisible = NO;
    }
}

- (IBAction)showUrlField:(id)sender {
    float yPos = 6.0;
    if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        yPos = 0.0;
    }
    
    if (!urlFieldVisible) {
        self.edit.title = @"Cancel";
        self.urlField.text = self.currentUrl;
        
        CGRect target = CGRectMake(4.0, yPos, self.urlField.frame.size.width, self.urlField.frame.size.height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.urlField.frame = target;
        [UIView commitAnimations];
        [self.urlField becomeFirstResponder];
        self.urlFieldVisible = YES;
    } else {
        [self hideUrlField];
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)_webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    self.currentUrl = [[request URL] absoluteString];
    NSString *theTitle = [[request URL] path];
    self.titleLabel.text = theTitle;
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)_webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self buttonState];
}

- (void)webViewDidFinishLoad:(UIWebView *)_webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self buttonState];
    NSString *theTitle=[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.titleLabel.text = theTitle;
}

- (void)webView:(UIWebView *)_webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self buttonState];
}

#pragma mark - UITextFieldDelegate

- (BOOL) validateUrl: (NSString *) url {
    NSString *theURL =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", theURL]; 
    return [urlTest evaluateWithObject:url];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text length] > 0 && [self validateUrl:textField.text]) {
        [self load:[NSURL URLWithString:textField.text]];
        [self showUrlField:nil];
        return YES;
    }
    return NO;
}


#pragma mark - View lifecycle

- (void)positionPortrait {
    self.refresh.frame = CGRectMake(6, 12.0, self.refresh.frame.size.width, self.refresh.frame.size.height);
    self.back.frame = CGRectMake(30, 4.0, self.back.frame.size.width, self.back.frame.size.height);
    self.forward.frame = CGRectMake(67, 4.0, self.forward.frame.size.width, self.forward.frame.size.height);
    self.titleLabel.frame = CGRectMake(100, 10.0, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    self.urlField.frame = CGRectMake(-260, 6.0, self.urlField.frame.size.width, self.urlField.frame.size.height);
}

- (void)positionLandscape {
    self.refresh.frame = CGRectMake(6, 5.0, self.refresh.frame.size.width, self.refresh.frame.size.height);
    self.back.frame = CGRectMake(30, -2.0, self.back.frame.size.width, self.back.frame.size.height);
    self.forward.frame = CGRectMake(67, -2.0, self.forward.frame.size.width, self.forward.frame.size.height);
    self.titleLabel.frame = CGRectMake(100, 5.0, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    self.urlField.frame = CGRectMake(-260, 0.0, self.urlField.frame.size.width, self.urlField.frame.size.height);    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self.navigationController navigationBar] addSubview:self.refresh];
    [[self.navigationController navigationBar] addSubview:self.back];
    [[self.navigationController navigationBar] addSubview:self.forward];
    [[self.navigationController navigationBar] addSubview:self.titleLabel];
    [[self.navigationController navigationBar] addSubview:self.urlField];
    [self positionPortrait];
    [self buttonState];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.webView stopLoading];
    [self.webView removeFromSuperview];
    [self.refresh removeFromSuperview];
    [self.back removeFromSuperview];
    [self.forward removeFromSuperview];
    [self.urlField removeFromSuperview];
    [self.titleLabel removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)] autorelease];
    self.webView.scalesPageToFit = YES;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.webView.delegate = self;
    
    self.refresh = [UIButton buttonWithType:UIButtonTypeCustom];
    self.refresh.contentMode = UIViewContentModeScaleAspectFit;
    self.refresh.frame = CGRectMake(0, 0, 20, 22);
    [self.refresh setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [self.refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    
    self.back = [UIButton buttonWithType:UIButtonTypeCustom];
    self.back.frame = CGRectMake(0, 0, 30, 36);
    [self.back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];

    self.forward = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forward.frame = CGRectMake(0, 0, 30, 36);
    [self.forward setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
    [self.forward addTarget:self action:@selector(forward:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 21)] autorelease];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    self.urlField = [[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 242, 31)] autorelease];
    self.urlField.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    self.urlField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.urlField.returnKeyType = UIReturnKeyGo;
    self.urlField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.urlField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.urlField.keyboardType = UIKeyboardTypeURL;
    self.urlField.borderStyle = UITextBorderStyleRoundedRect;
    self.urlField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.urlField.delegate = self;
    
    [self.view addSubview:self.webView];
    
    [self load:[NSURL URLWithString:kStartURL]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.webView = nil;
    self.refresh = nil;
    self.back = nil;
    self.forward = nil;
    self.titleLabel = nil;
    self.urlField = nil;
    self.edit = nil;
    self.currentUrl = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (self.urlFieldVisible) {
        wasUrlFieldVisible = YES;
        [self hideUrlField];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (UIInterfaceOrientationIsPortrait(fromInterfaceOrientation)) {
        [self positionLandscape];
    } else {
        [self positionPortrait];
    }
    if (wasUrlFieldVisible) {
        wasUrlFieldVisible = NO;
        [self showUrlField:nil];
    }
}


- (void)dealloc {
    [webView release];
    [refresh release];
    [back release];
    [forward release];
    [titleLabel release];
    [urlField release];
    [edit release];
    [currentUrl release];
    [super dealloc];
}

@end