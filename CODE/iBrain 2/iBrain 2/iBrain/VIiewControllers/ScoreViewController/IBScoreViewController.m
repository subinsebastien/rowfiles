//
//  IBScoreViewController.m
//  iBrain
//
//  Created by user on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IBScoreViewController.h"
#import "IBHomeViewController.h"
#import "IBQuestionnaireViewController.h"
#import "IBAppDelegate.h"

@interface IBScoreViewController ()

@end

@implementation IBScoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)playAgain:(id)sender
{
    IBQuestionnaireViewController *quiz = [[IBQuestionnaireViewController alloc]initWithNibName:@"IBQuestionnaireViewController" bundle:nil];
    [self presentModalViewController:quiz animated:YES];
}

- (IBAction)shareToFaceBook:(id)sender
{
    [[IBAppDelegate application].FBUtility FBpostMessage:@"Won the game......"];
}

- (IBAction)goToHome:(id)sender
{
    IBHomeViewController *homeView = [[IBHomeViewController alloc]initWithNibName:@"IBHomeViewController" bundle:nil];
    [self presentModalViewController:homeView animated:YES];
}

@end
