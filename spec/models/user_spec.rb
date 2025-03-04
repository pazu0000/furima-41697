require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '全ての項目が入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        user = FactoryBot.build(:user) # Userのインスタンス生成
        user.nickname = '' # nicknameの値を空にする
        user.valid?
        expect(user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空では登録できない' do
        user = FactoryBot.build(:user) # Userのインスタンス生成
        user.email = '' # emailの値を空にする
        user.valid?
        expect(user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したメールアドレスは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスに@を含まない場合は登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが6文字未満では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it '英字のみのパスワードでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end
      it '数字のみのパスワードは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'abc１２３'
        @user.password_confirmation = 'abc１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end
      it 'パスワードとパスワード（確認用）が不一致だと登録できない' do
        @user.password_confirmation = 'differentpassword'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '姓（全角）が空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '姓（全角）に半角文字が含まれていると登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name must be full-width characters')
      end
      it '名（全角）に半角文字が含まれていると登録できない' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name must be full-width characters')
      end
      it '名（全角）が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '姓（カナ）が空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it '名（カナ）が空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it '姓（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.last_name_kana = 'たなか' # 平仮名
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana must be in full-width Katakana')

        @user.last_name_kana = '田中' # 漢字
        expect(@user).to be_invalid
        expect(@user.errors.full_messages).to include('Last name kana must be in full-width Katakana')

        @user.last_name_kana = 'Tanaka' # 英字
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana must be in full-width Katakana')

        @user.last_name_kana = '123' # 数字
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana must be in full-width Katakana')

        @user.last_name_kana = '@#!' # 記号
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana must be in full-width Katakana')
      end

      it '名（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.first_name_kana = 'たろう' # 平仮名
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana must be in full-width Katakana')

        @user.first_name_kana = '太郎' # 漢字
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana must be in full-width Katakana')

        @user.first_name_kana = 'Taro' # 英字
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana must be in full-width Katakana')

        @user.first_name_kana = '123' # 数字
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana must be in full-width Katakana')

        @user.first_name_kana = '@#!' # 記号
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana must be in full-width Katakana')
      end
      it '生年月日が空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
