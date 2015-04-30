//
//  JSMNewTaskViewController.m
//  List
//
//  Created by Joseph Smalls-Mantey on 4/29/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import "JSMNewTaskViewController.h"

@interface JSMNewTaskViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *dueDateField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *reminderField;
@property (weak, nonatomic) IBOutlet UIDatePicker *reminderDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *categoryField;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmentedControl;
@property (weak, nonatomic) IBOutlet UITextView *noteField;

@property (nonatomic) BOOL dueDatePickerIsShowing;
@property (nonatomic) BOOL reminderDatePickerIsShowing;
@property (nonatomic) BOOL listPickerIsShowing;


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

#pragma mark - TableViewDelegate 

//Constants for static tableview
#define nameFieldIndex 0
#define dateDueFieldIndex 1
#define dateDuePickerIndex 2
#define reminderFieldIndex 3
#define reminderPickerIndex 4
#define listFieldIndex 5
#define listPickerIndex 6
#define priorityFieldIndex 7
#define notesFieldIndex 8

#define fieldCellHeight 64
#define pickerCellHeight 162


//If datePickerIsShowing, set the height of the cell to 164 (the hieght of a date picker). If !datePickerIsShowing, set the height of the cell to 0
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = fieldCellHeight;
    
    if (indexPath.row == dateDuePickerIndex){
        
        height = self.dueDatePickerIsShowing ? pickerCellHeight : 0.0f;
        
    } else if (indexPath.row == reminderPickerIndex){
        
        height = self.reminderDatePickerIsShowing ? pickerCellHeight : 0.0f;
        
    }
    else if (indexPath.row == listPickerIndex){
        
        height = self.listPickerIsShowing ? pickerCellHeight : 0.0f;
        
    }
    
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
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
