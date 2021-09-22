//
//  ViewController.m
//  HHKeyboard
//
//  Created by Henry on 2021/6/12.
//

#import "ViewController.h"
#import "HHKeyboardView.h"
#import "HHKeyboardHelper.h"
#import "UIColor+HHKeyboard.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, HHKeyboardViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HHKeyboardView *keyboardView;

@property (nonatomic, assign) BOOL dark;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    self.tableView.backgroundColor = [UIColor blueColor];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];

    [self.view addSubview:self.keyboardView];
    [self.keyboardView resetFrame];
    [self updateTableViewInsets];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"暗黑模式" style:UIBarButtonItemStylePlain target:self action:@selector(onClickDark)];
}

- (void)onClickDark {
    _dark = !_dark;
    UIWindow *keyWindow = [HHKeyboardHelper kb_window];
    if (@available(iOS 13.0, *)) {
        if (_dark) {
            keyWindow.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
        } else {
            keyWindow.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        }
    } else {
        // Fallback on earlier versions
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.keyboardView dismissKeyboard];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    if (size.width > size.height) { // 横屏
        // 横屏布局
    } else {
        // 竖屏布局
    }
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        [self.keyboardView configLayout:size];
        
    } completion:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"标题 %ld", indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - HHKeyboardViewDelegate

- (void)keyboard:(HHKeyboardView *)keyboard didChangeHeight:(CGFloat)height {
    [self updateTableViewInsets];
}

- (void)updateTableViewInsets {
    CGFloat bottom = CGRectGetMaxY(self.view.frame) - CGRectGetMinY(self.keyboardView.frame) - [HHKeyboardHelper kb_bottomSafeHeight];

    UIEdgeInsets insets = UIEdgeInsetsMake(0.f, 0.f, bottom, 0.f);
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
//    [self scrollToBottom:YES];
}

- (void)scrollToBottom:(BOOL)animate {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:20 - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animate];
    });
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.keyboardView dismissKeyboard];
}

- (HHKeyboardView *)keyboardView {
    if (!_keyboardView) {
        _keyboardView = [[HHKeyboardView alloc] init];
//        _keyboardView.showFace = NO;
//        _keyboardView.showVoice = YES;
//        _keyboardView.showMore = YES;
        _keyboardView.delegate = self;
        HHKeyboardMoreItem *item = [HHKeyboardMoreItem moreItemWithType:0 title:@"相机" image:nil];
        NSMutableArray *more = @[item, item, item, item, item, item, item, item, item, item].mutableCopy;
        [_keyboardView setMoreItems:more];
    }
    return _keyboardView;
}

@end
