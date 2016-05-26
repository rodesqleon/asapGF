//
//  WelcomeWizardViewController.m
//  asapGF
//
//  Created by rodrigoe on 24-05-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "WelcomeWizardViewController.h"
#import "WelcomePage1ViewController.h"


@interface WelcomeWizardViewController ()

@end

@implementation WelcomeWizardViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    
    WelcomePage1ViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    
    [self.pageController didMoveToParentViewController:self];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(WelcomePage1ViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(WelcomePage1ViewController *)viewController index];
    
    
    index++;
    
    if (index == 4) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (WelcomePage1ViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    WelcomePage1ViewController *childViewController = [[WelcomePage1ViewController alloc] initWithNibName:@"WelcomeScreenView_1" bundle:nil];
    childViewController.index = index;
    
    return childViewController;
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 4;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

@end
