//
//  SAArtist.m
//  spotify-artist-viewer
//
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import "SAArtist.h"

@implementation SAArtist

- (instancetype) initWith:(NSString*)artistName artistUri:(NSString*)ID  artistImgURL:(NSString *)imgurl{
    self = [super init];
    if(self){
        self.artistUri = ID;
        self.artistName = artistName;
        self.imgURL = imgurl;
    }
    return self;
}


@end
