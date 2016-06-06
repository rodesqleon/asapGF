//
//  LocationDetailViewController.h
//  asapGF
//
//  Created by rodrigoe on 06-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface LocationDetailViewController : UIViewController <MKMapViewDelegate,MKAnnotation,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) NSDictionary *locations;
@end
