//
//  SAArtistTableViewController.m
//  spotify-artist-viewer
//
//  Created by Sara Lieto on 6/9/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import "SAArtistTableViewController.h"
#import "SAArtist.h"
#import "SARequestManager.h"



@interface SAArtistTableViewController ()
//@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;

@end

@implementation SAArtistTableViewController
//connecting this view controller with the Artist object (importing SAArtist, too)
@synthesize artistArray;
@synthesize searchResults;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *baseURL = [NSURL URLWithString:@"/documents"];
   
    
    //initialize an array to view in table view comprise of a list of SAArtist objcts
    SAArtist *test = [[SAArtist alloc]init];
    test.artistName = @"test";
    //initialize artistArray
  
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
    //[searchBar sizeToFit];
    [searchBar setDelegate:self];
    
    [self setSearchController:[[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self]];
    
    [self.searchController setSearchResultsDataSource:self];
    [self.searchController setSearchResultsDelegate:self];
    [self.searchController setDelegate:self];
    

    
    //self.searchResults = [NSMutableArray arrayWithCapacity:[artistArray count]];
    [self.tableView setTableHeaderView:self.searchController.searchBar]; // (or just searchBar)

    
    [self.tableView reloadData];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    SARequestManager *manager = [SARequestManager sharedManager];
    
    [manager getArtistWithQuery:searchText success:^(NSArray *artists) {
       self.artistArray = artists;
     } failure:^(NSError *error) {
         NSLog(@"block failure");
    }];
    
    [self.tableView reloadData];
    
}
#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.searchResults count];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

//In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  //  [segue destinationViewController];
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    SAArtist *newArtist = nil;
    newArtist.artistName = [artistArray objectAtIndex:indexPath.row];
    cell.textLabel.text = newArtist.artistName;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

@end
