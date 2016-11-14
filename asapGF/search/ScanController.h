//
//  ScanController.h
//  BarcodeScanner
//
//  Created by Vijay Subrahmanian on 09/05/15.
//  Copyright (c) 2015 Vijay Subrahmanian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanController : UIViewController <UITextFieldDelegate,NSURLConnectionDelegate>
@property (nonatomic) NSString *selectedOption;
@property (nonatomic) NSString *productName;
@property (nonatomic) NSString *productDescription;
@end
