# HHKeyboard

[![Requirement](https://badgen.net/badge/icon/iOS%209.0%2B?color=cyan&icon=apple&label)](https://cocoapods.org/pods/HHKeyboard)
[![Version](https://img.shields.io/cocoapods/v/HHKeyboard.svg?style=flat)](https://cocoapods.org/pods/HHKeyboard)
[![License](https://img.shields.io/cocoapods/l/HHKeyboard.svg?style=flat)](https://cocoapods.org/pods/HHKeyboard)
[![Platform](https://img.shields.io/cocoapods/p/HHKeyboard.svg?style=flat)](https://cocoapods.org/pods/HHKeyboard)

![image](https://github.com/hutaol/HHKeyboard/blob/main/Screenshots/screenshots_1.png)
![image](https://github.com/hutaol/HHKeyboard/blob/main/Screenshots/screenshots_2.png)

## 特性 - Features

- 支持暗黑模式
- 根据字体、边距自动调整高度
- 适配iPhone X
- 适配横竖屏

## 安装 - Installation

### CocoaPods

1. 在Podfile中添加：

```ruby
pod 'HHKeyboard'
pod 'HHKeyboard/Face' // 表情图片
```

2. 执行 `pod install` 或 `pod update`。

若搜索不到库，可执行`pod repo update`，或使用 `rm ~/Library/Caches/CocoaPods/search_index.json` 移除本地索引然后再执行安装，或更新一下 CocoaPods 版本。

## 示例 - Example

添加HHKeyboardView

```object

- (void)addKeyboardView {
    _keyboardView = [[HHKeyboardView alloc] init];
    _keyboardView.delegate = self;

    // 相关配置
    HHKeyboardConfiguration *config = [[HHKeyboardConfiguration alloc] init];
    _keyboardView.configuration = config;

    // 更多Item
    HHKeyboardMoreItem *itemPhoto = [HHKeyboardMoreItem moreItemWithType:0 title:@"相机" image:[UIImage imageNamed:@"chat_more_icons_photo"]];
    HHKeyboardMoreItem *itemCamera = [HHKeyboardMoreItem moreItemWithType:1 title:@"拍摄" image:[UIImage imageNamed:@"chat_more_icons_camera"]];

    NSMutableArray *more = @[itemPhoto, itemCamera].mutableCopy;
    [_keyboardView setMoreItems:more];

    // 配置布局，展示在底部的输入框
    [_keyboardView configLayout:self.view.frame.size];

    [self.view addSubview:_keyboardView];
    
}

```

屏幕旋转

```object
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.keyboardView configLayout:size];
    } completion:nil];
}
```

## Author

Email: 1325049637@qq.com

## License

HHKeyboard is available under the MIT license. See the LICENSE file for more info.
