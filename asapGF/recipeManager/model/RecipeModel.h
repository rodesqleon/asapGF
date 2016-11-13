//
//  RecipeModel.h
//  asapGF
//
//  Created by rodrigoe on 27-09-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeModel : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *recipeDescription;
@property (nonatomic) NSString *image;
+ (RecipeModel*)getInstance;
@end
