//
//  PresentationWizardViewController.h
//  asapGF
//
//  Created by rodrigoe on 18-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageControlDelegate;

@interface PresentationWizardViewController : UIPageViewController <UIPageViewControllerDataSource>


@property (strong, nonatomic) UIPageViewController *pageController;
@property(nonatomic,retain) UIColor *currentPageIndicatorTintColor;
@property(nonatomic,retain) UIColor *pageIndicatorTintColor;

@end
