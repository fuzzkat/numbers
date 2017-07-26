Q1. Planning and Architecture
-----------------------------

### Methodology

I practice Extreme Programming (XP), usually supported by Kanban or
Scrum.

Obviously in the context of this recruitment exercise, a brief has been
provided, but that would usually be explored as part of the agile
methodology directly with the client.

Before starting a project of this sort, it's always worth checking if an
off the shelf solution exists that might be better value for the client.

I always "do the simplest thing that could possibly work" then get
feedback from the client, so the following might be a suitably fast
feedback loop.

-   Discuss the smallest tool that could deliver some value.
-   Perhaps a RESTful API consisting of;
    -   An endpoint to upload an asset which returns an unique ID
    -   An endpoint that takes an ID and responds with the
        original file.
    -   n.b. at this point identifying the asset remains the
        responsibility of the user.
    -   This should be deployed to a production environment, so that the
        client can use it straight away.
-   The next story, written in collaboration with the client might;
    -   recognise that the user will have difficulty keeping track of
        IDs and provide a simple list of assets.
    -   add metadata, so that the files' content can be assessed without
        downloading
    -   search by metadata content

The choice of which story is most important is up to the client. These
small iterative steps provide immediate feedback about what the customer
actually needs and can highlight incorrect assumptions about
requirements.

All of the above should be done with a mind to the kind of solution that
might emerge, but should not be driven entirely by that vision.

At any point in the process, development can stop and the client should
have the most valuable tool available given the resources allocated.

### Options for Solution

Initially we can probably do without a database or index. A simple file
system based store will suffice. However, the brief implies a need for
indexing and caching of metadata related to the assets.

#### Metadata Storage

I can see two straightforward options for caching metadata about the
assets.

1.  Lucene index
    -   We can push all the metadata into Lucene when the file is added
    -   Use ElasticSearch to query the files' metadata
    -   Use document fields/tags to represent hierarchical structure/s
    -   Create structured explorable view of files by querying each
        layer of tree structure

2.  ActiveRecord objects
    -   Different classes could represent asset types
    -   Easier to pull representational structure for display in a tree
        format, etc.
    -   Store metadata in Active Record objects
        -   Use Sunspot gem for Solr-powered search of above

I'd probably favour Lucene, as it's a solution with fewer moving parts,
although it might be slightly more effort to set up the environment. If
the code was written following SOLID principles, it should be easy
enough to change direction if needed further down the line.

#### Image Resizing

-   Usually this is delegated to something like ImageMagick on
    the server.
-   A request to the web server would check to see if geometry has been
    provided
-   If not, return the original image.
-   If so, use a naming convention to check for a resized image on the
    disk i.e. {uniqueid}-{width}x{height}.{extension}
-   If not, call imageMagick to create a new file with that geometry and
    store it using the same naming convention.
-   Then return the geometry resized image.

Depending on expected usage, we might have to consider cache expiry by
keeping a log of file access.

#### Extracting Metadata from Files

Rather than expecting the user to manually enter metadata which
partially duplicates the content of the files, it's preferable to
extract searchable data from the assets.

Assuming we are running on a \*nix platform (i.e. Linux, macOS or \*BSD)
we can use the following techniques to gather content data at time of
upload.

Reading PDF content

-   Use pdftotext to extract textual content from pdf files
-   If no textual output from above then
    -   Use Tesseract (and gem) to OCR non-textual pdf files to capture
        content

Reading Microsoft Office content

-   Assuming Linux platform (or macOS with Brew), we can use the
    following to extract plain text from a Microsoft Word document;

`unzip -ca RawnetRailsDeveloperTest.docx word/document.xml | sed -e 's/<[^>]*>//g'`

The same technique can be used for Excel docs.

Reading Metadata from JPEG

-   We can use ruby-exif gem to gather the metadata from JPEG images.

