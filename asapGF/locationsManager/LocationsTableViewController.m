//
//  LocationsTableViewController.m
//  asapGF
//
//  Created by rodrigoe on 06-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "LocationsModel.h"
#import "LocationDetailViewController.h"
#import "LocationsTableViewCell.h"
#import "LocationsTableViewController.h"


@interface LocationsTableViewController ()
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UITableView *locationsTableView;
@property (nonatomic) NSDictionary *wsResponse;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *activityIndicatorView;


@end

@implementation LocationsTableViewController

+(NSString*) changeVCRequestedEvent {
    return @"CHANGE_VIEWCONTROLLER_REQUESTED_EVENT";
}

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
    
    LocationsModel *locationModel = [LocationsModel getInstance];
    
    if([locationModel getLocationsList]){
    [self.activityIndicatorView stopAnimating];
    
    }else{
    [self.activityIndicatorView startAnimating];
    
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"No locations to show";
        messageLabel.textColor = [UIColor grayColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Avenir-Thin" size:20];
        [messageLabel sizeToFit];
        
        self.locationsTableView.backgroundView = messageLabel;
        self.locationsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self performSelector:@selector(loadLocations) withObject:nil afterDelay:1.0];
    }
}

- (void)loadLocations{
    LocationsModel *locationModel = [LocationsModel getInstance];
    
    if([locationModel getLocationsList]){
        
    }else{
        //Load the json on another thread
        NSString *ws = @"http://always420.cl/wsLocations.php";
        NSURL *url = [NSURL URLWithString:ws];
        NSString *jsonResponse = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        
        NSData *jsonData = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
        
        self.wsResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        [self performSelector:@selector(didReloadData) withObject:nil afterDelay:1.0];

    }
}

- (void)didReloadData{
    [self.activityIndicatorView stopAnimating];
    if([self.wsResponse[@"status"] isEqualToString:@"OK"]){
        LocationsModel *locationModel = [LocationsModel getInstance];
        
        
        self.locations = self.wsResponse[@"info"];
        
        [locationModel setLocationsList:self.locations];
        
        [locationModel persistData];
        
        
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
    LocationsModel *locationModel = [LocationsModel getInstance];
    return [[locationModel getLocationsList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationsTableViewCell *cell = [self.locationsTableView dequeueReusableCellWithIdentifier:@"LocationsCellIdentifier" forIndexPath:indexPath];
    if(!cell){
        cell = [self.locationsTableView dequeueReusableCellWithIdentifier:@"LocationsCellIdentifier" forIndexPath:indexPath];
    }
    LocationsModel *locationModel = [LocationsModel getInstance];
    NSDictionary *info = [[locationModel getLocationsList] objectAtIndex:indexPath.row];
    
    cell.locationTitle.text = [info[@"NAME"] stringByReplacingOccurrencesOfString:@"&Nacute;" withString:@"Ñ"];
    cell.locationDescription.text = info[@"DESCRIPTION"];
    
    cell.addresLbl.text = info[@"ADDRESS"];
    
    
    // Configure the cell...
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationDetailViewController *locationDetail = [LocationDetailViewController new];
    LocationsModel *locationModel = [LocationsModel getInstance];
    NSDictionary *info = [[locationModel getLocationsList] objectAtIndex:indexPath.row];
    locationDetail.locations = info;
    [[self navigationController] pushViewController:locationDetail animated:YES];
    [self.locationsTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
