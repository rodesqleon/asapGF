//
//  AddProductViewController.h
//  asapGF
//
//  Created by rodrigoe on 26-05-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddProductViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic) NSString *selectedOption;
@property (nonatomic) NSString *productName;
@property (nonatomic) NSString *productDescription;
@end
