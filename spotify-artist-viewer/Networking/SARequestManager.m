//
//  SARequestManager.m
//  spotify-artist-viewer
//
//  Created by Sara Lieto on 6/9/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import "SARequestManager.h"
#import "SAArtist.h"

@implementation SARequestManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static SARequestManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [SARequestManager new];
    });
    return sharedManager;
}

- (void) getArtistWithQuery:(NSString *) query success:(void (^)(NSArray *artists))success failure:(void(^)(NSError *error))failure{
    //Construction of URL with current Search Bar Text (query)
    NSString *urltest = @"https://api.spotify.com/v1/search?q=";
    NSString *url = [urltest stringByAppendingString:query];
    NSString *type = @"&type=artist";
    NSString *urlWithType = [url stringByAppendingString:type];
    NSURL *requestURL = [NSURL URLWithString:urlWithType];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSMutableArray *artists = [[NSMutableArray alloc] init];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                               options:0
                                                                 error:NULL];

        if([result isKindOfClass:[NSDictionary class]]){
            NSDictionary *itemDictionary = [result objectForKey:@"artists"];
            for(NSDictionary *item in [itemDictionary valueForKey:@"items"]){
                SAArtist *artist = [[SAArtist alloc]init];
                
                NSDictionary *imgArray = [item objectForKey:@"images"];
                artist.artistName = [item valueForKey:@"name"];
                artist.artistUri = [item valueForKey:@"uri"];
                NSArray *tempImgUrl = [imgArray valueForKey:@"url"];
                if(tempImgUrl.count != 0){
                    artist.imgURL = [tempImgUrl objectAtIndex:0];
                }
                [artists addObject:artist];

            }
            if(success){
            success(artists);
            } else{
                failure(nil);
            }
        }
        
    }];
    
    [task resume];

    
}

-(void)getBio:(NSString *) uri success:(void (^)(NSArray *bios))success failure:(void(^)(NSError *error))failure{
    NSString *urlPrefix = @"http://developer.echonest.com/api/v4/artist/biographies?api_key=";
    NSString *myapikey =@"D4YA0K8VK2VQIUVGC&id=";
    NSString *urlwithapi = [urlPrefix stringByAppendingString:myapikey];
    NSString *urlwithuri = [urlwithapi stringByAppendingString:uri];
    NSURL *requestURL = [NSURL URLWithString:urlwithuri];
    NSMutableArray *bios = [NSMutableArray new];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
        if([json isKindOfClass:[NSDictionary class]]){
        
            NSDictionary *responseDictionary= [json objectForKey:@"response"];
            NSDictionary *biosDictionary = [[responseDictionary objectForKey:@"biographies"] objectAtIndex:0];
            if(biosDictionary.count != 0){
            NSMutableString *bioText = [biosDictionary objectForKey:@"text"];
            [bios addObject:bioText];
            }
        }
        
        if(bios.count !=0){
        success(bios);
        }else{
            failure(nil);
        }
        
        
    }];
  
    [task resume];
    
   }






@end
