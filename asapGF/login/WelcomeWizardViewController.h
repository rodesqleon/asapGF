//
//  WelcomeWizardViewController.h
//  asapGF
//
//  Created by rodrigoe on 24-05-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageControlDelegate;

@interface WelcomeWizardViewController : UIPageViewController <UIPageViewControllerDataSource>


@property (strong, nonatomic) UIPageViewController *pageController;
@property(nonatomic,retain) UIColor *currentPageIndicatorTintColor;
@property(nonatomic,retain) UIColor *pageIndicatorTintColor;

@end
