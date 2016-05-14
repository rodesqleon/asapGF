//
//  MenuViewController.m
//  asapGF
//
//  Created by rodrigoe on 14-05-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "ScanController.h"
#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"menu_style_1" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"MANTENEDOR",@"settings header");
    }
    //[self loadView];
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)addProduct:(id)sender{
    ScanController *newScan = [ScanController new];
    newScan.selectedOption = @"ADD_PRODUCT";
    [[self navigationController] pushViewController:newScan animated:YES];

}

- (IBAction)deleteProduct:(id)sender{
    ScanController *newScan = [ScanController new];
    newScan.selectedOption = @"DELETE_PRODUCT";
    [[self navigationController] pushViewController:newScan animated:YES];

    
}

- (IBAction)updateProduct:(id)sender{
    ScanController *newScan = [ScanController new];
    newScan.selectedOption = @"UPDATE_PRODUCT";
    [[self navigationController] pushViewController:newScan animated:YES];

}

@end
