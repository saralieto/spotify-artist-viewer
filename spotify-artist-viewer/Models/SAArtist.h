//
//  SAArtist.h
//  spotify-artist-viewer
//
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAArtist : NSObject

//artist name, photo, bio, spotify ID number

@property (nonatomic)NSString *artistName;
@property (nonatomic)NSString *artistUri;
@property(nonatomic)NSString *imgURL;



+ (id)artistInformation:(NSString*)artistName artistID:(NSString*)ID;



@end
