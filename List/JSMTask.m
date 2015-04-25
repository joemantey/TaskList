//
//  Task.m
//  List
//
//  Created by Joseph Smalls-Mantey on 4/6/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//


//@property (strong,nonatomic) NSString *name;
//@property (strong,nonatomic) NSString *details;
//@property (strong, nonatomic) NSString *category;
//
//@property (strong, nonatomic) NSDate *dateCreated;
//@property (strong, nonatomic) NSDate *dateDue;
//
//@property (nonatomic) NSInteger userPriority;
//@property (nonatomic) NSInteger currentPriority;
//
//@property (nonatomic) BOOL *isGoal;
#import "JSMTask.h"

@implementation JSMTask

//add time period

-(instancetype)initWithName:(NSString *)name
                 andDetails:(NSString *)details
                andCategory:(NSString *)category
                 andDateDue:(NSDate *)dateDue
            andTimeInterval:(NSTimeInterval )timeTilDue
            andUserPriority:(NSInteger)userPriority
                  andIsGoal:(BOOL)isGoal{
    
    if (self = [super init]) {
        _name = name;
        _details = details;
        _category = category;
        _dateCreated = [NSDate date];
        _dateDue = dateDue;
        _timeTilDue = timeTilDue;
        _userPriority = userPriority;
        _currentPriority = userPriority;
        _isGoal = isGoal;
    }
    
    return self;
}

-(instancetype)init{
    self = [ self initWithName:@""
                    andDetails:@""
                   andCategory:@""
                    andDateDue:nil
               andTimeInterval:[_dateCreated timeIntervalSinceDate:_dateDue]
               andUserPriority:30
                     andIsGoal:NO ];
    
    return self;
}

#pragma mark 

#define LOWBound 31
#define MEDIUMBound 61
#define HIGHBound 91

/*  Priority is based on a number system. Text labels are generated from the currentPriority propery which is the numeric score manipulated AILite to provide an indication of task priority.
 
 0-30 Low
 31-60 Medium
 60-90 High
 91-100 Imediate */

-(void)setPriority{
    
    NSInteger priorityInteger = self.currentPriority;
    NSString *outputString = [[NSString alloc]init];
    
    if (priorityInteger < LOWBound )
    {
        outputString = @"Low";
    }
    else if ( priorityInteger < MEDIUMBound)
    {
        outputString = @"Medium";
    }
    else if ( priorityInteger < HIGHBound)
    {
        outputString = @"High";
    }
    else if (priorityInteger > HIGHBound)
    {
        outputString = @"Immediate";
    }
    
    self.currentPriorityString = outputString;
}



@end
