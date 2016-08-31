//
//  RecipeListTableViewController.m
//  asapGF
//
//  Created by rodrigoe on 01-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "RecipeDetailViewController.h"
#import "RecipeListTableViewController.h"
#import "RecipeListTableViewCell.h"

@interface RecipeListTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *recipeTableView;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (nonatomic) NSDictionary *wsResponse;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *activityIndicatorView;


@end

@implementation RecipeListTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"RecipeListView_style_1" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Recipes",@"settings header");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    [self.recipeTableView registerNib:[UINib nibWithNibName:@"RecipeCellView_style_1" bundle:nil] forCellReuseIdentifier:@"RecipeCellIdentifier"];
    self.recipeTableView.dataSource = self;
    self.container.layer.cornerRadius = 40.0;
    self.container.layer.borderWidth = 1;
    self.container.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    if(self.wsResponse){
    
    }else{
        [self.activityIndicatorView startAnimating];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"No recipes to show";
        messageLabel.textColor = [UIColor grayColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Avenir-Thin" size:20];
        [messageLabel sizeToFit];
        
        self.recipeTableView.backgroundView = messageLabel;
        self.recipeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self performSelector:@selector(loadRecipe) withObject:nil afterDelay:1.0];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadRecipe{
    
    //Load the json on another thread
    NSString *ws = @"http://always420.cl/wsRecipes.php";
    NSURL *url = [NSURL URLWithString:ws];
    NSString *jsonResponse = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    
    NSData *jsonData = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    self.wsResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    [self performSelector:@selector(didReloadData) withObject:nil afterDelay:1.0];
}

- (IBAction)reloadAction:(UIButton *)sender {
    
    //Load the json on another thread
    NSString *ws = @"http://always420.cl/wsRecipes.php";
    NSURL *url = [NSURL URLWithString:ws];
    NSString *jsonResponse = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    
    NSData *jsonData = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    self.wsResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    [self didReloadData];

}

- (void)didReloadData{
    [self.activityIndicatorView stopAnimating];
    if([self.wsResponse[@"status"] isEqualToString:@"OK"]){
        self.recipes = self.wsResponse[@"info"];
        
        [self.recipeTableView reloadData];

    }else{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Product Manager"
                                                            message:@"Producto actualizado satisfactoriamente"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }];
    }
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeListTableViewCell *cell = [self.recipeTableView dequeueReusableCellWithIdentifier:@"RecipeCellIdentifier" forIndexPath:indexPath];
    if(!cell){
        cell = [self.recipeTableView dequeueReusableCellWithIdentifier:@"RecipeCellIdentifier" forIndexPath:indexPath];
    }
    NSDictionary *info = [self.recipes objectAtIndex:indexPath.row];
    
    cell.recipeName.text = info[@"name"];
    
    NSLog(@"%@", info[@"description"]);
    

    [cell.recipeImage sd_setImageWithURL:[NSURL URLWithString:info[@"image"]]
placeholderImage:[UIImage imageNamed:@"noImgHolder"]];
    
    // Configure the cell...
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeDetailViewController *recipeDetail = [RecipeDetailViewController new];
    NSDictionary *info = [self.recipes objectAtIndex:indexPath.row];
    recipeDetail.recipes = info;
    [[self navigationController] pushViewController:recipeDetail animated:YES];
    [self.recipeTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
