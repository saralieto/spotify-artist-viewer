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
//@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end

@implementation SAArtistTableViewController
//connecting this view controller with the Artist object (importing SAArtist, too)
@synthesize artistArray;
@synthesize searchResults;
@synthesize rowNum;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchBar setDelegate:self];
    //[self.tableView reloadData];
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text Change

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    SARequestManager *manager = [SARequestManager sharedManager];
    
    [manager getArtistWithQuery:searchText success:^(NSArray *artists)  {
       self.artistArray = artists;
        [self.tableView reloadData];
     } failure:^(NSError *error) {
         NSLog(@"block failure");
    }];
    
    
    
}

#pragma mark - Button cell pressing

//- (IBAction)buttonPressed:(id)sender
//{
//
//    [self performSegueWithIdentifier:@"NextScreen" sender:sender];
//}

//-(IBAction)did

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    rowNum = row;
    NSLog(@"RowNum - %d", rowNum);
    [self performSegueWithIdentifier:@"NextScreen" sender:nil];
 
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier ] isEqualToString:@"NextScreen"]){
        UITableViewCell *selectedCell = (UITableViewCell *)sender;
        
        SAArtistViewController *svc = [segue destinationViewController];
        SAArtist *artistToBePassed = [[SAArtist alloc]init];
        
        artistToBePassed = [self.artistArray objectAtIndex:rowNum];
        NSLog(@"ArtistName - %@", artistToBePassed.artistName);

        [svc setArtistNameVC:artistToBePassed.artistName];
        
        
    }
        //get SAArtist
        // SAArtist *artistToPass;
        // [stvc
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.artistArray count];
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
    
    SAArtist *newArtist = [self.artistArray objectAtIndex:indexPath.row];
    cell.textLabel.text = newArtist.artistName;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

@end
