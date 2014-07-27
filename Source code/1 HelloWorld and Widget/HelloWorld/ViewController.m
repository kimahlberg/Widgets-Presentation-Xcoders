//
//  ViewController.m
//  HelloWorld
//
//  Created by Kim Ahlberg on 7/23/14.
//  Copyright (c) 2014 The Evil Boss. All rights reserved.
//

#import "ViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface ViewController ()

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 1 Controlling Visibility

- (IBAction)showWidgetTapped:(id)sender {
    [self setWidgetVisibility:YES];
}

- (IBAction)hideWidgetTapped:(id)sender {
    [self setWidgetVisibility:NO];
}

- (void)setWidgetVisibility:(BOOL)visibility
{
    [[NCWidgetController widgetController] setHasContent:visibility forWidgetWithBundleIdentifier:@"com.theevilboss.HelloWorld.HelloWorldExtension"];
    
    if (visibility) {
        NSLog(@"Enabled widget");
    } else {
        NSLog(@"Disabled widget");
    }
}

@end
