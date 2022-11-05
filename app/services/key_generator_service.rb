class KeyGeneratorService < ApplicationService
  attr_accessor :length,
                :format,
                :format_klass,
                :last_base_index

  DEFAULT_LENGHT = 7
  FORMATS = { base58: Base58 }
  INDEX2VALUES = { base58: BASE58_INDEX2VALUE_MAPPING }

  def initialize(format: :base58, length: DEFAULT_LENGHT)
    @id_str = ''
    @length = length
    @format_klass = FORMATS[format]
    @index_value = INDEX2VALUES[format]
    @last_base_index = Base58::BASE - 1
  end

  def call
    @length.times.each do
      index = SecureRandom.random_number(0..@last_base_index)
      @id_str.concat(@index_value[index])
    end
    [@id_str, @format_klass.decode(@id_str)]
  end
end
