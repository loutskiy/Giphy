//
//  GifsVC.h
//  Giphy
//
//  Created by Mikhail Lutskiy on 23.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GiphyCoreSDK/GiphyCoreSDK-Swift.h>

@protocol GifsVCDelegate

- (void) didFinishWithSelectedImage:(GPHMedia *) image;

@end

@interface GifsVC : UICollectionViewController

@property (assign, nonatomic) id <GifsVCDelegate> delegate;

@end
