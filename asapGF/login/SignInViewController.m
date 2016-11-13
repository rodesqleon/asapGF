//
//  SignInViewController.m
//  asapGF
//
//  Created by Rodrigo Esquivel on 03-04-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "LoginViewController.h"
#import "SignInViewController.h"

@interface SignInViewController ()
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UITextField *userName_textField;
@property (weak, nonatomic) IBOutlet UITextField *email_textField;
@property (weak, nonatomic) IBOutlet UITextField *password_textField;
@property (weak, nonatomic) IBOutlet UIView *condition_btn;
@property (nonatomic, strong) IBOutlet UINavigationItem *navEng;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
@property (nonatomic) NSDictionary *dict;
@end

@implementation SignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"signInView_style_1" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Sign In",@"settings header");
        
    }
    //[self loadView];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    self.signInBtn.layer.cornerRadius = 40.0;
    self.userName_textField.layer.borderWidth = 1;
    self.userName_textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.password_textField.layer.borderWidth = 1;
    self.password_textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.email_textField.layer.borderWidth = 1;
    self.email_textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.userName_textField.layer.cornerRadius = 10.0;
    self.password_textField.layer.cornerRadius = 10.0;
    self.email_textField.layer.cornerRadius = 10.0;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma signin_btn_action

- (IBAction)signin:(id)sender{
    if([self.userName_textField.text isEqualToString:@""] || [self.password_textField.text isEqualToString:@""] || [self.email_textField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration"
                                                        message:@"Please set all the fields"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        
        NSString *var0 = @"name=";
        NSString *var1 = [var0 stringByAppendingString:self.userName_textField.text];
        NSString *var2 = [var1 stringByAppendingString:@"&email="];
        NSString *var3 = [var2 stringByAppendingString:self.email_textField.text];
        NSString *var4 = [var3 stringByAppendingString:@"&pwd="];
        NSString *post = [var4 stringByAppendingString:self.password_textField.text];
        
        //NSString *post = @"name=test4&email=test4&pwd=test4";
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://always420.cl/wsSignIn.php"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        NSData *response = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:nil error:nil];
        self.dict = [NSDictionary new];
        self.dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
        
        [self.activityIndicatorView startAnimating];
        [self performSelector:@selector(didSignIn) withObject:nil afterDelay:5.0];
    }
    
}

- (void)didSignIn{
    
    if([self.dict[@"status"] isEqualToString:@"OK"]){
        NSLog(@"Status: %@", self.dict[@"status"]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration"
                                                        message:self.dict[@"msg"]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [self.activityIndicatorView stopAnimating];
        [self performSelector:@selector(goToHome) withObject:nil afterDelay:5.0];
        
    }else{
        NSLog(@"Status: %@", self.dict[@"status"]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration"
                                                        message:@"Error. Please try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [self.activityIndicatorView stopAnimating];
    }

}

- (void)goToHome{
    LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"loginView_style_1" bundle:nil];
    [[self navigationController] pushViewController:loginView animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.userName_textField) {
        [theTextField resignFirstResponder];
    }
    id asd;
    [self signin:asd];
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
