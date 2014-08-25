//
//  UICollectionViewCell+ELSPhotoPreviewCell.m
//  RedK
//
//  Created by L on 2014-08-21.
//  Copyright (c) 2014 ElectrikSheep. All rights reserved.
//

#import "ELSPhotoPreviewCell.h"

@interface ELSPhotoPreviewCell()

@property(nonatomic, weak) IBOutlet UIImageView *photoImageView;

@end



@implementation ELSPhotoPreviewCell

// Set the picture preview from ALAsset import
- (void) setAsset:(ALAsset *)asset
{
    _asset = asset;
    self.photoImageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
}

-(void) setImage:(UIImage*)image{
    self.photoImageView.image = image ;
}

// Toggle the visual aspect of the preview
-(void) setCellToSelected:(BOOL) selected {
    if( selected)
        [self.photoImageView setAlpha:.5];
    else
        [self.photoImageView setAlpha:1];
}

@end

