//
//  FaceBookUtility.m
//  sample
//
//  Created by user on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FaceBookUtility.h"

@implementation FaceBookUtility

@synthesize delegate = delegate_;
@synthesize facebook;

- (void)FBLogin
{
    if (!facebook)
    {
        facebook = [[Facebook alloc] init];
    }
    if (![facebook isSessionValid])
    {
        [self FBSessionBegin:self];
    }
    else 
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You Are Already Logined" message:@"please logout to relogin as diferent user" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)FBpostMessage:(NSString *)message
{
    if (!facebook)
    {
        facebook = [[Facebook alloc] init];
    }
    
    if (![facebook isSessionValid])
    {
        [self FBSessionBegin:self];
    }
    else
    {
        NSLog(@"HERER....");
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:message forKey:@"message"];
        
        [facebook requestWithMethodName:@"facebook.Stream.publish" andParams:params
andHttpMethod:@"POST" andDelegate:self];
        // --------------Upload images -----------
        
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"baby5" ofType:@"png"];
//        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
//        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                       @"Test message", @"message", imageData, @"source", nil];
//        [facebook requestWithGraphPath:@"me/photos" andParams:params andHttpMethod:@"POST" andDelegate:self];
         }
    
}
//
- (void)FBSessionBegin:(id<FBSessionDelegate>)sessionDelegate
{
    NSString *appId = [NSString stringWithFormat:@"301550186588553"];
    NSArray *permission = [NSArray arrayWithObjects:@"publish_stream", nil];
    [facebook authorize:appId permissions:permission delegate:sessionDelegate];
}

- (void) FBLogout
{
    [facebook logout:self];
}

- (void)fbDidLogin
{
   UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"You are logined successfully" message:@"" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
    NSLog(@"LOGINED SUCCESSFULLY");
    if([delegate_ respondsToSelector:@selector(didLoginedSucessfully)]) 
    {
        [delegate_ didLoginedSucessfully]; 
    }
}

- (void)fbDidLogout
{
    NSLog(@"LOGOUT SUCCESSFULLY");
}

- (void)request:(FBRequest *)request didLoad:(id)result 
{
	if ([result isKindOfClass:[NSArray class]])
    {
		result = [result objectAtIndex:0];
	}
	NSLog(@"Result of API call: %@", result);
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error 
{
    NSLog(@"Failed with error: %@", [error localizedDescription]);
}

- (void)dealloc
{
    facebook = nil;
}

@end
