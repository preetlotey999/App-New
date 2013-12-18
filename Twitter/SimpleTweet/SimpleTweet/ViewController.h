//
//  ViewController.h
//  SimpleTweet
//
//  Created by Ray Wenderlich on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *button1Label;
@property (weak, nonatomic) IBOutlet UILabel *button2Label;
@property (weak, nonatomic) IBOutlet UILabel *button3Label;
@property (weak, nonatomic) IBOutlet UILabel *button4Label;

- (IBAction)button1Tapped:(id)sender;
- (IBAction)button2Tapped:(id)sender;
- (IBAction)button3Tapped:(id)sender;
- (IBAction)button4Tapped:(id)sender;
- (IBAction)tweetTapped:(id)sender;

@end
