//
//  ELSDisplayView.m
//  RedK
//
//  Created by L on 2014-08-22.
//  Copyright (c) 2014 ElectrikSheep. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ELSDisplayView : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSArray* savedImages ;

-(void) prepareViewWith:(NSArray*) listOfPictures andInitialIndex:(NSInteger) index;

@end

