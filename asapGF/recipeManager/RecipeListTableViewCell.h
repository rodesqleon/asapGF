//
//  RecipeListTableViewCell.h
//  asapGF
//
//  Created by rodrigoe on 01-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;
@property (weak, nonatomic) IBOutlet UILabel *recipeName;
@property (weak, nonatomic) IBOutlet UIView *imageContainer;

@end
