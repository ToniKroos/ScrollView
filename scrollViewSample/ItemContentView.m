//
//  ItemContentView.m
//  scrollViewSample
//
//  Created by inkeansong on 2017. 5. 30..
//  Copyright © 2017년 inkeansong. All rights reserved.
//

#import "ItemContentView.h"

@interface ItemContentView()
@property (weak, nonatomic) IBOutlet UIImageView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIView *frontView;
@property (strong, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *frontLabel;
@property (weak, nonatomic) IBOutlet UILabel *backLabel;

@end

@implementation ItemContentView

- (void)update
{
    _contentView.hidden = NO;
    _shadowView.hidden = NO;
    
    _frontLabel.text = [NSString stringWithFormat:@"FRONT %@", self.itemIndex];
    _backLabel.text = [NSString stringWithFormat:@"BACK %@", self.itemIndex];
}

- (void)didShow
{
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self);
}

- (void)didHide
{
    [self showView:_frontView];
}

- (void)showView:(UIView *)view
{
    NSArray *views = @[_backView, _frontView];
    for (UIView *v in views) {
        if (v == view) {
            [_contentView addSubview:v];
        }
        else {
            [v removeFromSuperview];
        }
    }
}

- (IBAction)showBackView:(id)sender {
    [self showView:_backView];
    
}
- (IBAction)closeBackView:(id)sender {
    [self showView:_frontView];
}

@end
