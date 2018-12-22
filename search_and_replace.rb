FILLER_CHAR = "ƾ"

def search_and_replace(pattern, replacements)
  # replace all double-curly-braces with a special character
  escapes = pattern.scan(/{{2,}/)

  escapes.each do |escape|
    if escape.length.even?
      replacement_chars = FILLER_CHAR * (escape.length / 2)
      pattern = pattern.gsub(escape, replacement_chars)
    else
      replacement_chars = FILLER_CHAR * (escape.length / 2)
      pattern = pattern.gsub(escape, replacement_chars + "{")
    end
  end

  occurences = pattern.scan(/{\d}/)

  occurences.each do |occurence|
    occurence_index = occurence.gsub(/[{}]/, "").to_i
    replacement_text = replacements[occurence_index]
    pattern = pattern.gsub(occurence, replacement_text)
  end
  pattern.gsub(FILLER_CHAR, "{")
end
