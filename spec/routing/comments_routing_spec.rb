require 'rails_helper'

RSpec.describe CommentsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'posts/1/comments')
        .to route_to('comments#index', post_id: '1')
    end

    it 'routes to #new' do
      expect(get: 'posts/1/comments/new')
        .to route_to('comments#new', post_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/comments/1').to route_to('comments#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/comments/1/edit').to route_to('comments#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/posts/1/comments')
        .to route_to(controller: 'comments', action: 'create', post_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/comments/1').to route_to('comments#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/comments/1').to route_to('comments#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/posts/1/comments/1')
        .to route_to(
          action: 'destroy', controller: 'comments', post_id: '1', id: '1'
        )
    end
  end
end
