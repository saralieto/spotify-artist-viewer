//
//  SAArtist.m
//  spotify-artist-viewer
//
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import "SAArtist.h"

@implementation SAArtist

@synthesize artistID;
@synthesize artistName;


+ (id)artistInformation:(NSString*)artistName artistID:(NSString*)ID {
    SAArtist *artistInput  = [[self alloc]init];
    artistInput.artistID = ID;
    artistInput.artistName = artistName;

    return artistInput;
}


@end
