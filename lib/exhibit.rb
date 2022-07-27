class Exhibit
  attr_reader :name, :cost

  def initialize(params)
    @name = params[:name]
    @cost = params[:cost]
  end
end
