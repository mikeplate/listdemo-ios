#import "ViewController.h"
#import "EditViewController.h"
#import "Product.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _data = [[NSMutableArray alloc] init];
    NSString* storage = [[NSUserDefaults standardUserDefaults] stringForKey:@"products"];
    if (storage!=nil) {
        NSArray* array = [storage componentsSeparatedByString:@"&"];
        for (int i = 0; i<array.count; i += 2) {
            Product* p = [[Product alloc] init];
            p.name = [array objectAtIndex:i];
            p.price = [[array objectAtIndex:i+1] intValue];
            [_data addObject:p];
        }
    }

    [self updateView];
}

- (void)saveData {
    NSMutableString* storage = [[NSMutableString alloc] init];
    for (Product* p in _data) {
        if (storage.length>0)
            [storage appendString:@"&"];
        [storage appendString:p.name];
        [storage appendString:@"&"];
        [storage appendFormat:@"%d", p.price];
    }
    
    NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
    [prefs setValue:storage forKey:@"products"];
    [prefs synchronize];
}

- (void)updateView {
    NSString* msg = [NSString stringWithFormat:@"%d products", _data.count];
    _heading.text = msg;

    [_list reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onAdd:(id)sender {
    EditViewController* editView = [[EditViewController alloc] init];
    editView.product = nil;
    [self presentModalViewController:editView animated:YES];
}

- (void)add:(Product*)product {
    [_data addObject:product];
    [self updateView];
    [self saveData];
}

- (void)edit:(Product*)product {
    NSIndexPath* path = [_list indexPathForSelectedRow];
    [_data setObject:product atIndexedSubscript:path.row];
    [self updateView];
    [self saveData];
}

- (void)delete {
    NSIndexPath* path = [_list indexPathForSelectedRow];
    [_data removeObjectAtIndex:path.row];
    [self updateView];
    [self saveData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell* cell = [_list dequeueReusableCellWithIdentifier:@"Xyz"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Xyz"];
    }

    Product* p = [_data objectAtIndex:indexPath.row];
    NSString* str = [NSString stringWithFormat:@"%@ %d SEK", p.name, p.price];
    [cell.textLabel setText:str];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EditViewController* editView = [[EditViewController alloc] init];
    editView.product = [_data objectAtIndex:indexPath.row];
    [self presentModalViewController:editView animated:YES];
}

@end
