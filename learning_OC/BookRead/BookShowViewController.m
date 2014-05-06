//
//  BookShowViewController.m
//  learning_OC
//
//  Created by test on 4/1/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "BookShowViewController.h"

#import "EGOImageView.h"
#import "GQTCommons.h"

@interface BookShowViewController ()

- (void)showCurrentPage;

@end

@implementation BookShowViewController

@synthesize currentChapter;
@synthesize currentContentInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self showCurrentPage];
    
    self.Scroll_Content.zoomScale = 1.0;
    [self.Scroll_Content setMinimumZoomScale:1.0];
    [self.Scroll_Content setMaximumZoomScale:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [currentChapter release];
    [currentContentInfo release];
    
    [_label_title release];
    [_Scroll_Content release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setLabel_title:nil];
    [self setScroll_Content:nil];
    [super viewDidUnload];
}

#pragma mark - UIScrollView Delegate
- (UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView {
    UIView *view = [scrollView viewWithTag:20130402];
    
    return view;
}

- (void)showCurrentPage{
    self.navigationItem.title = self.currentContentInfo.bookName;
    
    self.label_title.text = self.currentContentInfo.contentTitle;
    
    if (currentContentInfo.type == BookTypeText) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.Scroll_Content.frame.size.width, self.Scroll_Content.frame.size.height + (iPhone5 ? 43 : -21))];
        [webView loadHTMLString:self.currentContentInfo.content baseURL:nil];
        [self.Scroll_Content addSubview:webView];
        [webView release];
        
    }else {
        EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"ico_nophoto.png"]];
        [imageView setImageURL:[NSURL URLWithString:[GQTCommons getImageUrl:self.currentContentInfo.content]]];
        imageView.frame = CGRectMake(0, 0, self.Scroll_Content.frame.size.width, self.Scroll_Content.frame.size.height + (iPhone5 ? 43 : -21));
        imageView.tag = 20130402;
        [self.Scroll_Content addSubview:imageView];
        [imageView release];
    }
}
@end
