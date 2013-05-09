#
#   index.coffee
#
#   jsonselect-cli
# ### Usage
# jsonselect <selector> [-f file] [-o file]
#
# ### Parameters
#
# selector - a css selector (see http://jsonselect.org/)
#
# ### Options
#
# -?, -h, --help print usage + help options
# -f, --file <filename> read JSON data from the file specified; if -f is omitted, use stdin
# -o, --output <filename> write the rendered result to the filename specified; if -o is omitted, use stdout#
#
#
#  Author: Noda Yoshikazu <noda.yoshikazu@gmail.com>
#  last update: May 3, 2013
# 
jsonselect = require('jsonselect')
_       = require('underscore')
should  = require('should')
program = require('commander')
fs      = require('fs')



module.exports = class Jsonselect_Cli
    args = null
    jsonIn = null
    jsonText = null
    
    #
    # Creates Jsonselect_Cli object
    # 
    constructor: (selectors, input, output) ->
        should.exist(selectors)
        @args = {}
        @args.selectors = selectors
        @args.input = if input then input else 'stdin'    # file path or 'stdin'
        @args.output = if output then output else 'stdout'

    #
    # Parses input JSON and applies the selector to the JSON object.
    # 
    run: () ->
        if @args.input isnt 'stdin'
            exist = fs.existsSync @args.input
            exist.should.be.true
            try
                @jsonIn  = JSON.parse(fs.readFileSync(@args.input))
            catch err
                console.log 'Error: malformed JSON'
                return -1
            @_apply()
        else
            process.stdin.resume()
            process.stdin.setEncoding('utf8')
            @jsonText = ''
            process.stdin.on 'data', (chunk) =>
                if not chunk.match /^[ \t\n]*$/g
                    try
                        @jsonText += chunk
                        
                    catch err
                        console.log 'Error: malformed JSON'
                        return -1
            process.stdin.on 'end', () =>
                @jsonIn = JSON.parse(@jsonText)                
                @_apply()

    #
    # Executes Jsonselect
    # 
    _apply: () ->    
        should.exist(@jsonIn)
        m = jsonselect.match(@args.selectors[0], @jsonIn)
        if @args.output is 'stdout'
            console.log JSON.stringify(m)
        else
            (@args.output.length > 0).should.be.true
            fs.writeFileSync(@args.output, JSON.stringify(m))
        return 0

# Run it
program
    .option('-?', 'output usage information')
    .version('0.0.1')
    .usage('<selector> [-f infile] [-o outfile]')
    .option('-f, --file <infile>', 'JSON file')
    .option('-o, --output <outfile>', 'JSON file')
    .parse(process.argv)

if program["?"] is true
    program.help()  # Exits process

jscli = new Jsonselect_Cli(program.args, program.file, program.output)
jscli.run()



