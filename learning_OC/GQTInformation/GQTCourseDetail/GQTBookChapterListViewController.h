//
//  GQTBookChapterListViewController.h
//  learning_OC
//
//  Created by test on 3/22/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GQTBookInfo.h"

#import <MediaPlayer/MediaPlayer.h>

#import "EGORefreshTableViewController.h"

@interface GQTBookChapterListViewController : EGORefreshTableViewController<MPMediaPickerControllerDelegate,UIAlertViewDelegate>{
    GQTBookInfo *book;
    
}

@property (retain, nonatomic) GQTBookInfo *book;

@end
