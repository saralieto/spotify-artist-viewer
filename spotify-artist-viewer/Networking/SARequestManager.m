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
                
                NSString *regQuery = @"http://developer.echonest.com/api/v4/artist/biographies?api_key=FILDTEOIK2HBORODV&id=";
                
                
                
                [artists addObject:a];
                
                
            }
            
            
            //econest query http://developer.echonest.com/api/v4/artist/biographies?api_key=FILDTEOIK2HBORODV&id=spotify:artist:4Z8W4fKeB5YxbusRsdQVPb
            
            
            success(artists);
            
            
        }
        
        
        
        
    }];
    
    [task resume];
    
    
    
}

-(void)getBio:(NSString *) uri success:(void (^)(NSString *bio))success failure:(void(^)(NSError *error))failure{
    // NSString *urlPrefix = @"http://developer.echonest.com/api/v4/artist/biographies?api_key=";
    NSString *url =@"http://developer.echonest.com/api/v4/artist/biographies?api_key=D4YA0K8VK2VQIUVGC&id=ARH6W4X1187B99274F&format=json&results=1&start=0&license=cc-by-sa";
    
    
    NSString *myapikey =@"D4YA0K8VK2VQIUVGC=";
    // NSString *urlwithapi = [urlPrefix stringByAppendingString:myapikey];
    //NSString *urlwithuri = [urlwithapi stringByAppendingString:uri];
    // NSString *urltest = [urltest stringByAppendingString:url];
    
    NSURL *requestURL = [NSURL URLWithString:url];
    NSString *bio;
    // NSLog(@"echonesturl - %@", urlwithuri);
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    //[urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0 error:NULL];
        
        // NSString *incBio = data;
        //[bio isEqualToString:json];
        NSLog(@"JSON - %@", json);
        
        
        
    }];
    
    success(bio);
    
    
    [task resume];
    
    
}





@end
