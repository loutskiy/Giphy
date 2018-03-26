//
//  PhotoVC.m
//  Giphy
//
//  Created by Mikhail Lutskiy on 23.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

#import "PhotoVC.h"
#import <GiphyCoreSDK/GiphyCoreSDK-Swift.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "GifsVC.h"
#import <FLAnimatedImage/FLAnimatedImage.h>
#import "ImageClass.h"
#import "HJImagesToVideo.h"
#import "VideoCreate.h"
#import "GifDuration.h"

@interface PhotoVC () <GifsVCDelegate> {
    FLAnimatedImageView *im;
    GPHMedia *media;
    NSURL *imageURL;
}

@end

@implementation PhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.image;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectGifAction:(id)sender {
    GifsVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GifsVC"];
    vc.delegate = self;
    [self presentViewController:vc animated:true completion:nil];
}

- (IBAction)saveAction:(id)sender {
    NSLog(@"duration %f", [GifDuration getGifDuration:imageURL] * 24);
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"Documents/movie.mp4"]];
    NSMutableArray *imageArray = [NSMutableArray new];
    for (int i = 0; i < ([GifDuration getGifDuration:imageURL] * 24); i++) {
        [imageArray addObject:self.imageView.image];
    }

    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];




    [HJImagesToVideo saveVideoToPhotosWithImages:imageArray
                                        withSize:self.imageView.frame.size
                              animateTransitions:YES
                               withCallbackBlock:^(BOOL success) {
                                   if (success) {
                                       NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:
                                                             [NSString stringWithFormat:@"temp.mp4"]];
                                       AVAsset *asset = [AVAsset assetWithURL:[NSURL fileURLWithPath:tempPath]];
                                       [[[VideoCreate alloc] init] mixVideoAsset:asset andGifUrl:imageURL];
                                       NSLog(@"Success");
                                   } else {
                                       NSLog(@"Failed");
                                   }
                               }];
}

- (void)didFinishWithSelectedImage:(GPHMedia *)image {
    [im removeFromSuperview];
    media = image;
    im = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, (self.imageView.frame.size.height-[ImageClass imageSizeAfterAspectFit:self.imageView].height) / 2, 100, 100)];
    
    NSLog(@"%f", (self.imageView.frame.size.height-[ImageClass imageSizeAfterAspectFit:self.imageView].height) / 2);
    im.contentMode = UIViewContentModeScaleAspectFit;
    [im sd_setImageWithURL:[NSURL URLWithString:image.images.original.gifUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable url) {
        NSLog(@"image %@", image);
        imageURL = url;
    }];
    [self.view addSubview:im];
}

@end
