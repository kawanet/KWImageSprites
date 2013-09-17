//
//  DEMOTableViewController.m
//  KWImageSprites
//
//  Created by Yusuke Kawasaki on 2013/09/16.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "DEMOTableViewController.h"
#import "KWImageSprites.h"

@interface DEMOTableViewController ()

@end

@implementation DEMOTableViewController

NSArray *_list;
KWImageSprites *sprites;

- (void)viewDidLoad {
    [super viewDidLoad];

    sprites = [[KWImageSprites alloc] init];
    NSError *err = nil;

    [sprites loadMapWithPath:@"glyphicons-halflings.json" error:&err];
    [sprites loadImageWithPath:@"glyphicons-halflings.png" error:&err];

    NSMutableArray *list = [[NSMutableArray alloc] init];
    for (id key in sprites.map.keyEnumerator) {
        [list addObject:key];
    }
    _list = list;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    NSString *key = _list[indexPath.item];
    cell.textLabel.text = key;
    cell.imageView.image = [sprites spriteForName:key];

    return cell;
}


@end
