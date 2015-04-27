//
//  JSMTaskList.m
//  List
//
//  Created by Joseph Smalls-Mantey on 4/25/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import "JSMTaskList.h"
#import "JSMTask.h"

@implementation JSMTaskList

//organize task list by due date

-(NSArray *)returnTaskListOrganizedByDateCreated:(NSMutableArray *)taskArray{
    
    NSArray *returnArray  = [[NSArray alloc]init];
    
    NSSortDescriptor *dateCreatedSortDescripitor = [NSSortDescriptor sortDescriptorWithKey:@"dateCreated"
                                                                        ascending:NO];
    returnArray  = [taskArray sortedArrayUsingDescriptors:@[dateCreatedSortDescripitor]];
    
    return returnArray;
}

//build array of tasks list which has events organized by due date

-(NSArray *)returnSortedArrayOfTasksWithDueDates:(NSMutableArray *)taskArray{
    
    NSArray *returnArray  = [[NSArray alloc]init];
    
    NSMutableArray *buildArray =[[NSMutableArray alloc]init];
    
    for (JSMTask *task in taskArray) {
        if (task.dateDue) {
            [buildArray addObject:task];
        }
    }
    
    NSSortDescriptor *dateCreatedSortDescripitor = [NSSortDescriptor sortDescriptorWithKey:@"dateCreated"
                                                                                 ascending:NO];
    returnArray  = [buildArray sortedArrayUsingDescriptors:@[dateCreatedSortDescripitor]];
    
    return returnArray;
}

//build array of tasks for today

//build array of task for tomorrow and on


@end
