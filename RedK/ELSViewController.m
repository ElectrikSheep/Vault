//
//  ELSViewController.m
//  RedK
//
//  Created by L on 2014-08-21.
//  Copyright (c) 2014 ElectrikSheep. All rights reserved.
//

#import "ELSViewController.h"

@interface ELSViewController ()

@end

@implementation ELSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
	// Do any additional setup after loading the view, typically from a nib.

    // Check if this is the first time the App launches, we will need to create the Images folder
    // To save the selected pictures in it
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *imagesPath = [documentsPath stringByAppendingPathComponent:@"images"];
    
    if (![fileManager fileExistsAtPath:imagesPath]) {
        NSLog(@"Creating a new folder to store the images") ;
        [fileManager createDirectoryAtPath:imagesPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    else{ NSLog(@"Folder already Exist") ;}
    
    // Now we need to make sure the application is allowed to access the Gallery/Camera features
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if( status != ALAuthorizationStatusAuthorized){
        // The user will have to give persmission to the app
    }
    else {
    }

}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"TestAppLoginData" accessGroup:nil];
    self.userPW = [keychain objectForKey:(__bridge id)(kSecAttrService)];
    NSLog(@"%@", self.userPW );
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark PASSCODE

-(void) pinPadSuccessPin {
    [self.appDelegate unlockApplication] ;
}

-(NSInteger) pinLenght {
    return 4 ;
}

- (BOOL)checkPin:(NSString *)pin{
    UIAlertView *alert;
    
    NSLog(@"Checking Pin : %@", pin) ;
    if( self.userPW == nil ) {
        NSLog(@"Setting new Pin") ;
        KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"TestAppLoginData" accessGroup:nil];
        [keychain setObject:pin forKey:(__bridge id)(kSecAttrService)];
        self.userPW = pin ;
        
        alert = [[UIAlertView alloc] initWithTitle:@"" message:@"New Password Created" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] ;
        [alert show];
        return YES;
    }
    
    else {
        if ([pin isEqualToString:self.userPW ]) {
            alert = [[UIAlertView alloc] initWithTitle:@"" message:@"App Unlocked" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] ;
            [alert show];
            return YES ;
        }
        else {
            
            alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Wrong Passcode" delegate:self cancelButtonTitle:@"Damn" otherButtonTitles:nil] ;
            [alert show];
            return NO ;
        }
    }
}





#pragma mark BUTTON_ACTIONS

- (IBAction)btn_ViewGallery:(id)sender {
    [self btnActionForString:@"viewGallery"];
}

- (IBAction)btn_ImportNewMedia:(id)sender {
    [self btnActionForString:@"addMedia" ];
   }


-(void) btnActionForString:(NSString*) segueName {
    if( [self.appDelegate getLockStatus] ) {
        [self performSegueWithIdentifier:segueName sender:self];
    }
    else {
        if( self.userPW == nil )
            [self passCodeWithEdit:YES];
        else
            [self passCodeWithEdit:NO];
    }
}

-(void) passCodeWithEdit:(BOOL) edit {
    PPPinPadViewController* pinViewController = [[PPPinPadViewController alloc] init];
    pinViewController.delegate = self;
    
    // For some reason if I set this to YES everything explode, people died during testing :|
    pinViewController.isSettingPinCode = NO ;
    pinViewController.backgroundImage = [UIImage imageNamed:@"pinViewImage"] ;
    if( edit ){
        NSLog(@"Pin Creation");
        pinViewController.pinTitle = @"Create new Passcode";
        pinViewController.cancelButtonHidden = YES; //default is False
    }
    else {
        NSLog(@"Pin Checking");
        pinViewController.pinTitle = @"Enter Passcode";
        pinViewController.cancelButtonHidden = NO; //default is False
    }
    [self presentViewController:pinViewController animated:YES completion:nil];
}

@end
