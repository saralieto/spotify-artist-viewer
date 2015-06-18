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
#import "SAArtistViewController.h"

@interface SAArtistTableViewController ()
@property (strong, nonatomic) SARequestManager *manager;
@end

@implementation SAArtistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.artists = [NSMutableArray new];
    [self.searchBar setDelegate:self];
    self.manager = [SARequestManager sharedManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Text Change

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    [self.manager getArtistWithQuery:searchText success:^(NSArray *artists)  {
      
        self.artists = [artists mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
     } failure:^(NSError *error) {
         NSLog(@"block failure");
    }];
    
}

#pragma mark - Button cell pressing

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"NextScreen" sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier ] isEqualToString:@"NextScreen"]){
        SAArtistViewController *svc = [segue destinationViewController];
        SAArtist *artistToBePassed = [[SAArtist alloc]init];
        artistToBePassed = [self.artists objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        [svc setVcArtist:artistToBePassed];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.artists count];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

                                  
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    SAArtist *newArtist = [self.artists objectAtIndex:indexPath.row];
    cell.textLabel.text = newArtist.artistName;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

@end
