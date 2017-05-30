//
//  ItemContentView.h
//  scrollViewSample
//
//  Created by inkeansong on 2017. 5. 30..
//  Copyright © 2017년 inkeansong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemContentView : UIView
// 쿠폰 이름
@property (strong, nonatomic) NSString *itemIndex;

- (void)didShow;
- (void)didHide;

- (void)update;

@end
