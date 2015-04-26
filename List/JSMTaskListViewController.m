//
//  JSMTaskListViewController.m
//  List
//
//  Created by Joseph Smalls-Mantey on 4/25/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import "JSMTaskListViewController.h"
#import "JSMTaskDataManager.h"

@interface JSMTaskListViewController ()

@property (strong, nonatomic) JSMTaskDataManager *taskDataManager;

@end

@implementation JSMTaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.taskDataManager = [JSMTaskDataManager sharedDataManager];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
