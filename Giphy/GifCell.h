//
//  GifCell.h
//  Giphy
//
//  Created by Mikhail Lutskiy on 23.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/FLAnimatedImageView+WebCache.h>

@interface GifCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imgView;

@end
