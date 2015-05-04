//
//  JSMLiteAI.m
//  List
//
//  Created by Joseph Smalls-Mantey on 4/7/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//


/*
 The algorithm works on a scale of 0-1000. This allows there to be enough variotion of scores between objects and makes things easy on the programmer and consumer as things on a decimal scale can be easily divided and displayed.
 */



#import "JSMLiteAI.h"
#import "JSMTask.h"
#import "JSMConstants.h"
#import <DateTools.h>
#import <DTTimePeriod.h>




@implementation JSMLiteAI

//Create some sample data in app delegate


-(void)setPriority:(JSMTask *)task fromArray:(NSMutableArray *)taskArray {
    
    JSMTask *adjustedTask = task;
    
    if (task.dueDate)
    //if something has a due date, update the time until due date for that object
    {
        adjustedTask.timeUntiDueDate = [[DTTimePeriod alloc]initWithStartDate:[NSDate date] endDate:task.dueDate];

        
        //if it is due that day
        
        if ([task.dueDate isToday]) {}
            
            
            
    }
}

#pragma mark Helper Methods





-(NSInteger)getTaskPercentilefromArray:(NSMutableArray *)array usingTask:(JSMTask *)task{
    
    
    
    ///make sure array is sorted
    
    //get
    
    return 1;

}

-(NSTimeInterval)getTimeIntervalbetween:(NSDate *)startDate andEndDate:(NSDate *)endDate{
   
    NSTimeInterval secondsBetween = [startDate timeIntervalSinceDate:endDate];
    
    return secondsBetween;

}



@end

/*
        //Build an array of all of the task for today
        NSMutableArray *todaysTasksArray = [[NSMutableArray alloc] init];
        for (JSMTask *taskToAddToToday in taskArray) {
            
            if ([todaysTaskTask.dueDate isToday]) {
                [todaysTasksArray addObject:taskToAddToToday];
            }
        }
        
        
        //Count the amount of items in the array to set the
    }
    
    //get all of the items do today, and distribute them based on when they are due that day
    
    // and distribute by assigned importnace
    
    //if it is due in the next 2 days, set the priority to to high
    
    //get all of the items do for the next two days, and distribute them based on when they are due within those two days
    
    // and distribute by assigned importance
    
    //if it is due in the next 7 days, set the priority to medium
    
    //get all of the items do for the next two days, and distribute them based on when they are due within those two days
    
    // and distribute by assigned importance
    
    //if it is due in the in more than 7 days, set the priority to low
    
    
    //get all of the items do in more than 7 days, and distribute them based on when they are due within those two days
    
    // and distribute by assigned importance
    
}





//if something does not have a due date

//find all of the events which don't have a due date

//create and array with them

//order them by the time elapsed by the time is done

//count the array

//get the objects position in the array

//based on the count of the array and the objects position, calculate it's % index

//multiply index by 90 to get importane score */