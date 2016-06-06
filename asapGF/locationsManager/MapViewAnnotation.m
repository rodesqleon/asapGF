//
//  MapViewAnnotation.m
//  asapGF
//
//  Created by rodrigoe on 06-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "MapViewAnnotation.h"

@implementation MapViewAnnotation

@synthesize coordinate=_coordinate;
@synthesize title=_title;

-(id) initWithTitle:(NSString *) title AndCoordinate:(CLLocationCoordinate2D)coordinate
{
    self =  [super init];
    _title = title;
    _coordinate = coordinate;
    return self;
}

@end
