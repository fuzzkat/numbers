class NumbersController < ApplicationController
  def index
    @pager = NumberPager.new(params[:count], params[:page])
  end
end
