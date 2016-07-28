//
//  DetailViewController.m
//  LocationReminders
//
//  Created by Jeremy Moore on 7/26/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import "DetailViewController.h"
#import "Reminder.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *radiusField;

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
    
    NSString *reminderName = self.nameField.text;
    NSNumber *radius = [NSNumber numberWithFloat:self.radiusField.text.floatValue];
    
    Reminder *reminder = [Reminder object];
    reminder.name = reminderName;
    reminder.radius = radius;
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    if (self.completion) {
        NSLog(@"Reminder name: %@", reminderName);
        self.completion([MKCircle circleWithCenterCoordinate:self.coordinate radius:[radius floatValue]]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
