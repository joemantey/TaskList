//
//  JSMTaskTableViewCell.h
//  List
//
//  Created by Joseph Smalls-Mantey on 5/5/15.
//  Copyright (c) 2015 Joseph Smalls-Mantey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSMTaskTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *priorityLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *detailLabel;

@end
