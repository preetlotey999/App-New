//
//  OAuthDemoAppDelegate.h
//  OAuthDemo
//
//  Created by Rodrigo on 28/06/2010.
//  Copyright 2010 SharpCube. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OAuthConsumer.h"

@interface OAuthDemoAppDelegate : NSObject
{
	OAToken *accessToken;
	
    NSWindow *window;
	IBOutlet NSTextField *consumerKey;
	IBOutlet NSTextField *consumerSecret;
	IBOutlet NSTextField *pinCode;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction) getRequestToken:(id)sender;
- (IBAction) getAccessToken:(id)sender;
- (IBAction) getHomeTimeline:(id)sender;

@end
