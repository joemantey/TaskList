//
//  JSMNewTaskTableViewController.m
//  List
//
//  Created by Joseph Smalls-Mantey on 5/5/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import "JSMNewTaskTableViewController.h"
#import "JSMDataStore.h"
#import "Task.h"


@interface JSMNewTaskTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *dueDateField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *reminderField;
@property (weak, nonatomic) IBOutlet UIDatePicker *reminderDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *listField;
@property (weak, nonatomic) IBOutlet UIPickerView *listPicker;
@property (weak, nonatomic) IBOutlet UITextField *priorityField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmentedControl;
@property (weak, nonatomic) IBOutlet UITextView *detailField;
@property (weak, nonatomic) IBOutlet UITextField *detailFieldPlaceholder;
@property (weak, nonatomic) IBOutlet UIView *detailFieldLine;



- (IBAction)nameFieldDidChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelName;
- (IBAction)didCancelName:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelDateDue;
- (IBAction)didCancelDueDate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelReminder;
- (IBAction)didCancelReminder:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelList;
- (IBAction)didCancelList:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelPriority;
- (IBAction)didCancelPriority:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelDetails;
- (IBAction)didCancelDetails:(id)sender;


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
@property (nonatomic) BOOL priorityPickerIsShowing;
@property (nonatomic) BOOL detailPlaceholderIsShowing;

@property (strong, nonatomic) JSMDataStore *dataManager;

@end

@implementation JSMNewTaskTableViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.store = [JSMDataStore sharedDataStore];
    
    [self hidePickerViews];
    [self setUpTextInOutlets];
    [self setUpPlaceHolderText];
    [self setUpButtonImages];
    [self resignFirstResponder];
    
    self.listPicker.dataSource = self;
    self.listPicker.delegate = self;
    
    self.dueDateField.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.store fetchData];
    [self populateCategoryArray];
}

-(void)hidePickerViews{
    
    self.dueDatePickerIsShowing = NO;
    self.dueDatePicker.hidden = YES;
    
    self.reminderDatePickerIsShowing = NO;
    self.reminderDatePicker.hidden= YES;
    
    self.listPickerIsShowing =  NO;
    self.listPicker.hidden = YES;
    
    self.priorityPickerIsShowing = NO;
    self.prioritySegmentedControl.hidden = YES;
    
    self.detailField.hidden = YES;
    self.detailPlaceholderIsShowing = YES;
    self.detailFieldPlaceholder.hidden = NO;
    self.detailFieldLine.hidden = NO;
}


- (void)setUpTextInOutlets{
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    
    [self.dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    self.listField.text = self.categoryPickerItems[0];
}

-(void)setUpPlaceHolderText{
    
    UIColor *color = [UIColor colorWithWhite:1 alpha:0.7];

    self.nameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"task name" attributes:@{NSForegroundColorAttributeName: color }];
    
    self.dueDateField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"due date" attributes:@{NSForegroundColorAttributeName: color }];
    
    self.reminderField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"reminder date" attributes:@{NSForegroundColorAttributeName: color }];
    
     self.listField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"task list" attributes:@{NSForegroundColorAttributeName: color }];
    
    self.priorityField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"task priority" attributes:@{NSForegroundColorAttributeName: color }];
    
    self.detailFieldPlaceholder.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"notes" attributes:@{NSForegroundColorAttributeName: color }];
}


-(void)setUpButtonImages{
    
    [self.cancelName setImage:[UIImage imageNamed:@"Cancel"] forState:normal];
    self.cancelName.hidden = YES;
    
    [self.cancelDateDue setImage:[UIImage imageNamed:@"Cancel"] forState:normal];
    self.cancelDateDue.hidden = YES;
    
    [self.cancelReminder setImage:[UIImage imageNamed:@"Cancel"] forState:normal];
    self.cancelReminder.hidden = YES;
    
    [self.cancelList setImage:[UIImage imageNamed:@"Cancel"] forState:normal];
    self.cancelList.hidden = YES;
    
    [self.cancelPriority setImage:[UIImage imageNamed:@"Cancel"] forState:normal];
    self.cancelPriority.hidden = YES;
    
    [self.cancelDetails setImage:[UIImage imageNamed:@"Cancel"] forState:normal];
    self.cancelDetails.hidden = YES;
}

#pragma mark - Action Outlets


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
    
    
    if (self.prioritySegmentedControl.selectedSegmentIndex == -1) {
        self.userPriority = 0;
    }else{
        self.userPriority = self.prioritySegmentedControl.selectedSegmentIndex;
    }
    self.name = self.nameField.text;
    self.dueDate = self.dueDatePicker.date;
    self.reminderDate = self.reminderDatePicker.date;
    self.list = self.listField.text;
    self.details = self.detailField.text;
    

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


- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *stringToDisplay = self.categoryPickerItems[row];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:stringToDisplay attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
    
}

#pragma mark - TableViewDelegate

#define nameFieldIndex 0
#define dateDueFieldIndex 1
#define dateDuePickerIndex 2
#define reminderFieldIndex 3
#define reminderPickerIndex 4
#define listFieldIndex 5
#define listPickerIndex 6
#define priorityFieldIndex 7
#define priorityPickerIndex 8
#define detailFieldIndex 9

#define fieldCellHeight 48
#define pickerCellHeight 180
#define pickerCellAndButtonHeight 220
#define segmentedCellHeight 96
#define detailCellHeight  228

-(void)populateCategoryArray{
    
    self.categoryPickerItems = @[@"To Do's", @"Shopping List", @"Assignments", @"Goals"];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = fieldCellHeight;
    
    if (indexPath.row == reminderPickerIndex){
        
        if (self.reminderDatePickerIsShowing) {
            height = pickerCellHeight;
        }else{
            height = 0;
        }
    }
    else if (indexPath.row == dateDuePickerIndex){
        
        if (self.dueDatePickerIsShowing) {
            height = pickerCellHeight;
        }else{
            height = 0;
        }
    }
    else if (indexPath.row == listPickerIndex){
        
        if (self.listPickerIsShowing) {
            height = pickerCellAndButtonHeight;
        }else{
            height = 0;
        }
    }
    else if (indexPath.row == priorityPickerIndex){
        
        if (self.priorityPickerIsShowing) {
            height = segmentedCellHeight;
        }else{
            height = 0;
            
        }
    }else if (indexPath.row == detailFieldIndex){
        if (self.detailPlaceholderIsShowing) {
            height = fieldCellHeight;
        }else{
            height = detailCellHeight;
        }
    }
    return height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == dateDueFieldIndex){
    
        if (self.dueDatePickerIsShowing){
            [self hideDueDatePicker];
            [self fillDueDateField];
          
        }else {
            [self showDueDatePickerCell];
        }
    } else if (indexPath.row == reminderFieldIndex){
        
        if (self.reminderDatePickerIsShowing){
            [self hideReminderDatePicker];
            [self fillReminderField];
        }else {
            [self showReminderDatePickerCell];
        }
        
    }else if (indexPath.row == listFieldIndex){
        
        if (self.listPickerIsShowing){
            [self hideListPicker];
            [self fillListField];
        }else {
            [self showListPicker];
        }
    }
    else if (indexPath.row == priorityFieldIndex){
    
        if (self.priorityPickerIsShowing){
            [self hidePriorityPicker];
            [self fillPriorityField];
            
        }else {
            [self showPriorityPicker];
        }
    }
    else if (indexPath.row == detailFieldIndex){
        
        if (self.detailPlaceholderIsShowing) {
            [self expandDetailCell];
        }
    }

    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - textViewDelegate






#pragma mark - helper methods

- (void)showDueDatePickerCell{
    
    [self hideListPicker];
    [self hidePriorityPicker];
    [self hideReminderDatePicker];
    [self hidePickerViews];
    [self collapseDetailCell];
    
    self.dueDatePickerIsShowing = YES;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    self.dueDatePicker.hidden = NO;
    self.dueDatePicker .alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.dueDatePicker.alpha = 1.0f;
        
    }];
}



- (void)showReminderDatePickerCell{
    
    [self hideDueDatePicker];
    [self hideListPicker];
    [self hidePriorityPicker];
    [self hidePickerViews];
    [self collapseDetailCell];

    
    self.reminderDatePickerIsShowing = YES;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    self.reminderDatePicker.hidden = NO;
    self.reminderDatePicker.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.reminderDatePicker.alpha = 1.0f;
        
    }];
}


- (void)showListPicker {
    
    [self hideDueDatePicker];
    [self hidePriorityPicker];
    [self hideReminderDatePicker];
    [self hidePickerViews];
    [self collapseDetailCell];

    self.listPickerIsShowing = YES;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    self.listPicker.hidden = NO;
    
    self.listPicker.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
                self.listPicker.alpha = 1.0f;
                self.listField.text = @"select list";
    }];
}


- (void)showPriorityPicker {
    
    [self hideDueDatePicker];
    [self hideListPicker];
    [self hideReminderDatePicker];
    [self hidePickerViews];
    [self collapseDetailCell];

    
    self.priorityPickerIsShowing = YES;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    self.prioritySegmentedControl.hidden = NO;
    
    self.prioritySegmentedControl.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.prioritySegmentedControl.alpha = 1.0f;
        self.priorityField.text = [self.prioritySegmentedControl titleForSegmentAtIndex:self.prioritySegmentedControl.selectedSegmentIndex];
    }];
}

- (void)expandDetailCell{
    
    [self hideDueDatePicker];
    [self hideListPicker];
    [self hidePriorityPicker];
    [self hideReminderDatePicker];
    [self hidePickerViews];
    
    self.detailPlaceholderIsShowing = NO;
    self.detailFieldLine.hidden = NO;
    self.detailField.hidden = NO;
    
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.detailFieldPlaceholder.hidden = YES;

    }];
}

- (void)collapseDetailCell{
    
    self.detailPlaceholderIsShowing = YES;
    self.detailFieldLine.hidden = NO;
    self.detailField.hidden = YES;
    
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.detailFieldPlaceholder.hidden = NO;
    }];
}


- (void)hideDueDatePicker{
    
    if (self.dueDatePickerIsShowing == YES) {
    
        self.dueDatePickerIsShowing= NO;
    
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    
        if (self.cancelDateDue.hidden == YES) {
        
            self.cancelDateDue.hidden = NO;
            self.cancelDateDue.alpha = 0.0f;;
        }
    
        [UIView animateWithDuration:0.25
     
                         animations:^{
                             self.dueDatePicker.alpha = 0.0f;
                             self.cancelDateDue.alpha = 1.0f;
                         }
                         completion:^(BOOL finished){
                             self.dueDatePicker.hidden = YES;
                         }
         ];
    }
}

- (void)fillDueDateField{
    
    self.dueDateField.text = [self.dateFormatter stringFromDate:[self.dueDatePicker date]];
}


- (void)hideReminderDatePicker{
    
    if (self.reminderDatePickerIsShowing == YES) {
    
        self.reminderDatePickerIsShowing= NO;
    
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    
        if (self.cancelReminder.hidden == YES) {
        
            self.cancelReminder.hidden = NO;
            self.cancelReminder.alpha = 0.0f;
        }
    
        [UIView animateWithDuration:0.25
     
                         animations:^{
                             self.reminderDatePicker.alpha = 0.0f;
                             self.cancelReminder.alpha = 1.0f;
                         }
                         completion:^(BOOL finished){
                             self.reminderDatePicker.hidden = YES;
                         }];
    }
}

- (void)fillReminderField{
    self.reminderField.text = [self.dateFormatter stringFromDate:[self.reminderDatePicker date]];
}

- (void)hideListPicker{
    
    
    if (self.listPickerIsShowing == YES) {
    
    
        self.listPickerIsShowing = NO;
    
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    
        if (self.cancelList.hidden == YES){
        
            self.cancelList.hidden = NO;
            self.cancelList.alpha = 0.0f;
        }
    
        [UIView animateWithDuration:0.25
     
                         animations:^{
                             self.listPicker.alpha = 0.0f;
                             self.cancelList.alpha = 1.0f;
                             self.cancelList.hidden = NO;

                         }
                         completion:^(BOOL finished){
                             self.listPicker.hidden = YES;
                     }];
    }
}

- (void)fillListField{
    NSInteger row = [self.listPicker selectedRowInComponent:0];
    self.listField.text = [self.categoryPickerItems objectAtIndex:row];
}


- (void)hidePriorityPicker{
    
    if (self.priorityPickerIsShowing == YES) {
    
        self.priorityPickerIsShowing = NO;
        
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        
        if (self.cancelPriority.hidden == YES) {
            
            self.cancelPriority.alpha = 0.0f;
            self.cancelPriority.hidden = NO;
        }
        
        
        [UIView animateWithDuration:0.25
         
                         animations:^{
                             self.prioritySegmentedControl.alpha = 0.0f;
                             self.cancelPriority.alpha = 1.0f;
                             self.cancelPriority.hidden = NO;
                             
                         }
                         completion:^(BOOL finished){
                             self.prioritySegmentedControl.hidden = YES;
                         }];
    }
}

- (void)fillPriorityField{
    
    NSString *stringToAppend = [self.prioritySegmentedControl titleForSegmentAtIndex:self.prioritySegmentedControl.selectedSegmentIndex];
    self.priorityField.text = [NSString stringWithFormat:@"%@ priority", stringToAppend];
}


- (IBAction)didCancelName:(id)sender {
}


- (IBAction)didCancelDueDate:(id)sender {
    
    [self hideDueDatePicker];
    
    UIColor *color = [UIColor colorWithWhite:1 alpha:0.7];
    
    self.dueDateField.text = @"";
    self.dueDateField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"due date" attributes:@{NSForegroundColorAttributeName: color }];
    
    [UIView animateWithDuration:0.25
     
                     animations:^{
                
                         self.cancelDateDue.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){
                         
                         self.cancelDateDue.alpha = 1.0;
                         self.cancelDateDue.hidden = YES;
                     }];
}


- (IBAction)didCancelReminder:(id)sender {
    
    [self hideReminderDatePicker];
    
    UIColor *color = [UIColor colorWithWhite:1 alpha:0.7];
    
    self.reminderField.text = @"";
    self.reminderField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"due date" attributes:@{NSForegroundColorAttributeName: color }];
    
    [UIView animateWithDuration:0.25
     
                     animations:^{
                         
                         self.cancelReminder.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){
                         
                         self.cancelReminder.alpha = 1.0;
                         self.cancelReminder.hidden = YES;
                     }];
}


- (IBAction)didCancelList:(id)sender {
    
    [self hideListPicker];
    
    UIColor *color = [UIColor colorWithWhite:1 alpha:0.7];
    
    self.listField.text = @"";
    self.listField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"select list " attributes:@{NSForegroundColorAttributeName: color }];
    
    [UIView animateWithDuration:0.25
     
                     animations:^{
                         
                         self.cancelList.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){
                         
                         self.cancelList.alpha = 1.0;
                         self.cancelList.hidden = YES;
                     }];
}

- (IBAction)didCancelPriority:(id)sender {
    
    [self hidePriorityPicker];
    
    UIColor *color = [UIColor colorWithWhite:1 alpha:0.7];
    
    self.priorityField.text = @"";
    self.priorityField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"due date" attributes:@{NSForegroundColorAttributeName: color }];
    
    [UIView animateWithDuration:0.25
     
                     animations:^{
                         
                         self.cancelPriority.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){
                         
                         self.cancelPriority.alpha = 1.0;
                         self.cancelPriority.hidden = YES;
                     }];
}


- (IBAction)didCancelDetails:(id)sender {
    [self collapseDetailCell];
}


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    //hides keyboard when another part of layout was touched
//    [self.view endEditing:YES];
//    [super touchesBegan:touches withEvent:event];
//}

- (IBAction)nameFieldDidChange:(id)sender {
    self.title = self.nameField.text;
}

@end




/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

