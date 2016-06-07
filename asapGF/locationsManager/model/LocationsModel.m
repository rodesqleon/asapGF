//
//  LocationsModel.m
//  asapGF
//
//  Created by rodrigoe on 06-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "AppUser.h"
#import "LocationsModel.h"

@interface LocationsModel()
@property (nonatomic) NSURL *modelFile;
@property (nonatomic) NSMutableDictionary *LocationsListOfDictionary;
@end

@implementation LocationsModel
// 1 Declare a static variable to hold the instance of your class, ensuring it’s available globally inside your class.
static LocationsModel *_getInstance =nil;

/*!
 * @discussion Static method for getting a singleton instance.
 * @param not required
 * @return An unique instance of for this class.
 */
+ (LocationsModel*)getInstance
{
    // 2 Declare the static variable dispatch_once_t which ensures that the initialization code executes only once.
    static dispatch_once_t oncePredicate;
    
    // 3 Use Grand Central Dispatch (GCD) to execute a block which initializes an instance of this class.
    dispatch_once(&oncePredicate, ^{
        _getInstance = [[LocationsModel alloc] initWithCachedData];
        
    });
    
    return _getInstance;
}

-(instancetype) initWithCachedData
{
    NSURL *modelFile;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentDirectory = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    modelFile = [documentDirectory URLByAppendingPathComponent:LocationsModel.modelFileName];
    
    NSData *LocationsListData = [NSData dataWithContentsOfURL:modelFile options:NSDataReadingMappedIfSafe error:nil];
    
    if (!LocationsListData) {
        self = [super init];
        self.modelFile = modelFile;
        self.LocationsListOfDictionary = [[NSMutableDictionary alloc] init];
        //initializating the class empty
        [self persistData];
    }
    else {
        self =[NSKeyedUnarchiver unarchiveObjectWithData:LocationsListData];
        self.modelFile = modelFile;
    }
    
    return self;
}

+(NSString*)modelFileName {
    return @"LocationsModel.bin";
}

-(void) persistData
{
    if (self.LocationsList != nil) {
        NSData *LocationsListData = [NSKeyedArchiver archivedDataWithRootObject:self];
        BOOL success = [LocationsListData writeToURL:self.modelFile options:NSDataWritingAtomic error:nil];
        if (!success){
            NSLog(@"NewsListModel failed to writo to disk: %@", LocationsListData);
        }
    }
}

+(void) removeModel{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentDirectory = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *modelFile = [documentDirectory URLByAppendingPathComponent:LocationsModel.modelFileName];
    [fileManager removeItemAtURL:modelFile error:nil];
    if (_getInstance){
        [_getInstance.LocationsListOfDictionary removeAllObjects];
    }
    
}

-(NSArray*) getLocationsListForKey:(NSString*)key {
    if (!key){
        key = @"dashboard";
    }
    AppUser *appUser = [AppUser getInstance];
    return [self.LocationsListOfDictionary valueForKeyPath:[NSString stringWithFormat:@"%@.%@.LocationsList",appUser.userID,key ]];
}
-(void)setLocationsList:(NSMutableArray *)locationsList forKey:(NSString*)key
{
    if (!key){
        key = @"dashboard";
    }
    AppUser *appUser = [AppUser getInstance];
    NSDictionary *keyedItem =@{ appUser.userID :
                                    @{ key :
                                           @{
                                               @"LocationsList":locationsList,
                                               @"lastUpdate":[NSDate date]
                                               }
                                       }
                                };
    [self.LocationsListOfDictionary setValuesForKeysWithDictionary:keyedItem];
    self.LocationsList = locationsList;
    [self persistData];
}
-(NSDate*) lastUpdateForKey:(NSString*)key {
    if (!key){
        key = @"dashboard";
    }
    
    AppUser *appUser = [AppUser getInstance];
   
    NSDate *lastUpdate = [self.LocationsListOfDictionary valueForKeyPath:[NSString stringWithFormat:@"%@.%@.lastUpdate",appUser.userID,key ]];
    if (!lastUpdate){
        lastUpdate = [NSDate dateWithTimeIntervalSince1970:0];
    }
    return lastUpdate;
}

#pragma mark NSCoding
-(void) encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.LocationsListOfDictionary forKey:@"LocationsListByDay"];
}

-(instancetype) initWithCoder:(NSCoder *)coder
{
    self = [super init];
    self.LocationsListOfDictionary = [coder decodeObjectForKey:@"LocationsListByDay"];
    return self;
}

@end
