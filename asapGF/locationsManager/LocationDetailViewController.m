//
//  LocationDetailViewController.m
//  asapGF
//
//  Created by rodrigoe on 06-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "MapViewAnnotation.h"
#import "LocationDetailViewController.h"

@interface LocationDetailViewController ()

@end

@implementation LocationDetailViewController

#define METERS_PER_MILE 1609.344

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"locationsDetailView_style_1" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.mapView addAnnotations:[self createAnnotations]];
    
    [self zoomToLocation];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)createAnnotations
{
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    
        NSString *title = self.locations[@"NAME"];
        
        //Create coordinates from the latitude and longitude values
        CLLocationCoordinate2D coord;
        coord.latitude = [self.locations[@"LATITUDE"] doubleValue];
        coord.longitude = [self.locations[@"LONGITUDE"] doubleValue];
        
        MapViewAnnotation *annotation = [[MapViewAnnotation alloc] initWithTitle:title AndCoordinate:coord];
        [annotations addObject:annotation];
    return annotations;
}

- (void)zoomToLocation
{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [self.locations[@"LATITUDE"] doubleValue];
    zoomLocation.longitude= [self.locations[@"LONGITUDE"] doubleValue];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE,0.5*METERS_PER_MILE);
    [self.mapView setRegion:viewRegion animated:YES];
    
    [self.mapView regionThatFits:viewRegion];
}


@end
