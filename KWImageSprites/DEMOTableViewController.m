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

KWImageSprites *sprites;

- (void)viewDidLoad {
    [super viewDidLoad];

    sprites = [[KWImageSprites alloc] init];
    NSError *err = nil;

    [sprites loadMapWithPath:@"glyphicons-halflings.json" error:&err];
    if (err) NSLog(@"%@", err);
    
    [sprites loadImageWithPath:@"glyphicons-halflings.png" error:&err];
    if (err) NSLog(@"%@", err);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return sprites.allNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // filename
    NSString *name = sprites.allNames[indexPath.item];
    cell.textLabel.text = name;
    
    // image
    UIImage *image = [sprites spriteForName:name];
    cell.imageView.image = image;
    cell.textLabel.enabled = !!image;
    
    return cell;
}

@end
