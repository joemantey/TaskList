//
//  Task.m
//  List
//
//  Created by Joseph Smalls-Mantey on 4/6/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.



#import "JSMTask.h"
#import "JSMConstants.h"
#import <DTTimePeriod.h>


@implementation JSMTask

//NEEDS START PERIOD AND END PERIOD FOR GOALS



-(instancetype)initWithName:(NSString *)name
                 andDetails:(NSString *)details
                andList:(NSString *)list
                 andDateDue:(NSDate *)dateDue
            andReminderDate:(NSDate *)reminderDate
            andUserPriority:(NSInteger)userPriority
                  andIsGoal:(BOOL)isGoal{
    
    if (self = [super init]) {
        _name = name;
        _details = details;
        _list = list;
        _dateCreated = [NSDate date];
        _dueDate = dateDue;
        _reminderDate = reminderDate;
        if (_dueDate) {
            _timeUntiDueDate = [[DTTimePeriod alloc]initWithStartDate:[NSDate date] endDate:dateDue];
            _isDueToday = [dateDue isToday];
        }else {
            _timeUntiDueDate = nil;
            _isDueToday = NO;
        }
        _userPriority = userPriority;
        _currentPriority = userPriority;
        _isGoal = isGoal;
    }
    
    return self;
}

-(instancetype)init{
    
    
    self = [ self initWithName:@""
                    andDetails:@""
                       andList:@""
                    andDateDue:nil
               andReminderDate:nil
               andUserPriority:LowPriorityInteger
                     andIsGoal:NO ];
    
    return self;
}

#pragma mark 

#define LOWBound 31
#define MEDIUMBound 61
#define HIGHBound 91

/*  Priority is based on a number system. Text labels are generated from the currentPriority propery which is the numeric score manipulated AILite to provide an indication of task priority.
 
*/




-(void)setPriority{
    
    NSInteger priorityInteger = self.currentPriority;
    NSString *outputString = [[NSString alloc]init];
    
    if (priorityInteger < LOWBound )
    {
        outputString = @"Low";
    }
    else if ( priorityInteger < MEDIUMBound)
    {
        outputString = @"Medium";
    }
    else if ( priorityInteger < HIGHBound)
    {
        outputString = @"High";
    }
    else if (priorityInteger > HIGHBound)
    {
        outputString = @"Immediate";
    }
    
    self.currentPriorityString = outputString;
}

-(double)getPercentageOfTimeElapsedBetweenpPeriodStartDate:(NSInteger)periodStartDateAdjuster andPeriodEndDate:(NSInteger)periodEndDateAdjuster usingTask:(JSMTask *)task{
    
    NSDate *todaysDate       = [NSDate date];
    NSDate *dueDate         =  task.dueDate;
    NSDate *periodStartDate = [dueDate dateBySubtractingDays:periodStartDateAdjuster];
    NSDate *periodEndDate   = [dueDate dateBySubtractingDays:periodEndDateAdjuster];
    
    DTTimePeriod *taskTimePeriod = [[DTTimePeriod alloc] init];
    taskTimePeriod.StartDate = periodStartDate;
    taskTimePeriod.EndDate = periodEndDate;
    
    DTTimePeriod *timeUntilDueDate = [[DTTimePeriod alloc]init];
    timeUntilDueDate.StartDate = todaysDate;
    timeUntilDueDate.EndDate = dueDate;
    
    DTTimePeriod *timeBetweenThenEndOfPeriodAndDueDate= [[DTTimePeriod alloc] init];
    timeUntilDueDate.StartDate = dueDate;
    timeUntilDueDate.EndDate = periodEndDate;
    
    
    
    
    
}


-(double )getPercentageOfTimeElapsedBetweenMilestonesForTask:(JSMTask *)task {
    
    
    NSDate *taskCreationDate = task.dateCreated;
    NSDate *taskDueDate = task.dueDate;
    NSDate *milestoneDate = [NSDate date];
    
    
    DTTimePeriod *taskTimePeriod = [[DTTimePeriod alloc] init];
    taskTimePeriod.startDate = taskCreationDate;
    taskTimePeriod.endDate = taskDueDate;
    
    DTTimePeriod *taskTimeElapsed = [[DTTimePeriod alloc] init];
    taskTimeElapsed.startDate = taskCreationDate;
    taskTimeElapsed.endDate =milestoneDate;
    
    
    double totalTime = [taskTimePeriod durationInMinutes];
    double timeElapsed = [taskTimeElapsed durationInMinutes];
    
    double percentComplete = timeElapsed/totalTime;
    
    return percentComplete;
    
}


@end
