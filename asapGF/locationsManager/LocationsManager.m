//
//  LocationsManager.m
//  asapGF
//
//  Created by rodrigoe on 06-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "AppUser.h"
#import "AppDelegate.h"
#import "LocationsManager.h"
#import "LocationsModel.h"
#import "LocationsTableViewController.h"
#import "LocationDetailViewController.h"

#pragma ws name
static NSString*  const kLocationsGetLocationsList = @"wsLocations";

@interface LocationsManager()
@property (nonatomic) LocationsTableViewController *locationsTableView;
@property (nonatomic) LocationDetailViewController *locationsDetailView;
@property (nonatomic) UINavigationController *nc;
@property (nonatomic) NSString *context;
@property (nonatomic) NSDictionary *news;


@end

@implementation LocationsManager

+(NSString*) changeVCRequestedEvent {
    return @"CHANGE_VIEWCONTROLLER_REQUESTED_EVENT";
}

+(instancetype)getInstance
{
    // 1 Declare a static variable to hold the instance of your class, ensuring it’s available globally inside your class.
    static LocationsManager *_getInstance = nil;
    
    // 2 Declare the static variable dispatch_once_t which ensures that the initialization code executes only once.
    static dispatch_once_t oncePredicate;
    
    // 3 Use Grand Central Dispatch (GCD) to execute a block which initializes an instance of this class.
    dispatch_once(&oncePredicate, ^{
        _getInstance = [[LocationsManager alloc] init];
        
        //4 initializing variables
        [_getInstance initializeContext];
        
        
    });
    
    return _getInstance;
    
}

-(void)initializeContext
{
    
}

-(void) startManagerWithDict:(NSDictionary*)dict
{
    self.locationsTableView = [LocationsTableViewController new];
    [self addObservers:[LocationsTableViewController changeVCRequestedEvent] fromObject:self.locationsTableView];
    
    self.nc = (UINavigationController*)[self getRootViewController];
    
    LocationsModel *locationsModel = [LocationsModel getInstance];
    
    AppUser *appUser = [AppUser getInstance];
    
    /*if (([[locationsModel lastUpdateForKey:self.context] timeIntervalSinceNow] < -appModel.appContext.secondsToRefreshList)&&([appModel.appUser.isLogged isEqualToString:@"YES"])){
        [self refreshNewsList:NO];
    }*/
    
    [self refreshNewsList:NO];

}

-(void)addObservers: (NSString*) eventName fromObject:(NSObject*)object
{
    
    //remove previous listeners
    [[NSNotificationCenter defaultCenter] removeObserver:self name:eventName object:object];
    
    // Start listening events from manager
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeVCRequestedEventHandler:)
                                                 name:eventName
                                               object:object];
}


-(void) changeVCRequestedEventHandler: (NSNotification *) notif
{
    if ([[notif.userInfo valueForKey:@"target"] isEqualToString:@"LocationDetailViewController"]){
        self.locationsDetailView.locations = [notif.userInfo valueForKey:@"data"];
        [[self nc] pushViewController:self.locationsDetailView animated:YES];

    }
}


-(UIViewController*)getRootViewController {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return delegate.window.rootViewController;
}

-(void) refreshNewsList:(BOOL) forced{
    
    
    
}





@end
