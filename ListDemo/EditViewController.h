#import <UIKit/UIKit.h>
#import "Product.h"

@interface EditViewController : UIViewController <UIAlertViewDelegate> {
    IBOutlet UITextField *_name;
    IBOutlet UITextField *_price;
    IBOutlet UIButton *_delete;
}

@property Product* product;

- (IBAction)onCancel:(id)sender;
- (IBAction)onOK:(id)sender;
- (IBAction)onDelete:(id)sender;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
