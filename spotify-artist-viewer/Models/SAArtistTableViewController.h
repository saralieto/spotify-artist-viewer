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
//<UISearchBarDelegate, UISearchDisplayDelegate>
@property (strong, nonatomic) NSMutableArray *artistArray;
@property (strong,nonatomic) NSMutableArray *searchResults;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) int rowNum;
//@property (nonatomic) SARequestManager *manager;
//@property (strong, nonatomic) SARequestManager *magager;

@end
