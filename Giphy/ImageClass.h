//
//  ImageClass.h
//  Giphy
//
//  Created by Mikhail Lutskiy on 26.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageClass : NSObject

+ (CGSize)imageSizeAfterAspectFit:(UIImageView*)imgview;

@end
