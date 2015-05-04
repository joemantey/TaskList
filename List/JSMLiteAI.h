//
//  JSMLiteAI.h
//  List
//
//  Created by Joseph Smalls-Mantey on 4/7/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSMTask.h"

@interface JSMLiteAI : NSObject

-(double )getPercentageOfTimeElapsedBetweenMilestonesForTask:(JSMTask *)task;

@end
