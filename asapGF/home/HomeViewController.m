//
//  HomeViewController.m
//  asapGF
//
//  Created by Rodrigo Esquivel on 03-04-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "LocationsTableViewController.h"
#import "RecipeListTableViewController.h"
#import "HomeViewController.h"
#import "MenuViewController.h"
#import "SettingsTableViewController.h"
#import "LoginViewController.h"
#import "NewScanViewController.h"
#import "AppUser.h"


@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *logout_btn;
@property (weak, nonatomic) IBOutlet UIButton *product_btn;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"dashboard_style_1" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    AppUser *appUser = [AppUser getInstance];
    self.usernameLabel.text = [[appUser getUserInfo] valueForKey:@"name"];
    self.product_btn.hidden = YES;
    if([[[appUser getUserInfo] valueForKey:@"role"] isEqualToString:@"admin"]){
        self.product_btn.hidden = NO;
    }
    self.firstView.layer.cornerRadius = 40.0;
    self.firstView.layer.borderWidth = 1;
    self.firstView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.secondView.layer.cornerRadius = 40.0;
    self.secondView.layer.borderWidth = 1;
    self.secondView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.thirdView.layer.cornerRadius = 40.0;
    self.thirdView.layer.borderWidth = 1;
    self.thirdView.layer.borderColor = [[UIColor lightGrayColor] CGColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma signin_btn_action

- (IBAction)logout:(id)sender{
    SettingsTableViewController *settingView = [[SettingsTableViewController alloc] initWithNibName:@"settings_style_1" bundle:nil];
    //LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"loginView_style_1" bundle:nil];
    [[self navigationController] pushViewController:settingView animated:YES];

}

-(IBAction)searchBtn:(id)sender{
    NewScanViewController *newScan = [[NewScanViewController alloc] initWithNibName:@"newScanView_style_1" bundle:nil];
    //ScannerViewController *newScan = [ScannerViewController new];
    
    [[self navigationController] pushViewController:newScan animated:YES];
    
    

}

-(IBAction)locationBtn:(id)sender{
    LocationsTableViewController *location = [[LocationsTableViewController alloc] initWithNibName:@"locationsListView_style_1" bundle:nil];
    
    [[self navigationController] pushViewController:location animated:YES];
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Dashboard"
                                                    message:@"Coming soon"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];*/

}

- (IBAction)foodBtn:(id)sender{

    RecipeListTableViewController *recipe = [[RecipeListTableViewController alloc] initWithNibName:@"menu_style_1" bundle:nil];

    [[self navigationController] pushViewController:recipe animated:YES];
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Dashboard"
                                                    message:@"Coming soon"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];*/
    
}

- (IBAction)productManager:(id)sender{
    MenuViewController *productM = [[MenuViewController alloc] initWithNibName:@"menu_style_1" bundle:nil];
    [[self navigationController] pushViewController:productM animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
