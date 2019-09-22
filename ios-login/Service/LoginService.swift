class LoginService {
    func login(username: String, password: String){
        APIManager.requestData(url: "loginUser?username=" + username + "&password=" + password, method: .get, parameters: nil, completion: { (result) in
        })
    }
}
