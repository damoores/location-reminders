//
//  NSMutableArray+Additions.h
//  LocationReminders
//
//  Created by Jeremy Moore on 7/25/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Additions)

- (id)dequeue;
- (void)enqueue:(id)object;
- (id)popStack;
- (void)push:(id)object;

@end
