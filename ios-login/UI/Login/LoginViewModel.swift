import RxSwift
import RxCocoa

class LoginViewModel {
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    let loginService : LoginService

    public init(loginService : LoginService) {
          self.loginService = loginService
      }
      
    func login() {
        loginService.login(username: username.value, password: password.value)
    }
}
