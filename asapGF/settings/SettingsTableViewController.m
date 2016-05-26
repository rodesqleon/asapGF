//
//  SettingsTableViewController.m
//  asapGF
//
//  Created by rodrigoe on 05-05-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "LoginViewController.h"
#import "AboutViewController.h"
#import "PrivacyViewController.h"
#import "FAQTableViewController.h"

@interface SettingsTableViewController ()
@property NSMutableArray* adjustmentsSettingOptions;
@end

@implementation SettingsTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"settings_style_1" bundle:nibBundleOrNil];
    //self = [super initWithNibName:@"LoginView_Normal_P" bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"CONFIGURACIÓN",@"settings header");
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain
                                                                         target:self action:@selector(logoutAction:)];
        self.navigationItem.rightBarButtonItem = anotherButton;
        
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
       @"name":NSLocalizedString(@"INFORMACIÓN",@"adjustments information section"),
       @"options":
           @[
               @{
                   @"name":NSLocalizedString(@"Acerca de",@"adjustments about item"),
                   @"target":@"AboutUs"
                   },
               @{
                   @"name":NSLocalizedString(@"FAQ",@"adjustments help item"),
                   @"target":@"Help"
                   },
               @{
                   @"name":NSLocalizedString(@"Politica de privacidad",@"adjustments privacy policy item"),
                   @"target":@"Privacy"
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

- (IBAction)logoutAction:(UIButton *)sender {
    LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"loginView_style_1" bundle:nil];
    [[self navigationController] pushViewController:loginView animated:YES];
    
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font =[UIFont fontWithName:@"Avenir-Black" size:14];
        cell.backgroundColor = [UIColor colorWithRed:255/255.0 green:244/255.0 blue:191/255.0 alpha:1.0];
    }
    // Configure the cell...
    cell.textLabel.text = self.adjustmentsSettingOptions[indexPath.section][@"options"][indexPath.row][@"name"];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.adjustmentsSettingOptions[indexPath.section][@"options"][indexPath.row][@"name"] isEqualToString:@"Acerca de"]){
        AboutViewController *about = [AboutViewController new];
        [[self navigationController] pushViewController:about animated:YES];
        
    }else if([self.adjustmentsSettingOptions[indexPath.section][@"options"][indexPath.row][@"name"] isEqualToString:@"Politica de privacidad"]){
        PrivacyViewController *privacy = [PrivacyViewController new];
        [[self navigationController] pushViewController:privacy animated:YES];
    }else{
        FAQTableViewController *faq = [[FAQTableViewController alloc] initWithNibName:@"faq_style_1" bundle:nil];
        [[self navigationController] pushViewController:faq animated:YES];

    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
