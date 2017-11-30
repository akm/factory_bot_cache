RSpec.describe FactoryGirlCache do
  it "has a version number" do
    expect(FactoryGirlCache::VERSION).not_to be nil
  end

  class Identified
    attr_reader :id
    def initialize
      @@max_id ||= 0
      @id = @@max_id + 1
    end
  end

  describe :of do
    it do
      expect(FactoryGirl).to receive(:create).with("obj_1"){ Identified.new }.once
      r1 = FactoryGirlCache.of(:obj)[1]
      expect(r1).not_to be_nil
      r2 = FactoryGirlCache.of(:obj)[1]
      expect(r2).to eq r1
      expect(r2.id).to eq r1.id
      expect(r2.object_id).to eq r1.object_id
    end
  end

  describe :id_map_of do
    it do
      allow(FactoryGirl).to receive(:create).with(any_args){ Identified.new }
      map = {}
      (1..3).each do |orig_id|
        map[orig_id] = FactoryGirlCache.of(:obj)[orig_id]
      end
      map.each do |orig_id, obj|
        r = FactoryGirlCache.id_map_of(:obj)[orig_id]
        expect(r).to eq obj.id
      end
    end
  end

end
