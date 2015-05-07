//
//  JSMNewTaskListViewController.m
//  List
//
//  Created by Joseph Smalls-Mantey on 5/6/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import "JSMNewTaskListViewController.h"
#import "JSMTaskDataManager.h"
#import "JSMTask.h"
#import "JSMTaskTableViewCell.h"

@interface JSMNewTaskListViewController ()

@property (strong, nonatomic) JSMTaskDataManager *taskDataManager;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation JSMNewTaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super viewDidLoad];
    
    self.taskDataManager = [JSMTaskDataManager sharedDataManager];
    
    [self setUpTimeProperties];

}

- (void)setUpTimeProperties{
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.taskDataManager.taskList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSMTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"task.cell" forIndexPath:indexPath];
    
    JSMTask *task = self.taskDataManager.taskList[indexPath.row];
    cell.titleLabel.text = task.name;
    cell.dateLabel.text = [self.dateFormatter stringFromDate:task.dueDate];
    cell.priorityLabel.text = [NSString stringWithFormat: @"%ld", (long)task.currentPriority];
    
    return cell;
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
