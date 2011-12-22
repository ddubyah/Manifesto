# ELF Manifesto #

A gem for creating file manifests from Mustache templates

## Usage ##

Run from the command line. Provide a template file and pass in a number of file globs ("*.jpg", or "images/*.*" for example). Each file collection returned from the each glob will be used to populate the given template. 

e.g.

`manifesto create template_file.mustache '*.*' '*.jpg' 'pages/*.html'`

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

`manifesto create template_file.mustache '*.*' '*.jpg' 'pages/*.html' > manifest.json`
will render the template and save it in manifest.json.

---

## Passing Arbitrary Properties ##

Use the --properties or -p switch to pass in a string to be evaluated as a property hash
 
`manifesto create template_file.mustache -p "{ :name => 'foo', :surname => 'bar' }" '*.*' '*.jpg' 'pages/*.html'`

will make the {{props.name}} and {{props.surname}} available in the template. (N.B. Ruby syntax for the hash)


---
## Built in templates ##

There are a few built in templates available. Use 

`manifesto list`

...to list them.

* simple.mustache - simple template for playing around and getting your globs right
* imsmanifest.xml.mustache - For creating SCORM manifests. If you don't know what they are then you don't need 'em :)

### Displaying a template ###

If you want to view a built in template you can use

`manifesto show template_name`

(you only need to use the start of the template name for the sake of brevity. So `manifesto show ims` would do the trick).

If you want to base your own templates on one of the built in ones then you can pipe it out to a file and then edit it.

`manifesto show template_name > my_template.mustache`

To use a built in template use the -s switch with the template name 

`manifesto -s ims "*.*"`

or just prefix the template name with an underscore

`manifesto -m ims "*.*"`

---
## Using config files ##

Typing long string representations of property hashes into the command line is 'orrible. So you can use config files instead. Like this one...

> {
> 	template: "_imsmanifest",
> 	globs: ["pages/**/*.html", "assets*/**/*.* ", "js/**/*.*"],
> 	props: {
> 		manifest_id:'com.learning.eh',
> 		org_id: 'ID72c02ada-df91-41ca-a440-15062a4683c0',
> 		package_name: 'Module 6',
> 	}
> }

* template: path to a template relative to the current working directory
* globs: array of file searches
* props: arbitrary properties to reference in the templates

To use a config file use the -c switch

`manifesto -c path_to_config.file`

N.B. Config files are evaluated as Ruby, just so you know

---
# TODO #

*	Support registration of new templates
*	Add some simple template helpers
	*	GUID creator
* Commander -h seems to fail on windows machines. Doh!

[mustache]: http://mustache.github.com/mustache.5.html