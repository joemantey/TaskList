//
//  JSMDataStore.h
//  List
//
//  Created by Joseph Smalls-Mantey on 6/16/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface JSMDataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *taskArray;
@property (strong, nonatomic) NSArray *listArray;


+ (instancetype) sharedDataStore;

- (void) saveContext;
- (void) generateTestData;
- (void) fetchTasks;

@end
