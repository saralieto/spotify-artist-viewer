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
static SARequestManager *rm = nil;

+ (instancetype) sharedManager{
    
    if(!rm){
        rm = [[SARequestManager alloc] init];
    }
    
    return rm;
}

- (void) getArtistWithQuery:(NSString *) query success:(void (^)(NSArray *artists))success failure:(void(^)(NSError *error))failure{
   // NSString *q = query;
    //GET https://api.spotify.com/v1/artists/{id}
    //GET https://api.spotify.com/v1/search
    //create url based on query
    NSString *urltest = @"https://api.spotify.com/v1/search?q=";
    NSString *url = [urltest stringByAppendingString:query];
    NSString *type = @"&type=artist";
    NSString *urlWithType = [url stringByAppendingString:type];
    NSURL *requestURL = [NSURL URLWithString:urlWithType];
       
    //create request, set to GET
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
   
   
    NSMutableArray *artists = [[NSMutableArray alloc] init];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                  options:0
                                                    error:NULL];
 
        NSLog(@"JSON - %@", result);
        if([result isKindOfClass:[NSDictionary class]]){
           NSDictionary *itemArray = [[NSDictionary alloc] init];
            itemArray = [result objectForKey:@"artists"];
    
         
           
            NSDictionary *artistArray = [[NSDictionary alloc] init];
            artistArray = [itemArray objectForKey:@"items"];

            
            for(itemArray in [itemArray valueForKey:@"items"]){
                SAArtist *a = [[SAArtist alloc]init];
                
                NSDictionary *imgArray = [[NSDictionary alloc] init];
                imgArray = [itemArray objectForKey:@"images"];
                NSArray *tempimgUrl = [imgArray valueForKey:@"url"];
                
                //making sure artist has images
                
                if(tempimgUrl.count != NULL){
                
                a.imgURL = [tempimgUrl objectAtIndex:0];
                }
                
                NSLog(@"url - %@", tempimgUrl);
                NSString *name = [itemArray valueForKey:@"name"];
                                a.artistName = name;
                
                NSString *uri = [itemArray valueForKey:@"uri"];
                a.artistUri = uri;
                
                
                [artists addObject:a];
                               

            }
            
            success(artists);
            
  
        }
        
                                     
    
        
    }];
    
    [task resume];

    
    
    
    
    
    //grab info from Spotify API - artist, bio, photo
    //return as json
    //parse json, store artist information
    //into artistArray in SearchTableViewController
    
    
}
@end
