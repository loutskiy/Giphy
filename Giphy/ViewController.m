//
//  ViewController.m
//  Giphy
//
//  Created by Mikhail Lutskiy on 23.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import <GiphyCoreSDK/GiphyCoreSDK-Swift.h>
#import "PhotoVC.h"
@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusAuthorized) {
        // Access has been granted.
        [self openPhotoPickerController];
        NSLog(@"Access has been granted.");
    }
    
    else if (status == PHAuthorizationStatusDenied) {
        // Access has been denied.
        NSLog(@"Access has been denied.");
    }
    
    else if (status == PHAuthorizationStatusNotDetermined) {
        NSLog(@"Access has not been determined.");
        // Access has not been determined.
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized) {
                // Access has been granted.
                [self openPhotoPickerController];
                NSLog(@"Access has been granted.");
            }
            
            else {
                // Access has been denied.
                NSLog(@"Access has been denied.");
            }
        }];
    }
    
    else if (status == PHAuthorizationStatusRestricted) {
        // Restricted access - normally won't happen.
        NSLog(@"Restricted access - normally won't happen.");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) openPhotoPickerController {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//
//}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage* originalImage = nil;
    originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if(originalImage==nil)
    {
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if(originalImage==nil)
    {
        originalImage = [info objectForKey:UIImagePickerControllerCropRect];
    }
    PhotoVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoVC"];
    vc.image = originalImage;
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:controller animated:true completion:nil];
}

@end
