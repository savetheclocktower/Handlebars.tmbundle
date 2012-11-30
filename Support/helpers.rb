#!/usr/bin/env ruby -wKU
# encoding: UTF-8
require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/plist'

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

# Show a completion popup.
#
# This is made possible by tm_dialog2, but we're not using the builtin Ruby
# library (TextMate::UI) because it's in an unreliable state. Its plist
# bundle doesn't work properly in recent versions of OS X; that's why we
# include our own in this bundle. And about half of the TextMate::UI
# methods use a version of the tm_dialog2 command syntax that is no longer
# supported.
#
def show_popup(choices)
  # Fail silently when we can't find tm_dialog2.
  return unless defined?(TM_DIALOG)
  
  unless choices[0].is_a?(Hash)
    choices.map! { |c| { 'display' => c.to_s } }
  end
  
  command = %Q{#{TM_DIALOG} popup --suggestions #{e_sh choices.to_plist}}
  `#{command}`
end