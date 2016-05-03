//
//  BlockerPopupViewController.m
//  UPorto
//
//  Created by Marco Beraud on 21-10-14.
//  Copyright (c) 2014 MoofwdChile. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "ModalSpinnerViewController.h"

@interface ModalSpinnerViewController ()
@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (strong,nonatomic) IBOutlet UIImageView *slowAnimationImageView;
@end

@implementation ModalSpinnerViewController

static ModalSpinnerViewController *spinner = nil;

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"BlockerPopupView_Normal_P_Style1" bundle:nibBundleOrNil];
    if (self){
        //add custom initialization here
    }
    return self;
        
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) startAnimation {
	self.slowAnimationImageView.transform = CGAffineTransformMakeScale(1, 1);
	
	[UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
		self.slowAnimationImageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
	} completion:^(BOOL finished) {
		
	}];
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.slowAnimationImageView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 * @discussion Shows a modal view with spinner on top of screen
 * @param No params required.
 * @return Nothing.
 */
+(void)showModalSpinner
{
    if (!spinner){
        spinner = [[ModalSpinnerViewController alloc] init];
        spinner.view.frame = [UIScreen mainScreen].bounds;
    }
    
    AppDelegate *delegate =[UIApplication sharedApplication].delegate;
    [delegate.window.rootViewController.view addSubview:spinner.view];
	
	[spinner startAnimation];
}

/*!
 * @discussion Shows a modal view with spinner on top of screen
 * @param No params required.
 * @return Nothing.
 */
+(void)dismissModalSpinner
{
    [spinner.view removeFromSuperview];
}



@end
