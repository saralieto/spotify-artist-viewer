//
//  SAArtistViewController.m
//  spotify-artist-viewer
//
//  Created by Sara Lieto on 6/9/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import "SAArtistViewController.h"
#import "SAArtist.h"
#import "SARequestManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SAArtistViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *artistImg;
@property (weak, nonatomic) IBOutlet UIButton *backButton;



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
    self.artistImg.layer.cornerRadius = self.artistImg.frame.size.height/2;
    [self.artistImg.layer setMasksToBounds:YES];

    UIButton *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonPressed:)];
    self.navigationItem.backBarButtonItem = backButton;
 
    
 
    while(self.vcArtist.bio == nil){
        self.setBio;
        self.bio.text = self.vcArtist.bio;
    }
  // self.bio.text = @"test";
    NSLog(@"ArtistBio - %@", self.vcArtist.bio);
    

    
    

    
    
}

-(void)setBio{
SARequestManager *manager = [SARequestManager sharedManager];
    [manager getBio:self.vcArtist.artistUri success:^(NSArray *bios){
        if(bios.count != NULL){
        
        self.vcArtist.bio = [bios objectAtIndex:0];
        
           
        }
        
    } failure:^(NSError *error) {
        NSLog(@"block failure");
    }];
   // self.vcArtist.bio = [manager getBio:self.vcArtist.artistUri];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonPressed:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
