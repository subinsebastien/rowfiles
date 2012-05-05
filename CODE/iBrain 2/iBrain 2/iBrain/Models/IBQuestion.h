//
//  IBQuestion.h
//  iBrain
//
//  Created by user on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBQuestion : NSObject
{
    NSString *question_;
    NSString *optionA_;
    NSString *optionB_;
    NSString *optionC_;
    NSString *optionD_;
    NSString *answer_;
}

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *optionA;
@property (nonatomic, strong) NSString *optionB;
@property (nonatomic, strong) NSString *optionC;
@property (nonatomic, strong) NSString *optionD;
@property (nonatomic, strong) NSString *answer;

@end
