//
//  JSMNewTaskViewController.m
//  List
//
//  Created by Joseph Smalls-Mantey on 4/29/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import "JSMNewTaskViewController.h"
#import "JSMTask.h"
#import "JSMTaskDataManager.h"

@interface JSMNewTaskViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *dueDateField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *reminderField;
@property (weak, nonatomic) IBOutlet UIDatePicker *reminderDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *listField;
@property (weak, nonatomic) IBOutlet UIPickerView *listPicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmentedControl;
@property (weak, nonatomic) IBOutlet UITextView *detailField;

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *details;
@property (strong, nonatomic) NSString *list;
@property (strong, nonatomic) NSDate *dueDate;
@property (strong, nonatomic) NSDate *reminderDate;
@property (nonatomic) NSInteger userPriority;
@property (nonatomic) BOOL isGoal;

- (IBAction)cancelButton:(id)sender;
- (IBAction)saveButton:(id)sender;

@property (nonatomic) BOOL dueDatePickerIsShowing;
@property (nonatomic) BOOL reminderDatePickerIsShowing;
@property (nonatomic) BOOL listPickerIsShowing;

@property (strong, nonatomic) JSMTaskDataManager *dataManager;




@end

@implementation JSMNewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.dataManager = [JSMTaskDataManager sharedDataManager];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton:(id)sender {
    
    //set the properties equal to the inuputs
    
    self.name = self.nameField.text;
    self.dueDate = self.dueDatePicker.date;
    self.reminderDate = self.reminderDatePicker.date;
    self.list = self.listField.text;
    self.details = self.detailField.text;
    
    //make sure the user priority has been set!!!!!!
    
    //create a new event from those properties
    
    JSMTask *newTask = [[JSMTask alloc]initWithName:self.name
                                         andDetails:self.details
                                            andList:self.list
                                         andDateDue:self.dueDate
                                    andReminderDate:self.reminderDate
                                    andUserPriority:self.userPriority
                                          andIsGoal:self.isGoal];
    
    [self.dataManager.taskList addObject:newTask];
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 9;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == dateDueFieldIndex){
        
        //If the datePickerIsShowing...
        if (self.dueDatePickerIsShowing){
            //...hide it!
            [self hideDatePickerCell:self.dueDatePicker andupdateBool:self.dueDatePickerIsShowing];
        }else {
            //...show it!
            [self showDatePickerCell:self.dueDatePicker andupdateBool:self.dueDatePickerIsShowing];
        }
        
    } else if (indexPath.row == reminderFieldIndex){
        
        if (self.reminderDatePickerIsShowing){

            [self hideDatePickerCell:self.reminderDatePicker andupdateBool:self.reminderDatePickerIsShowing];
        }else {
            
            [self showDatePickerCell:self.reminderDatePicker andupdateBool:self.reminderDatePickerIsShowing];
        }
        
    } else if (indexPath.row == listFieldIndex){
        
        if (self.listPickerIsShowing){
            
            [self hidePickerCell:self.listPicker andupdateBool:self.listPickerIsShowing];
        }else {
            
            [self showPickerCell:self.listPicker andupdateBool:self.listPickerIsShowing];
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    UIDatePicker *datePicker = picker;
    
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
                         
                         if (datePicker == self.dueDatePicker) {
                              self.dueDate = [datePicker date];
                         }else if (datePicker == self.reminderDatePicker) {
                             self.reminderDate = [datePicker date];
                         }
                        
                     }];
}


- (void)hidePickerCell:(UIPickerView *)picker andupdateBool:(BOOL)isShowingBool {
    
    BOOL pickerIsShowing = isShowingBool;
    UIPickerView *pickerView = picker;
    
    pickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
     
                     animations:^{
                         pickerView.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){

                         pickerView.hidden = YES;
                         
                         self.list = self.listField.text;
                     }];
}



@end
