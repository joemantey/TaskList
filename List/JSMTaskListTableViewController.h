//
//  JSMTaskListTableViewController.h
//  List
//
//  Created by Joseph Smalls-Mantey on 5/5/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSMDataStore.h"

@interface JSMTaskListTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *managedListObjects;
@property (strong, nonatomic) JSMDataStore *store;

@end
