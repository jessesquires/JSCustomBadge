//
//  ViewController.m
//  BadgeDemo
//
//  Created by Jesse Squires on 4/25/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import "ViewController.h"
#import "JSCustomBadge.h"

@interface ViewController ()
@end


@implementation ViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
    
	JSCustomBadge *badge0 = [JSCustomBadge customBadgeWithString:@"666"];
    
	JSCustomBadge *badge1 = [JSCustomBadge customBadgeWithString:@"JSCustomBadge"
                                                 withStringColor:[UIColor blackColor]
                                                  withInsetColor:[UIColor greenColor]
                                                  withBadgeFrame:YES
                                             withBadgeFrameColor:[UIColor yellowColor]
                                                       withScale:1.5
                                                     withShining:YES
                                                      withShadow:YES];
	
	JSCustomBadge *badge2 = [JSCustomBadge customBadgeWithString:@"Retina Ready!"
                                                 withStringColor:[UIColor whiteColor]
                                                  withInsetColor:[UIColor blueColor]
                                                  withBadgeFrame:YES
                                             withBadgeFrameColor:[UIColor whiteColor]
                                                       withScale:1.5
                                                     withShining:YES
                                                      withShadow:YES];

	JSCustomBadge *badge3 = [JSCustomBadge customBadgeWithString:@"...and scalable"
                                                 withStringColor:[UIColor whiteColor]
                                                  withInsetColor:[UIColor purpleColor]
                                                  withBadgeFrame:YES
                                             withBadgeFrameColor:[UIColor blackColor]
                                                       withScale:2.5
                                                     withShining:NO
                                                      withShadow:NO];
    
	JSCustomBadge *badge4 = [JSCustomBadge customBadgeWithString:@"...with Shining"
                                                 withStringColor:[UIColor blackColor]
                                                  withInsetColor:[UIColor orangeColor]
                                                  withBadgeFrame:YES
                                             withBadgeFrameColor:[UIColor blackColor]
                                                       withScale:1.5
                                                     withShining:YES
                                                      withShadow:YES];
    
	JSCustomBadge *badge5 = [JSCustomBadge customBadgeWithString:@"Flat, no shining"
                                                 withStringColor:[UIColor whiteColor]
                                                  withInsetColor:[UIColor brownColor]
                                                  withBadgeFrame:YES
                                             withBadgeFrameColor:[UIColor blackColor]
                                                       withScale:1.5
                                                     withShining:NO
                                                      withShadow:NO];

    JSCustomBadge *badge6 = [JSCustomBadge customBadgeWithString:@"Open & Free"
                                                 withStringColor:[UIColor whiteColor]
                                                  withInsetColor:[UIColor blackColor]
                                                  withBadgeFrame:YES
                                             withBadgeFrameColor:[UIColor yellowColor]
                                                       withScale:1.25
                                                     withShining:YES
                                                      withShadow:YES];
    
    [badge1 autoBadgeSizeWithString:@"JSCustomBadge for iOS"];
    
    NSMutableArray *badges = [NSMutableArray arrayWithObjects:
                              badge0, badge1, badge2, badge3, badge4, badge5, badge6, nil];
	
    CGFloat y = 20.0f;
    for (JSCustomBadge *each in badges) {
        
        CGFloat x = (self.view.frame.size.width / 2.0f) - (each.frame.size.width / 2.0f);
        CGSize size = each.frame.size;
        
        each.frame = CGRectMake(x, y, size.width, size.height);
        
        [self.view addSubview:each];
        
        y += (20.0f + size.height);
    }
}

@end
