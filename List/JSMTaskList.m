//
//  JSMTaskList.m
//  List
//
//  Created by Joseph Smalls-Mantey on 4/25/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import "JSMTaskList.h"

@implementation JSMTaskList




#pragma mark - TaskList search methods

//organize task list by due date



-(NSArray *)returnTaskListOrganizedByDateCreated:(NSMutableArray *)taskArray{
    
    NSArray *returnArray  = [[NSArray alloc]init];
    
    NSSortDescriptor *dateCreatedSortDescripitor = [NSSortDescriptor sortDescriptorWithKey:@"dateCreated"
                                                                        ascending:NO];
    returnArray  = [taskArray sortedArrayUsingDescriptors:@[dateCreatedSortDescripitor]];
    
    return returnArray;
}

-(NSArray *)returnTaskListOrganizedByDueDate:(NSMutableArray *)taskArray{
    
    NSArray *returnArray  = [[NSArray alloc]init];
    
    NSSortDescriptor *dateCreatedSortDescripitor = [NSSortDescriptor sortDescriptorWithKey:@"dueDate"
                                                                                 ascending:NO];
    returnArray  = [taskArray sortedArrayUsingDescriptors:@[dateCreatedSortDescripitor]];
    
    return returnArray;
}




@end






















//
////build array of tasks list which has events organized by due date
//
//-(NSArray *)returnSortedArrayOfTasksWithDueDates:(NSMutableArray *)taskArray{
//    
//    NSArray *returnArray  = [[NSArray alloc]init];
//    
//    NSMutableArray *buildArray =[[NSMutableArray alloc]init];
//    
//    for (JSMTask *task in taskArray) {
//        if (task.dueDate) {
//            [buildArray addObject:task];
//        }
//    }
//    
//    NSSortDescriptor *dateCreatedSortDescripitor = [NSSortDescriptor sortDescriptorWithKey:@"dateCreated"
//                                                                                 ascending:NO];
//    returnArray  = [buildArray sortedArrayUsingDescriptors:@[dateCreatedSortDescripitor]];
//    
//    return returnArray;
//}
//
//
//
////build array of tasks for today
//
//-(NSArray *)returnArrayofTodaysTasks:(NSMutableArray *)taskArray{
//    
//    NSArray *returnArray  = [[NSArray alloc]init];
//    
//    NSMutableArray *buildArray =[[NSMutableArray alloc]init];
//    
//    for (JSMTask *task in taskArray) {
//        if ([task.dueDate isToday])
//        {
//            [buildArray addObject:task];
//        }
//    }
//    
//    returnArray = buildArray;
//    
//    return returnArray;
//}
//
//
//
////build array of task for tomorrow
//
//-(NSArray *)returnArrayofTomorrowsTasks:(NSMutableArray *)taskArray{
//    
//    NSArray *returnArray  = [[NSArray alloc]init];
//    
//    NSMutableArray *buildArray =[[NSMutableArray alloc]init];
//    
//    for (JSMTask *task in taskArray) {
//        if (![task.dueDate isTomorrow])
//        {
//            [buildArray addObject:task];
//        }
//    }
//    
//    returnArray = buildArray;
//    
//    return returnArray;
//}
//
//
//
////build array of tasks which are neither today nor tomorrow
//
//-(NSArray *)returnArrayofTaskLessTodayAndTomorrow:(NSMutableArray *)taskArray{
//    
//    NSArray *returnArray  = [[NSArray alloc]init];
//    
//    NSMutableArray *buildArray =[[NSMutableArray alloc]init];
//    
//    for (JSMTask *task in taskArray) {
//        if (![task.dueDate isToday] && ![task.dueDate isTomorrow])
//        {
//            [buildArray addObject:task];
//        }
//    }
//    
//    returnArray = buildArray;
//    
//    return returnArray;
//}
