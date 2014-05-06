//
//  BookReadViewController.m
//  learning_OC
//
//  Created by test on 3/23/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "BookReadViewController.h"

#import "BookShowViewController.h"

#import "UITools.h"
#import "NSObject+SBJson.h"

@interface BookReadViewController (){
    
    NSMutableArray *bookContentArr;
    int bookPosition;
}

@property (assign, nonatomic) int bookPosition;
@property (retain, nonatomic) NSMutableArray *bookContentArr;

- (void)showPrePage;
- (void)showCurrentPage;
- (void)showNextPage;

- (void)sendRequestToServersWithBookId:(int)bookId chapterId:(int)chapterId requestTag:(PageType)tag;
- (void)changeBookContentView:(BOOL)isLeft;

@end

@implementation BookReadViewController

@synthesize book;

@synthesize currentContentInfo;
@synthesize subviewsArray;
@synthesize chapterArr;
@synthesize currentChapter;
@synthesize bookContentArr;
@synthesize bookPosition;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        type = PageTypeCur;
        willshowType = PageTypeCur;
        bookPosition = 0;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self sendRequestToServersWithBookId:self.book.bookId chapterId:currentChapter.chapterPageNumber requestTag:type];
    
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
    [recognizer release];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer];
    [recognizer release];
}

//触摸事件 的实现函数
//滑动事件1
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    //如果往右滑
    BOOL isleft = TRUE;
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
//        NSLog(@"****************向右滑****************");
        int position = [self.chapterArr indexOfObject:self.currentChapter];
        if (position >= 1) {
            self.currentChapter = [self.chapterArr objectAtIndex:position - 1];
            self.currentContentInfo = [self.bookContentArr objectAtIndex:(bookPosition + 2)%3];

            [self.bookContentArr replaceObjectAtIndex:(bookPosition + 1) %3 withObject:@""];
            isleft = FALSE;
            bookPosition = (bookPosition + 2)%3;
        }else{
            
            return;
        }
        
    }
    //如果往左滑
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
//        NSLog(@"****************向左滑****************");
        int position = [self.chapterArr indexOfObject:self.currentChapter];
        if (position < [self.chapterArr count] - 1) {
            self.currentChapter = [self.chapterArr objectAtIndex:position + 1];
            self.currentContentInfo = [self.bookContentArr objectAtIndex:(bookPosition + 1)%3];
            
            [self.bookContentArr replaceObjectAtIndex:(bookPosition + 2)%3 withObject:@""];
                        
            bookPosition = (bookPosition + 1)%3;
            isleft = TRUE;
        }else{
            
            return;
        }
    }
    
    [self changeBookContentView:isleft];
}



- (void)getNearBookContent{
    GQTBOOKContentInfo *nextBook = [self.bookContentArr objectAtIndex:((bookPosition + 1)%3)];
    GQTBOOKContentInfo *preBook = [self.bookContentArr objectAtIndex:((bookPosition + 2)%3)];
    
     int position = [self.chapterArr indexOfObject:self.currentChapter];
    
    if (nextBook == nil || [nextBook isEqual:@""]) {
        
        if (position + 1 <= [self.chapterArr count] - 1) {
            GQTBookChapterInfo *chapter = [self.chapterArr objectAtIndex:position + 1];
            
            [self sendRequestToServersWithBookId:self.book.bookId chapterId:chapter.chapterPageNumber requestTag:PageTypeNext];
        }else
            return;

    }
    
    if (preBook == nil || [preBook isEqual:@""]) {
        if (position - 1 >= 0) {
            GQTBookChapterInfo *chapter = [self.chapterArr objectAtIndex:position - 1];
            [self sendRequestToServersWithBookId:self.book.bookId chapterId:chapter.chapterPageNumber requestTag:PageTypePre];
        }else
            return;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    bookContentArr = [[NSMutableArray alloc] initWithObjects:@"",@"",@"", nil];
    subviewsArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"", nil];
    
    
    CGRect rect = self.scrollView_Content.frame;
    rect.size.height += (iPhone5 ? 88 : 0);
    self.scrollView_Content.frame = rect;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollView delegate   判断是否滚动的
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

#pragma mark - make the book content show
- (void)showPrePage{
    BookShowViewController *showController = [[BookShowViewController alloc] init];
    
    int position = [self.chapterArr indexOfObject:self.currentChapter];
    if (position >= 1) {
        showController.currentChapter = [self.chapterArr objectAtIndex:(position - 1)];
    }else{
        [showController release];
        
        return;
    }
    
    showController.currentContentInfo = [self.bookContentArr objectAtIndex:(bookPosition + 2)%3];
    [self.subviewsArray replaceObjectAtIndex:(bookPosition + 2)%3 withObject:showController];
    [showController release];
}

- (void)showCurrentPage{
    BookShowViewController *showController = [[BookShowViewController alloc] init];
    showController.currentChapter = self.currentChapter;
    showController.currentContentInfo = [self.bookContentArr objectAtIndex:bookPosition%3];
    [self.subviewsArray replaceObjectAtIndex:bookPosition withObject:showController];
    [showController release];
}

- (void)showNextPage{
    BookShowViewController *showController = [[BookShowViewController alloc] init];
    
    int position = [self.chapterArr indexOfObject:self.currentChapter];
    if (position < [self.chapterArr count] - 1) {
        showController.currentChapter = [self.chapterArr objectAtIndex:(position + 1)];
    }else{
        [showController release];
        
        return;
    }
    
    showController.currentContentInfo = [self.bookContentArr objectAtIndex:(bookPosition + 1)%3];
    [self.subviewsArray replaceObjectAtIndex:(bookPosition + 1)%3 withObject:showController];
    [showController release];
}

#pragma mark - request Delegate
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
        
        if (request.tag == PageTypeCur) {
            
            self.currentContentInfo = content;
            [self.bookContentArr replaceObjectAtIndex:(bookPosition%3) withObject:content];
            [self showCurrentPage];
            
            [self changeBookContentView:FALSE];
        }else if(request.tag == PageTypeNext){
            [self.bookContentArr replaceObjectAtIndex:((bookPosition + 1)%3) withObject:content];
            [self showNextPage];
            
        }else if (request.tag == PageTypePre){
            
            [self.bookContentArr replaceObjectAtIndex:((bookPosition + 2)%3) withObject:content];
            [self showPrePage];
        }
        
        [content release];
    }
}


#pragma mark - segment select button click
- (void)changeBookContentView:(BOOL)isLeft{
    
    self.scrollView_Content.contentSize = CGSizeMake(320*[subviewsArray count], self.scrollView_Content.frame.size.height);
    
    [self.scrollView_Content setContentOffset:CGPointMake(320*bookPosition, 0) animated:NO];
    BookShowViewController *subViewController = (BookShowViewController *) [subviewsArray objectAtIndex:bookPosition];
    subViewController.view.frame = CGRectMake(bookPosition * 320, 0, 320, self.scrollView_Content.frame.size.height);
    
    if (subViewController == nil) {
        return ;
    }
    
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:0.7f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:(isLeft ? UIViewAnimationTransitionCurlUp :UIViewAnimationTransitionCurlDown) forView:self.view cache:YES];
    
    [self.scrollView_Content addSubview:subViewController.view];
    [self.scrollView_Content bringSubviewToFront:subViewController.view];
    
    [UIView commitAnimations];
    

    [self getNearBookContent];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [UITools showAlert:@"网络有问题，请检查网络!!" delegate:nil];
}

- (void)sendRequestToServersWithBookId:(int)bookId chapterId:(int)chapterId requestTag:(PageType)tag{
    NSString *urlStr = [NSString stringWithFormat:@"%@?bookId=%d&page=%d",CR_URL_BOOK_DETAIL,bookId,chapterId];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.timeOutSeconds = 20;
    request.tag = tag;
    request.delegate = self;
    [request startAsynchronous];
}

- (void)dealloc {
    [book release];
    [currentContentInfo release];
    [bookContentArr release];
    [subviewsArray release];
    
    [chapterArr release];
    [currentChapter release];
    
    [_scrollView_Content release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setScrollView_Content:nil];
    [super viewDidUnload];
}
@end
