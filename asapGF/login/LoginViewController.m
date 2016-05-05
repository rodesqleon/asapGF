//
//  LoginViewController.m
//  asapGF
//
//  Created by Rodrigo Esquivel on 02-04-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "ModalSpinnerViewController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "SignInViewController.h"
#import "AppUser.h"
@interface LoginViewController ()
@property (nonatomic) NSDictionary *loginDict;
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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.userName_textField.delegate = self;
    self.password_textField.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma login_btn_action

-(IBAction)login:(id)sender{
    [ModalSpinnerViewController showModalSpinner];
    /*VALIDATION PASSWORD TEXT FIELD*/
    if([self.password_textField.text isEqualToString:@""] || [self.userName_textField.text isEqualToString:@""]){
        [ModalSpinnerViewController dismissModalSpinner];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
                                                        message:@"Incorrect username, please try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        [ModalSpinnerViewController dismissModalSpinner];
        NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
        
        if ([self.userName_textField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
                                                           message:@"Enter valid character, please try again."
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
            [alert show];
        }else{
            NSString *ws = @"http://192.168.43.239/wsLogIn.php?usr=";
            NSString *callA = [ws stringByAppendingString:self.userName_textField.text];
            NSString *callB = [callA stringByAppendingString:@"&pwd="];
            NSString *callC = [callB stringByAppendingString:self.password_textField.text];
            NSURL *url = [NSURL URLWithString:callC];
            NSString *jsonResponse = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"%@",jsonResponse);
        
            NSData *jsonData = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
            self.loginDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        
            [self didLogin];
        }
    }
    
    
}

-(void)didLogin{
    [ModalSpinnerViewController dismissModalSpinner];
    NSLog(@"Status: %@", self.loginDict[@"status"]);
    if([self.loginDict[@"status"] isEqualToString:@"OK"]){
        if([[self.loginDict valueForKey:@"info"] count] > 0){
            NSMutableDictionary *response = [[[self.loginDict valueForKey:@"info"] objectAtIndex:0]mutableCopy];
            AppUser *appUser = [[AppUser getInstance] initWithDict:response];
            
            if([appUser.userNAME isEqualToString:self.userName_textField.text]){
                HomeViewController *homeView = [[HomeViewController alloc] initWithNibName:@"dashboard_style_1" bundle:nil];
                [[self navigationController] pushViewController:homeView animated:YES];
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
        HomeViewController *homeView = [[HomeViewController alloc]
                                        initWithNibName:@"dashboard_style_1" bundle:nil];
        [[self navigationController] pushViewController:homeView animated:YES];
    }
}

-(IBAction)signin:(id)sender{
    SignInViewController *signView = [[SignInViewController alloc] initWithNibName:@"signInView_style_1" bundle:nil];
    [[self navigationController] pushViewController:signView animated:YES];
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
