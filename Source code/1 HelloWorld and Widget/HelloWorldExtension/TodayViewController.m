//
//  TodayViewController.m
//  HelloWorldExtension
//
//  Created by Kim Ahlberg on 7/24/14.
//  Copyright (c) 2014 The Evil Boss. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#define kHeightCollapsed 37
#define kHeightExpanded 74
#define kBackgroundColor [UIColor purpleColor]

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UIButton *sizeToggleButton;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Set the initial size.
    CGSize updatedSize = self.preferredContentSize;
    updatedSize.height = kHeightCollapsed;
}

- (void)awakeFromNib
{
    // Set the initial size.
    CGSize updatedSize = self.preferredContentSize;
    updatedSize.height = kHeightCollapsed;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Set the initial size.
    CGSize updatedSize = self.preferredContentSize;
    updatedSize.height = kHeightCollapsed;
    [self setPreferredContentSize:updatedSize];
    
    // Set the initial background color.
    self.view.backgroundColor = kBackgroundColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encoutered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

#pragma mark - 1 Configure margins
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:
(UIEdgeInsets)defaultMarginInsets
{
    UIEdgeInsets newMarginInsets = defaultMarginInsets;
    newMarginInsets.left = 0.0;
    
    return newMarginInsets;
}

#pragma mark - 2 Adjust height
- (IBAction)sizeToggleButtonTapped:(id)sender
{
    CGSize updatedSize = self.preferredContentSize;
    
    if (self.preferredContentSize.height > kHeightCollapsed) {
        updatedSize.height = kHeightCollapsed;
    } else {
        updatedSize.height = kHeightExpanded;
    }
    
    [self setPreferredContentSize:updatedSize];
}

#pragma mark - 3 Animate height adjustment
- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:
(id<UIViewControllerTransitionCoordinator>)coordinator
{
    UIColor *newBackgroundColor = kBackgroundColor;
    NSString *newButtonTitle = @"More...";
    if (size.height > kHeightCollapsed) {
        newBackgroundColor = [UIColor clearColor];
        newButtonTitle = @"Less...";
    }
    
    [coordinator animateAlongsideTransition:
     ^(id<UIViewControllerTransitionCoordinatorContext> context) {
         [self.view layoutIfNeeded]; // This animates the constraints.
         self.view.backgroundColor = newBackgroundColor;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self.sizeToggleButton setTitle:newButtonTitle forState:UIControlStateNormal];
    }];
}

@end
