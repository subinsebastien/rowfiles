//
//  FaceBookUtility.h
//  sample
//
//  Created by user on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"

@protocol FBLoginedDelegate;

@interface FaceBookUtility : NSObject<FBSessionDelegate, FBDialogDelegate, FBRequestDelegate>
{
    Facebook *facebook;
   
    id delegate_;
}

@property(nonatomic, retain) Facebook *facebook;
@property (nonatomic, strong) NSObject <FBLoginedDelegate> *delegate;

- (void)FBLogin;

- (void)FBpostMessage:(NSString *)message;

- (void)FBSessionBegin:(id<FBSessionDelegate>)sessinDelegate;

- (void)FBLogout;

@end

@protocol FBLoginedDelegate

- (void)didLoginedSucessfully;

@end

