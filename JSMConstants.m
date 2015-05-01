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


NSInteger const HighPriorityInteger = 3;
NSInteger const MedPriorityInteger = 2;
NSInteger const LowPriorityInteger = 1;

NSInteger const MaxBasePriority = 1000;
NSInteger const HighBasePriority = 800;
NSInteger const MediumBaseValue = 600;
NSInteger const LowBaseValue = 400;

NSInteger const HighPriorityAdjuster = 100;
NSInteger const MediumPriorityAdjuster = 0;
NSInteger const LowPriorityAdjuster = -100;

NSTimeInterval const ImmediateInterval = 1440;
NSTimeInterval const HighPriorityInterval = 4320;
NSTimeInterval const MediumPriorityInterval = 10080;

@end
