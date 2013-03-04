#import <UIKit/UIKit.h>
#import "Product.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray* _data;
    IBOutlet UITableView *_list;
    IBOutlet UILabel *_heading;
}
- (IBAction)onAdd:(id)sender;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)add:(Product*)product;
- (void)edit:(Product*)product;
- (void)delete;

@end
