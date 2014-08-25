//
//  ELSLibraryImportViewController.m
//  RedK
//
//  Created by L on 2014-08-21.
//  Copyright (c) 2014 ElectrikSheep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELSLibraryImportViewController.h"

@interface ELSLibraryImportViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UINavigationBarDelegate>

@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *assets;
@property(nonatomic, strong) NSMutableArray *selectedPicture ;

@end

@implementation ELSLibraryImportViewController

int SELECTED_PICTURES = 0 ;

+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButton:)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO ;
    
    // Number of selected pictures
    SELECTED_PICTURES = 0 ;
    
    // Allow for the selection of multiple pictures
    self.collectionView.allowsMultipleSelection = YES ;
    self.collectionView.allowsSelection = YES ;
    
    self.selectedPicture = [[NSMutableArray alloc] init ];
    
    _assets = [@[] mutableCopy];
    __block NSMutableArray *tmpAssets = [@[] mutableCopy];


    // Use ALAsset to get the data from the gallery
    ALAssetsLibrary *assetsLibrary = [ELSLibraryImportViewController defaultAssetsLibrary];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if(result)
            {
                [tmpAssets addObject:result];
            }
        }];
        
        //NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
        //self.assets = [tmpAssets sortedArrayUsingDescriptors:@[sort]];
        self.assets = tmpAssets;
        
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error loading images %@", error);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark SAVING_PICTURE_TO_DISK


-(void) doneButton:(id)sender{
    
    NSData *pngData ;
    
    ALAsset *asset ;
    ALAssetRepresentation *defaultRep;
    UIImage *image ;
    
    for( NSNumber *t in self.selectedPicture ){
        
        // Get pic from list of asset
        asset = self.assets[ [t integerValue] ];
        defaultRep = [asset defaultRepresentation];
        image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];
        
        // Convert picture
        pngData = UIImagePNGRepresentation(image);
        
        // Name it uniquely
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        NSString *strTime   = [objDateformat stringFromDate:[NSDate date]];
        NSString * fileName = [NSString stringWithFormat:@"%@%@.png", @"images/",strTime] ;
        
        // Save that bad boy
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName]; //Add the file name
        [pngData writeToFile:filePath atomically:YES]; //Write the file

        NSLog(@"%@", filePath);
    }
}








#pragma mark COLLECTION_VIEW


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Get Cell and place it in Selected state
    ELSPhotoPreviewCell *cell =  (ELSPhotoPreviewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setCellToSelected:YES] ;
    
    // Increment list and save the index
    SELECTED_PICTURES ++ ;
    NSInteger index =indexPath.row;
    [self.selectedPicture addObject:[NSNumber numberWithInteger:index]] ;
    
    // Set the Navigation bar
    self.navigationItem.rightBarButtonItem.enabled = YES ;
    self.navigationItem.title = [NSString stringWithFormat:@"%d Selected", SELECTED_PICTURES];
}
-(void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Get Cell and place it in DE-selected state
    ELSPhotoPreviewCell *cell =  (ELSPhotoPreviewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setCellToSelected:NO] ;
    
    SELECTED_PICTURES -- ;
    if( SELECTED_PICTURES == 0)
        self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%d Selected", SELECTED_PICTURES];
    NSInteger index =indexPath.row;
    [self.selectedPicture removeObject:[NSNumber numberWithInteger:index]] ;
}


- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ELSPhotoPreviewCell *cell = (ELSPhotoPreviewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ELSPhotoPreviewCell" forIndexPath:indexPath];
    
    ALAsset *asset = self.assets[indexPath.row];
    cell.asset = asset;
    cell.highlighted = YES ;
    return cell;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

@end