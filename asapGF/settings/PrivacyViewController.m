//
//  PrivacyViewController.m
//  asapGF
//
//  Created by rodrigoe on 14-05-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()

@end

@implementation PrivacyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"privacy_style_1" bundle:nibBundleOrNil];
    //self = [super initWithNibName:@"LoginView_Normal_P" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"POLITICA DE PRIVACIDAD",@"settings header");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
