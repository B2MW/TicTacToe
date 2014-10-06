//
//  SecondViewController.m
//  TicTacToe
//
//  Created by Bradley Walker on 10/4/14.
//  Copyright (c) 2014 BlackSummerVentures. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <UIWebViewDelegate>
#pragma mark - Class Properties
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SecondViewController

#pragma mark - UI Navigation and Loading Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self loadPage:@"http://wikipedia.org/wiki/Tic-tac-toe"];
}
- (void) loadPage:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

#pragma mark - Web View Elements
- (void):(UIWebView *)webView {
    [self.activityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
    [self.activityIndicator isHidden];
}

@end
