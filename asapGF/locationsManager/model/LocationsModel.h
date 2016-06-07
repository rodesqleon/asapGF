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
+(void)removeModel;
-(NSArray*) getLocationsListForKey:(NSString*)key;
-(void) setLocationsList:(NSMutableArray *)newsList forKey:(NSString*)key;
-(NSDate*) lastUpdateForKey:(NSString*)key;

@end
