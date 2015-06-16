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


-(instancetype)initWith:(NSString*)artistName artistUri:(NSString*)ID  artistImgURL:(NSString *)imgurl{
    self = [super init];
    if(self){
        self.artistUri = artistUri;
        self.artistName = artistName;
        self.imgURL = imgurl;
    }

    return self;
}


@end
