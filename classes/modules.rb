
module Validation

  # this function reads config.txt line by line and checks whether language and
  # name entries exist. Will only return data if both entries exist.
  def verify_config(config)
    lang = ""
    name = ""
    f = File.open(config, "r") # opens config file
    # Entries in config file should be in the following format:
    # Ex: 'language: en\n'

    f.each_line do |line|
      # these variables return the first index of specified string
      lang_index = line =~ /language/ # regex search for language
      name_index = line =~ /name/ # regex search for name

      # if there's a match, then resulting data entry is captured
      if (lang_index != nil)
        lang = line[lang_index + 10..-2] # why + 10? Because 'language: ' is 10 chars
        # why -2? Because there's a newline char at end.
      elsif (name_index != nil)
        name = line[name_index + 6..-1]
      end

    end
    f.close

    # if either lang or name weren't found, the config file is invalid and is deleted
    # if both entries were found then returns their associated values
    if lang.empty? || name.empty?
      puts "Invalid config file found! Deleting #{config}..."
      puts "Archivo de configuración dañado! Borrar #{config}..."
      File.delete(config)
    else
      return lang, name
    end

  end
end


# helper mathematical functions
module Math

  def approx_percent(num, div)
    float = (num.to_f / div.to_f) * 100.0

    # crude way to inhibit percent from hitting 101%
    # if (float.round >= 101)
    #   float = 100
    # end

    return float

  end

  def convert_to_seconds(minutes)
    seconds = minutes * 60
    return seconds
  end

  # This function needs to be overhauled, but would allow a smaller progress bar.
  def convert_divpersec(minutes)
    seconds = convert_to_seconds(minutes)
    div_per_sec = seconds / 40
    return div_per_sec
  end
end
