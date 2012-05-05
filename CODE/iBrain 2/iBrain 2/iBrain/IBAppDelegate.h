//
//  IBAppDelegate.h
//  iBrain
//
//  Created by user on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"
#import "FaceBookUtility.h"

@class IBHomeViewController;

@interface IBAppDelegate : UIResponder <UIApplicationDelegate>
{
    FaceBookUtility *FBUtility;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FaceBookUtility *FBUtility;
;
@property (strong, nonatomic) IBHomeViewController *viewController;

+(IBAppDelegate *)application;

@end
