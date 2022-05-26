//
//  xw_LoginTabCell.m
//  XW_Object
//
//  Created by Benc Mai on 2019/11/27.
//  Copyright © 2019 武新义. All rights reserved.
//

#import "xw_LoginTabCell.h"
#import "xw_LoginViewModel.h"


@interface xw_LoginTabCell ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
{
    BOOL showList;           //是否弹出下拉列表
}

@property(nonatomic,strong)UIView* topBgView;
@property(nonatomic,strong)UIImageView* topImageView;
@property(nonatomic,strong)UILabel* topTitleLabel;

@property(nonatomic,strong)UIView* bgView;
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UITextField* usernameTextField;
@property(nonatomic,strong)UITextField* pwdTextField;
@property(nonatomic,strong)UIButton* loginBtn;
@property(nonatomic,strong)UIButton* forgetBtn;
@property(nonatomic,strong)UIButton* registerBtn;
@property(nonatomic,strong)UITextView* protocolTextView;

@property(nonatomic,strong)UITableView* tb;

@property(nonatomic,strong)NSArray* dataSource;

@property (assign, nonatomic) BOOL isSelect;

@end
@implementation xw_LoginTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)xw_setupUI{
    self.xw_height = SCREEN_HEIGHT;
    [self.contentView addSubview:self.topBgView];
    
    [self.contentView addSubview:self.topImageView];
    [self.contentView addSubview:self.topTitleLabel];
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.usernameTextField];
    
    [self.bgView addSubview:self.pwdTextField];
    [self.contentView addSubview:self.protocolTextView];
    [self.contentView addSubview:self.loginBtn];
    [self.contentView addSubview:self.forgetBtn];
    [self.contentView addSubview:self.registerBtn];
    
    [self.contentView addSubview:self.tb];
    
}
-(void)xw_updateConstraints{
    
    self.bgView.sd_layout
    .leftSpaceToView(self.contentView, 30)
    .rightSpaceToView(self.contentView, 30)
    .centerYEqualToView(self.contentView)
    .heightIs(208);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.bgView, 30)
    .rightSpaceToView(self.bgView, 30)
    .topEqualToView(self.bgView)
    .heightIs(80);
    
    
    self.usernameTextField.sd_layout
    .leftSpaceToView(self.bgView, 30)
    .rightSpaceToView(self.bgView, 30)
    .topSpaceToView(self.titleLabel, 0)
    .heightIs(40);
    
    self.tb.sd_layout
    .leftEqualToView(self.usernameTextField)
    .rightEqualToView(self.usernameTextField)
    .topSpaceToView(self.usernameTextField, 0)
    .heightIs(0);
    

    
    self.pwdTextField.sd_layout
    .leftSpaceToView(self.bgView, 30)
    .rightSpaceToView(self.bgView, 30)
    .topSpaceToView(self.usernameTextField, 15)
    .heightIs(40);

 
    self.topTitleLabel.sd_layout
    .bottomSpaceToView(self.bgView, 0)
    .leftSpaceToView(self.contentView, 30)
    .rightSpaceToView(self.contentView, 30)
    .heightIs(60);
    
    self.topImageView.sd_layout
    .bottomSpaceToView(self.topTitleLabel, 0)
    .centerXEqualToView(self.contentView)
    .heightIs(80).widthIs(80);
    
    self.protocolTextView.sd_layout
    .leftSpaceToView(self.contentView, 30)
    .rightSpaceToView(self.contentView, 30)
    .topSpaceToView(self.bgView, 10)
    .heightIs(40);
    
    self.loginBtn.sd_layout
    .leftSpaceToView(self.contentView, 30)
    .rightSpaceToView(self.contentView, 30)
    .topSpaceToView(self.protocolTextView, 0)
    .heightIs(50);
    
    self.forgetBtn.sd_layout
    .leftSpaceToView(self.contentView, 30)
    .topSpaceToView(self.loginBtn, 5)
    .heightIs(40).widthIs(80);
    
    self.registerBtn.sd_layout
    .rightSpaceToView(self.contentView, 30)
    .topSpaceToView(self.loginBtn, 5)
    .heightIs(40).widthIs(80);
    
   
    
    
    
}
-(void)setViewMode:(id )viewMode{
    showList=NO;//默认不显示下拉框
    self.isSelect = YES;
    xw_LoginViewModel* vModel = (xw_LoginViewModel* )viewMode;
//    RAC(vModel ,account) = self.usernameTextField.rac_textSignal;
//    RAC(vModel ,password) = self.pwdTextField.rac_textSignal;
    [[RACSignal merge:@[self.usernameTextField.rac_textSignal, RACObserve(self.usernameTextField, text)]] subscribeNext:^(NSString* text){
         vModel.account = text;
    }];
    
    [[RACSignal merge:@[self.pwdTextField.rac_textSignal, RACObserve(self.pwdTextField, text)]] subscribeNext:^(NSString* text){
         vModel.password = text;
    }];

    self.dataSource = [[NSUserDefaults standardUserDefaults] objectForKey:@"accountInfo"];
    [self.tb reloadData];
    
   
    self.protocolTextView.attributedText = [NSAttributedString protocolIsSelect:self.isSelect ];
    
}



#pragma make 懒加载
-(UIView*)topBgView{
    if (!_topBgView) {
        _topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
        _topBgView.backgroundColor = COLOR(@"#206EEA");
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.topBgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(50,50 )];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

        maskLayer.frame = self.topBgView.bounds;

        maskLayer.path = maskPath.CGPath;

        self.topBgView.layer.mask = maskLayer;
    }
    return _topBgView;
}
-(UIImageView*)topImageView{
    if (!_topImageView) {
        _topImageView = [UIImageView new];
        _topImageView.image = IMG(@"icon_logo");
    }
    return _topImageView;
}
-(UILabel*)topTitleLabel{
    if (!_topTitleLabel) {
        _topTitleLabel = [UILabel new];
        _topTitleLabel.text = @"海关技术中心";
        _topTitleLabel.textColor = COLOR(@"#ffffff");
        _topTitleLabel.font = FONT(15);
        _topTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topTitleLabel;
}



-(UIView*)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView addShadowToView:[UIColor blackColor]];
        [_bgView.layer setCornerRadius:5];
    }
    return _bgView;
}
-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"登录";
        _titleLabel.textColor = COLOR(@"#206EEA");
        _titleLabel.font = FONT(25);
    }
    return _titleLabel;
}

-(UITextField*)usernameTextField{
    if (!_usernameTextField) {
        _usernameTextField = [UITextField new];
        _usernameTextField.font = FONT(15);
        _usernameTextField.placeholder = @"请输用户名";
        _usernameTextField.textColor = COLOR(@"#383838");
        _usernameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _usernameTextField.backgroundColor = COLOR(@"#F5F5F5");
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_username");
        [leftView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(leftView)
        .centerYEqualToView(leftView).widthIs(13).heightIs(16);
        _usernameTextField.leftView = leftView;
        
        _usernameTextField.leftViewMode = UITextFieldViewModeAlways;
        
        
        
        
        UIButton * rightBtn = [UIButton buttonWithTitie:@"" WithtextColor:nil WithBackColor:nil WithBackImage:nil WithImage:IMG(@"icon_down_arrow") WithFont:0 EventBlock:^(id  _Nonnull params) {
            if (self.dataSource.count > 0) {
                [self setShowList:!self.showList];
            }
            
        }];
        rightBtn.tag = 10001;
        rightBtn.frame = CGRectMake(0, 0, 40, 40);
        _usernameTextField.rightView = rightBtn;
        
        _usernameTextField.rightViewMode = UITextFieldViewModeAlways;
        
        _usernameTextField.delegate = self;
        @weakify(self);
        [[[_usernameTextField.rac_textSignal map:^id(NSString* value) {
            return @(value.length);
        }] filter:^BOOL(id value) {
            return [value intValue] > 11;
        }] subscribeNext:^(id x) {
            @strongify(self);
            self.usernameTextField.text = [self.usernameTextField.text substringToIndex:11];
        }];
        ViewRadius(_usernameTextField, 5);
        
    }
    return _usernameTextField;
}

-(UITextField*)pwdTextField{
    if (!_pwdTextField) {
        _pwdTextField = [UITextField new];
        _pwdTextField.font = FONT(15);
        _pwdTextField.placeholder = @"请输入密码";
        _pwdTextField.textColor = COLOR(@"#383838");
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.backgroundColor = COLOR(@"#F5F5F5");
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_pwd");
        [leftView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(leftView)
        .centerYEqualToView(leftView).widthIs(13).heightIs(16);
        
        _pwdTextField.leftView = leftView;
        
        _pwdTextField.leftViewMode = UITextFieldViewModeAlways;
//        ViewBorderRadius(_pwdTextField, 3, 1, COLOR(@"#C5C5C5"));
        @weakify(self);
        [[[_pwdTextField.rac_textSignal map:^id(NSString* value) {
            return @(value.length);
        }] filter:^BOOL(id value) {
            return [value intValue] > 25;
        }] subscribeNext:^(id x) {
            @strongify(self);
            self.pwdTextField.text = [self.pwdTextField.text substringToIndex:25];
        }];
        ViewRadius(_pwdTextField, 5);
    }
    return _pwdTextField;
}

-(UIButton*)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithTitie:@"登录" WithtextColor:COLOR(@"#ffffff") WithBackColor:COLOR(@"#206EEA") WithBackImage:nil WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
            if (!self.isSelect) {
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"请勾选阅读同意服务协议和政策隐私").wDisappelSecondSet(1).wStart();
                return ;
            }
            if (self.didChickEventBlock) {
                self.didChickEventBlock(@"0");
            }
        }];
        ViewRadius(_loginBtn, 5);
    }
    return _loginBtn;
}
-(UIButton*)forgetBtn{
    if (!_forgetBtn) {
        _forgetBtn = [UIButton buttonWithTitie:@"忘记密码?" WithtextColor:COLOR(@"#2A2A2A") WithBackColor:nil WithBackImage:nil WithImage:nil WithFont:15 EventBlock:^(id  _Nonnull params) {
            if (self.didChickEventBlock) {
                self.didChickEventBlock(@"XWMVVMRACRouter://NaviPush/xw_ForgetViewController");
            }
        }];
        
    }
    return _forgetBtn;
}
-(UIButton*)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithTitie:@"注册" WithtextColor:COLOR(@"#2A2A2A") WithBackColor:nil WithBackImage:nil WithImage:nil WithFont:15 EventBlock:^(id  _Nonnull params) {
            if (self.didChickEventBlock) {
                self.didChickEventBlock(@"XWMVVMRACRouter://NaviPush/xw_RegisterViewController");
            }
        }];
       
    }
    return _registerBtn;
}

-(UITableView*)tb{
    if (!_tb) {
        _tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tb.backgroundColor = [UIColor whiteColor];
        _tb.dataSource = self;
        _tb.delegate = self;
        [_tb registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _tb.bounces = NO;
        ViewBorderRadius(_tb, 5, 1, COLOR(@"#e5e5e5"));
    }
    return _tb;
}

-(UITextView*)protocolTextView{
    if (!_protocolTextView) {
        _protocolTextView = [UITextView new];
        
           _protocolTextView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor],
                                            NSUnderlineColorAttributeName: [UIColor lightGrayColor],
                                            NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
           
           _protocolTextView.delegate = self;
           _protocolTextView.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
           _protocolTextView.scrollEnabled = NO;
    }
    return _protocolTextView;
}
#pragma UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"agreement"]) {
        NSLog(@"服务协议---------------");
        if (self.didChickEventBlock) {
            self.didChickEventBlock(@"agreement");
        }
        return NO;
    } else if ([[URL scheme] isEqualToString:@"privacy"]) {
        NSLog(@"隐私条款---------------");
        if (self.didChickEventBlock) {
            self.didChickEventBlock(@"privacy");
        }
        return NO;
    }else if ([[URL scheme] isEqualToString:@"checkbox"]) {
        self.isSelect = !self.isSelect;
        self.protocolTextView.attributedText = [NSAttributedString protocolIsSelect:self.isSelect];
        return NO;
    }
    return YES;
}

#pragma UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self setShowList:NO];
}
#pragma marklistViewdataSource method and delegate method

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{

   return self.dataSource.count;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString*cellid=@"listviewid";

    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:cellid];

    if(cell==nil){

        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];

    }

    //文本标签

    cell.textLabel.text = self.dataSource[indexPath.row][@"account"];
    cell.backgroundColor = [UIColor clearColor];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

   return 40;

}

//当选择下拉列表中的一行时，设置文本框中的值，隐藏下拉列表

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   //NSLog(@"select");

//   textField.text = (NSString *)[listobjectAtIndex:indexPath.row];

//NSLog(@"1");

  //NSLog(@"textField.text=%@",textField.text);

    self.usernameTextField.text = self.dataSource[indexPath.row][@"account"];
    self.pwdTextField.text = self.dataSource[indexPath.row][@"pwd"];
    
   [self setShowList:NO];

}
-(BOOL)showList{//setShowList:No为隐藏，setShowList:Yes为显示

   return showList;

}

-(void)setShowList:(BOOL)b{

   showList=b;

    UIButton* btn = (UIButton*)[self viewWithTag:10001];
   NSLog(@"showlist is set ");

   if(showList){
       [self.usernameTextField resignFirstResponder];
       
       [btn setImage:IMG(@"icon_up_arrow") forState:UIControlStateNormal];
       CGFloat height = 200;
       if (self.dataSource.count < 5) {
           height = self.dataSource.count* 40;
       }
       self.tb.sd_layout.heightIs(height);
       
       
   }else {
       [btn setImage:IMG(@"icon_down_arrow") forState:UIControlStateNormal];
       self.tb.sd_layout.heightIs(0);
   }
    [self.tb updateLayout];

}


@end
