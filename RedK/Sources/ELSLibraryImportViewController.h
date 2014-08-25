//
//  ELSLibraryImportViewController.m
//  RedK
//
//  Created by L on 2014-08-21.
//  Copyright (c) 2014 ElectrikSheep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "ELSPhotoPreviewCell.h"

@interface ELSLibraryImportViewController : UIViewController

- (IBAction)doneButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *currentSelected;

@end
