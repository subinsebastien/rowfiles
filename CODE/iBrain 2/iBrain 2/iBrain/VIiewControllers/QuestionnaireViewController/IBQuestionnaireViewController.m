//
//  IBQuestionnaireViewController.m
//  iBrain
//
//  Created by user on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IBQuestionnaireViewController.h"
#import "IBHomeViewController.h"
#import "IBScoreViewController.h"
#import <Parse/Parse.h>


@interface IBQuestionnaireViewController ()

@end

@implementation IBQuestionnaireViewController
@synthesize question, optionA, optionB, optionC, optionD;
@synthesize optionATick, optionBTick, optionCTick, optionDTick;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
        whiteBox = [UIImage imageNamed:@"whiteBox.png"];
        tickBox = [UIImage imageNamed:@"Tick.png"];
        score = 0;
        currentAnswer = @"";
        selectedOption = @"";
        askedQuestionsIds_ = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    spinner.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:spinner];
    [spinner startAnimating];
    [self getTotalNumberOfQuestionsAvailable]; 
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [spinner stopAnimating];
    [spinner removeFromSuperview];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (void)getTotalNumberOfQuestionsAvailable
{
    PFQuery *query = [PFQuery queryWithClassName:@"Questionnaire"];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
    if (!error) 
    {
            // The count request succeeded. Log the count
        NSLog(@"THERE are totally %d questions available",count);
        totalQuestionsAvailable_ = count;
        [self getNextQuestion];
    } 
    else 
    {
            // The request failed
    }
    }];
    
}

#pragma -mark next question generation..
- (void)getNextQuestion
{
    [self getNextQuestionId];
    PFQuery *query = [PFQuery queryWithClassName:@"Questionnaire"];
    [query whereKey:@"questionId" equalTo:[NSNumber numberWithInt:nextQuestionId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            if (objects.count > 0)
            {
                questionnaire = [objects objectAtIndex:0];
                currentAnswer = [questionnaire objectForKey:@"answer"];
                NSLog(@"answer == %@",currentAnswer);
                [self showQuestionAndOptions];
            }
            
        } else 
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)getNextQuestionId
{
   
    NSLog(@"total questions... %d",totalQuestionsAvailable_);
    int questionId;
    questionId = ( arc4random() % totalQuestionsAvailable_ ) + 1;
    NSLog(@"qid ... %d",questionId);
    NSNumber *tempQuestionId = [NSNumber numberWithInt:questionId];
    
    if ([askedQuestionsIds_ containsObject:tempQuestionId])
    {
        NSLog(@"already asked ...");
        [self getNextQuestionId];
    }
    else
    {
        nextQuestionId = questionId;
        [askedQuestionsIds_ addObject:tempQuestionId];
    }
    [self resetTickButtons];
   
}

#pragma-mark options and confirm button actions
- (IBAction)optionASelected:(id)sender
{
    selectedOption = @"A";
    [optionATick setBackgroundImage:tickBox forState:UIControlStateNormal];
    [optionBTick setBackgroundImage:whiteBox forState:UIControlStateNormal];
    [optionCTick setBackgroundImage:whiteBox forState:UIControlStateNormal];
    [optionDTick setBackgroundImage:whiteBox forState:UIControlStateNormal];
    
}

- (IBAction)optionBSelected:(id)sender
{
    selectedOption = @"B";
    [optionATick setBackgroundImage:whiteBox forState:UIControlStateNormal];
    [optionBTick setBackgroundImage:tickBox forState:UIControlStateNormal];
    [optionCTick setBackgroundImage:whiteBox forState:UIControlStateNormal];
    [optionDTick setBackgroundImage:whiteBox forState:UIControlStateNormal];
}

- (IBAction)optionCSelected:(id)sender
{
    selectedOption = @"C";
    [optionATick setBackgroundImage:whiteBox forState:UIControlStateNormal];
    [optionBTick setBackgroundImage:whiteBox forState:UIControlStateNormal];
    [optionCTick setBackgroundImage:tickBox forState:UIControlStateNormal];
    [optionDTick setBackgroundImage:whiteBox forState:UIControlStateNormal];
}

- (IBAction)optionDSelected:(id)sender
{
    selectedOption = @"D";
    [optionATick setBackgroundImage:whiteBox forState:UIControlStateNormal];
    [optionBTick setBackgroundImage:whiteBox forState:UIControlStateNormal];
    [optionCTick setBackgroundImage:whiteBox forState:UIControlStateNormal];
    [optionDTick setBackgroundImage:tickBox forState:UIControlStateNormal];
}

- (IBAction)confirmAnswer:(id)sender
{
    if ([selectedOption isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Please select an option" message:@"" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        if ([self evaluateAnswer])
        {
            selectedOption = @"";
            currentAnswer = @"";
            score ++;
            if ([askedQuestionsIds_ count] == 10)
            {
                //Do additional set up after completing all questions...
                IBScoreViewController *scoreView = [[IBScoreViewController alloc]initWithNibName:@"IBScoreViewController" bundle:nil];
                [self presentModalViewController:scoreView animated:YES];
            }
            else 
            {
                [self.view addSubview:spinner];
                [spinner startAnimating];
                [self getNextQuestion]; 
            }
        }
        else 
        {
            selectedOption = @"";
            currentAnswer = @"";
            score = 0;
            alertView = [[UIAlertView alloc]initWithTitle:@"Wrong answer.." message:@"you are out..." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alertView show];
               IBHomeViewController *viewController  = [[IBHomeViewController alloc] initWithNibName:@"IBHomeViewController" bundle:nil];
             viewController.count=1;
        }
    }
}

- (BOOL)evaluateAnswer
{
    if ([selectedOption isEqualToString:currentAnswer])
    {
        return TRUE;
    }
    else 
    {
        return FALSE;
    }

}

- (void)resetTickButtons
{
    [optionATick setBackgroundImage:whiteBox forState:UIControlStateNormal];
    [optionBTick setBackgroundImage:whiteBox forState:UIControlStateNormal];
    [optionCTick setBackgroundImage:whiteBox forState:UIControlStateNormal];
    [optionDTick setBackgroundImage:whiteBox forState:UIControlStateNormal];
}

- (void)showQuestionAndOptions
{
    NSLog(@"questionnarie == %@",questionnaire);
    [question setTitle:[questionnaire objectForKey:@"question"] forState:UIControlStateNormal];
    [optionA setTitle:[questionnaire objectForKey:@"optionA"] forState:UIControlStateNormal];
    [optionB setTitle:[questionnaire objectForKey:@"optionB"] forState:UIControlStateNormal];

    [optionC setTitle:[questionnaire objectForKey:@"optionC"] forState:UIControlStateNormal];

    [optionD setTitle:[questionnaire objectForKey:@"optionD"] forState:UIControlStateNormal];
    [spinner stopAnimating];
    [spinner removeFromSuperview];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    if (buttonIndex==0) 
    {
        IBHomeViewController *homeView = [[IBHomeViewController alloc]initWithNibName:@"IBHomeViewController" bundle:nil];
        homeView.count=1;
        [self presentModalViewController:homeView animated:YES];
        
    }
}
@end


