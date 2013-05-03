#jsonselect-cli

 [![Build Status](https://api.travis-ci.org/nodayoshikazu/jsonselect-cli.png)](http://travis-ci.org/nodayoshikazu/jsonselect-cli)


#Installation
 
    > npm install
    > make build


#Testing

 To run the tests:

    > make test

    or

    > npm test


#Usage

    Usage: index.js <selector> [-f infile] [-o outfile]

    Options:

    -h, --help              output usage information
    -?                      output usage information
    -V, --version           output the version number
    -f, --file <infile>     JSON file
    -o, --output <outfile>  JSON file

#Examples

  Sample input JSON

    {
      "name": {
        "first": "Lloyd",
        "last": "Hilaiel"
      },
      "favoriteColor": "yellow",
      "languagesSpoken": [
        {
          "lang": "Bulgarian",
          "level": "advanced"
        },
        {
          "lang": "English",
          "level": "native",
          "preferred": true
        },
        {
          "lang": "Spanish",
          "level": "beginner"
        }
      ],
      "seatingPreference": [
        "window",
        "aisle"
      ],
      "drinkPreference": [
        "whiskey",
        "beer",
        "wine"
      ],
      "weight": 172
    }

  Results
  
    $ node lib/index.js ":root" < test/sample1.json
    [{"name":{"first":"Lloyd","last":"Hilaiel"},"favoriteColor":"yellow","languagesSpoken":[{"lang":"Bulgarian","level":"advanced"},{"lang":"English","level":"native","preferred":true},{"lang":"Spanish","level":"beginner"}],"seatingPreference":["window","aisle"],"drinkPreference":["whiskey","beer","wine"],"weight":172}]
    
    $ node lib/index.js ":root" -f test/sample1.json
    [{"name":{"first":"Lloyd","last":"Hilaiel"},"favoriteColor":"yellow","languagesSpoken":[{"lang":"Bulgarian","level":"advanced"},{"lang":"English","level":"native","preferred":true},{"lang":"Spanish","level":"beginner"}],"seatingPreference":["window","aisle"],"drinkPreference":["whiskey","beer","wine"],"weight":172}]
    
    $ node lib/index.js ":root" -f test/sample1.json -o test/root-out.obj
    
    $ node lib/index.js ".languagesSpoken .lang" -f test/sample1.json
    ["Bulgarian","English","Spanish"]
    
    $ node lib/index.js ".drinkPreference :first-child" -f test/sample1.json
    ["whiskey"]
    
    $ node lib/index.js ".seatingPreference :nth-child(1)" -f test/sample1.json
    ["window"]
    
    $ node lib/index.js ".weight" -f test/sample1.json
    [172]
    
    $ node lib/index.js ".lang" -f test/sample1.json
    ["Bulgarian","English","Spanish"]
    
    $ node lib/index.js ".favoriteColor" -f test/sample1.json
    ["yellow"]
    
    $ node lib/index.js "string.favoriteColor" -f test/sample1.json
    ["yellow"]
    
    $ node lib/index.js "string:last-child" -f test/sample1.json
    ["aisle","wine"]
    
    $ node lib/index.js "string:nth-child(-n+2)" -f test/sample1.json
    ["window","aisle","whiskey","beer"]
    
    $ node lib/index.js "string:nth-child(odd)" -f test/sample1.json
    ["window","whiskey","wine"]
    
    $ node lib/index.js "string:nth-last-child(1)" -f test/sample1.json
    ["aisle","wine"]
    
    $ node lib/index.js ":root" -f test/sample1.json
    [{"name":{"first":"Lloyd","last":"Hilaiel"},"favoriteColor":"yellow","languagesSpoken":[{"lang":"Bulgarian","level":"advanced"},{"lang":"English","level":"native","preferred":true},{"lang":"Spanish","level":"beginner"}],"seatingPreference":["window","aisle"],"drinkPreference":["whiskey","beer","wine"],"weight":172}]
    
    $ node lib/index.js "number" -f test/sample1.json
    [172]
    
    $ node lib/index.js ":has(:root > .preferred)" -f test/sample1.json
    [{"lang":"English","level":"native","preferred":true}]
    
    $ node lib/index.js ".preferred ~ .lang" -f test/sample1.json
    ["English"]
    
    $ node lib/index.js ":has(.lang:val(\"Spanish\")) > .level" -f test/sample1.json
    ["beginner"]
    
    $ node lib/index.js ".lang:val(\"Bulgarian\") ~ .level" -f test/sample1.json
    ["advanced"]
    
    $ node lib/index.js ".weight:expr(x<180) ~ .name .first" -f test/sample1.json
    ["Lloyd"]





#License 

(The MIT License)

Copyright (c) 2013 Noda Yoshikazu &lt;noda.yoshikazu@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
