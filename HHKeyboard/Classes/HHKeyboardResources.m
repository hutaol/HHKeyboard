//
//  HHKeyboardResources.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/13.
//

#import "HHKeyboardResources.h"

@implementation HHKeyboardResources

+ (NSString *)getPathWithFace:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HHFace" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
    if (!resourceBundle) {
        NSString *bundlePath = [bundle.resourcePath stringByAppendingPathComponent:@"HHFace.bundle"];
        resourceBundle = [NSBundle bundleWithPath:bundlePath];
    }
    return [[resourceBundle ?: bundle resourcePath] stringByAppendingPathComponent:name];
}

+ (UIImage *)getImageFromFace:(NSString *)name {
    NSString *path = [self getPathWithFace:name];
    return [UIImage imageWithContentsOfFile:path];
}

+ (NSMutableArray *)defaultFaceData {
    NSMutableArray *faceGroups = [NSMutableArray array];
    NSMutableArray *emojiFaces = [NSMutableArray array];
    NSArray *emojis = [NSArray arrayWithContentsOfFile:[self getPathWithFace:@"emoji/emoji.plist"]];
    for (NSDictionary *dic in emojis) {
        HHKeyboardFaceItem *data = [[HHKeyboardFaceItem alloc] init];
        NSString *name = [dic objectForKey:@"face_name"];
        NSString *path = [NSString stringWithFormat:@"emoji/%@", name];
        data.name = name;
        data.path = [self getPathWithFace:path];
//        [self addFaceToCache:data.path];
        [emojiFaces addObject:data];
    }
    
    if(emojiFaces.count != 0){
        HHKeyboardFaceGroup *emojiGroup = [[HHKeyboardFaceGroup alloc] init];
        emojiGroup.groupIndex = 0;
        emojiGroup.groupPath = [self getPathWithFace:@"emoji/"];
        emojiGroup.faces = emojiFaces;
        emojiGroup.needBackDelete = YES;
        emojiGroup.menuPath = [self getPathWithFace:@"emoji/menu"];
//        [self addFaceToCache:emojiGroup.menuPath];
        [faceGroups addObject:emojiGroup];
        
    }
    return faceGroups;
}

@end
