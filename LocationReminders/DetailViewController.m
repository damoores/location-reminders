//
//  DetailViewController.m
//  LocationReminders
//
//  Created by Jeremy Moore on 7/26/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import "DetailViewController.h"
#import "Reminder.h"
#import "LocationController.h"
@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *radiusField;
@property (weak, nonatomic) IBOutlet UIButton *setButton;

- (IBAction)setButtonSelected:(id)sender;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


- (IBAction)setButtonSelected:(id)sender {
    
    [self.setButton setEnabled:NO];
    NSString *reminderName = self.nameField.text;
    NSNumber *radius = [NSNumber numberWithFloat:self.radiusField.text.floatValue];
    
    Reminder *reminder = [Reminder object];
    reminder.name = reminderName;
    reminder.radius = radius;
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    __weak typeof(self) weakSelf = self;
    [reminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"Reminder saved to Parse");
    
        if (strongSelf.completion) {
            if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
                CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:strongSelf.coordinate radius:radius.floatValue identifier:reminderName];
                [[[LocationController sharedController]locationManager] startMonitoringForRegion:region];
                strongSelf.completion([MKCircle circleWithCenterCoordinate:strongSelf.coordinate radius:radius.floatValue]);
            }
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

@end
