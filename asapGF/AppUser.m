//
//  AppUser.m
//  asapGF
//
//  Created by Rodrigo Esquivel on 03-04-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "AppUser.h"

@interface AppUser()

@property (nonatomic) NSURL *modelFile;
@property (nonatomic) NSMutableDictionary *userDictionary;


@end

@implementation AppUser

static AppUser *_getInstance =nil;

+ (AppUser*)getInstance
{
    // 2 Declare the static variable dispatch_once_t which ensures that the initialization code executes only once.
    static dispatch_once_t oncePredicate;
    
    // 3 Use Grand Central Dispatch (GCD) to execute a block which initializes an instance of this class.
    dispatch_once(&oncePredicate, ^{
        _getInstance = [[AppUser alloc] initWithCachedData];
        
    });
    
    return _getInstance;
}


-(instancetype)initWithDict:(NSMutableDictionary *)dict{
    self = [super init];
    
    if(self){
        _userID = dict[@"id"];
        _userNAME = dict[@"name"];
        _userMAIL = dict[@"email"];
        _userROLE = dict[@"role"];
    }
    
    return self;
}

-(instancetype) initWithCachedData
{
    NSURL *modelFile;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentDirectory = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    modelFile = [documentDirectory URLByAppendingPathComponent:AppUser.modelFileName];
    
    NSData *eventListData = [NSData dataWithContentsOfURL:modelFile options:NSDataReadingMappedIfSafe error:nil];
    
    if (!eventListData) {
        self = [super init];
        self.modelFile = modelFile;
        self.userDictionary = [[NSMutableDictionary alloc] init];
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
    if (self.userDictionary != nil) {
        NSData *userInfoData = [NSKeyedArchiver archivedDataWithRootObject:self];
        BOOL success = [userInfoData writeToURL:self.modelFile options:NSDataWritingAtomic error:nil];
        if (!success){
            NSLog(@"UserModel failed to writo to disk: %@", userInfoData);
        }
    }
}
-(void) removeModel{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentDirectory = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *modelFile = [documentDirectory URLByAppendingPathComponent:[AppUser modelFileName]];
    [fileManager removeItemAtURL:modelFile error:nil];
    if (_getInstance){
        [_getInstance.userDictionary removeAllObjects];
    }
    
}

- (void) setUserInfo:(NSMutableDictionary *)userInfo{
    
    [self.userDictionary setObject:userInfo forKey:@"userInfo"];
    [self.userDictionary setValue:[NSDate date] forKey:@"lastUpdate"];
    [self persistData];
}

- (NSMutableDictionary*) getUserInfo{
    return [self.userDictionary valueForKeyPath:@"userInfo"];
}

- (NSDate*) lastUpdate{

    NSDate *lastUpdate = [self.userDictionary valueForKeyPath:@"lastUpdate"];
    if (!lastUpdate){
        lastUpdate = [NSDate dateWithTimeIntervalSince1970:0];
    }
    return lastUpdate;
}

#pragma mark NSCoding
-(void) encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.userDictionary forKey:@"userInfo"];
}

-(instancetype) initWithCoder:(NSCoder *)coder
{
    self = [super init];
    self.userDictionary = [coder decodeObjectForKey:@"userInfo"];
    return self;
}

@end
