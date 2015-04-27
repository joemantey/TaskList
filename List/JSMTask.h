//
//  Task.h
//  List
//
//  Created by Joseph Smalls-Mantey on 4/6/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSDate+DateTools.h>
#import <DTTimePeriod.h>

@interface JSMTask : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *details;
@property (strong, nonatomic) NSString *category;

@property (strong, nonatomic) NSDate *dateCreated;
@property (strong, nonatomic) NSDate *dateDue;
@property (strong, nonatomic) DTTimePeriod *timeUntiDueDate;
@property (nonatomic) BOOL isDueToday;


@property (nonatomic) NSInteger userPriority;
@property (nonatomic) NSInteger currentPriority;
@property (nonatomic) NSString *currentPriorityString;


@property (nonatomic) BOOL isGoal;




-(instancetype)initWithName:(NSString *)name
                 andDetails:(NSString *)details
                andCategory:(NSString *)category
                 andDateDue:(NSDate *)dateDue
            andUserPriority:(NSInteger)userPriority
                  andIsGoal:(BOOL)isGoal;

-(instancetype)init;


@end
