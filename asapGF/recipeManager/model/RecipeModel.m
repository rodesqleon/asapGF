//
//  RecipeModel.m
//  asapGF
//
//  Created by rodrigoe on 27-09-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "RecipeModel.h"

@interface RecipeModel()

@property (nonatomic) NSURL *modelFile;
@property (nonatomic) NSMutableDictionary *recipeDictionary;


@end

@implementation RecipeModel

static RecipeModel *_getInstance =nil;

+ (RecipeModel*)getInstance
{
    // 2 Declare the static variable dispatch_once_t which ensures that the initialization code executes only once.
    static dispatch_once_t oncePredicate;
    
    // 3 Use Grand Central Dispatch (GCD) to execute a block which initializes an instance of this class.
    dispatch_once(&oncePredicate, ^{
        _getInstance = [[RecipeModel alloc] initWithCachedData];
        
    });
    
    return _getInstance;
}

-(instancetype) initWithCachedData
{
    NSURL *modelFile;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentDirectory = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    modelFile = [documentDirectory URLByAppendingPathComponent:RecipeModel.modelFileName];
    
    NSData *eventListData = [NSData dataWithContentsOfURL:modelFile options:NSDataReadingMappedIfSafe error:nil];
    
    if (!eventListData) {
        self = [super init];
        self.modelFile = modelFile;
        self.recipeDictionary = [[NSMutableDictionary alloc] init];
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
    return @"RecipeModel.bin";
}

-(void) persistData
{
    if (self.recipeDictionary != nil) {
        NSData *recipeInfoData = [NSKeyedArchiver archivedDataWithRootObject:self];
        BOOL success = [recipeInfoData writeToURL:self.modelFile options:NSDataWritingAtomic error:nil];
        if (!success){
            NSLog(@"RecipeModel failed to writo to disk: %@", recipeInfoData);
        }
    }
}
-(void) removeModel{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentDirectory = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *modelFile = [documentDirectory URLByAppendingPathComponent:[RecipeModel modelFileName]];
    [fileManager removeItemAtURL:modelFile error:nil];
    if (_getInstance){
        [_getInstance.recipeDictionary removeAllObjects];
    }
    
}

- (void) setRecipeInfo:(NSMutableArray *)recipeInfo{
    [self.recipeDictionary setObject:recipeInfo forKey:@"recipeInfo"];
    [self.recipeDictionary setValue:[NSDate date] forKey:@"lastUpdate"];
    [self persistData];
}

- (NSMutableArray*) getRecipesInfo{
    return [self.recipeDictionary valueForKey:@"recipeInfo"];
}

- (NSDate*) lastUpdate{
    NSDate *lastUpdate = [self.recipeDictionary valueForKey:@"lastUpdate"];
    if (!lastUpdate){
        lastUpdate = [NSDate dateWithTimeIntervalSince1970:0];
    }
    return lastUpdate;
}

#pragma mark NSCoding
-(void) encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.recipeDictionary forKey:@"recipeInfo"];
}

-(instancetype) initWithCoder:(NSCoder *)coder
{
    self = [super init];
    self.recipeDictionary = [coder decodeObjectForKey:@"recipeInfo"];
    return self;
}

@end
