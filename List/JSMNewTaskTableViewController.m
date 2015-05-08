//
//  JSMNewTaskTableViewController.m
//  List
//
//  Created by Joseph Smalls-Mantey on 5/5/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import "JSMNewTaskTableViewController.h"

#import "JSMTask.h"
#import "JSMTaskDataManager.h"

@interface JSMNewTaskTableViewController ()

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

@property (strong, nonatomic) NSArray *categoryPickerItems;

- (IBAction)cancelButton:(id)sender;
- (IBAction)saveButton:(id)sender;

- (IBAction)nameFieldChanged:(id)sender;
- (IBAction)datePickerValueChanged:(id)sender;
- (IBAction)reminderPickerValueChanged:(id)sender;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;



@property (nonatomic) BOOL dueDatePickerIsShowing;
@property (nonatomic) BOOL reminderDatePickerIsShowing;
@property (nonatomic) BOOL listPickerIsShowing;

@property (strong, nonatomic) JSMTaskDataManager *dataManager;

@end

@implementation JSMNewTaskTableViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self populateCategoryArray];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self hidePickerViews];
    [self setUpTimeProperties];
    
    self.dataManager = [JSMTaskDataManager sharedDataManager];
    
    self.listPicker.dataSource = self;
    self.listPicker.delegate = self;
    
}

-(void)hidePickerViews{
    
    self.dueDatePickerIsShowing = NO;
    self.dueDatePicker.hidden = YES;
    
    self.reminderDatePickerIsShowing = NO;
    self.reminderDatePicker.hidden= YES;
    
    self.listPickerIsShowing =  NO;
    self.listPicker.hidden = YES;
}


- (void)setUpTimeProperties{
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    self.dueDateField.text = [self.dateFormatter stringFromDate:[self.dueDatePicker date]];
    self.reminderField.text = [self.dateFormatter stringFromDate:[self.reminderDatePicker date]];
    
    NSInteger row = [self.listPicker selectedRowInComponent:0];
    self.listField.text = [self.categoryPickerItems objectAtIndex:row];
}

- (IBAction)nameFieldChanged:(id)sender {
    
    [self setTitle:self.nameField.text];
}


- (IBAction)datePickerValueChanged:(id)sender {
  
    self.dueDateField.text = [self.dateFormatter stringFromDate:[self.dueDatePicker date]];
}


- (IBAction)reminderPickerValueChanged:(id)sender {
   
    self.reminderField.text = [self.dateFormatter stringFromDate:[self.reminderDatePicker date]];
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - PickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 38;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.categoryPickerItems count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    self.listField.text= self.categoryPickerItems[row];
    return self.categoryPickerItems[row];
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

-(void)populateCategoryArray{
    
    self.categoryPickerItems = @[@"To Do's", @"Shopping List", @"Assignments", @"Goals"];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = fieldCellHeight;
    
    if (indexPath.row == dateDuePickerIndex){
        
        if (self.dueDatePickerIsShowing) {
            height = pickerCellHeight;
            
            
        }else{
            height = 0;
        }
        
    } else if (indexPath.row == reminderPickerIndex){
        
        if (self.reminderDatePickerIsShowing) {
            height = pickerCellHeight;
            
        }else{
            height = 0;
        }
        
    }
    else if (indexPath.row == listPickerIndex){
        
        if (self.listPickerIsShowing) {
            height = pickerCellHeight;
            
        }else{
            height = 0;
        }
        
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
;
        }
        
    } else if (indexPath.row == reminderFieldIndex){
        
        if (self.reminderDatePickerIsShowing){
            
            [self hideDatePickerCell:self.reminderDatePicker andupdateBool:self.reminderDatePickerIsShowing];
        }else {
            
            [self showDatePickerCell:self.reminderDatePicker andupdateBool:self.reminderDatePickerIsShowing];
        }
        
    }else if (indexPath.row == listFieldIndex){
        
        if (self.listPickerIsShowing){
            
            [self showListPicker];
        }else {
            
            [self hideListPicker];
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}





#pragma mark - helper methods

- (void)showDatePickerCell:(UIDatePicker *)picker andupdateBool:(BOOL)isShowingBool {
    
    
    //...change the BOOLEAN to indicate the the date picker is (about to be) shown...
    isShowingBool = YES;
    
    UIDatePicker *datePicker = picker;
    
    //...refresh the tableview...
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    //...seems like a good time to stop hiding the date picker...
    picker.hidden = NO;
    
    //Now some setup. Turn the date picker clear so we can have it fade in during our animation.
    picker.alpha = 0.0f;
    
    //Let's get our Walt Disney on and animate the appearance of this date picker.
    [UIView animateWithDuration:0.25 animations:^{
        
        datePicker.alpha = 1.0f;
        
    }];
}

- (void)showListPicker {
    
    [self.tableView beginUpdates];
    self.listPickerIsShowing = YES;
    
    self.listPicker.hidden = NO;
    
   
    
    
    self.listPicker.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.listPicker.alpha = 1.0f;
        
    }];
    [self.tableView endUpdates];
}



- (void)hideDueDatePickerCell{
    
    //...change the BOOLEAN to indicate the the date picker is (about to be) shown...
    self.dueDatePickerIsShowing= NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    //Animation time again. This time were turning the date picker clear.
    [UIView animateWithDuration:0.25
     
                     animations:^{
                         self.dueDatePicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         //when we're done animating, hide the picker
                         self.dueDatePicker.hidden = YES;
                         //update picker to show date
                         
                         
                         self.dueDateField.text = [self.dateFormatter stringFromDate:[self.dueDatePicker date]];
                         
                         
                     }];
}


- (void)hideReminderDatePickerCell{
    
    //...change the BOOLEAN to indicate the the date picker is (about to be) shown...
    self.reminderDatePickerIsShowing= NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    //Animation time again. This time were turning the date picker clear.
    [UIView animateWithDuration:0.25
     
                     animations:^{
                         self.reminderDatePicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         //when we're done animating, hide the picker
                         self.dueDatePicker.hidden = YES;
                         //update picker to show date
                         
                         
                             self.reminderField.text = [self.dateFormatter stringFromDate:[self.reminderDatePicker date]];
                         
                         
                     }];
}


- (void)hideListPicker{
    
    
    self.listPickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    
    [UIView animateWithDuration:0.25
     
                     animations:^{
                         self.listPicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         
                         self.listPicker.hidden = YES;
                         
                         NSInteger row = [self.listPicker selectedRowInComponent:0];
                         self.listField.text = [self.categoryPickerItems objectAtIndex:row];;
                     }];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
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
