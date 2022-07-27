require "./lib/exhibit"
require "./lib/patron"
require "./lib/museum"

RSpec.describe Museum do
  let(:dmns) { Museum.new("Denver Museum of Nature and Science") }
  let(:gems_and_minerals) { Exhibit.new({name: "Gems and Minerals", cost: 0}) }
  let(:dead_sea_scrolls) { Exhibit.new({name: "Dead Sea Scrolls", cost: 10}) }
  let(:imax) { Exhibit.new({name: "IMAX",cost: 15}) }
  let(:patron_1) { Patron.new("Bob", 0) }
  let(:patron_2) { Patron.new("Sally", 20) }
  let(:patron_3) { Patron.new("Johnny", 5) }

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

  it 'can admit new patrons and display by exhibit interest' do
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    patron_1.add_interest("Gems and Minerals")
    patron_1.add_interest("Dead Sea Scrolls")

    patron_2.add_interest("Dead Sea Scrolls")

    patron_3.add_interest("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    expect(dmns.patrons).to eq([patron_1, patron_2, patron_3])
    expect(dmns.patrons_by_exhibit_interest).to eq({"Gems and Minerals" => [patron_1],
                                                    "Dead Sea Scrolls" => [patron_1, patron_2, patron_3],
                                                    "IMAX" => []})
  end

  it 'can draw lottery winner tickets' do
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    patron_1.add_interest("Gems and Minerals")
    patron_1.add_interest("Dead Sea Scrolls")

    patron_2.add_interest("Dead Sea Scrolls")

    patron_3.add_interest("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    expect(dmns.ticket_lottery_contestants(dead_sea_scrolls)).to eq([patron_1, patron_3])
  end
end
