//
//  ELSPinCodeUpdaterViewController.m
//  RedK
//
//  Created by L on 2014-08-25.
//  Copyright (c) 2014 ElectrikSheep. All rights reserved.
//

#import "ELSPinCodeUpdaterViewController.h"

@interface ELSPinCodeUpdaterViewController ()

@end

@implementation ELSPinCodeUpdaterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)action_ConfirmBtn:(id)sender {
    if( _oldPassword.text.length != 4 ||
       _updatedPassword.text.length != 4 ||
       _confirmPassword.text.length != 4 ) {
        
        [self showAlertWithText:@"Length of password must be 4 numbers" andButton:@"Oh, Ok Sorry"];
        return ;
    }
    
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"TestAppLoginData" accessGroup:nil];

    if( [_oldPassword.text isEqualToString:
       [keychain objectForKey:(__bridge id)(kSecAttrService)]] ) {
        if ( [_confirmPassword.text isEqualToString:_updatedPassword.text]){
            
            [keychain setObject:_updatedPassword.text forKey:(__bridge id)(kSecAttrService)];
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self showAlertWithText:@"Password Updated" andButton:@"Cool"];
        
        }
        else {
            [self showAlertWithText:@"New Password mismatch" andButton:@"RAAAAH"];
        }
    }
    else {
        [self showAlertWithText:@"Wrong Password" andButton:@"Damn"] ;
        return ;
    }
    
    
}

-(void) showAlertWithText:(NSString*) message andButton:(NSString*)btnText {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"" message:message delegate:self cancelButtonTitle:btnText otherButtonTitles:nil , nil];
    [alert show ];
}

#pragma mark KEYBOARD
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// It is important for you to hide kwyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
