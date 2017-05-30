//
//  ViewController.m
//  scrollViewSample
//
//  Created by inkeansong on 2017. 5. 30..
//  Copyright © 2017년 inkeansong. All rights reserved.
//

#import "ViewController.h"
#import "ItemView.h"

@interface ViewController ()
@property (strong, nonatomic) ItemView *itemView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ItemView *itemView = [[[NSBundle mainBundle] loadNibNamed:@"ItemView" owner:nil options:nil] firstObject];
    
    itemView.frame = CGRectMake(0, 150, self.view.bounds.size.width, 281);
    [self.view addSubview:itemView];
    
    self.itemView = itemView;
    
    [self.itemView loadPages];
    [self.itemView resetViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
