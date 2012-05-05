//
//  IBHomeViewController.h
//  iBrain
//
//  Created by user on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"
#import "FaceBookUtility.h"

@interface IBHomeViewController : UIViewController
{
   
    IBOutlet UIActivityIndicatorView *spinner;
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *logOutButton;

}

- (IBAction)faceBookLoginButtonClicked:(id)sender;
- (IBAction)faceBookLogOutButtonClicked:(id)sender;

@property(nonatomic,retain) IBOutlet UIButton *loginButton;
@property(nonatomic,retain) IBOutlet UIButton *logOutButton;
@property(nonatomic,retain) IBOutlet UIButton *startButton;
@property int count;

-(IBAction)startQuiz:(id)sender;


@end
