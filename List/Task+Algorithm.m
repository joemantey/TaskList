//
//  Task+Algorithm.m
//  List
//
//  Created by Joseph Smalls-Mantey on 6/18/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import "Task+Algorithm.h"
#import <DTTimePeriod.h>
#import <NSDate+DateTools.h>
#import "JSMConstants.h"


@implementation Task (Algorithm)



-(void)setTaskPriorityWithTask:(Task *)task{
    
    NSDictionary *algorithmDictionary = [self buildDictionaryOfTaskPriortyValues];
    
    //if task has due date
    if (task.dueDate) {
        
        NSArray *algorithmKeys       = [self getMilestonesForTasksWithDueDate:task];
        NSString *algorithmKeyString = [self getDictionaryKeyStringforTask:task];
        
        double adjuster = [self getPercentageOfTimeElapsedSincePeriodStartDate:[algorithmKeys[1] integerValue]
                                                              andPeriodEndDate:[algorithmKeys[0] integerValue]
                                                                     usingTask:task];
        
        NSNumber *calculatedPriority = [self calculatePriorityForTask:task usingKeyString:algorithmKeyString andKeys:algorithmKeys andAdjuster:adjuster andAlgorithmDictionary:algorithmDictionary];
        
        task.currentPriority = calculatedPriority;
    }
    
    //if task doesn't have due date
    else {
        
        NSString *algorithmKeyString = [self getDictionaryKeyStringforTask:task];
        NSArray *algorithmKeys =       [self getMilestonesForTasksWithoutDueDate:task];
        
        double adjuster = [self getPercentageOfTimeElapsedSincePeriodStartDate:[algorithmKeys[0] integerValue]
                                                              andPeriodEndDate:[algorithmKeys[1] integerValue]
                                                                     usingTask:task];
        
        NSNumber *calculatedPriority = [self calculatePriorityForTask:task usingKeyString:algorithmKeyString andKeys:algorithmKeys andAdjuster:adjuster andAlgorithmDictionary:algorithmDictionary];
        
        task.currentPriority = calculatedPriority;
    }
}


-(NSNumber *)calculatePriorityForTask:(Task *)task usingKeyString:(NSString *)keyString andKeys:(NSArray *)keyArray andAdjuster:(double)adjuster andAlgorithmDictionary:(NSDictionary *)algorithmDictionary{
    
    
    //get the bottom of the range
    NSDictionary *currentAlgorithmDictionary = algorithmDictionary[keyString];
    
    NSNumber *bottomOfRangeKey = keyArray[1];
    NSNumber *topOfRangeKey    = keyArray[0];
    
    NSNumber *bottomOfPriorityRange = [currentAlgorithmDictionary objectForKey:bottomOfRangeKey];
    NSNumber *topOfPriorityRange    = [currentAlgorithmDictionary objectForKey:topOfRangeKey];
    NSInteger range = [topOfPriorityRange integerValue] - [bottomOfPriorityRange integerValue];
    
    NSInteger basePriority = [bottomOfPriorityRange integerValue];
    NSInteger adjustedPriority = basePriority + ( (NSInteger)adjuster * range);
    
    return [NSNumber numberWithInteger: adjustedPriority];
    
}



-(double)getPercentageOfTimeElapsedSincePeriodStartDate:(NSInteger)periodStartDateAdjuster andPeriodEndDate:(NSInteger)periodEndDateAdjuster usingTask:(Task *)task{
    
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







-(BOOL)checkIf:(NSInteger)integer isBetween:(NSInteger)integerOne and:(NSInteger)integerTwo{
    
    if (integer > integerOne && integer < integerTwo){
        return YES;
    }
    else{
        return NO;
    }
}



-(NSString *)getDictionaryKeyStringforTask:(Task *)task{
    
    if (task.isGoal) {
        return @"isAGoal";
    }
    else if (task.dueDate) {
        if (task.userPriority == [NSNumber numberWithInteger:highPriorityInteger ]) {
            return @"dueDateHigh";
        }
        else if (task.userPriority == [NSNumber numberWithInteger:medPriorityInteger]){
            return @"dueDateMedium";
        }
        else if (task.userPriority == [NSNumber numberWithInteger:lowPriorityInteger]) {
            return @"dueDateLow";
        }
        else {
            return @"dueDateLow";
        }
    }
    else{
        if (task.userPriority == [NSNumber numberWithInteger:highPriorityInteger]) {
            return @"noDueDateHigh";
        }
        if (task.userPriority == [NSNumber numberWithInteger:medPriorityInteger]) {
            return @"noDueDateMedium";
        }
        if (task.userPriority == [NSNumber numberWithInteger:lowPriorityInteger]) {
            return @"noDueDateLow";
        }else{
            return @"noDueDateLow";
        }
    }
}

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

-(NSArray *)getMilestonesForTasksWithoutDueDate:(Task *)task{
    
    
    NSDate *todaysDate = [NSDate date];
    
    NSInteger daysFromDateCreated = [todaysDate daysFrom:task.dateCreated];
    
    if ([self checkIf:daysFromDateCreated isBetween:42 and:1000000])
    {
        NSArray *outputArray = @[@42,@42];
        return outputArray;
    }
    else if ([self checkIf:daysFromDateCreated isBetween:28 and:42])
    {
        NSArray *outputArray = @[@42,@28];
        return outputArray;
    }
    else if ([self checkIf:daysFromDateCreated isBetween:28 and:21])
    {
        NSArray *outputArray = @[@28,@21];
        return outputArray;
    }
    else if ([self checkIf:daysFromDateCreated isBetween:21 and:14])
    {
        NSArray *outputArray = @[@21,@14];
        return outputArray;
    }
    else if ([self checkIf:daysFromDateCreated isBetween:14 and:7])
    {
        NSArray *outputArray = @[@14,@7];
        return outputArray;
    }
    else
    {
        NSArray *outputArray = @[@7,@0];
        return outputArray;
    }
}



-(NSArray *)getMilestonesForTasksWithDueDate:(Task *)task{
    
    
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
    
    else if ([self checkIf:daysFromDueDate isBetween:21 and:56])
    {
        NSArray *outputArray = @[@21,@56];
        return outputArray;
    }
    else
    {
        NSArray *outputArray = @[@56, @56];
        return outputArray;
    }
    
    
}




@end
