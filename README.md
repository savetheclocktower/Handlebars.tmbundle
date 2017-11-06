
# TextMate bundle for Handlebars

A bundle for [Handlebars][], the templating language. Modified heavily from [the original][drnic].

Built for [TextMate 2][textmate]; I'm not sure it will work at all in TextMate 1.x.

## New features

### Indentation rules, code folding

TextMate will know to indent lines inside block helpers, conditionals, and the like, and can also fold these constructs.

### Snippets

The bundle offers a couple of useful snippets for completing Handlebars tags. **When the cursor sits between two nested sets of braces (`{{}}`), certain keys will trigger snippets:**

#### Block helper snippet

Pressing <kbd>#</kbd> inside the braces triggers a block helper snippet like so:

![block helper snippet animation](http://i.imgur.com/9U742.gif)

The closing tag is automatically generated, and fills in the name of the function as you type; from there you can <kbd>TAB</kbd> into the area between the opening tag and the closing tag. Hitting <kbd>Return</kbd> will move you to a new line and indent the block as you expect.

#### Include partial snippet

Pressing <kbd>&gt;</kbd> inside the braces triggers an include-partial snippet like so:

![include-partial snippet animation](http://i.imgur.com/vdfF8.gif)

If the bundle knows where your templates are, the snippet can offer a list of possible completions for the partial name. If not, it won't offer any completions, but the rest of the snippet will work just fine. (See [Configuration][] below.)

### Open partial

When the cursor is inside the name of a partial (e.g., the "authorMeta" part of `{{> authorMeta}}`), pressing <kbd>Enter</kbd> (or <kbd>fn</kbd> + <kbd>Return</kbd> on laptop keyboards) will attempt to open that partial for editing.

If the bundle knows where your templates are, it can search all possible template locations, and open the first one it finds. If it doesn't, it'll look within the directory of the original file. (See [Configuration][] below.)

### Open helper

Similarly, when the cursor is inside the name of a helper (e.g., the `prune` part of `{{prune text 30}}`, or the `#list` part of `{{#list Foo}}…{{/list}}`), pressing <kbd>Enter</kbd> (<kbd>fn</kbd> + <kbd>Return</kbd>) will attempt to open that partial for editing.

This presumes that each helper has its own file, and that the file has the same name as the helper. (In the examples above, the command will look for `prune.js` and `list.js`, respectively.) If the bundle knows where your helpers are, it will search those folders for files of that name; otherwise it will do nothing. (See [Configuration][] below.)

### String scope injections

The annoying thing about HTML templating languages in TextMate 1 was that they couldn't pick up on stuff like this…

![example without injection grammar](http://i.imgur.com/Cv6J1.png)

…unless you felt like writing a bunch of rules to override the patterns in the HTML grammar.

TextMate 2 fixes this, to an extent, with [injections][]. Injections allow a bundle to add its own patterns into a scope captured by another bundle. So we can add some patterns that match only inside HTML strings, like so:

![example with injection grammar](http://i.imgur.com/pD2jW.png)

We don't inject the whole Handlebars grammar into strings, because it's likely you don't want the full range of syntax highlighting inside strings. Handlebars directives inside HTML strings have the scope name `meta.embedded.directive.handlebars`, and many themes have a style for the `meta.embedded` scope. If yours doesn't, consider adding it.

## Configuration

Certain features of the Handlebars bundle can be configured through environment variables; these are typically defined in a folder's `.tm_properties` file, like so:

    TM_HANDLEBARS_HELPERS_GLOB   = "${CWD}/helpers/*.js"
    TM_HANDLEBARS_TEMPLATES_GLOB = "${CWD}/templates/*.hbs"

These variables use [shell glob syntax][] (as interpreted by Ruby).
    
* `TM_HANDLEBARS_HELPERS_GLOB`: A glob that describes all the files that contain Handlebars helpers. Necessary for the "Open Helper" command.
* `TM_HANDLEBARS_TEMPLATES_GLOB`: A glob that describes all the template files defined in this project. Necessary for the "Open Partial" command, and for the name completion in the "Insert Partial" snippet.

## Dialog

The completion help requires that `tm_dialog2` is installed. To figure out if it's working correctly for you, type into an empty TextMate document...

    "$DIALOG" help
    
...then press <kbd>Ctrl</kbd> + <kbd>R</kbd> to execute the current line. If you see a list of registered commands, then `tm_dialog2` is installed and working; if you get an error, it means that the Dialog plugin is not installed correctly.

If it isn't working, check both `/Library/Application Support/TextMate/PlugIns` and `~/Library/Application Support/TextMate/PlugIns` and check for old versions of `Dialog.tmplugin` or `Dialog2.tmplugin`. If you find any, remove them.

## Grammars

The bundle comes with two grammars. If all you want is to use Handlebars with HTML, choose the **HTML (Handlebars)** grammar  (`text.html.handlebars`) and be done with it.

The **Handlebars** grammar (`source.handlebars`) is meant to act as a "clean" implementation of the Handlebars grammar, containing only patterns for matching Handlebars syntax. It can be used in standalone fashion (if you want to highlight only Handlebars syntax and nothing else in the file), or you can reference it from a grammar of your own creation.
 
For example, if you wanted to create a grammar that would highlight handlebars syntax inside XML, it would look something like this:

    {
      patterns = (
        { include = 'source.handlebars'; },
        { include = 'text.xml'; },
      );
    }

Obviously you'd want to add stuff to it, but that's the basic idea. (Depending on the grammar, you might have to supplement this with injections; consult the `text.html.handlebars` grammar for guidance.)

## Screenshots

### Vibrant Ink Redux theme

![screenshot (Vibrant Ink Redux theme)](http://i.imgur.com/c3mZj.png)

### Mac Classic theme

![screenshot (Mac Classic theme)](http://i.imgur.com/zFJtN.png)

### Cobalt theme

![screenshot (Cobalt theme)](http://i.imgur.com/BcwY8.png)

## Installation

To install via Git:

    mkdir -p ~/Library/Application\ Support/TextMate/Pristine\ Copy/Bundles
    cd ~/Library/Application\ Support/TextMate/Pristine\ Copy/Bundles
    git clone git://github.com/savetheclocktower/Handlebars.tmbundle.git
    osascript -e 'tell app "TextMate" to reload bundles'
    
To view or fork the source, visit the [Handlebars.tmbundle project on GitHub][github].

[drnic]:      http://github.com/drnic/Handlebars.tmbundle
[github]:     http://github.com/savetheclocktower/Handlebars.tmbundle
[injections]: http://blog.macromates.com/2012/injection-grammars-project-variables/
[handlebars]: http://handlebarsjs.com
[textmate]:   https://github.com/textmate/textmate
[shell glob syntax]: http://ruby-doc.org/core-1.9.3/Dir.html#method-c-glob
[configuration]: #configuration



## License

(The MIT License)

Copyright (c) 2010 Dr Nic Williams, drnicwilliams@gmail.com  
Copyright (c) 2012 Andrew Dupont,   mit@andrewdupont.net

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


