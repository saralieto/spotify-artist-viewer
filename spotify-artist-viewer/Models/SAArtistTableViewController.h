//
//  SAArtistTableViewController.h
//  spotify-artist-viewer
//
//  Created by Sara Lieto on 6/9/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SARequestManager.h"

@interface SAArtistTableViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *artists;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
