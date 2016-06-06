//
//  RecipeDetailViewController.m
//  asapGF
//
//  Created by rodrigoe on 06-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "RecipeDetailViewController.h"

@interface RecipeDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *imageContainer;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;
@property (weak, nonatomic) IBOutlet UITextView *recipeIngredients;
@property (weak, nonatomic) IBOutlet UITextView *recipeDescription;

@end

@implementation RecipeDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"RecipeDetailView_style_1" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    self.title = self.recipes[@"name"];
    self.recipeIngredients = self.recipes[@"ingredients"];
    self.recipeDescription = self.recipes[@"description"];
    [self.recipeImage sd_setImageWithURL:[NSURL URLWithString:self.recipes[@"image"]]
                        placeholderImage:[UIImage imageNamed:@"noImgHolder"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
