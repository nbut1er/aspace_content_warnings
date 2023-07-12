require 'db/migrations/utils'

Sequel.migration do

  up do
    $stderr.puts("Making changes to the content warnings for Cambridge")

    add_values_to_enum("content_warning_code", ["cw_warning", "cw_description", "cw_sensitivity"])
    cw_id = self[:enumeration].filter(:name => "content_warning_code").select(:id)
    for code in ["cw_racism", "cw_hate", "cw_adult"] do
      self[:enumeration_value].where(:value => code).update(:suppressed => 1)
    end
  end
end
