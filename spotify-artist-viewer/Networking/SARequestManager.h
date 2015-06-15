//
//  SARequestManager.h
//  spotify-artist-viewer
//
//  Created by Sara Lieto on 6/9/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SARequestManager : NSObject
+ (instancetype) sharedManager;

- (void) getArtistWithQuery:(NSString *) query success:(void (^)(NSArray *artists))success failure:(void(^)(NSError *error))failure;
//- (NSString *)getBio:(NSString *) uri;
-(void)getBio:(NSString *) uri success:(void (^)(NSArray *bios))success failure:(void(^)(NSError *error))failure;
@end
