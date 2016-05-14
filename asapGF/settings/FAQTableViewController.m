//
//  FAQTableViewController.m
//  asapGF
//
//  Created by rodrigoe on 05-05-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "FAQTableViewController.h"

@interface FAQTableViewController ()
@property NSMutableArray* adjustmentsSettingOptions;
@end

@implementation FAQTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"faq_style_1" bundle:nibBundleOrNil];
    //self = [super initWithNibName:@"LoginView_Normal_P" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"FAQ",@"settings header");
        
        [self createSettings];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) createSettings {
    self.adjustmentsSettingOptions =
    [[NSMutableArray alloc] initWithObjects:
     @{
       @"name":NSLocalizedString(@"¿Qué es ASAP GF?",@"adjustments information section"),
       @"options":
           @[
               @{
                   @"name":NSLocalizedString(@"As Soon As Possible Gluten Free",@"adjustments about item"),
                   @"target":@"FAQ"
                   },
               @{
                   @"name":NSLocalizedString(@"Lo Más Pronto Posible Libre de Gluten",@"adjustments about item"),
                   @"target":@"FAQ"
                   }
               ]
       },
         @{
           @"name":NSLocalizedString(@"¿Qué significa Gluten Free?",@"adjustments information section"),
           @"options":
               @[
                   @{
                       @"name":NSLocalizedString(@"Libre de gluten",@"adjustments about item"),
                       @"target":@"FAQ"
                       }
                   ]
           },
         @{
           @"name":NSLocalizedString(@"¿Qué la enfermedad celiaca?",@"adjustments information section"),
           @"options":
               @[
                   @{
                       @"name":NSLocalizedString(@"Es la intolerancia al gluten, proteina contenida en TACC",@"adjustments about item"),
                       @"target":@"FAQ"
                       }
                   ]
           },
         @{
           @"name":NSLocalizedString(@"¿Qué significa TACC?",@"adjustments information section"),
           @"options":
               @[
                   @{
                       @"name":NSLocalizedString(@"Trigo, Avena, Cebada y Centeno",@"adjustments about item"),
                       @"target":@"FAQ"
                       }
                   ]
           },
         nil
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES] ;
}

#pragma mark tableview delegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.adjustmentsSettingOptions count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.adjustmentsSettingOptions[section][@"options"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.0;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    header.backgroundColor = [UIColor colorWithRed:238/255.0 green:202/255.0 blue:140/255.0 alpha:1.0];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, 320, 20)];
    title.text =self.adjustmentsSettingOptions[section][@"name"];
    title.textColor = [UIColor blackColor];
    title.font = [UIFont fontWithName:@"Avenir-Black" size:14];
    [header addSubview:title];
    
    return header;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    tableView.backgroundColor = [UIColor colorWithRed:255/255.0 green:244/255.0 blue:191/255.0 alpha:1.0];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font =[UIFont fontWithName:@"Avenir-Book" size:10];
        cell.backgroundColor = [UIColor colorWithRed:255/255.0 green:244/255.0 blue:191/255.0 alpha:1.0];
    }
    // Configure the cell...
    cell.textLabel.text = self.adjustmentsSettingOptions[indexPath.section][@"options"][indexPath.row][@"name"];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
