//
//  NewScanViewController.m
//  asapGF
//
//  Created by Rodrigo Esquivel on 10-04-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "NewScanViewController.h"
#import "ScanController.h"

@interface NewScanViewController ()

@end

@implementation NewScanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"newScanView_style_1" bundle:nil];
    
    if (self) {
        // Custom initialization
    }
    [self loadView];
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

- (IBAction)newScanCode:(id)sender{
    
    ScanController *scanBarcode = [[ScanController alloc] initWithNibName:@"scannerView_style_1" bundle:nil];
    [self presentViewController:scanBarcode animated:YES completion:nil];

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
