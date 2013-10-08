//
//  KWImageSprites.m
//  KWImageSprites
//
//  Created by Yusuke Kawasaki on 2013/09/17.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "KWImageSprites.h"

static NSURL *pathToURL(NSString *path) {
    NSURL *url;
    if ([path characterAtIndex:0] == '/') {
        url = [NSURL fileURLWithPath:path isDirectory:NO];
    } else {
        url = [[NSBundle mainBundle] resourceURL];
        url = [NSURL URLWithString:path relativeToURL:url];
    }
    return url;
}

@implementation KWImageSprites
{
    NSCache *_cache;
}

- (NSCache *)cache {
    if (_cache) return _cache;
    return _cache = [NSCache new];
}

- (void)loadMapWithPath:(NSString *)path error:(NSError **)errorPtr {
    NSURL *url = pathToURL(path);
    [self loadMapWithURL:url error:errorPtr];
}

- (void)loadMapWithURL:(NSURL *)url error:(NSError **)errorPtr {
    NSData *json = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:errorPtr];
    if (!json) return;
    
    self.map = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:errorPtr];
}

- (void)loadImageWithPath:(NSString *)path error:(NSError **)errorPtr {
    NSURL *url = pathToURL(path);
    [self loadImageWithURL:url error:errorPtr];
}

- (void)loadImageWithURL:(NSURL *)url error:(NSError **)errorPtr {
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:errorPtr];
    if (!data) return;
    
    self.image = [UIImage imageWithData:data];
}

- (NSArray *)allNames {
    return self.map.allKeys;
}

- (UIImage *)imageForName:(NSString *)name {
    NSArray *array = self.map[name];
    if (!array || array.count < 4) {
        return nil;
    }
    
    CGFloat x = ((NSNumber *) (array[0])).floatValue;
    CGFloat y = ((NSNumber *) (array[1])).floatValue;
    CGFloat w = ((NSNumber *) (array[2])).floatValue;
    CGFloat h = ((NSNumber *) (array[3])).floatValue;
    CGRect rect = CGRectMake(x, y, w, h);
    
    UIImage *sprite = [self imageForRect:rect];
    return sprite;
}

- (UIImage *)imageForRect:(CGRect)rect {
    // cache name by rectangle
    NSString *name = [NSString stringWithFormat:@"x=%.0f&y=%.0f&w=%.0f&h=%.0f",
                      rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
    
    // check cached
    UIImage *cached = [self.cache objectForKey:name];
    if (cached) return cached;
    
    // clip an image
    CGImageRef cgimage = CGImageCreateWithImageInRect(self.image.CGImage, rect);
    UIImage *sprite = [UIImage imageWithCGImage:cgimage];
    CGImageRelease(cgimage);
    
    // cache result
    [self.cache setObject:sprite forKey:name];
    return sprite;
}

@end
