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

#pragma mark - Prioritization Helper Methods

-(NSDictionary *)buildDictionaryOfTaskPriortyValues{
    
    //Dictionaries for the events with due date set
    
    NSDictionary *dueDateHigh = @{
                                  @1:@9,
                                  @2:@7.5,
                                  @3:@6.5,
                                  @7:@5.5,
                                  @14:@4.5,
                                  @21:@3,
                                  @56:@0,
                                  };
    
    NSDictionary *dueDateMedium = @{
                                  @1:@8.5,
                                  @2:@7,
                                  @3:@6,
                                  @7:@4.5,
                                  @14:@3.5,
                                  @21:@2,
                                  @56:@0,
                                  };
    
    NSDictionary *dueDateLow = @{
                                    @1:@8,
                                    @2:@6.5,
                                    @3:@6,
                                    @7:@3.5,
                                    @14:@2,
                                    @21:@0.5,
                                    @56:@0,
                                    };
    
    //Dictionaries for events with no due date set
    
    NSDictionary *noDueDateHigh = @{
                                    @42:@9.5,
                                    @28:@9.5,
                                    @21:@9.5,
                                    @14:@9,
                                    @7:@8,
                                    @0:@5
                                    };
    
    NSDictionary *noDueDateMedium= @{
                                    @42:@9.5,
                                    @28:@9.5,
                                    @21:@9,
                                    @14:@8,
                                    @7:@6,
                                    @0:@3
                                    };
    NSDictionary *noDueDateLow= @{
                                 @42:@9.5,
                                 @28:@9,
                                 @21:@8,
                                 @14:@6,
                                 @7:@4,
                                 @0:@1
                                 };
    
}

-(double)getPercentageOfTimeElapsedSincePeriodStartDate:(NSInteger)periodStartDateAdjuster andPeriodEndDate:(NSInteger)periodEndDateAdjuster usingTask:(JSMTask *)task{
    
    NSDate *todaysDate      = [NSDate date];
    NSDate *dueDate         =  task.dueDate;
    NSDate *periodStartDate = [dueDate dateBySubtractingDays:periodStartDateAdjuster];
    NSDate *periodEndDate   = [dueDate dateBySubtractingDays:periodEndDateAdjuster];
    
    DTTimePeriod *taskTimePeriod = [[DTTimePeriod alloc] init];
    taskTimePeriod.StartDate     = periodStartDate;
    taskTimePeriod.EndDate       = periodEndDate;
    
    DTTimePeriod *timeSinceStartofPeriod = [[DTTimePeriod alloc]init];
    timeSinceStartofPeriod.StartDate     = periodStartDate;
    timeSinceStartofPeriod.EndDate       = todaysDate;
    
    
    double taskTimePeriodInMinutes                  = [taskTimePeriod durationInMinutes];
    double taskTimePeriodBeforeEndOfPeriodinMinutes = [timeSinceStartofPeriod durationInMinutes];
    
    double perecentaageOfTimeElapsedSincePeriodStartDate = taskTimePeriodBeforeEndOfPeriodinMinutes/taskTimePeriodInMinutes;
    
    return perecentaageOfTimeElapsedSincePeriodStartDate;
    
}


-(double )getPercentageOfTimeElapsedBetweenMilestonesForTask:(JSMTask *)task {
    
    
    NSDate *taskCreationDate = task.dateCreated;
    NSDate *taskDueDate = task.dueDate;
    NSDate *milestoneDate = [NSDate date];
    
    
    DTTimePeriod *taskTimePeriod = [[DTTimePeriod alloc] init];
    taskTimePeriod.StartDate = taskCreationDate;
    taskTimePeriod.EndDate = taskDueDate;
    
    DTTimePeriod *taskTimeElapsed = [[DTTimePeriod alloc] init];
    taskTimeElapsed.StartDate = taskCreationDate;
    taskTimeElapsed.EndDate =milestoneDate;
    
    
    double totalTime = [taskTimePeriod durationInMinutes];
    double timeElapsed = [taskTimeElapsed durationInMinutes];
    
    double percentComplete = timeElapsed/totalTime;
    
    return percentComplete;
    
}

-(void)setTaskPriorityWithTask:(JSMTask *)task{
    
    if (task.userPriority==0) {
        
        
    }else if ([task.userPriority ==0]!){
        
    }
    
}

-(void)setPriorityForTask:(JSMTask *)task{
    

}

-(void)setPriorityForTaskWithUserPriority:(JSMTask *)task{
    

    
}




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

@end
