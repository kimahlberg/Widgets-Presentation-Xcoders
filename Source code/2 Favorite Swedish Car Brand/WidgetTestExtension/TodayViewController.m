//
//  TodayViewController.m
//  WidgetTestExtension
//
//  Created by Kim Ahlberg on 7/18/14.
//  Copyright (c) 2014 The Evil Boss. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#define kAppGroupSuiteName @"group.com.theevilboss.widgettest"
#define kUnselectedColor [UIColor clearColor]
#define kSelectedColor [UIColor colorWithRed:0.4 green:0.8 blue:1.0 alpha:0.6]
#define kSelectedCarBrandKey @"SelectedCarBrandKey"

@interface TodayViewController () <NCWidgetProviding> 
@property (weak, nonatomic) IBOutlet UIButton *volvoButton;
@property (weak, nonatomic) IBOutlet UIButton *saabButton;
@property (weak, nonatomic) IBOutlet UIButton *koenigseggButton;

@end

@implementation TodayViewController


#pragma mark 1 Launch app using URL Scheme

- (IBAction)backgroundButtonTapped:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"kawidgettest://some/resource?param1=hello&param2=world"];
    NSExtensionContext *context = self.extensionContext;
    [context openURL:url completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened app");
        } else {
            NSLog(@"Failed to open app");
        }
    }];
}

#pragma mark 2 Shared user defaults via App Groups

- (IBAction)carBrandButtonTapped:(UIButton *)sender
{
    NSInteger brandInteger = sender.tag;
    
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:kAppGroupSuiteName];
    [mySharedDefaults setInteger:brandInteger forKey:kSelectedCarBrandKey];
    [mySharedDefaults synchronize];
    [self updateControls];
}

#pragma mark 3 Updating contents

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler
{
    // Perform any setup necessary in order to update the view.
    [self updateControls];
    
    // If an error is encoutered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (void)updateControls
{
    // Default state, all unselected.
    self.volvoButton.backgroundColor = kUnselectedColor;
    self.saabButton.backgroundColor = kUnselectedColor;
    self.koenigseggButton.backgroundColor = kUnselectedColor;
    
    // Read the selected state from the shared user defaults.
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:kAppGroupSuiteName];
    NSInteger selectedBrand = [mySharedDefaults integerForKey:kSelectedCarBrandKey];
    
    // Highlight the selected brand.
    switch (selectedBrand) {
        case 1:
            self.volvoButton.backgroundColor = kSelectedColor;
            break;
        case 2:
            self.saabButton.backgroundColor = kSelectedColor;
            break;
        case 3:
            self.koenigseggButton.backgroundColor = kSelectedColor;
            break;
        default:
            break;
    }
}

@end
