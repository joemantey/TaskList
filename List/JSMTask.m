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
    
    NSDictionary *dueDateHigh = @{@0:@10,
                                  @1:@9,
                                  @2:@7.5,
                                  @3:@6.5,
                                  @7:@5.5,
                                  @14:@4.5,
                                  @21:@3,
                                  @56:@0,
                                  };
    
    NSDictionary *dueDateMedium = @{
                                  @0:@10,
                                  @1:@8.5,
                                  @2:@7,
                                  @3:@6,
                                  @7:@4.5,
                                  @14:@3.5,
                                  @21:@2,
                                  @56:@0,
                                  };
    
    NSDictionary *dueDateLow = @{
                                 @0:@10,
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
    
    //Goal dictionary
    
    NSDictionary *isAGoal= @{
                             @1:@10,
                             @0.75:@8,
                             @0.5:@6,
                             @0.25:@4,
                             };
    
    NSDictionary *algorithmDictionary =  @{@"dueDateHigh":dueDateHigh,
                                         @"dueDateMedium":dueDateMedium,
                                            @"dueDateLow":dueDateLow,
                                         @"noDueDateHigh":noDueDateHigh,
                                       @"noDueDateMedium":noDueDateMedium,
                                          @"noDueDateLow":noDueDateLow,
                                               @"isAGoal":isAGoal
                                      };
    return algorithmDictionary;
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
    
    NSDictionary *algorithmDictionary = [self buildDictionaryOfTaskPriortyValues];
    
    NSArray *algorithmDictionaryKeys = [self getMilestonesForTasksWithDueDate:task];
    
    //get values from dictionary
    
    
    
}

-(NSArray *)getMilestonesForTasksWithoutDueDate:(JSMTask *)task{
    
    
    NSDate *todaysDate = [NSDate date];
    
    NSInteger daysFromDueDate = [todaysDate daysFrom:task.dueDate];
    
    if ([self checkIf:daysFromDueDate isBetween:0 and:1])
    {
        NSArray *outputArray = @[@0,@1];
        return outputArray;
    }
    
    else if ([self checkIf:daysFromDueDate isBetween:1 and:2])
    {
        NSArray *outputArray = @[@1,@2]; return outputArray;
        return outputArray;
    }
}



-(NSArray *)getMilestonesForTasksWithDueDate:(JSMTask *)task{
    
   
    NSDate *todaysDate = [NSDate date];
    
    NSInteger daysFromDueDate = [todaysDate daysFrom:task.dueDate];
    
    if ([self checkIf:daysFromDueDate isBetween:0 and:1])
    {
        NSArray *outputArray = @[@0,@1];
        return outputArray;
    }
    
    else if ([self checkIf:daysFromDueDate isBetween:1 and:2])
    {
        NSArray *outputArray = @[@1,@2]; return outputArray;
        return outputArray;
    }
    
    else if ([self checkIf:daysFromDueDate isBetween:2 and:3])
    {
        NSArray *outputArray = @[@2,@3];
         return outputArray;
    }
    
    else if ([self checkIf:daysFromDueDate isBetween:3 and:7])
    {
        NSArray *outputArray = @[@3,@7];
         return outputArray;
    }
    
    else if ([self checkIf:daysFromDueDate isBetween:7 and:14])
    {
        NSArray *outputArray = @[@7,@14];
         return outputArray;
    }
    
    else if ([self checkIf:daysFromDueDate isBetween:14 and:21])
    {
        NSArray *outputArray = @[@14,@21];
         return outputArray;
    }
    
    else if ([self checkIf:daysFromDueDate isBetween:21 and:28])
    {
        NSArray *outputArray = @[@21,@28];
         return outputArray;
    }
    
    else if ([self checkIf:daysFromDueDate isBetween:28 and:56])
    {
        NSArray *outputArray = @[@28,@56];
         return outputArray;
    }
    
    else
    {
        NSArray *outputArray = @[@56, @56];
         return outputArray;
    }
    
   
}


-(BOOL)checkIf:(NSInteger)integer isBetween:(NSInteger)integerOne and:(NSInteger)integerTwo{
 
    if (integer > integerOne)
    {
        if (integer < integerTwo)
            {
                return YES;
            }
        else
            {
                return NO;
            }
    }
    else
        {
            return NO;
        }
}

//-(NSArray *)getDictionaryValuesUsingKeysFromArray:(NSArray *)keyArray{
//
//    NSInteger keyOne = keyArray[0];
//    NSInteger keyTwo = keyArray[1];
//
//    NSArray *returnArray = @[[NSNumber numberWithInteger:keyOne], [NSNumber numberWithInteger:keyTwo]];
//
//    return returnArray;
//
//}

//-(void)setPriority{
//    
//    NSInteger priorityInteger = self.currentPriority;
//    NSString *outputString = [[NSString alloc]init];
//    
//    if (priorityInteger < LOWBound )
//    {
//        outputString = @"Low";
//    }
//    else if ( priorityInteger < MEDIUMBound)
//    {
//        outputString = @"Medium";
//    }
//    else if ( priorityInteger < HIGHBound)
//    {
//        outputString = @"High";
//    }
//    else if (priorityInteger > HIGHBound)
//    {
//        outputString = @"Immediate";
//    }
//    
//    self.currentPriorityString = outputString;
//}

@end
