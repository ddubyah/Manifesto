# ELF Manifesto #

A gem for creating file manifests from Mustache templates

## Usage ##

Run from the command line. Provide a template file and pass in a number of file globs ("*.jpg", or "images/*.*" for example). Each file collection returned from the each glob will be used to populate the given template. 