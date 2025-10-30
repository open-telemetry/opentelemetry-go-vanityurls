# go.opentelemetry.io
Vanityurls config for go.opentelemetry.io subdomain

## Adding a new package

Packages are configured in the `content/packages` folder. Each of them has a
content file with the package name.

Create a new file in `content/packages/<YOUR PACKAGE NAME>.md`. For example,
`content/packages/my_package.md`.

Add the following header to the document:

```markdown
---
repo: URL TO THE REPOSITORY
---
```

Where the URL to the repository is the location of the source code you need the
package to point to.
