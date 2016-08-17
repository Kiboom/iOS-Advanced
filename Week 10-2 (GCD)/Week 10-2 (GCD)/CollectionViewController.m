//
//  CollectionViewController.m
//  Week 10-2 (GCD)
//
//  Created by 김기범 on 2016. 8. 17..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"

@interface CollectionViewController ()
@property NSArray *jsonData;
@property BOOL isJsonDataDownloaded;
@property CFTimeInterval startTime;
@property NSInteger drawnCellCount;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static CGFloat const cellSpacing = 3;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.drawnCellCount = 0;
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    NSString *URLString = @"http://125.209.194.123/doodle.php";
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:URL
                                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                     self.jsonData = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                     options:0
                                                                                                                       error:nil];
                                                                     self.isJsonDataDownloaded = YES;
                                                                     self.startTime = CACurrentMediaTime();
                                                                     [self.collectionView reloadData];
                                                                 }];
    [dataTask resume];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return cellSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return cellSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(128, 50);
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 103;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row+1];
    cell.layer.borderColor = [[UIColor blackColor] CGColor];
    
    // wait until jsonData fully downloaded
    if(self.isJsonDataDownloaded == NO) {
        return cell;
    }
    
    dispatch_queue_t downloadQueue =
//    dispatch_queue_create("com.downloadQueue.operation", NULL);
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//            dispatch_get_main_queue();
    dispatch_async(downloadQueue, ^{
        NSURL *imageURL = [NSURL URLWithString:self.jsonData[indexPath.row][@"image"]];
//        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//        UIImage *image = [UIImage imageWithData:imageData];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            cell.imageView.image = image;
//            self.drawnCellCount ++;
//            if(self.drawnCellCount == 103) {
//                NSLog(@"Finished Time : %f", CACurrentMediaTime() - self.startTime);
//            }
//        });
        NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:imageURL
                                                                         completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                             UIImage *image = [UIImage imageWithData:data];
                                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                                 cell.imageView.image = image;
                                                                                 self.drawnCellCount ++;
                                                                                 if(self.drawnCellCount == 103) {
                                                                                     NSLog(@"Finished Time : %f", CACurrentMediaTime() - self.startTime);
                                                                                 }
                                                                             });
                                                                         }];
        [downloadTask resume];
    });
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [UIView animateWithDuration:0.3 animations:^{
    //            CGRect originFrame = cell.frame;
    //            cell.frame = CGRectMake(originFrame.origin.x,
    //                                    originFrame.origin.y,
    //                                    originFrame.size.width+30,
    //                                    originFrame.size.height+30);
    //        }];
    //    });
}

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
