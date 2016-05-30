require 'rails_helper'
require 'faker'

RSpec.describe UsersController, type: :controller do
  include Devise::TestHelpers

  let(:valid_attributes) do
    { email: Faker::Internet.email,
      password: Faker::Internet.password(6, 9),
      name: Faker::Internet.name,
      confirmed_at: Time.now
     }
  end

  let(:invalid_attributes) do
    { user:
      {
        email: Faker::Lorem.characters(10),
        password: Faker::Internet.password(10, 19)
      }
    }
  end

  let(:valid_session) { {} }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = FactoryGirl.create :user, :confirmed
    sign_in @user
  end

  describe 'GET #index' do
    it 'returns nothing until not logged in' do
      get :index
      expect(assigns(:users)).to eq nil
    end

    it 'returns all of the users' do
      get :index
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :show, { id: user.to_param }, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #new' do
    it 'assigns a new user as @user' do
      get :new, {}, valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :edit, { id: user.to_param }, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'assigns a newly created user as @user' do
        post :create, { user: valid_attributes }, valid_session
        expect(assigns(:user)).to be_a(User)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user as @user' do
        post :create, { user: invalid_attributes }, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, { user: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          email: 'admin@admin.com',
          password: 'password'
        }
      end

      it 'assigns the requested user as @user' do
        user = User.create! valid_attributes
        put :update, id: user.to_param, user: valid_attributes
        expect(assigns(:user)).to eq(user)
      end

      it 'redirects to the user' do
        user = User.create! valid_attributes
        put :update, id: user.to_param, user: valid_attributes
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid params' do
      it 'assigns the user as @user' do
        user = User.create! valid_attributes
        put :update, id: user.to_param, user: invalid_attributes
        expect(assigns(:user)).to eq(user)
      end
    end
  end
end
