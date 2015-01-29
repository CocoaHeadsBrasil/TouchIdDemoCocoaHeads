//
//  LoginViewController.m
//  cocoaheadstouchid
//
//  Created by José Lino on 26/11/14.
//  Copyright (c) 2014 Construtor Sistemas. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *mensagemButton;
@property (weak, nonatomic) IBOutlet UILabel *mensagemErroLabel;

@end

@implementation LoginViewController

#define USUARIO_LOGADO_SEGUE @"logarSegue"

- (IBAction)mensagemButtonTouch:(UIButton *)sender {
    [self autenticar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self autenticar];
}

-(void)autenticar
{
    // Verificar se existe suporte touchid
    LAContext *contextoAutenticacaoLocal = [[LAContext alloc] init];
    
    if ([contextoAutenticacaoLocal canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]){
        [contextoAutenticacaoLocal evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Demo #CocoaHeadsBR" reply:^(BOOL success, NSError *error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:USUARIO_LOGADO_SEGUE sender:self];
                });
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.mensagemErroLabel.text = error.localizedDescription;
                });
            }
        }];
    }
}

@end
