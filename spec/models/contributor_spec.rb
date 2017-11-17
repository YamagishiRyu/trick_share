require 'rails_helper'

RSpec.describe Contributor, type: :model do
  
  # initial setting 
  before do 
    FactoryGirl.reload
    @contributor = FactoryGirl.create(:contributor)
  end

  context 'validation' do
    describe 'sample' do
      specify 'sample should be valid' do
	expect(@contributor.validate).to be true
      end
    end

    describe 'attributes' do
      specify 'email uniqueness' do
	@other_con = FactoryGirl.create(:contributor)
	@other_con.email = @contributor.email
	expect(@other_con.validate).to be false
      end

      specify 'email should be present' do
	@contributor.email = ""
	expect(@contributor.validate).to be false
      end

      specify 'nick_name should be present' do
	@contributor.nick_name = "  "
	expect(@contributor.validate).to be false
      end

      specify 'nick_name length should be less than 30' do
	@contributor.nick_name = "a" * 31
	expect(@contributor.validate).to be false
      end

      specify 'password should be present' do
	@contributor.password = @contributor.password_confirmation = ' ' * 7
	expect(@contributor.validate).to be false
      end

      specify 'password should be more than 6' do
	@contributor.password = @contributor.password_confirmation = ' ' * 5
	expect(@contributor.validate).to be false
      end
    end
  end
end
