//
//  ELSViewController.h
//  RedK
//
//  Created by L on 2014-08-21.
//  Copyright (c) 2014 ElectrikSheep. All rights reserved.
//

#import <UIKit/UIKit.h>

// Check app permissions
#import <AssetsLibrary/AssetsLibrary.h>

// Display Pin Code
#import "PPPinPadViewController.h"

#import "KeychainItemWrapper.h"

#import "ELSAppDelegate.h"

@interface ELSViewController : UIViewController <PinPadPasswordProtocol>

@property (strong, nonatomic) NSString * userPW ;
@property (strong, nonatomic) ELSAppDelegate *appDelegate ;

@end
