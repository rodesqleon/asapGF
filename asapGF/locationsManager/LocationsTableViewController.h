//
//  LocationsTableViewController.h
//  asapGF
//
//  Created by rodrigoe on 06-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationsTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) NSArray *locations;
@end
