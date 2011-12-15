# ELF Manifesto #

A gem for creating file manifests from Mustache templates

## Usage ##

Run from the command line. Provide a template file and pass in a number of file globs ("*.jpg", or "images/*.*" for example). Each file collection returned from the each glob will be used to populate the given template. 

e.g.

> manifesto create template_file.mustache '*.*' '*.jpg' 'pages/*.html'

('create' is the default command so you can leave it out if you like. 'manifesto template_filed.mustache '*.*' '*.jpg' 'pages/*.html')
		
This will load the file 'template_file.mustache' and treat it as a [mustache][mustache] template. (Go [here][mustache] for more info). The file extension doesn't matter. I've used .mustache just to make the point.

At the end of the command you can provide any number of space delimited strings that will be evaluated as file globs and used to search the file system from your current location. In this example 

*		'*.*' returns paths to all files in the current directory
*	  '*.jpg' returns paths to all jpgs in the current directory
*	  'pages/*.html' returns paths to all html files in the pages directory

I'm sure you get the idea...

Each collection of paths are added to a numbered group and made available in the template. In our example, group1 corresponds to '*.*', group2 to '*.jpg' and so on. By referencing these groups in a mustache template you can build manifest files populated with all the file paths you need.

## Saving the manifest ##

The manifest is output to the console, so you can save it by copying or directing the output to a file.

> manifesto create template_file.mustache '*.*' '*.jpg' 'pages/*.html' > manifest.json

will render the template and save it in manifest.json.
 
---

# TODO #

*	Define output file path to save result
*	Supply sample templates
*	Support registration of new templates
*	Support arbitrary properties
*	Add some simple template helpers
	*	GUID creator

[mustache]: http://mustache.github.com/mustache.5.html