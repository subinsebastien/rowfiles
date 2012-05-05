//
//  FacebookShare.h
//  FacebookAndTwitter
//
//  Created by user on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"

@interface FacebookShare : NSObject <FBSessionDelegate, FBDialogDelegate, FBRequestDelegate>
{
    Facebook *facebook;
    NSString *url_;
    NSString *caption_;
}

@property (nonatomic, retain) NSString *url_;
@property (nonatomic, retain) NSString *caption_;

- (id) initWithUrl:(NSString *) url caption:(NSString *) caption;
- (void) postTheLinkUrl;
- (void) FBSessionBegin:(id<FBSessionDelegate>)sessionDelegate;
- (void) FBlogout;

@end
