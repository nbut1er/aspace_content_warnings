require 'db/migrations/utils'

Sequel.migration do

  up do
    $stderr.puts("Making changes to the content warnings for Cambridge")

    add_values_to_enum("content_warning_code", ["cw_warning", "cw_description", "cw_sensitivity"])
    cw_id = self[:enumeration].filter(:name => "content_warning_code").select(:id)
    ["cw_racism", "cw_hate", "cw_adult"].each { |code|
      self[:enumeration_value].filter(:enumeration_id => cw_id).where(:value => code).update(:suppressed => 1)
    }
  end
end
