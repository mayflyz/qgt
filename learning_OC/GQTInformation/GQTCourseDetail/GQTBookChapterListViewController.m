//
//  GQTBookChapterListViewController.m
//  learning_OC
//
//  Created by test on 3/22/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTBookChapterListViewController.h"

#import "AppDelegate.h"
#import "NSObject+SBJson.h"

#import "GQTBookReadViewController.h"
#import "DirectionMPMoviePlayerViewController.h"

#import "BookReadViewController.h"
#import "Reachability.h"

@interface GQTBookChapterListViewController (){
    GQTVideoChapterInfo *m_video;
}
@property (retain, nonatomic)     GQTVideoChapterInfo *m_video;

- (void)handleBookJsonStr:(NSString *)jsonStr;
- (void)HandleVideoJsonStr:(NSString *)jsonStr;

@end

@implementation GQTBookChapterListViewController

@synthesize book;
@synthesize m_video;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        m_video = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    if (book.type == CourseTypeBook) {
        NSString *catelog = [NSString stringWithFormat:@"%@?id=%d",CR_URL_BOOK_CATELOG,book.bookId];
        NSString *urlStr = [catelog stringByAppendingString:@"&page=%d&row=%d"];
        
        [self setRequestFormat:urlStr requestMoreBy:RequestMoreByPageFromPage];
        
    }else if(book.type == CourseTypeVideo){
        NSString *catelog = [NSString stringWithFormat:@"%@?id=%d",CR_URL_VIDEO_CATELOG,book.bookId];
        NSString *urlStr = [catelog stringByAppendingString:@"&page=%d&row=%d"];
        
        [self setRequestFormat:urlStr requestMoreBy:RequestMoreByPageFromPage];
    }
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [m_video release];
    [book release];
    
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChapterListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 1)];
        label.tag = 101;
        label.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:label];
        [label release];
        
        UIImage *image_ = [UIImage imageNamed:@"tabholder_active"];
        UIImageView *imageView_ = [[UIImageView alloc] initWithFrame:CGRectMake(15, (cell.frame.size.height -15)/2, 15, 15)];
        
        imageView_.image = image_;
        [cell.contentView addSubview:imageView_];
        [imageView_ release];
        
        UILabel *label_ = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 200, 20)];
        label_.tag = 100;
        label_.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:label_];
        [label_ release];
    }
    
    if (indexPath.row == 0) {
        UILabel *label = (UILabel *)[cell viewWithTag:101];
        label.hidden = YES;
    }else{
        UILabel *label = (UILabel *)[cell viewWithTag:101];
        label.hidden = NO;
    }
    
    if (book.type == CourseTypeBook) {
        
        GQTBookChapterInfo *chapter = [self.dataArray objectAtIndex:indexPath.row];
        
        UILabel *label_name = (UILabel *)[cell.contentView viewWithTag:100];
        label_name.text = chapter.chapterTitle;
    }else if(book.type == CourseTypeVideo){
        
        GQTVideoChapterInfo *video = [self.dataArray objectAtIndex:indexPath.row];
        
        UILabel *label_name = (UILabel *)[cell.contentView viewWithTag:100];
        label_name.text = video.videoName;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (book.type == CourseTypeBook) {
        //查看电子书信息
        GQTBookChapterInfo *chapter = [self.dataArray objectAtIndex:indexPath.row];
        
        BookReadViewController *viewController = [[BookReadViewController alloc] init];
        viewController.book = self.book;
        viewController.currentChapter = chapter;
        viewController.chapterArr = self.dataArray;
        viewController.hidesBottomBarWhenPushed = YES;
        [[APP_DELEGATE selectedNavigationController] pushViewController:viewController animated:YES];
        [viewController release];
        
    }else if(book.type == CourseTypeVideo){
        
        GQTVideoChapterInfo *video = [self.dataArray objectAtIndex:indexPath.row];
        self.m_video = video;
        Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        switch ([r currentReachabilityStatus]) {
            case NotReachable:
                {
                    //无网络处理
                }
                break;
            case ReachableViaWWAN:
                {
                    //使用3G网络处理
                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"友情提示：" message:@"你正在使用3G/2G网络，看视频将产生较大资费"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"继续观看",nil];
                    alert.tag = ReachableViaWWAN;
                    [alert show];
                    [alert release];

                    
                }
                break;
                
            case ReachableViaWiFi:
                {
                    [self playMovieInfo:video.videoUrl];

                }
                break;
            default:
                break;
        }
        
        
    }
}

-(void)myMovieFinishedCallback:(NSNotification*)notification{
    MPMoviePlayerController* theMovie = [notification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    [theMovie stop];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self playMovieInfo:self.m_video.videoUrl];
    }
}

- (void)playMovieInfo:(NSString *)videoURL{
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
    //        查看视频信息
    DirectionMPMoviePlayerViewController *playerView = [[DirectionMPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:videoURL]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:playerView];
    [playerView.moviePlayer play];
    [[APP_DELEGATE selectedNavigationController] presentModalViewController:playerView animated:YES];
    [playerView release];
}

- (void)loadDataRequestSuccess:(ASIHTTPRequest *)request{
    NSString *string=[[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    if (book.type == CourseTypeBook) {
        [self handleBookJsonStr:string];
    }else if(book.type == CourseTypeVideo){
        [self HandleVideoJsonStr:string];
    }
}

- (void)handleBookJsonStr:(NSString *)jsonStr{
    NSMutableDictionary *valueDic = [jsonStr JSONValue];
    
    NSInteger state = [[valueDic objectForKey:@"state"] integerValue];
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (state == 200) {
//        NSInteger bookId = [[valueDic objectForKey:@"bookId"] integerValue];
//        NSInteger recordCount = [[valueDic objectForKey:@"recordCount"] integerValue];
//        
//        NSString *bookName = [valueDic objectForKey:@"bookName"];
//        NSArray *bookAuthor = [valueDic objectForKey:@"bookAuthor"];
//        NSString *bookCategory = [valueDic objectForKey:@"bookCategory"];
//        
//        NSInteger rows = [[valueDic objectForKey:@"rows"] integerValue];
        
        NSArray *chapterList = [valueDic objectForKey:@"catalog"];
        for (NSDictionary *temp in chapterList) {
            GQTBookChapterInfo *chapter = [[GQTBookChapterInfo alloc] init];
            
            chapter.chapterId = [[temp objectForKey:@"contentId"] integerValue];
            chapter.chapterPageNumber = [[temp objectForKey:@"contentPage"] integerValue];
            chapter.chapterTitle = [temp objectForKey:@"contentTitle"];
            [tempArr addObject:chapter];
            [chapter release];
        }
    }
    
    [self.dataArray addObjectsFromArray:tempArr];
    [tempArr release];

}


- (void)HandleVideoJsonStr:(NSString *)jsonStr{
    NSMutableDictionary *valueDic = [jsonStr JSONValue];
    
    NSInteger state = [[valueDic objectForKey:@"state"] integerValue];
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (state == 200) {
//        NSInteger couserId = [[valueDic objectForKey:@"courseId"] integerValue];
//        NSString *couserName = [valueDic objectForKey:@"courseName"];
        
        NSArray *videoList = [valueDic objectForKey:@"videolist"];
        
        for (NSDictionary *temp in videoList) {
            GQTVideoChapterInfo *video = [[GQTVideoChapterInfo alloc] init];
            video.videoChapterId = [[temp objectForKey:@"videolist"] integerValue];
            video.videoTime = [[temp objectForKey:@"videoTime"] integerValue];
            video.videoUrl = [temp objectForKey:@"videoUrl"];
            video.videoTeacherId = [[temp objectForKey:@"teacherId"] integerValue];
            video.videoTeacherName = [temp objectForKey:@"teacherName"];
            video.videoName = [temp objectForKey:@"videoName"];
            
            [tempArr addObject:video];
            [video release];
        }
    }
    [self.dataArray addObjectsFromArray:tempArr];
    [tempArr release];
}
@end
