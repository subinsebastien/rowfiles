//
//  FacebookShare.m
//  FacebookAndTwitter
//
//  Created by user on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookShare.h"

@implementation FacebookShare
@synthesize url_, caption_;

- (id) initWithUrl:(NSString *)url caption:(NSString *)caption
{
    self = [super init];
    if(self)
    {
        url_ = [url retain];
        caption_ = [caption retain];
    }
    return self;
}

- (void)postTheLinkUrl
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
        
        
        // --------------Upload images -----------
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"baby5" ofType:@"png"];
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Test message", @"message", imageData, @"source", nil];
        [facebook requestWithGraphPath:@"me/photos" andParams:params andHttpMethod:@"POST" andDelegate:self];
        
        
        // -------------upload videos --------------------
        
//         NSString *videoFilePath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"mov"];
//        NSMutableDictionary *paramsVideos = [NSMutableDictionary dictionaryWithCapacity:3L];
//        
//        [paramsVideos setObject:[NSData dataWithContentsOfFile:videoFilePath] forKey:@"video_filename.MOV"];
//        [paramsVideos setObject:@"Title for this post." forKey:@"title"];
//        [paramsVideos setObject:@"Description for this post." forKey:@"description"];
//        
//        [facebook requestWithGraphPath:@"me/videos" andParams:paramsVideos andHttpMethod:@"POST" andDelegate:self];
        
        
       // -------------upload a url -----------------
        
//        NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
//        [params setObject:@"link" forKey:@"type"];
//        [params setObject:self.url_ forKey:@"link"];
//        [params setObject:self.caption_ forKey:@"description"];
//        [facebook dialog:@"feed" andParams:params andDelegate:self];
    }
    
}

- (void)FBSessionBegin:(id<FBSessionDelegate>)sessionDelegate
{
    NSString *appId = [NSString stringWithFormat:@"301550186588553"];
    NSArray *permission = [NSArray arrayWithObjects:@"publish_stream", nil];
    [facebook authorize:appId permissions:permission delegate:sessionDelegate];
}

- (void) FBlogout
{
    [facebook logout:self];
}

- (void)fbDidLogin
{
    [self postTheLinkUrl];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
	if ([result isKindOfClass:[NSArray class]]) {
		result = [result objectAtIndex:0];
	}
	NSLog(@"Result of API call: %@", result);
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Failed with error: %@", [error localizedDescription]);
}

- (void)dealloc
{
    [url_ release];
    [caption_ release];
    [facebook release];
    facebook = nil;
    [super dealloc];
}

@end
