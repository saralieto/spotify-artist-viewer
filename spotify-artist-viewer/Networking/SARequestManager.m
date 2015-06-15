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
            
                NSString *name = [itemArray valueForKey:@"name"];
                a.artistName = name;
                
                NSString *uri = [itemArray valueForKey:@"uri"];
                a.artistUri = uri;
                
                
                [artists addObject:a];
                
                
            }
            
            
            //econest query http://developer.echonest.com/api/v4/artist/biographies?api_key=FILDTEOIK2HBORODV&id=spotify:artist:4Z8W4fKeB5YxbusRsdQVPb
            
            
            success(artists);
            
            
        }
        
        
        
        
    }];
    
    [task resume];
    
    
    
}

-(void)getBio:(NSString *) uri success:(void (^)(NSArray *bios))success failure:(void(^)(NSError *error))failure{
     NSString *urlPrefix = @"http://developer.echonest.com/api/v4/artist/biographies?api_key=";

    NSString *myapikey =@"D4YA0K8VK2VQIUVGC&id=";
    NSString *jsonFormat = @"&format=json";
    
    NSString *urlwithapi = [urlPrefix stringByAppendingString:myapikey];
    NSString *urlwithuri = [urlwithapi stringByAppendingString:uri];
    
    
    NSURL *requestURL = [NSURL URLWithString:urlwithuri];
    NSMutableArray *bios = [NSMutableArray new];
    NSLog(@"echonesturl - %@", urlwithuri);
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestURL];
   
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSMutableString *bioTextArray;
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
        NSLog(@"JSON - %@", json);
        
        if([json isKindOfClass:[NSDictionary class]]){
        
            NSDictionary *bioArray = [[NSDictionary alloc] init];
            bioArray = [json objectForKey:@"response"];
            
            NSDictionary *biosArray = [[NSDictionary alloc] init];
            biosArray = [[bioArray objectForKey:@"biographies"] objectAtIndex:0];
            
            NSMutableString *bioTextArray;
            bioTextArray = [biosArray objectForKey:@"text"];
            
            
            NSLog(@"bioArray- %@", bioTextArray);
            [bios addObject:bioTextArray];
      
         
        }
        success(bios);
        
        
    }];
  
    [task resume];
    
   }






@end
