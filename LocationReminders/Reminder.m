//
//  Reminder.m
//  LocationReminders
//
//  Created by Jeremy Moore on 7/27/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

@dynamic name;
@dynamic location;
@dynamic radius;


+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Reminder";

}

@end