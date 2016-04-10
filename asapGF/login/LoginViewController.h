//
//  LoginViewController.h
//  asapGF
//
//  Created by Rodrigo Esquivel on 02-04-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userName_textField;
@property (weak, nonatomic) IBOutlet UITextField *password_textField;
@property (weak, nonatomic) IBOutlet UIButton *signIn_btn;
@property (weak, nonatomic) IBOutlet UIButton *logIn_btn;
@end
