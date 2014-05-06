//
//  GQTBookReadViewController.m
//  learning_OC
//
//  Created by test on 3/23/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTBookReadViewController.h"

#import "NSObject+SBJson.h"
#import "EGOImageView.h"
#import "GQTCommons.h"

@interface GQTBookReadViewController ()

@end

@implementation GQTBookReadViewController

@synthesize currentContentInfo;
@synthesize currentChapter;
@synthesize book;

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
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?bookId=%d&page=%d",CR_URL_BOOK_DETAIL,book.bookId,currentChapter.chapterPageNumber];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.timeOutSeconds = 20;
    request.delegate = self;
    [request startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [currentChapter release];
    [currentContentInfo release];
    [book release];
    
    [_label_Title release];
    [_scollView_Content release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setLabel_Title:nil];
    [self setScollView_Content:nil];
    [super viewDidUnload];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *responseStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    
    NSDictionary *valueDic = [responseStr JSONValue];
    NSInteger state = [[valueDic objectForKey:@"state"] integerValue];
    if (state == 200) {
        
        GQTBOOKContentInfo *content = [[GQTBOOKContentInfo alloc] init];
        content.contentId = [[valueDic objectForKey:@"contentId"] integerValue];
        content.contentPage = [[valueDic objectForKey:@"contentPage"] integerValue];
        content.contentTitle = [valueDic objectForKey:@"contentTitle"];
        content.content = [valueDic objectForKey:@"content"];
        if ([content.content hasPrefix:@"/"] ) {
            content.type = BookTypeImage;
        }else{
            content.type = BookTypeText;
        }
        
        content.bookId = [[valueDic objectForKey:@"bookId"] integerValue];
        content.bookAuthor = [valueDic objectForKey:@"bookAuthor"];
        content.bookName = [valueDic objectForKey:@"bookName"];
        
        self.currentContentInfo = content;
        [self showCurrentPage];
        
        [content release];
    }
}

- (void)showCurrentPage{
    self.navigationItem.title = self.currentContentInfo.bookName;
    
    self.label_Title.text = self.currentContentInfo.contentTitle;
    
    if (currentContentInfo.type == BookTypeText) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.scollView_Content.frame.size.width, self.scollView_Content.frame.size.height)];
        [webView loadHTMLString:self.currentContentInfo.content baseURL:nil];
        [self.scollView_Content addSubview:webView];
        [webView release];
        
        
//        UITextView *textView = [[UITextView alloc] init];
//        textView.frame = CGRectMake(0, 0, self.scollView_Content.frame.size.width, self.scollView_Content.frame.size.height);
//        [textView setFont:[UIFont systemFontOfSize:12]];
//        [textView setBackgroundColor:[UIColor clearColor]];
//        [textView setText:self.currentContentInfo.content];
//        [self.scollView_Content addSubview:textView];
//        [textView release];
    }else {
        EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"ico_nophoto.png"]];
        [imageView setImageURL:[NSURL URLWithString:[GQTCommons getImageUrl:self.currentContentInfo.content]]];
        imageView.frame = CGRectMake(0, 0, self.scollView_Content.frame.size.width, self.scollView_Content.frame.size.height);
        [self.scollView_Content addSubview:imageView];
        [imageView release];
    }

}

@end
