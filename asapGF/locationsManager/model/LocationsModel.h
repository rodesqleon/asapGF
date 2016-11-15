//
//  LocationsModel.h
//  asapGF
//
//  Created by rodrigoe on 06-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationsModel : NSObject<NSCoding>

@property (nonatomic) NSMutableArray *LocationsList;
@property (nonatomic,readonly) NSDate *lastUpdate;

+ (LocationsModel*)getInstance;
-(void)persistData;
-(void)removeModel;
-(NSArray*) getLocationsList;
-(void) setLocationsList:(NSMutableArray *)newsList;
-(NSDate*) lastUpdate;

@end
