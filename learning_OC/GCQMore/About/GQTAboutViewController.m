//
//  GQTAboutViewController.m
//  learning_OC
//
//  Created by test on 3/17/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTAboutViewController.h"

#import "GQTCommons.h"

@interface GQTAboutViewController ()

- (void)initNavigationBar;

@end

@implementation GQTAboutViewController

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
    [self initNavigationBar];
    
    [GQTCommons setViewBackImage:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

//为了支持iOS6
-(BOOL)shouldAutorotate
{
    return YES;
}

//为了支持iOS6
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)initNavigationBar{
    self.navigationItem.title = @"在线反馈";
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
}

- (void)dealloc {
    [_label_title release];
    [_label_version release];
    [_label_content release];
    [_label_Unit release];
    [_label_address release];
    [_label_email release];
    [_label_tel release];
    [_label_unitContent release];
    [_label_addressContent release];
    [_lael_emailContent release];
    [_label_telContent release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLabel_title:nil];
    [self setLabel_version:nil];
    [self setLabel_content:nil];
    [self setLabel_Unit:nil];
    [self setLabel_address:nil];
    [self setLabel_email:nil];
    [self setLabel_tel:nil];
    [self setLabel_unitContent:nil];
    [self setLabel_addressContent:nil];
    [self setLael_emailContent:nil];
    [self setLabel_telContent:nil];
    [super viewDidUnload];
}
@end
