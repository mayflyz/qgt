//
//  DEYRefreshTableViewController.h
//  DEyes
//
//  Created by zhenhua lu on 6/29/12.
//  Copyright (c) 2012 NeuSoft. All rights reserved.
//

#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "ASIHTTPRequest.h"

typedef enum {
	RequestMoreByPageFromPage = 0,
	RequestMoreByPageFromIndex,
	RequestMoreAllInOnce,	
} eRequestMoreType;

#define RequestTagForReload 1
#define RequestTagForLoadMore 2

@interface EGORefreshTableViewController : UITableViewController  <EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource, ASIHTTPRequestDelegate>
{
    NSMutableArray *dataArray;
    NSUInteger numberOfDataPerPage;
}

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, assign) NSUInteger numberOfDataPerPage;
@property (nonatomic, assign, readonly) eRequestMoreType requestMoreType;

- (NSUInteger)loadedRowCount;
- (NSObject *)objectForIndexPath:(NSIndexPath *)indexPath;
- (void)removeDeprecatedDataWhenRequestSuccess:(ASIHTTPRequest *)request;

- (void)setRequestFormat:(NSString *)requestFormat requestMoreBy:(eRequestMoreType)requestMoreType;
- (ASIHTTPRequest *)requestForMoreData:(BOOL)reload;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

- (void)loadMoreDataSource;
- (void)doneLoadingMoreDataSource;

//override this
- (void)loadDataRequestSuccess:(ASIHTTPRequest *)request;
- (void)loadDataRequestFailed:(ASIHTTPRequest *)request;

@end
