//
//  VideoCreate.h
//  Giphy
//
//  Created by Mikhail Lutskiy on 26.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface VideoCreate : NSObject

- (void)mixVideoAsset:(AVAsset *)videoAsset andGifUrl:(NSURL *)gifUrl;

@end
