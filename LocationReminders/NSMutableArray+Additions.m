//
//  NSMutableArray+Additions.m
//  LocationReminders
//
//  Created by Jeremy Moore on 7/25/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import "NSMutableArray+Additions.h"

@implementation NSMutableArray (Additions)

- (id)dequeue
{
    id firstObject = [self firstObject];
    if (firstObject) {
        [self removeObjectAtIndex:0];
        return firstObject;
    } else {
        return nil;
    }
}

- (void)enqueue:(id)object
{
    [self addObject:object];
}

- (id)popStack
{
    id lastObject =[self lastObject];
    if (lastObject) {
        [self removeLastObject];
        return lastObject;
    } else {
        return nil;
    }
}

- (void)push:(id)object
{
    [self addObject:object];
}

@end
