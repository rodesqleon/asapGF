//
//  UserModel.h
//  asapGF
//
//  Created by Rodrigo Esquivel on 13-11-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject <NSCoding>

+ (UserModel*)getInstance;
- (void)persistData;
+ (void)removeModel;
- (NSMutableDictionary*) getUserLoginInfo;
- (void) setUserLoginInfo:(NSMutableDictionary *)userLoginInfo;
- (NSDate*) lastUpdateForContext;

@end
