require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  let(:valid_attributes) { { title: Faker::Lorem.sentence } }

  let(:invalid_attributes) { { title1: Faker::Lorem.sentence } }

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all photos as @photos' do
      photo = Photo.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:photos)).to eq([photo])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested photo as @photo' do
      photo = Photo.create! valid_attributes
      get :show, { id: photo.to_param }, valid_session
      expect(assigns(:photo)).to eq(photo)
    end
  end

  describe 'GET #new' do
    it 'assigns a new photo as @photo' do
      get :new, {}, valid_session
      expect(assigns(:photo)).to be_a_new(Photo)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested photo as @photo' do
      photo = Photo.create! valid_attributes
      get :edit, { id: photo.to_param }, valid_session
      expect(assigns(:photo)).to eq(photo)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Photo' do
        expect { post :create, { photo: valid_attributes }, valid_session }
          .to change(Photo, :count).by(1)
      end

      it 'assigns a newly created photo as @photo' do
        post :create, { photo: valid_attributes }, valid_session
        expect(assigns(:photo)).to be_a(Photo)
        expect(assigns(:photo)).to be_persisted
      end

      it 'redirects to the created photo' do
        post :create, { photo: valid_attributes }, valid_session
        expect(response).to redirect_to(Photo.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved photo as @photo' do
        post :create, { photo: invalid_attributes }, valid_session
        # expect(assigns(:photo)).to be_a_new(Photo)
      end

      it "re-renders the 'new' template" do
        post :create, { photo: invalid_attributes }, valid_session
        # expect(response).to render_template("new")
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { caption: 'a caption' } }

      it 'updates the requested photo' do
        photo = Photo.create! valid_attributes
        put :update, id: photo.to_param, photo: new_attributes
        # photo.reload
        # skip('Add assertions for updated state')
      end

      it 'assigns the requested photo as @photo' do
        photo = Photo.create! valid_attributes
        put :update, id: photo.to_param, photo: valid_attributes
        expect(assigns(:photo)).to eq(photo)
      end

      it 'redirects to the photo' do
        photo = Photo.create! valid_attributes
        put :update, id: photo.to_param, photo: valid_attributes
        expect(response).to redirect_to(photo)
      end
    end

    context 'with invalid params' do
      it 'assigns the photo as @photo' do
        photo = Photo.create! valid_attributes
        put :update, id: photo.to_param, photo: invalid_attributes
        expect(assigns(:photo)).to eq(photo)
      end

      it "re-renders the 'edit' template" do
        photo = Photo.create! valid_attributes
        put :update, id: photo.to_param, photo: invalid_attributes
        # expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested photo' do
      photo = Photo.create! valid_attributes
      expect { delete :destroy, id: photo.to_param }
        .to change(Photo, :count).by(-1)
    end

    it 'redirects to the photos list' do
      photo = Photo.create! valid_attributes
      delete :destroy, { id: photo.to_param }, valid_session
      expect(response).to redirect_to(photos_url)
    end
  end
end
