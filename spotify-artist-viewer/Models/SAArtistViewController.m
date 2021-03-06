//
//  SAArtistViewController.m
//  spotify-artist-viewer
//
//  Created by Sara Lieto on 6/9/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import "SAArtistViewController.h"
#import "SAArtist.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SAArtistViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *artistImg;

@end

@implementation SAArtistViewController
@synthesize artistNameVC;
@synthesize header;
@synthesize bio;
@synthesize img;
@synthesize vcArtist;

- (void)viewDidLoad {
    [super viewDidLoad];
    header.text = vcArtist.artistName;
    
    NSURL *imageURL = [NSURL URLWithString:vcArtist.imgURL];
    [self.artistImg sd_setImageWithURL:imageURL];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
