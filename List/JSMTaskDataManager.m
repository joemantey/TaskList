//
//  JSMTaskDataManager.m
//  List
//
//  Created by Joseph Smalls-Mantey on 4/25/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import "JSMTaskDataManager.h"
#import "JSMTask.h"

@implementation JSMTaskDataManager
@synthesize managedObjectContext = _managedObjectContext;



+ (instancetype)sharedDataManager {
    static JSMTaskDataManager *_sharedDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataManager = [[JSMTaskDataManager alloc] init];
        _sharedDataManager.tasks = [[NSMutableArray alloc]init];
    });
    return _sharedDataManager;
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

@end
