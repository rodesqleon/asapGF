//
//  MenuViewController.m
//  asapGF
//
//  Created by rodrigoe on 14-05-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//
#import "ScanController.h"
#import "MenuViewController.h"
#import "AddProductViewController.h"


@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UIButton *managerAdd;
@property (weak, nonatomic) IBOutlet UIButton *managerEdit;
@property (weak, nonatomic) IBOutlet UIButton *managerDelete;

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"menu_style_1" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Manager",@"settings header");
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
    self.managerAdd.layer.cornerRadius = 40.0;
    self.managerAdd.layer.borderWidth = 1;
    self.managerAdd.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.managerEdit.layer.cornerRadius = 40.0;
    self.managerEdit.layer.borderWidth = 1;
    self.managerEdit.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.managerDelete.layer.cornerRadius = 40.0;
    self.managerDelete.layer.borderWidth = 1;
    self.managerDelete.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

- (IBAction)addProduct:(id)sender{
    
    AddProductViewController *add = [AddProductViewController new];
    add.selectedOption = @"ADD_PRODUCT";
    [[self navigationController] pushViewController:add animated:YES];

}

- (IBAction)deleteProduct:(id)sender{
    ScanController *newScan = [ScanController new];
    newScan.selectedOption = @"DELETE_PRODUCT";
    [[self navigationController] pushViewController:newScan animated:YES];

    
}

- (IBAction)updateProduct:(id)sender{
    AddProductViewController *add = [AddProductViewController new];
    add.selectedOption = @"UPDATE_PRODUCT";
    [[self navigationController] pushViewController:add animated:YES];

}

@end
