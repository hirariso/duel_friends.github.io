class User < ApplicationRecord
    has_secure_password

    validates :name,{presence: true}

#selfのテーブル内からnameカラムで入力した文字が含まれるものを取り出す
    def self.search(search)
        if search
            where("name LIKE ?","%#{search}%")
        else
            all
        end
    end

    
end
