//
//  GifDuration.m
//  Giphy
//
//  Created by Mikhail Lutskiy on 26.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

#import "GifDuration.h"

@implementation GifDuration

+ (CGFloat) getGifDuration: (NSURL *) url {    
    NSMutableArray * frames = [NSMutableArray new];
    NSMutableArray *delayTimes = [NSMutableArray new];
    
    CGFloat totalTime = 0.0;
    CGFloat gifWidth;
    CGFloat gifHeight;
    
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    
    // get frame count
    size_t frameCount = CGImageSourceGetCount(gifSource);
    for (size_t i = 0; i < frameCount; ++i) {
        // get each frame
        CGImageRef frame = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        [frames addObject:(__bridge id)frame];
        CGImageRelease(frame);
        
        // get gif info with each frame
        NSDictionary *dict = (NSDictionary*)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(gifSource, i, NULL));
//        NSLog(@"kCGImagePropertyGIFDictionary %@", [dict valueForKey:(NSString*)kCGImagePropertyGIFDictionary]);
        
        // get gif size
        gifWidth = [[dict valueForKey:(NSString*)kCGImagePropertyPixelWidth] floatValue];
        gifHeight = [[dict valueForKey:(NSString*)kCGImagePropertyPixelHeight] floatValue];
        
        NSDictionary *gifDict = [dict valueForKey:(NSString*)kCGImagePropertyGIFDictionary];
        [delayTimes addObject:[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime]];
        
        totalTime = totalTime + [[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime] floatValue];
    }
    
    NSLog(@"total Time %f", totalTime);
    
    if (gifSource) {
        CFRelease(gifSource);
    }
    return totalTime;
}

@end
