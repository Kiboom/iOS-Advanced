//
//  CollectionViewCell.h
//  Week 10-2 (GCD)
//
//  Created by 김기범 on 2016. 8. 17..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
