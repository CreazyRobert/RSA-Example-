//
//  REMainViewController.m
//  RSA Example
//
//  Created by JS Lim on 1/7/14.
//  Copyright (c) 2014 JS Lim. All rights reserved.
//

#include "RSA.h"

#import "REMainViewController.h"

// the cipherText is encrypted from plainText (83 characters) value
static NSString *plainText = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
static NSString *cipherText = @"bMUUisItkVcHeZsRbSrJ5TYOP+HwZWXuQ4T0PZ/5B9vTMpwbP/c4x378+5HefDQOM0WZh+6Lv46YvF28VdeMd2lkt5qE/tTGI7FXuPqwUebCSF7RrYAeICRnEa3ruMIo86WJxTglAF+Mf0zy/DmqM7NTEFVbF6xXBV72TWyMI8k=";

@interface REMainViewController ()

@property (nonatomic, strong) UITextView *inputTextView;
@property (nonatomic, strong) UITextView *plainTextView;
@property (nonatomic, strong) UITextView *cipherTextView;
@property (nonatomic, strong) UIButton *runButton;

@end

@implementation REMainViewController

@synthesize inputTextView = _inputTextView;
@synthesize plainTextView = _plainTextView;
@synthesize cipherTextView = _cipherTextView;
@synthesize runButton = _runButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"RSA Encryption/Decryption";
    
    CGRect frame = CGRectMake(20, 20, 280, 20);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.numberOfLines = 0;
    label.text = @"Input";
    [self.view addSubview:label];
    
    frame.origin.y += frame.size.height + 5;
    frame.size.height = 60;
    self.inputTextView = [[UITextView alloc] initWithFrame:frame];
    self.inputTextView.layer.borderWidth = 1.0f;
    self.inputTextView.text = plainText;
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    self.inputTextView.inputAccessoryView = toolBar;
    [self.view addSubview:self.inputTextView];
    
    frame.origin.y += frame.size.height + 20;
    frame.size.height = 20;
    label = [[UILabel alloc] initWithFrame:frame];
    label.numberOfLines = 0;
    label.text = @"Cipher text";
    [self.view addSubview:label];
    
    [self.view addSubview:label];
    frame.origin.y += frame.size.height + 5;
    frame.size.height = 100;
    self.cipherTextView = [[UITextView alloc] initWithFrame:frame];
    self.cipherTextView.editable = NO;
    self.cipherTextView.layer.borderWidth = 1.0f;
    [self.view addSubview:self.cipherTextView];
    
    frame.origin.y += frame.size.height + 20;
    frame.size.height = 20;
    label = [[UILabel alloc] initWithFrame:frame];
    label.numberOfLines = 0;
    label.text = @"Plain text";
    [self.view addSubview:label];
    
    frame.origin.y += frame.size.height + 5;
    frame.size.height = 60;
    self.plainTextView = [[UITextView alloc] initWithFrame:frame];
    self.plainTextView.editable = NO;
    self.plainTextView.layer.borderWidth = 1.0f;
    [self.view addSubview:self.plainTextView];
    
    frame.origin.y += frame.size.height + 20;
    frame.size.height = 40;
    frame.size.width = 100;
    frame.origin.x = 110;
    self.runButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.runButton.frame = frame;
    [self.runButton setTitle:@"Run" forState:UIControlStateNormal];
    [self.runButton addTarget:self action:@selector(runTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.runButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)decryptFromCipherText:(NSString *)cipher
{
    
    NSString *privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"pem"];
    NSLog(@"privateKeyPath: %@", privateKeyPath);
    
    char *plainText = js_private_decrypt([cipher UTF8String], [privateKeyPath UTF8String]);
    printf("Plain plain: %s\n", plainText);
    
    return [NSString stringWithUTF8String:plainText];
}

- (NSString *)encryptFromPlainText:(NSString *)plain
{
    
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"pem"];
    NSLog(@"publicKeyPath: %@", publicKeyPath);
    
    char *cipherText = js_public_encrypt([plain UTF8String], [publicKeyPath UTF8String]);
    printf("cipher : %s\n", cipherText);
    
    return [NSString stringWithUTF8String:cipherText];
}

- (NSString *)decryptWithPublicKeyFromCipherText:(NSString *)cipher
{
    
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"pem"];
    NSLog(@"privateKeyPath: %@", publicKeyPath);
    
//    char *plainText = js_private_decrypt([cipher UTF8String], [privateKeyPath UTF8String]);
    char *plainText = js_public_decrypt([cipher UTF8String], [publicKeyPath UTF8String]);
//    char *js_private_encrypt(const char *plain_text, const char *private_key_path); //私钥解密
//    char *js_public_decrypt(const char *cipher_text, const char *public_key_path); //公钥加密

    printf("Plain plain: %s\n", plainText);
    
    return [NSString stringWithUTF8String:plainText];
}

- (NSString *)encryptWithPrivateKeyFromPlainText:(NSString *)plain
{
    
    NSString *privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"pem"];
    NSLog(@"publicKeyPath: %@", privateKeyPath);
    
//    char *cipherText = js_public_encrypt([plain UTF8String], [publicKeyPath UTF8String]);
    char *cipherText = js_private_encrypt([plain UTF8String], [privateKeyPath UTF8String]);

    printf("cipher : %s\n", cipherText);
    
    return [NSString stringWithUTF8String:cipherText];
}

- (void)runTouched:(UIButton *)sender
{
//    self.cipherTextView.text = [self encryptFromPlainText:self.inputTextView.text];
//    self.plainTextView.text = [self decryptFromCipherText:self.cipherTextView.text];
//    self.cipherTextView.text = [self encryptWithPrivateKeyFromPlainText:self.inputTextView.text];
//    self.plainTextView.text = [self decryptWithPublicKeyFromCipherText:self.cipherTextView.text];
    
//    unsigned char *rsaPKCS1SignData(const unsigned char *src,int src_len,unsigned char *pri_key,int pri_key_len, int *dst_len)
    NSString *privateKeyString = @"-----BEGIN RSA PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALeacy2Aetnz0r+n\nBpW5FPlvuotaFpW1dMgdbYZ89Vb6DC0yaYVWHFhg7Eig8neEYIYx7VDwbLquLTk5\nk6Kpgzxxc2ZBw6ecIzJ+3XzJr1qnU1cfXZ1jDuVNsTZi1C8WwVfRQqEuAscxuUjH\n3vLIGl78JuOjHqP8bcxpIrY7Bn7BAgMBAAECgYAhOpW/1XHmgkdRIlSBwnZ2Um9L\niyltPOL+2Lyay4DHlgegInCQji4hHKGG34IieVXS07Rkoq669oz+v1nl5ZH3jwHB\noSuKgsH6AUM8Lnp0IxxnhV6irobhBvQyU6OxI4L03gvpZH3SDPPF+wI6kwk9zlTS\nO9QlHTZBMrRMiONL5QJBANtx5VaEtQGEoAYXN6EeQNlZS250gKZoKc5UNzcKmaCj\nPbGrcIc6DbG8uXTuqlJIyCxdDH3JQnShoaQewt1KNNMCQQDWMBwgVlROKSRvS1Jl\nLkHk7gKWd7ZXkH1XUkOHbg29r5ZQWiST5OERLnZFOonqskvywvFxIEP/KsIMUOlj\n/5GbAkBfabssjhDhcxfc7hVa8XuCxUd95BvXvqyGsKk9Plejt7ZoXMFVmpE/uW3t\ngKP/mPOoDmETBAHoEirk4Bcb/lrPAkEAjHhu6dJUZhJbf9YxSoRk2OQztET8xD7R\nxUQBX7+QqXePqFEGLixsYx1KmaqDqvWWE7dAK4YSsjVzoCosdtW0wwJBAKhrYUMG\nurSlwc1f34InbzF+IQEtTP9ewws0RxS3GpoYP60vb0aCGlKBJhWPhNeXBpnZLtqm\noFbfIV0UnxANcsA=\n-----END RSA PRIVATE KEY-----";
    
    NSString *publicKeyString = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC3mnMtgHrZ89K/pwaVuRT5b7qL\nWhaVtXTIHW2GfPVW+gwtMmmFVhxYYOxIoPJ3hGCGMe1Q8Gy6ri05OZOiqYM8cXNm\nQcOnnCMyft18ya9ap1NXH12dYw7lTbE2YtQvFsFX0UKhLgLHMblIx97yyBpe/Cbj\nox6j/G3MaSK2OwZ+wQIDAQAB\n-----END PUBLIC KEY-----";
//    char *charstring = js_privatekeyString_encrypt([@"刘hdgiuhsauighsiugheiherighehgbncbub杨" UTF8String], [privateKeyString UTF8String]);
//    
//    self.cipherTextView.text = [NSString stringWithUTF8String:charstring];
//    printf("%s",charstring);
//    char *js_privatestring_decrypt(const char *cipher_text, char *private_key_string)
//    char *js_publicstring_encrypt(const char *plain_text, char *public_key_string)
    char *charSting = js_publicstring_encrypt([@"刘hdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefhhdgiuhsauighsiugheiherighehgbncbubfasdfasdjfsadfhasuihfasiufhuiwhiufhweuifhweuifhweiufhweuifhwiuefh杨" UTF8String], [publicKeyString UTF8String]);
    
//    printf("%s",charSting);
    NSLog(@"%@",[NSString stringWithUTF8String:charSting]);
    
    char *decrypt = js_privatestring_decrypt(charSting,[privateKeyString UTF8String]);
//    printf("%s",decrypt);
    NSLog(@"%@",[NSString stringWithUTF8String:decrypt]);


    
    
    

    
    
}

- (void)doneTouched:(UIBarButtonItem *)sender
{
    [self.inputTextView resignFirstResponder];
}

@end
