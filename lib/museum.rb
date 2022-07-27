class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    exhibits.select do |exhibit|
      patron.interests.include?(exhibit.name)
    end
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    output = {}
    exhibits.each do |exhibit|
      output[exhibit.name] = []
    end
    patrons.each do |patron|
      patron.interests.each do |interest|
        output[interest] << patron
      end
    end
    output
  end


end
