//
//  UserModel.m
//  asapGF
//
//  Created by Rodrigo Esquivel on 13-11-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "UserModel.h"

@interface UserModel()
@property (nonatomic) NSURL *modelFile;
@property (nonatomic) NSMutableDictionary *userInfo;
@end

@implementation UserModel

// 1 Declare a static variable to hold the instance of your class, ensuring it’s available globally inside your class.
static UserModel *_getInstance =nil;

/*!
 * @discussion Static method for getting a singleton instance.
 * @param not required
 * @return An unique instance of for this class.
 */
+ (UserModel*)getInstance
{
    // 2 Declare the static variable dispatch_once_t which ensures that the initialization code executes only once.
    static dispatch_once_t oncePredicate;
    
    // 3 Use Grand Central Dispatch (GCD) to execute a block which initializes an instance of this class.
    dispatch_once(&oncePredicate, ^{
        _getInstance = [[UserModel alloc] initWithCachedData];
        
    });
    
    return _getInstance;
}

-(instancetype) initWithCachedData
{
    NSURL *modelFile;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentDirectory = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    modelFile = [documentDirectory URLByAppendingPathComponent:UserModel.modelFileName];
    
    NSData *eventListData = [NSData dataWithContentsOfURL:modelFile options:NSDataReadingMappedIfSafe error:nil];
    
    if (!eventListData) {
        self = [super init];
        self.modelFile = modelFile;
        self.userInfo = [[NSMutableDictionary alloc] init];
        //initializating the class empty
        [self persistData];
    }
    else {
        self =[NSKeyedUnarchiver unarchiveObjectWithData:eventListData];
        self.modelFile = modelFile;
    }
    
    return self;
}


+(NSString*)modelFileName {
    return @"UserModel.bin";
}
-(void) persistData
{
    if (self.userInfo != nil) {
        NSData *userInfoData = [NSKeyedArchiver archivedDataWithRootObject:self];
        BOOL success = [userInfoData writeToURL:self.modelFile options:NSDataWritingAtomic error:nil];
        if (!success){
            NSLog(@"UserModel failed to writo to disk: %@", userInfoData);
        }
    }
}
+(void) removeModel{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentDirectory = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *modelFile = [documentDirectory URLByAppendingPathComponent:[UserModel modelFileName]];
    [fileManager removeItemAtURL:modelFile error:nil];
    if (_getInstance){
        [_getInstance.userInfo removeAllObjects];
    }
    
}
- (NSMutableDictionary*) getUserLoginInfo{

    return [self.userInfo valueForKey:@"userInfo"];
}

- (void) setUserLoginInfo:(NSMutableDictionary *)userLoginInfo{
    
    /*[self.userInfo setObject:userLoginInfo forKey:@"userInfo"];
    [self.userInfo setValue:[NSDate date] forKey:@"lastUpdate"];
    
    [self persistData];*/
}

- (NSDate*) getlastUpdate{

    NSDate *lastUpdate = [self.userInfo valueForKey:@"lastUpdate"];
    if (!lastUpdate){
        lastUpdate = [NSDate dateWithTimeIntervalSince1970:0];
    }
    return lastUpdate;
}

#pragma mark NSCoding
-(void) encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.userInfo forKey:@"userInfo"];
}

-(instancetype) initWithCoder:(NSCoder *)coder
{
    self = [super init];
    self.userInfo = [coder decodeObjectForKey:@"userInfo"];
    return self;
}
@end

