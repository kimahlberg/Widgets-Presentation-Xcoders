//
//  ViewController.m
//  WidgetTest
//
//  Created by Kim Ahlberg on 7/18/14.
//  Copyright (c) 2014 The Evil Boss. All rights reserved.
//

#import "ViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#define kAppGroupSuiteName @"group.com.theevilboss.widgettest"
#define kUnselectedColor [UIColor colorWithWhite:0.8 alpha:1.0]
#define kSelectedColor [UIColor colorWithRed:0.4 green:0.8 blue:1.0 alpha:0.6]
#define kSelectedCarBrandKey @"SelectedCarBrandKey"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *volvoButton;
@property (weak, nonatomic) IBOutlet UIButton *saabButton;
@property (weak, nonatomic) IBOutlet UIButton *koenigseggButton;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Register for notification to update UI when the app becomes active.
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(updateControls)
                                                 name: UIApplicationDidBecomeActiveNotification
                                               object: nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
