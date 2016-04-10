//
//  AppUser.h
//  asapGF
//
//  Created by Rodrigo Esquivel on 03-04-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUser : NSObject
@property (nonatomic) NSString *userID;
@property (nonatomic) NSString *userNAME;
@property (nonatomic) NSString *userPWD;
@property (nonatomic) NSString *userMAIL;
+ (AppUser*)getInstance;
-(instancetype) initWithDict:(NSMutableDictionary *)dict;
@end
