//
//  RecipeListTableViewController.h
//  asapGF
//
//  Created by rodrigoe on 01-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeListTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray *recipes;

@end
