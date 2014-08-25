//
//  ELSPinCodeUpdaterViewController.h
//  RedK
//
//  Created by L on 2014-08-25.
//  Copyright (c) 2014 ElectrikSheep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"

@interface ELSPinCodeUpdaterViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *oldPassword;
@property (strong, nonatomic) IBOutlet UITextField *updatedPassword;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;

- (IBAction)action_ConfirmBtn:(id)sender;

@end
