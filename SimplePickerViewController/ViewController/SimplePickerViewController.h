//
//  SimplePickerViewController.h
//  SimplePickerViewController
//
//  Created by Omer Aktuna on 2/5/15.
//  Copyright (c) 2015 Markafoni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimplePickerViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *btnPicker;
@property (weak, nonatomic) IBOutlet UILabel *lblPickerResult;


- (IBAction)btnPickerAction:(id)sender;

@end
