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

  def ticket_lottery_contestants(exhibit)
    patrons_by_exhibit_interest[exhibit.name].select do |patron|
      patron.spending_money < exhibit.cost
    end
  end

  def draw_lottery_winner(exhibit)
    ticket_lottery_contestants(exhibit).sample&.name
  end
end
