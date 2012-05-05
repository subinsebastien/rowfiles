//
//  IBHomeViewController.m
//  iBrain
//
//  Created by user on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IBHomeViewController.h"
#import "FacebookShare.h"
#import "Facebook.h"
#import "IBQuestionnaireViewController.h"
#import <Parse/Parse.h>
#import "IBAppDelegate.h"
@interface IBHomeViewController ()

@end

@implementation IBHomeViewController

@synthesize logOutButton,loginButton,count,startButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
           
    }
    return self;
}

#pragma -mark view life cycle
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
//    if(self.count==1)
//    {
//    [self.logOutButton setHidden:NO];
//    [self.loginButton setHidden:YES];
//    }
//    else {
//            [self.logOutButton setHidden:YES];
//        [self.loginButton setHidden:NO];
//        [self.startButton setHidden:YES];
//    }
    NSLog(@"count %d",count);

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

#pragma-mark fb login and logout button actions

- (IBAction)faceBookLoginButtonClicked:(id)sender
{
   
    [[IBAppDelegate application].FBUtility FBLogin ];

}
- (IBAction)faceBookLogOutButtonClicked:(id)sender
{
        [[IBAppDelegate application].FBUtility FBLogout ];
}

- (void)didLoginedSucessfully
{
   //Do additional setup after successfull completion of login.
    NSLog(@"logined complete and  now at home view");
}

-(IBAction)startQuiz:(id)sender
{
    if (![[IBAppDelegate application].FBUtility.facebook isSessionValid]) 
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You Are not logined" message:@"please login to start..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else 
    {
        IBQuestionnaireViewController *quiz = [[IBQuestionnaireViewController alloc]initWithNibName:@"IBQuestionnaireViewController" bundle:nil];
        [self presentModalViewController:quiz animated:YES];
    }
}

@end
