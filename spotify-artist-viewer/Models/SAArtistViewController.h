//
//  SAArtistViewController.h
//  spotify-artist-viewer
//
//  Created by Sara Lieto on 6/9/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SAArtist;

@interface SAArtistViewController : UIViewController
@property (nonatomic)NSString *artistNameVC;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UILabel *bio;

//- (instancetype)initWithArtist:(SAArtist *)artist;

@end
