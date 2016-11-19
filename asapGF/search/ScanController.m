//
//  ScanController.m
//  BarcodeScanner
//
//  Created by Vijay Subrahmanian on 09/05/15.
//  Copyright (c) 2015 Vijay Subrahmanian. All rights reserved.
//

#import "ScanController.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ModalSpinnerViewController.h"
NSString *const kAddOption = @"ADD_PRODUCT";
NSString *const kUpdateOption = @"UPDATE_PRODUCT";
NSString *const kDeleteOption = @"DELETE_PRODUCT";
@interface ScanController () <AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UITextView *scanBarcode;
@property (weak, nonatomic) IBOutlet UIView *camPreviewView;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureLayer;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic) NSDictionary *wsResponse;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;


//NSURL HTTP REQUEST VAR
@property (nonatomic) NSData *responseData;
@property (nonatomic) NSURLResponse *response;
@property (nonatomic) NSString *productBarcode;


@end

@implementation ScanController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"scannerView_style_1" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        self.title = @"Scanner";
    }
    //[self loadView];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScanningSession];
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicatorView];
    [self navigationItem].rightBarButtonItem = barButton;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Start the camera capture session as soon as the view appears completely.
    [self.captureSession startRunning];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    self.activityIndicatorView = [[UIActivityIndicatorView alloc]
                              initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    // I've tried Gray, White, and WhiteLarge
    self.activityIndicatorView.hidden = YES;
    UIBarButtonItem* spinner = [[UIBarButtonItem alloc] initWithCustomView: self.activityIndicatorView];
    self.navigationItem.rightBarButtonItem = spinner;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rescanBtnPressed:(id)sender {
    // Start scanning again.
    [self.captureSession startRunning];
}

- (IBAction)copyBtnPressed:(id)sender {
    // Copy the barcode text to the clipboard.
    [UIPasteboard generalPasteboard].string = self.scanBarcode.text;
}

- (IBAction)doneBtnPressed:(id)sender {
    [self.captureSession stopRunning];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Local method to setup camera scanning session.
- (void)setupScanningSession {
    // Initalising hte Capture session before doing any video capture/scanning.
    self.captureSession = [[AVCaptureSession alloc] init];
    
    NSError *error;
    // Set camera capture device to default and the media type to video.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Set video capture input: If there a problem initialising the camera, it will give am error.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"Error Getting Camera Input");
        return;
    }
    // Adding input souce for capture session. i.e., Camera
    [self.captureSession addInput:input];

    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    // Set output to capture session. Initalising an output object we will use later.
    [self.captureSession addOutput:captureMetadataOutput];
    
    // Create a new queue and set delegate for metadata objects scanned.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("scanQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    // Delegate should implement captureOutput:didOutputMetadataObjects:fromConnection: to get callbacks on detected metadata.
    [captureMetadataOutput setMetadataObjectTypes:[captureMetadataOutput availableMetadataObjectTypes]];
    
    // Layer that will display what the camera is capturing.
    self.captureLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.captureLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.captureLayer setFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
    // Adding the camera AVCaptureVideoPreviewLayer to our view's layer.
    [self.camPreviewView.layer addSublayer:self.captureLayer];
    
    
    
}

// AVCaptureMetadataOutputObjectsDe legate method
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
        // Do your action on barcode capture here:
    NSString *capturedBarcode = nil;
    
    // Specify the barcodes you want to read here:
    NSArray *supportedBarcodeTypes = @[AVMetadataObjectTypeUPCECode,
                                       AVMetadataObjectTypeCode39Code,
                                       AVMetadataObjectTypeCode39Mod43Code,
                                       AVMetadataObjectTypeEAN13Code,
                                       AVMetadataObjectTypeEAN8Code,
                                       AVMetadataObjectTypeCode93Code,
                                       AVMetadataObjectTypeCode128Code,
                                       AVMetadataObjectTypePDF417Code,
                                       AVMetadataObjectTypeQRCode,
                                       AVMetadataObjectTypeAztecCode];
    
    // In all scanned values..
    for (AVMetadataObject *barcodeMetadata in metadataObjects) {
        // ..check if it is a suported barcode
        for (NSString *supportedBarcode in supportedBarcodeTypes) {
            
            if ([supportedBarcode isEqualToString:barcodeMetadata.type]) {
                // This is a supported barcode
                // Note barcodeMetadata is of type AVMetadataObject
                // AND barcodeObject is of type AVMetadataMachineReadableCodeObject
                AVMetadataMachineReadableCodeObject *barcodeObject = (AVMetadataMachineReadableCodeObject *)[self.captureLayer transformedMetadataObjectForMetadataObject:barcodeMetadata];
                capturedBarcode = [barcodeObject stringValue];
                // Got the barcode. Set the text in the UI and break out of the loop.
                
                
                
                //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    if([self.selectedOption isEqualToString:@"SEARCH_PRODUCT"]){
                        [self doSearchCode:capturedBarcode];
                    }else if([self.selectedOption isEqualToString:@"ADD_PRODUCT"]){
                        [self checkValidationProductByBarcode:capturedBarcode];
                    }else if([self.selectedOption isEqualToString:@"UPDATE_PRODUCT"]){
                        [self doUpdateProduct:capturedBarcode];
                    }else if([self.selectedOption isEqualToString:@"DELETE_PRODUCT"]){
                        [self doDeleteProduct:capturedBarcode];
                    }
                    [self.captureSession stopRunning];
                
                //});
                
                
                

                return;
            }
        }
    }
    
}

-(void)doSearchCode:(NSString *)barcode{
    //Load the json on another thread
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.activityIndicatorView.hidden = NO;
        [self.activityIndicatorView startAnimating];
        NSString *ws = @"http://always420.cl/wsValidateCode.php?codebar=";
        NSString *call = [ws stringByAppendingString:barcode];
        NSURL *url = [NSURL URLWithString:call];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                           timeoutInterval:60];
        //NSString *jsonResponse = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        
        //NSData *jsonData = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
        
        //self.wsResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        //[self performSelector:@selector(didScanCode) withObject:nil afterDelay:1.0];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }];
       
    //[self performSelector:@selector(didScanCode) withObject:nil afterDelay:0];

}

-(void)didScanCode{
    if([self.wsResponse[@"status"] isEqualToString:@"OK"]){
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.activityIndicatorView stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation"
                                                        message:@"Gluten free"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        NSLog(@"Gluten free");
    }];
    }else{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.activityIndicatorView stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation"
                                                        message:@"Product not registered gluten free"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        NSLog(@"Contains gluten");
    }];
    }
    
}

- (void)doAddProduct:(NSString *)barcode{
    
    NSString *var0 = @"name=";
    NSString *var1 = [var0 stringByAppendingString:self.productName];
    NSString *var2 = [var1 stringByAppendingString:@"&codebar="];
    NSString *var3 = [var2 stringByAppendingString:barcode];
    NSString *var4 = [var3 stringByAppendingString:@"&description="];
    NSString *post = [var4 stringByAppendingString:self.productDescription];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://always420.cl/wsAddProduct.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    
    self.wsResponse = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
    [self didAddProduct];

}

- (void)checkValidationProductByBarcode:(NSString *)barcode{
    self.selectedOption = @"CHECK_VALIDATION_PRODUCT";
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.activityIndicatorView.hidden = NO;
        [self.activityIndicatorView startAnimating];
        self.productBarcode = barcode;
        NSString *ws = @"http://always420.cl/wsProductValid.php?codebar=";
        NSString *call = [ws stringByAppendingString:barcode];
        NSURL *url = [NSURL URLWithString:call];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                           timeoutInterval:60];
        //NSString *jsonResponse = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        
        //NSData *jsonData = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
        
        //self.wsResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        //[self performSelector:@selector(didScanCode) withObject:nil afterDelay:1.0];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }];
}

- (void)gotValidationProduct{
    if([self.wsResponse[@"status"] isEqualToString:@"OK"]){
        NSDictionary *validation = [[self.wsResponse valueForKey:@"info"] objectAtIndex:0];
        [self addProductWithBarcode:self.productBarcode Validation:validation[@"validation"]];
    }else{
        [self doAddProduct:self.productBarcode];
    }

}

- (void)addProductWithBarcode:(NSString *)barcode Validation:(NSString *)validation{
    NSString *var0 = @"codebar=";
    NSString *var1 = [var0 stringByAppendingString:barcode];
    NSString *var2 = [var1 stringByAppendingString:@"&validation="];
    NSString *post = [var2 stringByAppendingString:validation];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://always420.cl/wsAddProductValid.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    
    self.wsResponse = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
    [self didAddProduct];
}

- (void)didAddProduct{
    if([self.wsResponse[@"status"] isEqualToString:@"OK"]){
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.activityIndicatorView stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Product Manager"
                                                        message:@"Producto añadido satisfactoriamente"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        NSLog(@"Product Added");
    }];
    }else{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.activityIndicatorView stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Product Manager"
                                                        message:@"Ups! El producto no se ha añadido"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        NSLog(@"Error try to adding a product");
    }];
    }
}

- (void)doUpdateProduct:(NSString *)barcode{
    NSString *var0 = @"name=";
    NSString *var1 = [var0 stringByAppendingString:self.productName];
    NSString *var2 = [var1 stringByAppendingString:@"&codebar="];
    NSString *var3 = [var2 stringByAppendingString:barcode];
    NSString *var4 = [var3 stringByAppendingString:@"&description="];
    NSString *post = [var4 stringByAppendingString:self.productDescription];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://always420.cl/wsUpdateProduct.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    
    self.wsResponse = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
    [self didUpdateProduct];

}

- (void)didUpdateProduct{
    if([self.wsResponse[@"status"] isEqualToString:@"OK"]){
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Product Manager"
                                                        message:@"Producto actualizado satisfactoriamente"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        NSLog(@"Product updated");
    }];
    }else{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Product Manager"
                                                        message:@"Ups! El producto no se ha actualizado"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        NSLog(@"Error try to updating a product");
    }];
    }
}

- (void)doDeleteProduct:(NSString *)barcode{
    NSString *var0 = @"codebar=";
    NSString *post = [var0 stringByAppendingString:barcode];
    
    //NSString *post = @"name=test4&email=test4&pwd=test4";
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://always420.cl/wsDeleteProduct.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    
    self.wsResponse = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
    [self didDeleteProduct];
}

- (void)didDeleteProduct{
    [ModalSpinnerViewController dismissModalSpinner];
    if([self.wsResponse[@"status"] isEqualToString:@"OK"]){
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Product Manager"
                                                        message:@"Producto eliminado satisfactoriamente"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        NSLog(@"Product Deleted");
    }];
    }else{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Product Manager"
                                                        message:@"Ups! El producto no se ha eliminado"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        NSLog(@"Error try to delete a product");
    }];
    }
}

//Delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"RODRIGOE => DATA : %@", response);
    self.response = response;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"RODRIGOE => DATA : %@", data);
    self.responseData = data;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    NSLog(@"Connection failed with error: %@", [error localizedDescription]);
    
    
    UIAlertView *ConnectionFailed = [[UIAlertView alloc]
                                     initWithTitle:@"Connection Failed"
                                     message: [NSString stringWithFormat:@"%@", [error localizedDescription]]
                                     delegate:self
                                     cancelButtonTitle:@"Ok"
                                     otherButtonTitles:nil];
    [ConnectionFailed show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *s = [[NSString alloc] initWithData:self.responseData encoding:NSASCIIStringEncoding];
    self.wsResponse  = [NSMutableDictionary new];
    NSData *objectData = [s dataUsingEncoding:NSUTF8StringEncoding];
    self.wsResponse = [NSJSONSerialization JSONObjectWithData:objectData
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil];
    if([self.selectedOption isEqualToString:@"SEARCH_PRODUCT"]){
        [self didScanCode];
    }else if([self.selectedOption isEqualToString:@"ADD_PRODUCT"]){
        [self didAddProduct];
    }else if([self.selectedOption isEqualToString:@"UPDATE_PRODUCT"]){
        [self didUpdateProduct];
    }else if([self.selectedOption isEqualToString:@"DELETE_PRODUCT"]){
        [self didDeleteProduct];
    }else if([self.selectedOption isEqualToString:@"CHECK_VALIDATION_PRODUCT"]){
        [self gotValidationProduct];
    }
    NSLog(@"RODRIGO => DATA : %@", s);
    
}





@end
