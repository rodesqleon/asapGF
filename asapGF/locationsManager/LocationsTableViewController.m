//
//  LocationsTableViewController.m
//  asapGF
//
//  Created by rodrigoe on 06-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "LocationDetailViewController.h"
#import "LocationsTableViewCell.h"
#import "LocationsTableViewController.h"

@interface LocationsTableViewController ()
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UITableView *locationsTableView;
@property (nonatomic) NSDictionary *wsResponse;

@end

@implementation LocationsTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"locationsListView_style_1" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Locations",@"settings header");
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    [self.locationsTableView registerNib:[UINib nibWithNibName:@"locationsTableViewCell_style_1" bundle:nil] forCellReuseIdentifier:@"LocationsCellIdentifier"];
    self.locationsTableView.dataSource = self;
    self.container.layer.cornerRadius = 40.0;
    self.container.layer.borderWidth = 1;
    self.container.layer.borderColor = [[UIColor lightGrayColor] CGColor];

    [self loadLocations];
}

- (void)loadLocations{
    
    //Load the json on another thread
    NSString *ws = @"http://always420.cl/wsLocations.php";
    NSURL *url = [NSURL URLWithString:ws];
    NSString *jsonResponse = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    
    NSData *jsonData = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    self.wsResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    [self didReloadData];
}

- (void)didReloadData{
    if([self.wsResponse[@"status"] isEqualToString:@"OK"]){
        self.locations = self.wsResponse[@"info"];
        NSLog(@"%@", self.locations);
        
        [self.locationsTableView reloadData];
        
    }else{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Product Manager"
                                                            message:@"Producto actualizado satisfactoriamente"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationsTableViewCell *cell = [self.locationsTableView dequeueReusableCellWithIdentifier:@"LocationsCellIdentifier" forIndexPath:indexPath];
    if(!cell){
        cell = [self.locationsTableView dequeueReusableCellWithIdentifier:@"LocationsCellIdentifier" forIndexPath:indexPath];
    }
    NSDictionary *info = [self.locations objectAtIndex:indexPath.row];
    
    cell.locationTitle.text = info[@"NAME"];
    
    
    // Configure the cell...
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationDetailViewController *locationDetail = [LocationDetailViewController new];
    NSDictionary *info = [self.locations objectAtIndex:indexPath.row];
    locationDetail.locations = info;
    [[self navigationController] pushViewController:locationDetail animated:YES];
    [self.locationsTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
