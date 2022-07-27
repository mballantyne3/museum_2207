require "./lib/exhibit"
require "./lib/patron"
require "./lib/museum"

RSpec.describe Museum do
  let(:dmns) { Museum.new("Denver Museum of Nature and Science") }
  let(:gems_and_minerals) { Exhibit.new({name: "Gems and Minerals", cost: 0}) }
  let(:dead_sea_scrolls) { Exhibit.new({name: "Dead Sea Scrolls", cost: 10}) }
  let(:imax) { Exhibit.new({name: "IMAX",cost: 15}) }
  let(:patron_1) { Patron.new("Bob", 20) }
  let(:patron_2) { Patron.new("Sally", 20) }

  it 'exists' do

    expect(dmns).to be_instance_of(Museum)
    expect(dmns.name).to eq("Denver Museum of Nature and Science")
  end

  it 'can have exhibits' do
    expect(dmns.exhibits).to eq([])

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expect(dmns.exhibits).to eq([gems_and_minerals, dead_sea_scrolls, imax])
  end

  it 'can have patrons with interests' do
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")

    expect(dmns.recommend_exhibits(patron_1)).to eq([gems_and_minerals, dead_sea_scrolls])

    patron_2.add_interest("IMAX")

    expect(dmns.recommend_exhibits(patron_2)).to eq([imax])
  end
end
