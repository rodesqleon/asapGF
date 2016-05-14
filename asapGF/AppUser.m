//
//  AppUser.m
//  asapGF
//
//  Created by Rodrigo Esquivel on 03-04-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "AppUser.h"

@implementation AppUser

+ (AppUser*)getInstance
{
    // 1 Declare a static variable to hold the instance of your class, ensuring it’s available globally inside your class.
    static AppUser *_getInstance = nil;
    
    // 2 Declare the static variable dispatch_once_t which ensures that the initialization code executes only once.
    static dispatch_once_t oncePredicate;
    
    // 3 Use Grand Central Dispatch (GCD) to execute a block which initializes an instance of this class.
    dispatch_once(&oncePredicate, ^{
        _getInstance = [[AppUser alloc] init];
        
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

@end
