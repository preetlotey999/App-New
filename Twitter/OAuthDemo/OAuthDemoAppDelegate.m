//
//  OAuthDemoAppDelegate.m
//  OAuthDemo
//
//  Created by Rodrigo on 28/06/2010.
//  Copyright 2010 SharpCube. All rights reserved.
//

#import "OAuthDemoAppDelegate.h"

@implementation OAuthDemoAppDelegate

@synthesize window;

- (IBAction) getRequestToken:(id)sender
{
	OAConsumer *consumer = [[OAConsumer alloc] initWithKey:[consumerKey stringValue]
													secret:[consumerSecret stringValue]];
	
	OADataFetcher *fetcher = [[OADataFetcher alloc] init];
	
	NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/oauth/request_token"];
	
	OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:url
																   consumer:consumer
																	  token:nil
																	  realm:nil
														  signatureProvider:nil];
	
	[request setHTTPMethod:@"POST"];
	
	NSLog(@"Getting request token...");
	
	[fetcher fetchDataWithRequest:request 
						 delegate:self
				didFinishSelector:@selector(requestTokenTicket:didFinishWithData:)
				  didFailSelector:@selector(requestTokenTicket:didFailWithError:)];	
}

- (IBAction) getAccessToken:(id)sender
{
	OAConsumer *consumer = [[OAConsumer alloc] initWithKey:[consumerKey stringValue]
													secret:[consumerSecret stringValue]];
	
	OADataFetcher *fetcher = [[OADataFetcher alloc] init];
	
	NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/oauth/access_token"];
	
	[accessToken setVerifier:[pinCode stringValue]];
	NSLog(@"Using PIN %@", accessToken.verifier);
	
	OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:url
																   consumer:consumer
																	  token:accessToken
																	  realm:nil
														  signatureProvider:nil];
	
	[request setHTTPMethod:@"POST"];
	
	NSLog(@"Getting access token...");
	
	[fetcher fetchDataWithRequest:request 
						 delegate:self
				didFinishSelector:@selector(accessTokenTicket:didFinishWithData:)
				  didFailSelector:@selector(accessTokenTicket:didFailWithError:)];	
}

- (IBAction) getHomeTimeline:(id)sender
{
	OAConsumer *consumer = [[OAConsumer alloc] initWithKey:[consumerKey stringValue]
													secret:[consumerSecret stringValue]];
	
	OADataFetcher *fetcher = [[OADataFetcher alloc] init];
	
	NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/home_timeline.xml"];
	
	OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:url
																   consumer:consumer
																	  token:accessToken
																	  realm:nil
														  signatureProvider:nil];
	
	NSLog(@"Getting home timeline...");
	
	[fetcher fetchDataWithRequest:request 
						 delegate:self
				didFinishSelector:@selector(apiTicket:didFinishWithData:)
				  didFailSelector:@selector(apiTicket:didFailWithError:)];	
}

- (void) requestTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data
{
	if (ticket.didSucceed)
	{
		NSString *responseBody = [[NSString alloc] initWithData:data 
													   encoding:NSUTF8StringEncoding];
		accessToken = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
		
		NSLog(@"Got request token. Redirecting to twitter auth page...");
		
		NSString *address = [NSString stringWithFormat:
							 @"https://api.twitter.com/oauth/authorize?oauth_token=%@",
							 accessToken.key];
		
		NSURL *url = [NSURL URLWithString:address];
		[[NSWorkspace sharedWorkspace] openURL:url];
	}
}

- (void) requestTokenTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error
{
	NSLog(@"Getting request token failed: %@", [error localizedDescription]);
}

- (void) accessTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data
{
	if (ticket.didSucceed)
	{
		NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		accessToken = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
		
		NSLog(@"Got access token. Ready to use Twitter API.");
	}
}

- (void) accessTokenTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error
{
	NSLog(@"Getting access token failed: %@", [error localizedDescription]);
}

- (void) apiTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data
{
	if (ticket.didSucceed)
	{
		NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		NSLog(@"Got home timeline. Length: %d.", [responseBody length]);
		NSLog(@"Body:\n%@", responseBody);
	}
}

- (void) apiTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error
{
	NSLog(@"Getting home timeline failed: %@", [error localizedDescription]);
}

@end
