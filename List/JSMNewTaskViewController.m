//
//  JSMNewTaskViewController.m
//  List
//
//  Created by Joseph Smalls-Mantey on 4/29/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import "JSMNewTaskViewController.h"

@interface JSMNewTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *dueDateField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *reminderField;
@property (weak, nonatomic) IBOutlet UIDatePicker *reminderDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *categoryField;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmentedControl;
@property (weak, nonatomic) IBOutlet UITextView *noteField;

@end

@implementation JSMNewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
