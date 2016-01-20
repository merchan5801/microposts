class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  　# プロフィールは任意力かつ300文字以内
  validates :profile , length: { maximum: 300 } 
  # 内容は任意入力かつ10文字以下
  validates :locate , length: { maximum: 10 } 
end
