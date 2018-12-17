require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have a valid factory' do
    user = FactoryBot.build(:user)
    expect(user.valid?).to eq(true)
  end
  
  context 'associations' do
    it { should have_many(:tasks_users).dependent(:destroy) }
    it { should have_many(:tasks) }
    it { should have_many(:task_results).dependent(:destroy) }
  end
  
  context 'validations' do
    context 'fields' do
      subject { FactoryBot.build(:user, password: nil) }
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
      it { should validate_presence_of(:password) }
      it { should validate_confirmation_of(:password) }
      it { should validate_length_of(:password).is_at_least(6) }
      it 'should validate format of :password' do
        # Only digits
        password = '12345678'
        user = FactoryBot.build(:user, password: password, password_confirmation: password)
        expect(user.valid?).to eq(true)
        
        # Only lowercase letters
        password = 'abcdefgh'
        user = FactoryBot.build(:user, password: password, password_confirmation: password)
        expect(user.valid?).to eq(false)
        expect(user.errors.full_messages.first).to eq('Password must contain at least eight characters and one number or symbol')
        
        # Only uppercase letters
        password = 'ABCDEFGH'
        user = FactoryBot.build(:user, password: password, password_confirmation: password)
        expect(user.valid?).to eq(false)
        expect(user.errors.full_messages.first).to eq('Password must contain at least eight characters and one number or symbol')
        
        # Only digits and lowercase letters
        password = '1234abcd'
        user = FactoryBot.build(:user, password: password, password_confirmation: password)
        expect(user.valid?).to eq(true)
        
        # Only digits and uppercase letters
        password = '1234ABCD'
        user = FactoryBot.build(:user, password: password, password_confirmation: password)
        expect(user.valid?).to eq(true)
        
        # Uppercase and lowercase letters
        password = 'ABCDefgh'
        user = FactoryBot.build(:user, password: password, password_confirmation: password)
        expect(user.valid?).to eq(false)
        expect(user.errors.full_messages.first).to eq('Password must contain at least eight characters and one number or symbol')
        
        # Digits, lowercase and uppercase letters
        password = '1234ABcd'
        user = FactoryBot.build(:user, password: password, password_confirmation: password)
        expect(user.valid?).to eq(true)
        
        # Letters and symbols
        password = 'abcdefg!'
        user = FactoryBot.build(:user, password: password, password_confirmation: password)
        expect(user.valid?).to eq(true)
      end
      it { should validate_presence_of(:role) }
    end
  end
end
