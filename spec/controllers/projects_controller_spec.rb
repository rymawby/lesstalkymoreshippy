require 'spec_helper'

describe ProjectsController do

	describe "POST create" do

		context "with valid attributes" do
			
			it "redirects to project page on creation" do
				post :create, project: FactoryGirl.attributes_for(:project)
				response.should redirect_to Project.last
			end

			
		end

	end

end
