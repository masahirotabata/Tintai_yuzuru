require 'rails_helper'

RSpec.describe Customer, type: :model do

  it "名前とメールアドレスとパスワードがあれば登録できる" do 
    expect(Customer.create(email: "hoge@gmail.com", password: "hogehoge")).to be_valid
  end 

  it "名前がなければ登録できない" do 
    expect(Customer.new(last_name: nil)).to_not be_valid 
  end 

  it "メールアドレスがなければ登録できない" do 
    expect(Customer.new(email: "")).to_not be_valid 
  end 

  it "メールアドレスが重複していたら登録できない" do 
    customer1 = Customer.create(last_name: "taro", email: "taro@example.com", password: "hogehoge")
    expect(Customer.new(last_name: "ziro", email: customer1.email, password: "hogehoge")).to_not be_valid
  end 

  it "パスワードがなければ登録できない" do 
    expect(Customer.new(email: "taro@example.com", password: nil)).to_not be_valid 
  end 

  it "password_confirmationとpasswordが異なる場合保存できない" do 
    expect(Customer.new(password:"password",password_confirmation: "passward")).to_not be_valid 
  end 

end
