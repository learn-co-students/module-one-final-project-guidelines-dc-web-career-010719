require 'ostruct'
require_relative "./connection_adapter"

DBRegistry ||= OpenStruct.new("test" => ConnectionAdapter.new("db/test.db"),
  "development" => ConnectionAdapter.new("db/development.db")
  )
