#!/usr/bin/env ruby -wKU
# encoding: UTF-8
require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

if ENV.key?('DIALOG') && !defined?(TM_DIALOG)
  TM_DIALOG = e_sh(ENV['DIALOG'])
end

# Some Handlebars snippets are triggered by typing a symbol within a double
# pair of braces. But if we implement them as simple snippets, we're unable
# to put the cursor after the closing brace pair, because those braces aren't
# part of the snippet.
#
# So instead, we implement them as commands that take the current line as
# input and insert the current line as a snippet. This requires escaping of
# input, but it works.
#
def snippet_inside_braces(opts)
  line, index, snippet = opts[:line], opts[:index], opts[:snippet]
  
  # Split the line into before/after cursor.
  line_parts = [
    line[0..index],
    line[(index + 1)...line.size]
  ]
  
  # Escape the parts for use in a snippet.
  line_parts.map! { |p| e_sn(p) }

  # Put the cursor after the closing braces.
  line_parts[1].gsub!(/^\}\}/, '}}$0')

  line_parts.join(snippet)
end

def show_popup(choices)
  TextMate::UI.complete(choices)
end
