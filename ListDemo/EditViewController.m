//
//  EditViewController.m
//  ListDemo
//
//  Created by Mike P on 2013-03-04.
//  Copyright (c) 2013 Mikael Plate. All rights reserved.
//

#import "EditViewController.h"
#import "ViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.product!=nil) {
        _name.text = self.product.name;
        _price.text = [NSString stringWithFormat:@"%d", self.product.price];
    }
    else {
        [_delete setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    _delete = nil;
    [super viewDidUnload];
}

- (IBAction)onCancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)onDelete:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Delete" message:@"Are you sure you want to delete this data?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        ViewController* parent = (ViewController*) [self presentingViewController];
        [parent delete];
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction)onOK:(id)sender {
    Product* p = [[Product alloc] init];
    p.name = _name.text;
    p.price = [_price.text intValue];
    
    ViewController* parent = (ViewController*) [self presentingViewController];
    if (self.product==nil)
        [parent add:p];
    else
        [parent edit:p];

    [self dismissModalViewControllerAnimated:YES];
}

@end
