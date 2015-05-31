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
        _sharedDataManager.taskList = [[NSMutableArray alloc]init];
    });
    return _sharedDataManager;
}


@end
