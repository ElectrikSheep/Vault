//
//  UIViewController+ELSGalleryDisplayViewController.m
//  RedK
//
//  Created by L on 2014-08-21.
//  Copyright (c) 2014 ElectrikSheep. All rights reserved.
//

#import "ELSGalleryDisplayViewController.h"

@interface ELSGalleryDisplayViewController ()

@property (strong, nonatomic) NSArray* savedImages ;
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation ELSGalleryDisplayViewController

NSInteger selectedIndex = -1 ;

- (void)viewDidLoad
{
    
    // Get file in Images folder
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *imagesPath = [documentsPath stringByAppendingPathComponent:@"images"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *bundleURL = [NSURL URLWithString:imagesPath];
    NSArray *contents = [fileManager contentsOfDirectoryAtURL:bundleURL
                                   includingPropertiesForKeys:@[]
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        error:nil];
    
    // Look for PNG files in the folder
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension == 'png'"];
    
    // Array to save the pictures
    _savedImages = [@[] mutableCopy];
    __block NSMutableArray *tmpAssets = [@[] mutableCopy];
    
    
    // For each file in the Folder import the PNG data and creat a UIImage
    for (NSURL *fileURL in [contents filteredArrayUsingPredicate:predicate]) {
        // Enumerate each .png file in directory
        NSData *pngData = [NSData dataWithContentsOfFile:fileURL.path];
        UIImage *image = [UIImage imageWithData:pngData];
        
        // Fail safe
        if( image != nil )
            [tmpAssets addObject:image];
    }
    _savedImages = tmpAssets ;
    
    [super viewDidLoad];
    
    // Reload the collection Data
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}











#pragma mark COLLECTION_VIEW


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"displayPicture" sender:self];
    
}
-(void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSInteger index =indexPath.row;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.savedImages.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ELSPhotoPreviewCell *cell = (ELSPhotoPreviewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ELSPhotoPreviewCell" forIndexPath:indexPath];
    
    UIImage *image = self.savedImages[indexPath.row];
    [cell setImage:image];
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


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Should never happen but let us be safe
    
    NSLog(@"Preparing for the Segue") ;
    if(selectedIndex == -1 ) return ;
    
    // Get next ViewController
    ELSDisplayView* nextViewController = segue.destinationViewController ;
    [nextViewController prepareViewWith:self.savedImages andInitialIndex:selectedIndex ];
}

@end
