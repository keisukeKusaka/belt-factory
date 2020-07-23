require 'rails_helper'

describe User do
  describe '#create' do

    #1
    it "name, number, password, department_idが存在すれば登録できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    #2
    it "nameが無い場合は登録できない" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    #3
    it "numberが無い場合は登録できない" do
      user = build(:user, number: nil)
      user.valid?
      expect(user.errors[:number]).to include("can't be blank")
    end

    #4
    it "passwordが無い場合は登録できない" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    #5
    it "department_idが無い場合は登録できない" do
      user = build(:user, department_id: nil)
      user.valid?
      expect(user.errors[:department]).to include("must exist")
    end

    #6
    # it "numberが5桁以下の場合は登録できない" do
    #   user = build(:user, number: "12345")
    #   user.valid?
    #   expect(user.errors[:number]).to include("is the wrong length (should be 6 characters)")
    # end

    #7
    # it "numberが7桁以上の場合は登録できない" do
    #   user = build(:user, number: "1234567")
    #   user.valid?
    #   expect(user.errors[:number]).to include("is the wrong length (should be 6 characters)")
    # end
    # numberに文字数のバリデーションを追加する事

    #8
    it "重複したnumberのuserが既に存在している場合は登録できない" do
      user = create(:user)
      another_user = build(:user, number: user.number)
      another_user.valid?
      expect(another_user.errors[:number]).to include("has already been taken")
    end

    #9
    it "passwordが5文字以下の場合は登録できない" do
      user = build(:user, password: "12345")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    #10
    # it "numberに数字以外が含まれている場合は登録できない" do
    #   user = build(:user, number: "test12")
    #   user.valid?
    #   expect(user)
    # end
    # numberに数値のみを受け付けるバリデーションを追加する事

    #11
    # it "passwordに英字と数字の両方が含まれていない場合は登録できない" do
    #   user = build(:user, password: "123456")
    #   user.valid?
    #   expect(user)
    # end
    # passwordに英字と数字の両方を要するバリデーションを追加する事
  end
end
