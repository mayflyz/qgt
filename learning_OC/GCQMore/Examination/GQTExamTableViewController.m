//
//  GQTExamTableViewController.m
//  learning_OC
//
//  Created by test on 3/19/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTExamTableViewController.h"

#import "GQTExamInfo.h"
#import "EGOImageView.h"
#import "GQTCommons.h"

#define ExaminationCellHeight 80

@interface GQTExamTableViewController ()

@end

@implementation GQTExamTableViewController

@synthesize type;
@synthesize dataArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        type = ExameTypePass;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"GQTExaminationCell" owner:self options:nil];
        cell = self.examingCell;
        self.examingCell = nil;
    }
    
    GQTExamInfo *exame = [self.dataArray objectAtIndex:indexPath.row];
    
    EGOImageView *learningImage = (EGOImageView *)[cell viewWithTag:2013031801];
    [learningImage setPlaceholderImage:[UIImage imageNamed:@"ico_nophoto.png"]];
    [learningImage setImageURL:[NSURL URLWithString:[GQTCommons getImageUrl:exame.examImage]]];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:2013031802];
    [titleLabel setText:exame.examName];
    
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:2013031803];
    [contentLabel setText:exame.examScroe];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ExaminationCellHeight;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)dealloc {
    [_examingCell release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setExamingCell:nil];
    [super viewDidUnload];
}
@end
