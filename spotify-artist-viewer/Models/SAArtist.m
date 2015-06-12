//
//  SAArtist.m
//  spotify-artist-viewer
//
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import "SAArtist.h"

@implementation SAArtist

@synthesize artistUri;
@synthesize artistName;
@synthesize imgURL;
@synthesize bio;


+ (id)artistInformation:(NSString*)artistName artistID:(NSString*)ID {
    SAArtist *artistInput  = [[self alloc]init];
    artistInput.artistUri = ID;
    artistInput.artistName = artistName;
    

    return artistInput;
}


@end
