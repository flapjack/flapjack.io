# ![Flapjack](http://flapjack.io/images/flapjack-2013-notext-transparent-50-50.png "Flapjack") packages.flapjack.io

The [Flapjack package repositories](http://packages.flapjack.io/) web page and maintenance info.

Packages are created with [Omnibus](http://github.com/flapjack/omnibus-flapjack),
and pushed to S3 as part of that project.

# Making changes

Make changes to the web content on packages.flapjack.io in this directory and push changes to github.

Note that package repositories are now maintained by [omnibus-flapjack](http://github.com/flapjack/omnibus-flapjack) using [aptly](http://www.aptly.info).

# Publishing to packages.flapjack.io

## Install awscli:

 * OS X: `brew install awscli`
 * Debian/Ubuntu: `sudo apt-get update && sudo apt-get install python-pip groff && sudo pip install awscli`

Configure awscli if you haven't already:

``` bash
aws configure --profile default
```

(or use a separate profile for this repo)

## Push to S3:

From within the root directory of the flapjack.io repo run:

```bash
bin/publish-packages-flapjack-io
```

## Adding or revoking other AWS users' permissions

There is a select group of people who can push packages to the official repositories at [packages.flapjack.io](http://packages.flapjack.io), which is hosted on S3.

To view who has access:

```
aws s3api get-bucket-acl --bucket packages.flapjack.io
```

To grant another AWS user to have write access to the packages.flapjack.io S3 bucket:

<div class="alert alert-info">
Warning: this replaces all existing ACLs - you can find the existing IDs of the existing users using the view command above.
</div>

```
aws s3api put-bucket-acl --bucket  packages.flapjack.io --grant-full-control 'id="EXISTINGID1",id="EXISTINGID2",...,emailaddress="YOUREMAILHERE"' --grant-read 'uri="http://acs.amazonaws.com/groups/global/AllUsers"'
```

To revoke access you need to run the above grant command, but without the ID of the person you wish to remove.

Currently the following people have access to the bucket:

 - [Jesse Reynolds](https://github.com/jessereynolds)
 - [Lindsay Holmwood](https://github.com/auxesis)
 - [Sarah Kowalik](https://github.com/hobbsee)

# How is the hosting configured?

We're using DNSimple for the flapjack.io domain name hosting, Amazon Route 53 for domain name hosting of packages.flapjack.io, and Amazon S3 to host the files and directories.

Here are the nameservers `flapjack.io` is delegated to:

```
flapjack.io name server ns4.dnsimple.com.
flapjack.io name server ns2.dnsimple.com.
flapjack.io name server ns3.dnsimple.com.
flapjack.io name server ns1.dnsimple.com.
```

Here are the nameservers `packages.flapjack.io` is delegated to:

```
packages.flapjack.io name server ns-1478.awsdns-56.org.
packages.flapjack.io name server ns-1565.awsdns-03.co.uk.
packages.flapjack.io name server ns-782.awsdns-33.net.
packages.flapjack.io name server ns-206.awsdns-25.com.
```

Route 53 has the following records for the `packages.flapjack.io` domain:

| Name               | Type | Value                                |
|--------------------|:----:|--------------------------------------|
|packages.flapjack.io| A    | ALIAS d3tuf7yoix2erv.cloudfront.net. |
|packages.flapjack.io| NS   | (aws nameservers as listed above)    |
|packages.flapjack.io| SOA  | (usual stuff)                        |

The S3 bucket name is `packages.flapjack.io` and the endpoint is [packages.flapjack.io.s3-website-us-east-1.amazonaws.com](http://packages.flapjack.io.s3-website-us-east-1.amazonaws.com).

Logging is configured to write to the bucked logs.packages.flapjack.io under `root/`
