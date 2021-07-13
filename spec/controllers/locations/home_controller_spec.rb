# frozen_string_literal: true

require 'spec_helper'

module Locations
  describe HomeController, type: :controller do
    routes { Locations::Engine.routes }

    let(:valid_session) { {} }

    describe 'GET #index' do
      render_views

      it 'location homepage is active in navbar' do
        get :index
        expect(response.body.include?('<li class="active"><a href="/locations/')).to eq true
      end
    end
  end
end
