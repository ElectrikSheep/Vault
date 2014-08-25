//
//  ELSAppDelegate.h
//  RedK
//
//  Created by L on 2014-08-21.
//  Copyright (c) 2014 ElectrikSheep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void) unlockApplication ;
-(BOOL) getLockStatus ;

@end
