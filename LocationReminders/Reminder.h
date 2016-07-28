//
//  Reminder.h
//  LocationReminders
//
//  Created by Jeremy Moore on 7/27/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import <Parse/Parse.h>

@interface Reminder : PFObject <PFSubclassing>

@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)NSNumber *radius;
@property (strong, nonatomic)PFGeoPoint *location;

@end
