//
//  IBQuestionnaireViewController.h
//  iBrain
//
//  Created by user on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBQuestionnaireViewController : UIViewController<UIAlertViewDelegate>
{
    NSInteger totalQuestionsAvailable_;
    NSMutableArray *askedQuestionsIds_;
    int nextQuestionId;

    NSString *currentAnswer;
    NSString *selectedOption;
    NSDictionary *questionnaire;
    int score;
    UIImage *whiteBox;
    UIImage *tickBox;
    IBOutlet UIActivityIndicatorView *spinner;
    UIAlertView *alertView;
}

@property(nonatomic, strong)IBOutlet UIButton *question;
@property(nonatomic, strong)IBOutlet UIButton *optionATick;
@property(nonatomic, strong)IBOutlet UIButton *optionBTick;
@property(nonatomic, strong)IBOutlet UIButton *optionCTick;
@property(nonatomic, strong)IBOutlet UIButton *optionDTick;


@property(nonatomic, strong)IBOutlet UIButton *optionA;
@property(nonatomic, strong)IBOutlet UIButton *optionB;
@property(nonatomic, strong)IBOutlet UIButton *optionC;
@property(nonatomic, strong)IBOutlet UIButton *optionD;

- (void)getTotalNumberOfQuestionsAvailable;

- (void)getNextQuestion;

- (void)getNextQuestionId;

- (IBAction)optionASelected:(id)sender;
- (IBAction)optionBSelected:(id)sender;
- (IBAction)optionCSelected:(id)sender;
- (IBAction)optionDSelected:(id)sender;

- (IBAction)confirmAnswer:(id)sender;

- (BOOL)evaluateAnswer;

- (void)resetTickButtons;

- (void)showQuestionAndOptions;


@end
