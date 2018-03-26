//
//  GifsVC.m
//  Giphy
//
//  Created by Mikhail Lutskiy on 23.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

#import "GifsVC.h"
#import "GifCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GifsVC () {
    NSArray *gifs;
}

@end

@implementation GifsVC

static NSString * const reuseIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getGifs];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    
    // Do any additional setup after loading the view.
}

- (void) getGifs {
    GPHClient *client = [[GPHClient alloc] initWithApiKey:@"xS2hk1x84XaJrbauxkCD7Saor88QFtHH"];
    [client search:@"cat" media:GPHMediaTypeGif offset:0 limit:100 rating:GPHRatingTypeRatedG lang:GPHLanguageTypeRussian pingbackUserId:nil completionHandler:^(GPHListMediaResponse * _Nullable response, NSError * _Nullable error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            gifs = response.data;
            [self.collectionView reloadData];
        }];
//        for (GPHMedia *media in response.data) {
//            NSLog(@"media %@", media.images.downsizedMedium.gifUrl);
//        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return gifs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GPHMedia *media = gifs[indexPath.row];
    GifCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:media.images.downsizedMedium.gifUrl]];
    // Configure the cell
    NSLog(@"url %@", media.images.downsizedMedium.gifUrl);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GPHMedia *media = gifs[indexPath.row];
    [self.delegate didFinishWithSelectedImage:media];
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
