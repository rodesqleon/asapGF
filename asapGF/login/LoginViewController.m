//
//  LoginViewController.m
//  asapGF
//
//  Created by Rodrigo Esquivel on 02-04-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "SignInViewController.h"
#import "AppUser.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"loginView_style_1" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    //[self loadView];
    return self;
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userName_textField.delegate = self;
    self.password_textField.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma login_btn_action

-(IBAction)login:(id)sender{
    
    NSString *ws = @"http://192.168.0.100/wsLogIn.php?pwd=";
    NSString *call = [ws stringByAppendingString:self.password_textField.text];
    
    NSURL *url = [NSURL URLWithString:call];
    NSString *jsonResponse = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",self.password_textField.text);
    NSLog(@"%@",jsonResponse);
    
    NSData *jsonData = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    if([dict[@"status"] isEqualToString:@"OK"]){
            NSLog(@"Status: %@", dict[@"status"]);
        if([[dict valueForKey:@"info"] count] > 0){
            NSMutableDictionary *response = [[[dict valueForKey:@"info"] objectAtIndex:0]mutableCopy];
            
            AppUser *appUser = [[AppUser getInstance] initWithDict:response];
            
            if([appUser.userNAME isEqualToString:self.userName_textField.text]){
                HomeViewController *homeView = [[HomeViewController alloc] initWithNibName:@"dashboard_style_1" bundle:nil];
                [self presentViewController:homeView animated:YES completion:nil];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
                                                                message:@"Incorrect username, please try again."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                NSLog(@"Incorrect username, please try again.");
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
                                                            message:@"Username doesn't exist, please sign in."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

            NSLog(@"Username doesn't exist, please sign in.");
        }
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration"
                                                        message:@"User doesn't exist, please sign in."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

        NSLog(@"Status: %@", dict[@"status"]);
    }
    

}

-(IBAction)signin:(id)sender{
    SignInViewController *signView = [[SignInViewController alloc] initWithNibName:@"signInView_style_1" bundle:nil];
    [self presentViewController:signView animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.userName_textField) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
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
