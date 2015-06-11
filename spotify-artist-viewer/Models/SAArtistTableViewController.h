//
//  SAArtistTableViewController.h
//  spotify-artist-viewer
//
//  Created by Sara Lieto on 6/9/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAArtistTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
//<UISearchBarDelegate, UISearchDisplayDelegate>
@property (strong, nonatomic) NSArray *artistArray;
@property (strong,nonatomic) NSMutableArray *searchResults;



@end
