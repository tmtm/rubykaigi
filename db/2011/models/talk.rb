require File.join(File.dirname(__FILE__), "yaml_loader")

class Talk < OpenStruct
  extend YamlLoader

  base_dir File.join(File.dirname(__FILE__), "../talks/")
  # base_dir Rails.root.join("db/2011/talks")

  def talks
    @talks ||= talk_ids ? talk_ids.map {|id| Talk.get(id) } : []
  end

  def to_hash
    hash = @table.dup
    
    if talk_ids
      hash.delete(:talk_ids)
      hash[:talks] = talks.map(&:to_hash)
    end

    hash
  end

end
