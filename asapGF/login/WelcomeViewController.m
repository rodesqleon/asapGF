//
//  WelcomeViewController.m
//  asapGF
//
//  Created by rodrigoe on 27-04-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"welcomeView_style_1" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    //[self loadView];
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToLogin:(id)sender{
    LoginViewController *loginVC = [LoginViewController new];
    [[self navigationController] pushViewController:loginVC animated:YES];
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
