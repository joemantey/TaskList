//
//  JSMConstants.m
//  List
//
//  Created by Joseph Smalls-Mantey on 4/7/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import "JSMConstants.h"

@implementation JSMConstants

NSString *const MyThingNotificationKey = @"MyThingNotificationKey";


NSInteger const highPriorityInteger = 3;
NSInteger const medPriorityInteger = 2;
NSInteger const lowPriorityInteger = 1;

NSInteger const maxBasePriority = 1000;
NSInteger const highBasePriority = 800;
NSInteger const mediumBaseValue = 600;
NSInteger const lowBaseValue = 400;

NSInteger const highPriorityAdjuster = 100;
NSInteger const mediumPriorityAdjuster = 0;
NSInteger const lowPriorityAdjuster = -100;

NSTimeInterval const immediateInterval = 1440;
NSTimeInterval const highPriorityInterval = 4320;
NSTimeInterval const mediumPriorityInterval = 10080;

@end
