//
//  SignUpViewController.m
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/4/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignUpTableViewCell.h"

typedef NS_ENUM(NSInteger, kCellType) {
    kCellTypeName,
    kCellTypePhone,
    kCellTypeCity,
    kCellTypeUsername,
    kCellTypePassword,
    kCellTypeEmail
};

@interface SignUpViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray * arrTitles;

@property (nonatomic, strong) NSMutableArray * arrValues;

@property (nonatomic, strong) NSMutableArray * arrCities;

@property (weak, nonatomic) IBOutlet UITableView *tblviewSignUp;

@property (strong, nonatomic) NSString *strCityID;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arrTitles = @[@"Name",@"Phone Number",@"City",@"Username",@"Password",@"Email"];
    
    _arrValues = [NSMutableArray array];
    
    for (int i = 0; i<_arrTitles.count; i++) {
        [_arrValues addObject:@""];
    }
    
    [self setupNavigationBar];
    self.navBar.lblTitle.text = @"Sign Up";
    self.navBar.btnCart.hidden = self.navBar.btnSearch.hidden = YES;
    
    
    [DBManager getDBValuesOfType:kEntityTypeCity andPerdicate:nil andWithCompletion:^(NSArray *items) {
        _arrCities = items.mutableCopy;
    }];
    
}

// MARK:- UITableView Datasource and Delegates -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SignUpTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SignUpTableViewCell class]) forIndexPath:indexPath];
    
    cell.lblTitle.text = _arrTitles[indexPath.row];
    cell.txtValue.text = _arrValues[indexPath.row];
    cell.txtValue.delegate = self;
    [cell.txtValue addTarget:self action:@selector(editingChangedOftextField:) forControlEvents:UIControlEventEditingChanged];
    cell.txtValue.tag = indexPath.row;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case kCellTypePassword:
        {
            [cell.txtValue setSecureTextEntry:YES];
        }
            break;
        case kCellTypeEmail:
        {
            [cell.txtValue setKeyboardType:UIKeyboardTypeEmailAddress];
        }
            break;
        case kCellTypePhone:
        {
            [cell.txtValue setKeyboardType:UIKeyboardTypeNumberPad];
        }
            break;
        case kCellTypeName:
        {
            [cell.txtValue setAutocapitalizationType:UITextAutocapitalizationTypeWords];
        }
            break;
        case kCellTypeCity:
        {
            UIPickerView * picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
            picker.dataSource = self;
            picker.delegate = self;
            cell.txtValue.inputView = picker;
            picker.tag = indexPath.row;
            
        }
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

// MARK:- UITextField Delegates and Fucntions -
- (void)editingChangedOftextField:(UITextField *) textField{
    
    [_arrValues replaceObjectAtIndex:textField.tag withObject:textField.text];
}

// MARK:- UIPickerview Datasource -
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _arrCities.count;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    City * city = _arrCities[row];
    return city.cityName;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    City * city = _arrCities[row];
    [_arrValues replaceObjectAtIndex:pickerView.tag withObject:city.cityName];
    _strCityID = city.cityid.stringValue;
    [_tblviewSignUp reloadData];
}
// MARK:- Buttons' Action -
- (IBAction)actionButtons:(id)sender {
    
    //Do a signUp Here and then redirect
    //only the userlogin will be done from here
    //retailer login will be done from the app delegate autometically
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Error!"
                                  message:@""
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    
    //i know the bottom if else is quite a bit messy
    //i do not like it either but
    //not have much time to complete all this
    //perfectly
    
    if ([[_arrValues objectAtIndex:kCellTypeName] isEqualToString:@""]) {
        alert.message = @"Please enter your name";
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }else{
        [dic setValue:[_arrValues objectAtIndex:kCellTypeName] forKey:@"name"];
    }
    
    if ([_strCityID isEqualToString:@""] || _strCityID==nil) {
        alert.message = @"Please enter your city";
    }else{
        [dic setValue:_strCityID forKey:@"cityid"];
    }
    
    if ([[_arrValues objectAtIndex:kCellTypeEmail] isEqualToString:@""]) {
        alert.message = @"Please enter your Email Id";
    }else{
        [dic setValue:[_arrValues objectAtIndex:kCellTypeEmail] forKey:@"email"];
    }
    
    if ([[_arrValues objectAtIndex:kCellTypePhone] isEqualToString:@""]) {
        alert.message = @"Please enter your phone number";
    }else{
        [dic setValue:[_arrValues objectAtIndex:kCellTypePhone] forKey:@"phoneNumber"];
    }
    
    if ([[_arrValues objectAtIndex:kCellTypePassword] isEqualToString:@""]) {
        alert.message = @"Please enter your password";
    }else{
        [dic setValue:[_arrValues objectAtIndex:kCellTypePassword] forKey:@"password"];
    }
    
    if ([[_arrValues objectAtIndex:kCellTypeUsername] isEqualToString:@""]) {
        alert.message = @"Please enter your Username";
    }else{
        [dic setValue:[_arrValues objectAtIndex:kCellTypeUsername] forKey:@"username"];
    }
    
    if (![alert.message isEqualToString:@""]) {
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    [DBManager insertData:dic intoEntityType:kEntityTypeUser];
    
    _constHeightBottomView.constant = [self heightOfView:self.view]-[self heightOfView:self.navBar];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        _viewBottom.backgroundColor = self.navBar.backgroundColor;
        [self.view layoutIfNeeded];
    
    } completion:^(BOOL finished) {
        [self gotoViewControllerOfName:@"MainViewController"];
    }];
    
}

@end
