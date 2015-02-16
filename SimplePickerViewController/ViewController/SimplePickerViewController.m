//
//  SimplePickerViewController.m
//  SimplePickerViewController
//
//  Created by Omer Aktuna on 2/5/15.
//  Copyright (c) 2015 Markafoni. All rights reserved.
//

#import "SimplePickerViewController.h"
#import "KeyboardDoneView.h"

@interface SimplePickerViewController () {
    NSArray *pickerArray;
}

@property (nonatomic, assign) BOOL pickerOpen;
@property (nonatomic, strong) UITextField *dummyField;
@property (nonatomic, strong) UIPickerView *picker_view;
@property (nonatomic, assign) float keyboardHeight;

@end

@implementation SimplePickerViewController

#pragma mark - Accessors
- (void)setPickerOpen:(BOOL)pickerOpen {
    _pickerOpen = pickerOpen;
    
    if(_pickerOpen) {
        [_dummyField becomeFirstResponder];
    }
    else {
        [self.view endEditing:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    pickerArray = [[NSArray alloc]initWithObjects:@"Item 1",@"Item 2",@"Item 3",@"Item 4",@"Item 5",@"Item 6",@"Item 7",@"Item 8",@"Item 9",@"Item 10",@"Item 11",@"Item 12",@"Item 13",@"Item 14",@"Item 15",@"Item 16",@"Item 17",@"Item 18",@"Item 19",@"Item 20", nil];
   
    [_lblPickerResult setText:@"Result in here !"];
    [_btnPicker setTitle:@"Click to Choose" forState:UIControlStateNormal];
    
    //pciker & dummy textField
    KeyboardDoneView *doneView = [[[NSBundle mainBundle] loadNibNamed:@"KeyboardDoneView" owner:self options:nil] objectAtIndex:0];
    
    [doneView.btnDone addTarget:self action:@selector(dismissPicker) forControlEvents:UIControlEventTouchUpInside];
    
    _picker_view = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    [_picker_view setDelegate:self];
    [_picker_view setDataSource:self];
    [_picker_view setBackgroundColor:[UIColor whiteColor]];
    
    _dummyField = [[UITextField alloc]initWithFrame:CGRectZero];
    _dummyField.inputView = _picker_view;
    _dummyField.inputAccessoryView = doneView;
    _dummyField.hidden = YES;
    [self.view addSubview:_dummyField];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnPickerAction:(id)sender {
    if (!_pickerOpen) {
        self.pickerOpen = YES;
    }
    else {
        [self dismissPicker];
    }
}

- (void)dismissPicker {
    if (_pickerOpen) {
        self.pickerOpen = NO;
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSValue *val = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardBounds = [val CGRectValue];
    
    self.keyboardHeight = CGRectGetHeight(keyboardBounds);
}

#pragma mark - PickerDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [pickerArray count];
}

#pragma mark - PickerDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [pickerArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_lblPickerResult setText:(NSString *)([pickerArray objectAtIndex:row])];
}



@end
