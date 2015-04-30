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

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *details;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSDate *dateDue;
@property (nonatomic) NSInteger userPriority;


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



#pragma mark - helper methods

- (void)showDatePickerCell:(UIDatePicker *)picker andupdateBool:(BOOL)isShowingBool {
    
    
    BOOL pickerIsShowing = isShowingBool;
    //...change the BOOLEAN to indicate the the date picker is (about to be) shown...
    pickerIsShowing = YES;
    
    UIDatePicker *datePicker = picker;
    
    //...refresh the tableview...
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    //...seems like a good time to stop hiding the date picker...
    datePicker.hidden = NO;
    
    //Now some setup. Turn the date picker clear so we can have it fade in during our animation.
    datePicker.alpha = 0.0f;
    
    //Let's get our Walt Disney on and animate the appearance of this date picker.
    [UIView animateWithDuration:0.25 animations:^{
        
        datePicker.alpha = 1.0f;
        
    }];
}

- (void)showPickerCell:(UIPickerView *)picker andupdateBool:(BOOL)isShowingBool {
    
    
    BOOL pickerIsShowing = isShowingBool;
    
    pickerIsShowing = YES;
    
    UIPickerView *pickerView = picker;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    pickerView.hidden = NO;
    
    pickerView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        pickerView.alpha = 1.0f;
        
    }];
}

- (void)hideDatePickerCell:(UIDatePicker *)picker andupdateBool:(BOOL)isShowingBool {
    
    BOOL pickerIsShowing = isShowingBool;
    UIDatePicker *p
    //...change the BOOLEAN to indicate the the date picker is (about to be) shown...
    pickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    //Animation time again. This time were turning the date picker clear.
    [UIView animateWithDuration:0.25
     
                     animations:^{
                         datePicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         //when we're done animating, hide the picker
                         datePicker.hidden = YES;
                         //update picker to show date
                         self.dateDue = [self.datePicker date];
                     }];
}




@end
