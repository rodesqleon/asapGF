//
//  AddProductViewController.m
//  asapGF
//
//  Created by rodrigoe on 26-05-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "AddProductViewController.h"
#import "ScanController.h"

@interface AddProductViewController ()

@property (weak, nonatomic) IBOutlet UITextField *productNameText;
@property (weak, nonatomic) IBOutlet UITextView *productDescriptionText;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceHolderText;
@end

@implementation AddProductViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"addProductView_style_1" bundle:nibBundleOrNil];
    
    //[self loadView];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    if([self.selectedOption isEqualToString:@"ADD_PRODUCT"]){
        self.title = NSLocalizedString(@"Add Product",@"settings header");
    }else{
        self.title = NSLocalizedString(@"Update Product",@"settings header");
    }
    self.productNameText.layer.cornerRadius = 10.0;
    self.productNameText.layer.borderWidth = 1;
    self.productNameText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.productDescriptionText.layer.cornerRadius = 10.0;
    self.productDescriptionText.layer.borderWidth = 1;
    self.productDescriptionText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.nextBtn.layer.cornerRadius = 40.0;
    self.nextBtn.layer.borderWidth = 1;
    self.nextBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.productDescriptionText setDelegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scannerProduct:(id)sender{
    if([self.productNameText.text isEqualToString:@""] || [self.productDescriptionText.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.title
                                                        message:@"Please set a name and descripton for product."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
    ScanController *newScan = [ScanController new];
     newScan.selectedOption = self.selectedOption;
     newScan.productName = self.productNameText.text;
     newScan.productDescription = self.productDescriptionText.text;
     [[self navigationController] pushViewController:newScan animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.productNameText) {
        [theTextField resignFirstResponder];
    }
    id asd;
    [self scannerProduct:asd];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)textViewDidChange:(UITextView *)textView {
    // Enable and disable lblPlaceHolderText
    if ([textView.text length] > 0) {
        [self.lblPlaceHolderText setHidden:YES];
    } else {
        [self.lblPlaceHolderText setHidden:NO];
    }
}

@end
