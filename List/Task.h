//
//  Task.h
//  List
//
//  Created by Joseph Smalls-Mantey on 6/25/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic, retain) NSNumber * currentPriority;
@property (nonatomic, retain) NSString * currentPriorityString;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * isDueToday;
@property (nonatomic, retain) NSNumber * isGoal;
@property (nonatomic, retain) NSString * list;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * reminderDate;
@property (nonatomic, retain) NSNumber * userPriority;

@end
