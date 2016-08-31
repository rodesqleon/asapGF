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
#import "WelcomeWizardViewController.h"
#import "AppUser.h"
#import "PresentationWizardViewController.h"
@interface LoginViewController ()
@property (nonatomic) NSDictionary *loginDict;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *activityIndicatorView;

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
    self.logIn_btn.layer.cornerRadius = 40.0;
    self.userName_textField.layer.borderWidth = 1;
    self.userName_textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.password_textField.layer.borderWidth = 1;
    self.password_textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.userName_textField.layer.cornerRadius = 10.0;
    self.password_textField.layer.cornerRadius = 10.0;
    [self.activityIndicatorView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma login_btn_action

-(IBAction)login:(id)sender{
    [self.activityIndicatorView startAnimating];
    /*VALIDATION PASSWORD TEXT FIELD*/
    if([self.password_textField.text isEqualToString:@""] || [self.userName_textField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
                                                        message:@"Incorrect username, please try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        
        NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
        
        if ([self.userName_textField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
                                                           message:@"Enter valid character, please try again."
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
            [alert show];
        }else{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSString *ws = @"http://always420.cl/wsLogIn.php?usr=";
            NSString *callA = [ws stringByAppendingString:self.userName_textField.text];
            NSString *callB = [callA stringByAppendingString:@"&pwd="];
            NSString *callC = [callB stringByAppendingString:self.password_textField.text];
            NSURL *url = [NSURL URLWithString:callC];
            NSString *jsonResponse = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"%@",jsonResponse);
        
            NSData *jsonData = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
            self.loginDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            
            [self performSelector:@selector(didLogin) withObject:nil afterDelay:1.0];
        }];
        }
    }
    
    
}

-(void)didLogin{
    
    NSLog(@"Status: %@", self.loginDict[@"status"]);
    if([self.loginDict[@"status"] isEqualToString:@"OK"]){
        if([[self.loginDict valueForKey:@"info"] count] > 0){
            NSMutableDictionary *response = [[[self.loginDict valueForKey:@"info"] objectAtIndex:0]mutableCopy];
            AppUser *appUser = [AppUser new];
            appUser = [[AppUser getInstance] initWithDict:response];
            
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
                [self.activityIndicatorView stopAnimating];
                NSLog(@"Incorrect username, please try again.");
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
                                                            message:@"Username doesn't exist, please sign in."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [self.activityIndicatorView stopAnimating];
            NSLog(@"Username doesn't exist, please sign in.");
        }
        
    }else{
        
        [self performSelector:@selector(goToHome) withObject:nil afterDelay:1.0];
        
    }
}

- (void) goToHome{
    [self.activityIndicatorView stopAnimating];
    HomeViewController *homeView = [[HomeViewController alloc]
                                    initWithNibName:@"dashboard_style_1" bundle:nil];
    [[self navigationController] pushViewController:homeView animated:YES];
}
-(IBAction)signin:(id)sender{
    SignInViewController *signView = [[SignInViewController alloc] initWithNibName:@"signInView_style_1" bundle:nil];
    [[self navigationController] pushViewController:signView animated:YES];
}

-(IBAction)backToWelcomeScreen:(id)sender{
    WelcomeWizardViewController *welcome = [WelcomeWizardViewController new];
    [[self navigationController] pushViewController:welcome animated:NO];

}

-(IBAction)presentationGF:(id)sender{
    PresentationWizardViewController *presentation = [PresentationWizardViewController new];
    [[self navigationController] pushViewController:presentation animated:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.userName_textField) {
        [theTextField resignFirstResponder];
    }
    id asd;
    [self login:asd];
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
