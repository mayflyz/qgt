//
//  GQTLearingTableViewController.h
//  learning_OC
//
//  Created by test on 3/18/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _LearningType{
    LearningTypeNone = 0,
    LearningTypeQualityCourses,
    LearningTypeNotLearning,
    LearningTypeInProgress,
    LearningTypeCompleted
}LearningType;

@interface GQTLearingTableViewController : UITableViewController{
    NSArray *dataArray;
    LearningType type;
}

@property (assign, nonatomic) LearningType type;
@property (retain, nonatomic) NSArray *dataArray;

@property (retain, nonatomic) IBOutlet UITableViewCell *learningCell;

@end
