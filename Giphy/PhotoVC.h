//
//  PhotoVC.h
//  Giphy
//
//  Created by Mikhail Lutskiy on 23.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoVC : UIViewController
@property (strong, nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)selectGifAction:(id)sender;
- (IBAction)saveAction:(id)sender;

@end
