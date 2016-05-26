//
//  WelcomePage1ViewController.m
//  asapGF
//
//  Created by rodrigoe on 24-05-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "WelcomePage1ViewController.h"
#import "LoginViewController.h"


@interface WelcomePage1ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@end

@implementation WelcomePage1ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    switch (self.index) {
        case 0:
            self.titleLbl.text = @"Welcome to asapGF";
            self.descriptionLbl.text = @"asapGF is an app to all their people that have celiac disease";
            break;
        case 1:
            self.titleLbl.text = @"Search your product";
            self.descriptionLbl.text = @"Wherever you go, use asapGF to know if your product contains gluten or not.";
            break;
        case 2:
            self.titleLbl.text = @"As soon as possible";
            self.descriptionLbl.text = @"Just tap on search, close up your product to the camera and let you know.";
            break;
        case 3:
            self.titleLbl.text = @"All that you need";
            self.descriptionLbl.text = @"Take a look the receipts and places to eat.";
            break;
        default:
            break;
    }

    self.containerView.layer.cornerRadius = 10.0;
    
    }

-(IBAction)goToLogin:(id)sender{
    if(self.index == 3){
        LoginViewController *loginVC = [LoginViewController new];
        [[self navigationController] pushViewController:loginVC animated:YES];
    }
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
