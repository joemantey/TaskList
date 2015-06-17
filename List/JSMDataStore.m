//
//  JSMDataStore.m
//  List
//
//  Created by Joseph Smalls-Mantey on 6/16/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import "JSMDataStore.h"
#import "Task.h"
#import <CoreData/CoreData.h>

@implementation JSMDataStore
@synthesize managedObjectContext = _managedObjectContext;

+ (instancetype)sharedDataStore {
    static JSMDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[JSMDataStore alloc] init];
    });
    
    return _sharedDataStore;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"list.sqlite"];
    
    NSError *error = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"list" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)fetchData
{
    NSFetchRequest *messagesRequest = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
    
    NSSortDescriptor *createdAtSorter = [NSSortDescriptor sortDescriptorWithKey:@"dateCreated" ascending:YES];
    messagesRequest.sortDescriptors = @[createdAtSorter];
    
    self.taskArray = [self.managedObjectContext executeFetchRequest:messagesRequest error:nil];
    
    if ([self.taskArray count]==0) {
        [self generateTestData];
    }
}

- (void)generateTestData
{
    Task *taskOne = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:self.managedObjectContext];
    
    taskOne.currentPriority = @25;
    taskOne.currentPriorityString = @"Low";
    taskOne.dateCreated = [NSDate date];
    taskOne.details = @"It's my first task. The devil is in the details";
    taskOne.isDueToday = @0;
    taskOne.isGoal = @0;
    taskOne.list = @"To Do's";
    taskOne.name = @"My First Task";
    
    
    [self saveContext];
    [self fetchData];
}


@end
