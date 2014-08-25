//
//  UICollectionViewCell+ELSPhotoPreviewCell.h
//  RedK
//
//  Created by L on 2014-08-21.
//  Copyright (c) 2014 ElectrikSheep. All rights reserved.
//


#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>


@interface ELSPhotoPreviewCell : UICollectionViewCell
@property(nonatomic, strong) ALAsset *asset;

-(void) setCellToSelected:(BOOL) selected ;
-(void) setImage:(UIImage*)image;
@end
