
# TextMate bundle for Handlebars

A bundle for [Handlebars][], the templating language. Modified heavily from [the original][drnic].

Built for [TextMate 2][textmate]; I'm not sure it will work at all in TextMate 1.x.

## New features

### Indentation rules, code folding

TextMate will know to indent lines inside block functions, conditionals and the like, and can also fold these constructs.

### Smart completion

When the cursor sits between two nested sets of braces (`{{}}`), pressing `#` triggers a block function snippet like so:

![smart completion animation](http://i.imgur.com/mfl9z.gif)

The closing tag is automatically generated, and fills in the name of the function as you type; from there you can <kbd>TAB</kbd> into the area between the opening tag and the closing tag. Hitting <kbd>Return</kbd> will move you to a new line and indent the block as you expect.

### Follow partials

When the cursor is inside the name of a partial (e.g., the "authorMeta" part of `{{> authorMeta}}`), pressing <kbd>Enter</kbd> (<kbd>fn</kbd> + <kbd>Return</kbd> on laptop keyboards) will attempt to open that partial for editing. (Right now, this only works if the partial is in the same directory as the first file and has the same extension, but I might make this more robust in the future.)

### String scope injections

The annoying thing about HTML templating languages in TextMate 1 was that they couldn't pick up on stuff like this…

![Example without injection grammar](http://i.imgur.com/Cv6J1.png)

…unless you felt like writing a bunch of rules to override the patterns in the HTML grammar.

TextMate 2 fixes this, to an extent, with [injections][]. Injections allow a bundle to add its own patterns into a scope captured by another bundle. So we can add some patterns that match only inside HTML strings, like so:

![Example with injection grammar](http://i.imgur.com/pD2jW.png)

We don't inject the whole Handlebars grammar into strings, because it's likely you don't want the full range of syntax highlighting inside strings. Handlebars directives inside HTML strings have the scope name `meta.embedded.directive.handlebars`, and many themes have a style for the `meta.embedded` scope. If yours doesn't, consider adding it.

## Grammars

The bundle comes with two grammars. If all you want is to use Handlebars with HTML, choose the **HTML (Handlebars)** grammar  (`text.html.handlebars`) and be done with it.

The **Handlebars** grammar (`source.handlebars`) is meant to act as a "clean" implementation of the Handlebars grammar, containing only patterns for matching Handlebars syntax. It can be used in standalone fashion (if you want to highlight only Handlebars syntax and nothing else in the file), or you can reference it from a grammar of your own creation.
 
For example, if you wanted to create a grammar that would highlight handlebars syntax inside XML, it would look something like this:

    {
      patterns = (
        { include = 'source.handlebars'; },
        { include = 'text.html.textile'; },
      );
    }
    
Obviously you'd want to add stuff to it, but that's the basic idea. (Depending on the grammar, you might have to supplement this with injections; consult the `text.html.handlebars` grammar for guidance.)

## Screenshots

### Vibrant Ink Redux theme

![Screenshot (Vibrant Ink Redux theme)](http://i.imgur.com/c3mZj.png)

### Mac Classic theme

![Screenshot (Mac Classic theme)](http://i.imgur.com/zFJtN.png)

### Cobalt theme

![Screenshot (Cobalt theme)](http://i.imgur.com/BcwY8.png)

## Installation

To install via Git:

    mkdir -p ~/Library/Application\ Support/TextMate/Bundles
    cd ~/Library/Application\ Support/TextMate/Bundles
    git clone git://github.com/drnic/Handlebars.tmbundle.git
    osascript -e 'tell app "TextMate" to reload bundles'
    
To view or fork the source, visit the [Handlebars.tmbundle project on GitHub][github].

[drnic]:      http://github.com/drnic/Handlebars.tmbundle
[github]:     http://github.com/savetheclocktower/Handlebars.tmbundle
[injections]: http://blog.macromates.com/2012/injection-grammars-project-variables/
[handlebars]: http://handlebarsjs.com
[textmate]:   https://github.com/textmate/textmate


## License

(The MIT License)

Copyright (c) 2010 Dr Nic Williams, drnicwilliams@gmail.com

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


