//
//  ViewController.m
//  GoTDemoApp
//
//  Created by Matthew Ledwon on 8/21/18.
//  Copyright © 2018 Vaporstream. All rights reserved.
//

#import "ViewController.h"
#import "GOTHouse.h"
#import "GOTCharacter.h"
#import "HouseTableViewCell.h"

@interface ViewController ()

@property (nonatomic, retain) NSArray *houses;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activitySpinner;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetworkActivity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startNetworkActivity {
    [self.activitySpinner startAnimating];
}

- (void)endNetworkActivity {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activitySpinner stopAnimating];
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDatasource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HouseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HouseCell"];

    if (cell == nil) {
        cell = [[HouseTableViewCell alloc] init];
    }

    cell.house = [self.houses objectAtIndex:indexPath.row];
    [cell drawCell];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.houses count];
}

@end
