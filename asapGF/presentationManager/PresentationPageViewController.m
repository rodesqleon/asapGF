//
//  PresentationPageViewController.m
//  asapGF
//
//  Created by rodrigoe on 18-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "PresentationPageViewController.h"
#import "LoginViewController.h"

@interface PresentationPageViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *goToLoginBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation PresentationPageViewController

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
    if(self.index == 10){
        self.goToLoginBtn.hidden = NO;
    }else{
        self.goToLoginBtn.hidden = YES;
    }
    
    switch (self.index) {
        case 0:
            self.titleLbl.text = @"AS SOON AS POSSIBLE GLUTEN FREE";
            self.imageView.image = [UIImage imageNamed:@"images.png"];
            self.descriptionLbl.text = @"Welcome to asapGF";
            break;
        case 1:
            self.titleLbl.text = @"INTRODUCTION";
            self.descriptionLbl.text = @"What is asapGF? \nWhat is gluten? \nWhat is celiac disease?";
            break;
        case 2:
            self.titleLbl.text = @"ELEVATOR PITCH";
            self.imageView.image = [UIImage imageNamed:@"speech.png"];
            self.descriptionLbl.text = @"Start up";
            break;
        case 3:
            self.titleLbl.text = @"VALUE PROPOSITION";
            self.imageView.image = [UIImage imageNamed:@"barcode.png"];
            self.descriptionLbl.text = @"Identify if a product contains gluten through the code bar";
            break;
        case 4:
            self.titleLbl.text = @"CUSTOMER SEGMENT";
            self.descriptionLbl.text = @"All people that have a celiac disease";
            break;
        case 5:
            self.titleLbl.text = @"CHANNELS";
            self.imageView.image = [UIImage imageNamed:@"relationship.png"];
            self.descriptionLbl.text = @"The application and social networks";
            break;
        case 6:
            self.titleLbl.text = @"CUSTOMER RELATIONSHIP";
            self.imageView.image = [UIImage imageNamed:@"customer.png"];
            self.descriptionLbl.text = @"Mobile first";
            break;
        case 7:
            self.titleLbl.text = @"REVENUE STREAMS";
            self.imageView.image = [UIImage imageNamed:@"nonprofit.png"];
            self.descriptionLbl.text = @"asapGF is a non-profit app";
            break;
        case 8:
            self.titleLbl.text = @"KEY RESOURCES";
            self.imageView.image = [UIImage imageNamed:@"keyresources.png"];
            self.descriptionLbl.text = @"Most important resource are all products on the market that not contain gluten.";
            break;
        case 9:
            self.titleLbl.text = @"KEY ACTIVITIES";
            self.imageView.image = [UIImage imageNamed:@"Checklist-icon.png"];
            self.descriptionLbl.text = @"- A list with the most products on the market \n- Make your device a readable camera to scan code bars \n-Provides an useable app to customers";
            break;
        case 10:
            self.titleLbl.text = @"KEY PATNERS";
            self.imageView.image = [UIImage imageNamed:@"keypatners.png"];
            self.descriptionLbl.text = @"Locations that make or sell gluten free producst and all communities or foundations";
            break;
        case 11:
            self.titleLbl.text = @"COST STRUCTURE";
            self.descriptionLbl.text = @"All the finance movement be for non-profit propose. We have all the intentions that CORFO program believe in asapGF";
            break;
        default:
            break;
    }
    
    self.containerView.layer.cornerRadius = 10.0;
    
}

-(IBAction)goToLogin:(id)sender{
    if(self.index == 10){
        LoginViewController *loginVC = [LoginViewController new];
        [[self navigationController] pushViewController:loginVC animated:YES];
    }
}


@end
